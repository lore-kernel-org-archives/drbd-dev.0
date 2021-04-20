Return-Path: <gustavo@embeddedor.com>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
	[192.185.148.142])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A1BB64204A7
	for <drbd-dev@lists.linbit.com>; Tue, 20 Apr 2021 22:48:31 +0200 (CEST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
	by gateway34.websitewelcome.com (Postfix) with ESMTP id 6DFC5A9141
	for <drbd-dev@lists.linbit.com>; Tue, 20 Apr 2021 15:25:39 -0500 (CDT)
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
References: <cover.1605896059.git.gustavoars@kernel.org>
	<44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba77fcbe-8770-d234-509b-7dc5ac079319@embeddedor.com>
Date: Tue, 20 Apr 2021 15:25:51 -0500
MIME-Version: 1.0
In-Reply-To: <44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 027/141] drbd: Fix fall-through warnings for
	Clang
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

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:28, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding a break statement instead of just
> letting the code fall through to the next, and by adding a fallthrough
> pseudo-keyword in places whre the code is intended to fall through.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/block/drbd/drbd_receiver.c | 1 +
>  drivers/block/drbd/drbd_req.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index dc333dbe5232..c19bb74ac935 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -5863,6 +5863,7 @@ static int got_NegRSDReply(struct drbd_connection *connection, struct packet_inf
>  		switch (pi->cmd) {
>  		case P_NEG_RS_DREPLY:
>  			drbd_rs_failed_io(device, sector, size);
> +			break;
>  		case P_RS_CANCEL:
>  			break;
>  		default:
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 330f851cb8f0..9f212a923a3c 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -750,6 +750,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>  
>  	case WRITE_ACKED_BY_PEER_AND_SIS:
>  		req->rq_state |= RQ_NET_SIS;
> +		fallthrough;
>  	case WRITE_ACKED_BY_PEER:
>  		/* Normal operation protocol C: successfully written on peer.
>  		 * During resync, even in protocol != C,
> 
