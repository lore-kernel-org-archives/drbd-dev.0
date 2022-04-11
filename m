Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
	[209.85.208.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 24EF2420124
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2022 17:21:12 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id d10so18940385edj.0
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2022 08:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220411120204.3683999-1-rui.xu@easystack.cn>
In-Reply-To: <20220411120204.3683999-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Mon, 11 Apr 2022 17:21:01 +0200
Message-ID: <CAGNP_+WSFxF3Jzb7ozJMjSsOEDxLR6n_CMt58NHzmyOJErjfng@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd:clear NEW_CUR_UUID when uuid was
	actually created
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

You mentioned in your other message that this patch is intended for DRBD 9.0.
https://lists.linbit.com/pipermail/drbd-dev/2022-April/006577.html

I'm afraid that the 9.0 branch is end-of-life, so this won't be
applied. The drbd-9.1 branch is the place for improvements, especially
since it already contains related fixes to the handling of suspended
IO due to quorum loss.

Thank you for your participation in the project nevertheless!

Best regards,
Joel
