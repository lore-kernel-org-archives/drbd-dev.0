Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
	[209.85.219.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C11DB4202BA
	for <drbd-dev@lists.linbit.com>; Wed, 16 Oct 2024 18:44:52 +0200 (CEST)
Received: by mail-yb1-f171.google.com with SMTP id
	3f1490d57ef6-e2975b197d1so1848839276.2
	for <drbd-dev@lists.linbit.com>; Wed, 16 Oct 2024 09:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-3-zhengbing.huang@easystack.cn>
	<CADGDV=V4kpNPAWf6MsdswhbMqKPe5=qEMXkF_KBqXVM7W+aUhQ@mail.gmail.com>
	<f368f323-140c-9995-63b7-ec8ada21a7f0@easystack.cn>
	<73f04036-5bb3-9ad5-bfe1-ea4d26817ceb@easystack.cn>
In-Reply-To: <73f04036-5bb3-9ad5-bfe1-ea4d26817ceb@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 16 Oct 2024 18:44:40 +0200
Message-ID: <CADGDV=XqOK7iQ1cCNMWEBjZdx-iZVmsrgfVmQWTEnOqgk2ODWQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] drbd_transport_rdma: put kref for cm in
	dtr_path_established in error path
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
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

Hello easystack team,

I probably fixed the (or some of the) problems you intended to fix
with this patch series.

Please see these recent commits on the master branch:

3f82aed6e drbd_transport: fix a use after free in drbd_get_listener()
1f2f11c47 rdma: remove dtr_path_established()
e38120f3d rdma: Fix leaking a cm_id object
e0f5e307e rdma: fix superficial kref_put() in error code path in
dtr_cma_accept()
35a6b002c rdma: fix concurrency of activate_path() and __dtr_disconnect_pat=
h()
6ccd39432 rdma: fix an access after free() in dtr_destroy_cm()
5a711b347 rdma: fix free() of scheduled delayed_work
847aab659 rdma: remove misguided kref_get()/kref_put()

I will go over your patch series and your comments. I'm sorry I
dropped the ball on this. I was out on vacation in July, and when I
came back, 1000 things needed my attention.

Best regards,
 Philipp

On Mon, Jul 1, 2024 at 4:48=E2=80=AFAM Dongsheng Yang
<dongsheng.yang@easystack.cn> wrote:
>
>
>
> =E5=9C=A8 2024/7/1 =E6=98=9F=E6=9C=9F=E4=B8=80 =E4=B8=8A=E5=8D=88 10:07, =
Dongsheng Yang =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2024/6/28 =E6=98=9F=E6=9C=9F=E4=BA=94 =E4=B8=8B=E5=8D=88 5:40=
, Philipp Reisner =E5=86=99=E9=81=93:
> >> Hello Dongsheng,
> >>
> >> Please add more information why you think this change fixes a bug.
> >> Have you experienced a leak of cm structs?
> >> We got a RDMA_CM_EVENT_ESTABLISHED event. Even if DRBD does not do
> >> anything with this cm, we sill expect a RDMA_CM_EVENT_DISCONNECTED in
> >> the future. Is a problem in the handling of the disconnect?
> >
> > If dtr_path_established() go into this branch, it will not
> > schedule_work(&cm->establish_work);
> >
> > That means path->cm->state =3D DSM_CONNECTED; will not be done in
> > dtr_path_established_work_fn(), so __dtr_disconnect_path() will not cal=
l
> > rdma_disconnect(). That means this reference will never be put.
>
> let me consider this  example:
> a) rdma_connect() called and RDMA_CM_EVENT_ESTABLISHED received.
>
> b) network failure and dtr_path_established() go into error path.
>
> c) establish_work will not be scheduled.
>
> d) drbdadm down test will hang because cm ref is not put.
> >>
> >> best regards,
> >>   Philipp
> >>
> >> On Mon, Jun 24, 2024 at 9:28=E2=80=AFAM zhengbing.huang
> >> <zhengbing.huang@easystack.cn> wrote:
> >>>
> >>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
> >>>
> >>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> >>> ---
> >>>   drbd/drbd_transport_rdma.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> >>> index cfbae0e78..eccd0c6ce 100644
> >>> --- a/drbd/drbd_transport_rdma.c
> >>> +++ b/drbd/drbd_transport_rdma.c
> >>> @@ -922,6 +922,7 @@ static void dtr_path_established(struct dtr_cm *c=
m)
> >>>                          atomic_set(&cs->active_state, PCS_INACTIVE);
> >>>                          wake_up(&cs->wq);
> >>>                  }
> >>> +               kref_put(&cm->kref, dtr_destroy_cm);
> >>>                  return;
> >>>          }
> >>>
> >>> --
> >>> 2.27.0
> >>>
