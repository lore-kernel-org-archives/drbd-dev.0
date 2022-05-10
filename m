Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
	[209.85.218.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3B14B4202D2
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2022 13:25:40 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id l18so32239492ejc.7
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2022 04:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <AAsAIAC8IfSaXGMbJbgsMKpG.1.1652181400930.Hmail.rui.xu@easystack.cn>
In-Reply-To: <AAsAIAC8IfSaXGMbJbgsMKpG.1.1652181400930.Hmail.rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Tue, 10 May 2022 13:24:29 +0200
Message-ID: <CAGNP_+W2Ys27fco_W6x+UvkUMKva5FpzZEAu4EnhvqM+Bx5NGQ@mail.gmail.com>
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

Could you describe your use case in more detail? What are you trying
to achieve with DRBD?

This will help understand why you would like to restore the
functionality. Perhaps there is a simpler solution that also works for
your purposes.

Best regards,
Joel
