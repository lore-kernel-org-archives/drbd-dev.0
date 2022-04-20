Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
	[209.85.218.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C9230420164
	for <drbd-dev@lists.linbit.com>; Wed, 20 Apr 2022 12:22:43 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id g13so2563541ejb.4
	for <drbd-dev@lists.linbit.com>; Wed, 20 Apr 2022 03:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220419121647.638794-1-rui.xu@easystack.cn>
In-Reply-To: <20220419121647.638794-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Wed, 20 Apr 2022 12:22:32 +0200
Message-ID: <CAGNP_+Wfbohf2NkB+LXhHSBEQk_jK-Xi+-wRJimG3G0Z2pbbqg@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix a race of drbd_free_peer_req
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

Hi Xu,

I think there is a potential race here, but I am not convinced that
this is a general solution. The peer request could still be freed by
got_peer_ack() between checking "list_empty(&peer_req->recv_order)"
and freeing it in drbd_finish_peer_reqs(). Also, this solution keeps
the page chain for peer requests for an unnecessarily long time, which
is not ideal in memory constrained situations.

The underlying race, as far as I understand it, is that got_peer_ack()
can be called while still processing the request in
drbd_finish_peer_reqs(). This is only relevant for peer writes and not
resync, so only the e_end_block() path is of interest. got_peer_ack()
will only be called after we have sent the corresponding barrier ack
for the peer request.

On the basis of this reasoning, I think a simple solution is to swap
drbd_may_finish_epoch() and drbd_free_page_chain() in e_end_block().
Please try this and send it as a patch if it solves your problem.

By the way, this patch doesn't compile due to a mismatched brace.

Best regards,
Joel
