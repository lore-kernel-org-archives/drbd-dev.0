Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
	[209.85.208.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E814C420625
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2022 14:55:26 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id c12so12422192edv.10
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2022 05:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNP_+W2Ys27fco_W6x+UvkUMKva5FpzZEAu4EnhvqM+Bx5NGQ@mail.gmail.com>
	<AJwAbwDZIVuayp7pP6u5v4pq.3.1652184563067.Hmail.rui.xu@easystack.cn>
In-Reply-To: <AJwAbwDZIVuayp7pP6u5v4pq.3.1652184563067.Hmail.rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Tue, 10 May 2022 14:55:15 +0200
Message-ID: <CAGNP_+VQDpNfrDgWLDc0F1Va-Fnt5VEAFreXVn7ufiq6R_OJTQ@mail.gmail.com>
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

Dual primary mode is not recommended for this scenario due to data
divergence considerations. How do you handle a loss of network
connectivity between the storage nodes?

Is it possible to use diskless DRBD clients instead of iSCSI
initiators for your purposes?

Assuming you have to use iSCSI, the normal solution is to only have
one active target. Use a cluster manager to support failover to the
other storage node. For instance, add a third node with minimal
resources as a diskless tiebreaker, enable DRBD quorum, and use the
drbd-reactor promoter as a simple cluster manager. Have you considered
this option?

Best regards,
Joel
