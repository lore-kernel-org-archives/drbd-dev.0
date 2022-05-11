Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
	[209.85.218.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A406F420372
	for <drbd-dev@lists.linbit.com>; Wed, 11 May 2022 14:57:32 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id g6so3910823ejw.1
	for <drbd-dev@lists.linbit.com>; Wed, 11 May 2022 05:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNP_+VQDpNfrDgWLDc0F1Va-Fnt5VEAFreXVn7ufiq6R_OJTQ@mail.gmail.com>
	<ABEAGAAXIWGeUYOCD1PNhaqL.3.1652248501946.Hmail.rui.xu@easystack.cn>
In-Reply-To: <ABEAGAAXIWGeUYOCD1PNhaqL.3.1652248501946.Hmail.rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Wed, 11 May 2022 14:56:20 +0200
Message-ID: <CAGNP_+WCw4+Obv_o0631Mi4Nub52O3OgHsCO_jesc-dGxBfUsQ@mail.gmail.com>
To: "rui.xu" <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: a proposal of two-primaries mode
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

The topic of active/active iSCSI targets on dual primary DRBD has been
discussed in detail before. Here are some examples:

https://lists.linbit.com/pipermail/drbd-user/2010-October/014845.html
https://lists.linbit.com/pipermail/drbd-user/2011-November/017238.html
https://lists.linbit.com/pipermail/drbd-user/2013-October/020295.html

In short, active/active iSCSI targets with dual primary DRBD is not
recommended. Unless there have been significant recent developments,
this is still the case.

The solution with iSCSI target failover via a cluster manager should
not introduce much more failover delay. You need to get the
distributed lock from your paxos system already. That is essentially
the same as what the cluster manager would do. The only additional
overhead is that you have to promote DRBD and start an iSCSI target.

You could try configuring your iSCSI initiator into a failover mode,
rather than load balancing, assuming it has such an option. Although
this is not the solution I would recommend, it is less likely to run
into problems.

Best regards,
Joel
