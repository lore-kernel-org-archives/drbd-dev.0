Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
	[209.85.218.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5258E4203DF
	for <drbd-dev@lists.linbit.com>; Mon,  1 Aug 2022 16:22:23 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id i14so1914083ejg.6
	for <drbd-dev@lists.linbit.com>; Mon, 01 Aug 2022 07:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220728114759.810371-1-rui.xu@easystack.cn>
In-Reply-To: <20220728114759.810371-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Mon, 1 Aug 2022 16:22:12 +0200
Message-ID: <CAGNP_+UM0GR2oukOeN8NoKMka=_Hox4SB9MSBgNPMcOrcYxqXg@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix a bug with two-primaries
	configuration
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

The behavior that you describe is the intended behavior, I believe. If
you have two primaries and want to disconnect them in a controlled
fashion, you should demote them first.

As discussed previously, you probably should not be using
"allow-two-primaries" at all.

The proposed patch unfortunately also breaks various other usage
scenarios. For instance, if you have two nodes that are both Secondary
and UpToDate, and run 'drbdsetup disconnect', it will cause them to
become Outdated.

Best regards,
Joel
