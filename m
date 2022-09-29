Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
	[209.85.208.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 028F8420175
	for <drbd-dev@lists.linbit.com>; Thu, 29 Sep 2022 11:39:57 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id y100so685109ede.6
	for <drbd-dev@lists.linbit.com>; Thu, 29 Sep 2022 02:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220921090710.2238953-1-rui.xu@easystack.cn>
In-Reply-To: <20220921090710.2238953-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 29 Sep 2022 11:39:46 +0200
Message-ID: <CAGNP_+Xh9e8hA+B73Li4P-kZ6KvcazAQkwCpfAzDCpR-7HzDBA@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: philipp.reisner@linbit.com, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix a bug of got_peer_ack
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

> Consider a scenrio that io is ongoing and the backing disk of
> secondary drbd suddenly broken. Some requset from primary node
> will not be processed in receive_Data since there is no ldev.
> And primary node will send peer_ack to secondary node for those
> requsets, but the secondary node will not find these requests in
> got_peer_ack.
>
> The first problem caused by this bug is that the two nodes will be
> disconnected, and the second problem is that some peer requests
> can't be destroyed.

I can confirm this issue. Thanks for reporting it.

> Fix it by find the last peer request on peer_requests list and then
> the remaining requests on the list will be destroyed.

I believe this is a valid solution. It is missing the case where
another peer ack is sent afterwards too, so that got_peer_ack() is
called with connection->peer_requests empty. But don't worry about
that for now.

The question is - do we need to send peer acks to peers that responded
with P_NEG_ACK at all? At the point when the write fails on the
secondary, we could set the bitmap bits and free the request. Then we
don't need the peer-ack from the primary. This may lead to a simpler
and more robust solution. I'll try it.

Best regards,
Joel
