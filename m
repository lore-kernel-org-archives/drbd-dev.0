Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
	[209.85.208.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3F81D420603
	for <drbd-dev@lists.linbit.com>; Wed,  1 Sep 2021 10:40:44 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id q17so2703867edv.2
	for <drbd-dev@lists.linbit.com>; Wed, 01 Sep 2021 01:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210901023826.838222-1-rui.xu@easystack.cn>
In-Reply-To: <20210901023826.838222-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Wed, 1 Sep 2021 10:40:32 +0200
Message-ID: <CAGNP_+U3-BZ+9uykZuttOp6+irG15yesyFfDs27kj3M6BJN+1A@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: do not finish the stable resync when
 repl state is L_PAUSED_SYNC_T
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

Hi,

Thanks for the contribution. Please describe the steps necessary to
reproduce the issue. I tried briefly to reproduce it without success;
getting a paused sync to finish before a running one is not that easy.
A test in https://github.com/LINBIT/drbd9-tests would be ideal, but a
written description is OK too.

Please also verify that the issue occurs on the latest drbd-9.0 or
master branch. I see from the patch that you are working on a version
that is at least a couple of months old.

Best regards,
Joel
