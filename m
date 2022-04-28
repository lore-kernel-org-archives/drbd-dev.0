Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
	[209.85.208.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 94D434201DC
	for <drbd-dev@lists.linbit.com>; Thu, 28 Apr 2022 10:59:53 +0200 (CEST)
Received: by mail-ed1-f41.google.com with SMTP id e23so4713451eda.11
	for <drbd-dev@lists.linbit.com>; Thu, 28 Apr 2022 01:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220426080903.1831211-1-rui.xu@easystack.cn>
In-Reply-To: <20220426080903.1831211-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 28 Apr 2022 09:59:42 +0100
Message-ID: <CAGNP_+W2ARFLdM1a8UNibar_Xu+j4bd8WVwLp88-J8PnivVNEw@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: fix a race of drbd_free_peer_req
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

Applied as https://github.com/LINBIT/drbd/commit/254f91494b5fa2e30b0aa816ea573edb3babac99

Thanks!
Joel
