Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
	[209.85.208.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 55100162268
	for <drbd-dev@lists.linbit.com>; Thu, 31 Jul 2025 14:36:18 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
	4fb4d7f45d1cf-604bff84741so591651a12.2
	for <drbd-dev@lists.linbit.com>; Thu, 31 Jul 2025 05:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250709025553.694792-1-zhengbing.huang@easystack.cn>
	<20250709025553.694792-2-zhengbing.huang@easystack.cn>
In-Reply-To: <20250709025553.694792-2-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 31 Jul 2025 14:36:05 +0200
Message-ID: <CADGDV=U0teF1qic1UvrfMJcR8VRfD4VPDwKRZ6TnuymwgrDbvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drbd: Fix kernel crash in drbd_find_path_by_addr()
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks applied

On Wed, Jul 9, 2025 at 5:01=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> We hava the crash info as follow:
>  BUG: unable to handle kernel NULL pointer dereference at 000000000000000=
0
>  Workqueue: ib_cm cm_work_handler [ib_cm]
>  RIP: 0010:drbd_find_path_by_addr+0x6c/0xd0 [drbd]
>  Call Trace:
>   dtr_cma_event_handler+0x1c1/0x4ee [drbd_transport_rdma]
>   cma_cm_event_handler+0x25/0xd0 [rdma_cm]
>   cma_ib_req_handler+0x7cd/0x1250 [rdma_cm]
>   ? addr4_resolve+0x67/0xd0 [ib_core]
>   cm_process_work+0x22/0xf0 [ib_cm]
>   cm_req_handler+0x7ed/0xf40 [ib_cm]
>   ? __switch_to_asm+0x35/0x70
>   cm_work_handler+0x798/0xf30 [ib_cm]
>   ? finish_task_switch+0x18e/0x2e0
>   process_one_work+0x1a7/0x360
>   ? create_worker+0x1a0/0x1a0
>   worker_thread+0x30/0x390
>   ? create_worker+0x1a0/0x1a0
>   kthread+0x10a/0x120
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x1f/0x40
>
> The code that crash is traverse the listener->waiters list:
> struct drbd_path *drbd_find_path_by_addr(struct drbd_listener *listener, =
struct sockaddr_storage *addr)
> {
>         struct drbd_path *path;
>
>         list_for_each_entry(path, &listener->waiters, listener_link) {
>                 if (addr_equal(&path->peer_addr, addr))
>                         return path;
>         }
>
>         return NULL;
> }
>
> The listener->waiters list has a Path node:
> crash> struct dtr_listener ff4ba75054797c00
> struct dtr_listener {
>   listener =3D {
>     kref =3D {
>       refcount =3D {
>         refs =3D {
>           counter =3D 2
>         }
>       }
>     },
>     resource =3D 0xff4ba766cc325000,
>     transport_class =3D 0xffffffffc037f080 <rdma_transport_class>,
>     list =3D {
>       next =3D 0xff4ba766cc325500,
>       prev =3D 0xff4ba766cc325500
>     },
>     waiters =3D {
>       next =3D 0xff4ba74fd578e138,
>       prev =3D 0xff4ba74fd578e138
>     },
>  ...
> }
>
> but this Path has been released:
> crash> struct drbd_path 0xff4ba74fd578e000
> struct drbd_path {
>   my_addr =3D {
>     ss_family =3D 1,
>     __data =3D "\000\000\000\000"
>   },
>   peer_addr =3D {
>     ss_family =3D 0,
>     __data =3D "\000\000\000\000\000\000\0"
>   },
>   kref =3D {
>     refcount =3D {
>       refs =3D {
>         counter =3D 0
>       }
>     }
>   },
>   net =3D 0x0,
>   my_addr_len =3D 0,
>   peer_addr_len =3D 0,
>   flags =3D 0,
>   // all zero
>   ...
> }
>
> So this path has been released, but it is still on the listener->waiters =
list,
> which cause problem when traverse the list later.
>
> And the scenario of this problem should be like this:
> thread_1:
>   remove_path()
>     dtr_remove_path()
>       drbd_put_listener()
>         list_del(&path->listener_link)
>                                           thread_2:
>                                             ...
>                                             dtr_activate_path()
>                                               drbd_get_listener()
>                                                 list_add(&path->listener_=
link, &listener->waiters);
>                                             ...
>    ...
>    kfree(path)
>
> thread_3:
> connect request come in:
> dtr_cma_event_handler()
>   dtr_cma_accept()
>     drbd_find_path_by_addr()
>     crash
>
> To avoid this use-after-free, we hold an additional reference to drbd_pat=
h
> whenever it is added to the listener->waiters list, and drop it when remo=
ved.
>
> This ensures the path memory remains valid during list traversal.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drbd/drbd_transport.c b/drbd/drbd_transport.c
> index 00e7f9269..aff96716f 100644
> --- a/drbd/drbd_transport.c
> +++ b/drbd/drbd_transport.c
> @@ -224,6 +224,7 @@ int drbd_get_listener(struct drbd_path *path)
>
>         spin_lock_bh(&listener->waiters_lock);
>         list_add(&path->listener_link, &listener->waiters);
> +       kref_get(&path->kref);
>         path->listener =3D listener;
>         spin_unlock_bh(&listener->waiters_lock);
>         /* After exposing the listener on a path, drbd_put_listenr() can =
destroy it. */
> @@ -258,6 +259,7 @@ void drbd_put_listener(struct drbd_path *path)
>
>         spin_lock_bh(&listener->waiters_lock);
>         list_del(&path->listener_link);
> +       kref_put(&path->kref, drbd_destroy_path);
>         spin_unlock_bh(&listener->waiters_lock);
>         kref_put(&listener->kref, drbd_listener_destroy);
>  }
> --
> 2.43.0
>
