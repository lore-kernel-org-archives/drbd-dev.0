Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B2BE4207DE
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jun 2024 17:31:47 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
	4fb4d7f45d1cf-57a1fe6392eso1569011a12.0
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jun 2024 08:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240611111406.8308-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20240611111406.8308-1-zhengbing.huang@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 13 Jun 2024 17:31:35 +0200
Message-ID: <CAGNP_+XpeynrNvTA=tpRWECfmZK1SJersc21Gv-Qu6-suRoNUw@mail.gmail.com>
Subject: Re: [PATCH] rdma: Fix dtr_path use-after-free
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
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

Thanks. Merged as
https://github.com/LINBIT/drbd/commit/d37efcdbae279f124aa2271bbd8927058a6fb038

I edited the commit message a bit to make it easier to understand.

Best regards,
Joel
