Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
	[209.85.218.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1880A420065
	for <drbd-dev@lists.linbit.com>; Fri,  8 Apr 2022 10:23:45 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id n6so15719422ejc.13
	for <drbd-dev@lists.linbit.com>; Fri, 08 Apr 2022 01:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220302123523.471277-1-rui.xu@easystack.cn>
	<ANUANAAVIdwn*FrX7b*E8aoA.3.1648177379860.Hmail.rui.xu@easystack.cn>
	<CAGNP_+U9ex9RjftsSFOcXmhTYs4uXGH+OKskLqUjzARozdEc_w@mail.gmail.com>
In-Reply-To: <CAGNP_+U9ex9RjftsSFOcXmhTYs4uXGH+OKskLqUjzARozdEc_w@mail.gmail.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 8 Apr 2022 10:23:34 +0200
Message-ID: <CAGNP_+Wmd20E3MBkxsOnyE3Y67zmfUnSqP1vSAHPMap9U-AEVg@mail.gmail.com>
To: Xu Rui <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd:do not wait for negotiation result with
	unconnected peer
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

Thanks for this patch! It has been applied in a slightly simplified form as:
https://github.com/LINBIT/drbd/commit/aea83b266ba9a3c46ea773a12f57b2fb6dff15a4

Joel
