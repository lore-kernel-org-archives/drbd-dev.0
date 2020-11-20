Return-Path: <philipp.reisner@linbit.com>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 670194207E4
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 10:13:34 +0100 (CET)
Received: by mail-io1-f66.google.com with SMTP id u21so9179079iol.12
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 01:13:34 -0800 (PST)
MIME-Version: 1.0
References: <859ad180-0e92-5542-4d52-730589e99682@easystack.cn>
In-Reply-To: <859ad180-0e92-5542-4d52-730589e99682@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 20 Nov 2020 10:13:22 +0100
Message-ID: <CADGDV=X9P9A+ig-K-nCcTvTD11jTWE6ai0SH17BDm1MLb+DCzQ@mail.gmail.com>
To: Zhang Duan <duan.zhang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] drbd: delay resync start unless source
 has transferred to L_SYNC_SOURCE
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

Hi Zhang,

The explanation is sound, the patch looks good. I am going to apply this.

What I wanted to ask:
Are you using automated tests to find this kind of defects?
The tests we maintain are here: https://github.com/LINBIT/drbd9-tests
We would welcome very much if you contribute your tests to this as well.

best regards,
 Phil

On Wed, Nov 18, 2020 at 9:46 AM Zhang Duan <duan.zhang@easystack.cn> wrote:
>
> drbd_start_resync may be rescheduled due to down_trylock failure, leaves a
> state of L_WF_BITMAP_S while target state is L_SYNC_TARGET and already has
> sent its resync request. Then, resync going on while the source is
> L_WF_BITMAP_S
> will lead to data lose by time sequence below:
>
> L_WF_BITMAP_S                   L_SYNC_TARGET
>                                  resync request(sector A)
> reply old data(A)               read & write old data(A)
> new IO(A)
> send oos(A)                     set oos(A)
> A is at new version             resync write A done
>                                  set in sync(A) but A is at old version
>
> Signed-off-by: ZhangDuan <duan.zhang@easystack.cn>
> ---
>   drbd/drbd_receiver.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git drbd/drbd_receiver.c drbd/drbd_receiver.c
> index a31e44b2..7a9ce4d0 100644
> --- drbd/drbd_receiver.c
> +++ drbd/drbd_receiver.c
> @@ -3301,6 +3301,15 @@ static int receive_DataRequest(struct
> drbd_connection *connection, struct packet
>                 return ignore_remaining_packet(connection, pi->size);
>         }
>   +     /* Tell target to have a retry, waiting for the rescheduled
> +        * drbd_start_resync to complete. Otherwise the concurrency
> +        * of send oos and resync may lead to a data lose. */
> +       if ((pi->cmd == P_RS_DATA_REQUEST || pi->cmd == P_CSUM_RS_REQUEST) &&
> +                       peer_device->repl_state[NOW] == L_WF_BITMAP_S) {
> +               drbd_send_ack_rp(peer_device, P_RS_CANCEL, p);
> +               return ignore_remaining_packet(connection, pi->size);
> +       }
> +
>         peer_req = drbd_alloc_peer_req(peer_device, GFP_TRY);
>         err = -ENOMEM;
>         if (!peer_req)
> --
> 2.24.0.windows.2
>
>
> --
> Sincerely Yours,
> Zhang Duan
