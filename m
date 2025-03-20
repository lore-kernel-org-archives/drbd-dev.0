Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
	[209.85.128.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 18F1116091D
	for <drbd-dev@lists.linbit.com>; Thu, 20 Mar 2025 07:36:55 +0100 (CET)
Received: by mail-yw1-f173.google.com with SMTP id
	00721157ae682-6f768e9be1aso15717057b3.0
	for <drbd-dev@lists.linbit.com>; Wed, 19 Mar 2025 23:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250219030506.1389085-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20250219030506.1389085-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 20 Mar 2025 07:36:44 +0100
Message-ID: <CADGDV=VV6yf56iQQJ4vw2Y250ORjgkzCt0KdgmUezcu+oogTLA@mail.gmail.com>
Subject: Re: [PATCH] drbd: Fix IO block after network failure
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

Hi Zhengbing,

Yes, I verified your findings and applied this patch with tiny
modifications to make it checkpatch.pl compliant.
https://github.com/LINBIT/drbd/commit/4e28788df7f935ed78042f74b0969dd7fc0c7=
eb7

Thanks!

Best regards,
 Philipp


On Wed, Feb 19, 2025 at 4:10=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> Network failure test, I/O is not finished.
> The oldest_request has follow status information:
>
> master: pending|postponed       local: in-AL|completed|ok       net[1]: q=
ueued|done : C|barr
>
> This req also has RQ_NET_QUEUED,so its reference count
> cannot be reduced to zero and req cannot complete.
>
> The commit 8962f7c03c1
> drbd: exclude requests that are not yet queued from "seen_dagtag_sector"
> has modify the __next_request_for_connection() function,
> which causes the sender thread to be unable to clean up all
> pending req when the network failure.
>
> The race occurred as follows, where T is a submit req thread,
> and S is a sender thread:
> S: process_one_request() handle r0
> S: network failure. drbd_send_dblock(r0) fail, then call __req_mod(r0, SE=
ND_FAILED...)
> S: Call mod_rq_state(), r0 clear RQ_NET_QUEUED, and still has RQ_NET_PEND=
ING
> T: r1 arrive drbd_send_and_submit(), add to transfer_log, and set RQ_NET_=
QUEUED
> S: drbd_sender() handle network failure, change_cstate(C_NETWORK_FAILURE)
>
> When sender thread state change to stop, and want to
> cleanup all currently unprocessed requests(call __req_mod(req, SEND_CANCE=
LED...)).
> but it can not find r1, because in the __next_request_for_connection() fu=
nction,
> r0 always satisfies the first if condition and returns NULL.
> static struct drbd_request *__next_request_for_connection(...)
> {
> ...
>                 if (unlikely(s & RQ_NET_PENDING && !(s & (RQ_NET_QUEUED|R=
Q_NET_SENT))))
>                         return NULL;
> ...
> }
> Finally, r1 could not be completed due to has RQ_NET_QUEUED.
>
> So, In the cleanup process of sender,
> we find all the req with RQ_NET_QUEUED and clean it.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_sender.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drbd/drbd_sender.c b/drbd/drbd_sender.c
> index 80badc606..e6fc751c7 100644
> --- a/drbd/drbd_sender.c
> +++ b/drbd/drbd_sender.c
> @@ -3251,6 +3251,24 @@ static struct drbd_request *tl_next_request_for_co=
nnection(struct drbd_connectio
>         return connection->todo.req;
>  }
>
> +static struct drbd_request *tl_next_request_for_cleanup(struct drbd_conn=
ection *connection)
> +{
> +       struct drbd_request *req;
> +       struct drbd_request *found_req =3D NULL;
> +
> +       list_for_each_entry_rcu(req, &connection->resource->transfer_log,=
 tl_requests) {
> +               unsigned s =3D req->net_rq_state[connection->peer_node_id=
];
> +
> +               if (s & RQ_NET_QUEUED) {
> +                       found_req =3D req;
> +                       break;
> +               }
> +       }
> +
> +       connection->todo.req =3D found_req;
> +       return connection->todo.req;
> +}
> +
>  static void maybe_send_state_afer_ahead(struct drbd_connection *connecti=
on)
>  {
>         struct drbd_peer_device *peer_device;
> @@ -3644,7 +3662,7 @@ int drbd_sender(struct drbd_thread *thi)
>         /* cleanup all currently unprocessed requests */
>         if (!connection->todo.req) {
>                 rcu_read_lock();
> -               tl_next_request_for_connection(connection);
> +               tl_next_request_for_cleanup(connection);
>                 rcu_read_unlock();
>         }
>         while (connection->todo.req) {
> @@ -3660,7 +3678,7 @@ int drbd_sender(struct drbd_thread *thi)
>                         complete_master_bio(device, &m);
>
>                 rcu_read_lock();
> -               tl_next_request_for_connection(connection);
> +               tl_next_request_for_cleanup(connection);
>                 rcu_read_unlock();
>         }
>
> --
> 2.43.0
>
