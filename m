Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
	[209.85.208.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 70438420170
	for <drbd-dev@lists.linbit.com>; Fri, 12 Aug 2022 18:34:35 +0200 (CEST)
Received: by mail-ed1-f41.google.com with SMTP id z2so1996867edc.1
	for <drbd-dev@lists.linbit.com>; Fri, 12 Aug 2022 09:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220810115748.1484527-1-rui.xu@easystack.cn>
In-Reply-To: <20220810115748.1484527-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 12 Aug 2022 18:33:24 +0200
Message-ID: <CAGNP_+VqDKWbr=-+vg6wzMZjoSdicjeQtw4-NsHwBgSvhapwkw@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: retry the IO when connection lost
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

> And it's simpler than the current mechanism.

It certainly is.

Unfortunately it breaks other things. I will not comment on details of
the code, but rather on the core architectural concern.

I believe requests that were not yet completed could be retried as you propose.

The difficult requests are those that are completed, but for which no
barrier ack has yet been received. These requests may not yet have
been persisted on the peer, even with protocol C. Only once the
barrier ack has been received do we know that the write has been
persisted. Until then the peer might lose the write if it crashes.

Until we regain quorum, we do not know what to do with such requests.
There are 2 possibilities:
a) It may be that only a network outage occurred. In this case we want
to resume without a resync.
b) It may be that the peer crashed. In this case we need to perform a
resync including the blocks corresponding to these requests.

We keep the requests in the transfer log until we regain quorum, so
that we know whether we are in situation a) or b).

Your patch assumes that "OK" requests can be assumed to have been
persisted on the peer:
+ } else if (req->net_rq_state[idx] & RQ_NET_OK) {
+ goto barrier_acked;

That is, the patch assumes that situation a) will occur. If b)
actually occurred, then the necessary blocks will not be resynced and
this could cause data corruption.

I am very ready to believe that there is a simpler way of dealing with
suspended requests, but it must handle these different possibilities.

> My test also meet a problem introduced by commit 33600a4632f2.
> I have three nodes running with drbd9.1(node-1, node-2 and node-3),
> node-1 is primary and other nodes are secondary. Both quorum and
> quorum-minimum-redundancy are set to 2.

Indeed, the quorum-minimum-redundancy implementation is now stricter.
Previously it allowed requests to complete which should not have been
allowed to. The stricter implementation introduces some tricky corner
cases which make it hard to use. I recommend that you do not use it
unless you are really certain that you need it. There may have been
some confusing recommendations in the past. I recommended it for a
while. Now it is not recommended to use quorum-minimum-redundancy in
general.

Best regards,
Joel
