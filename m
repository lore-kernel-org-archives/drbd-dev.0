Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BAFEF160961
	for <drbd-dev@lists.linbit.com>; Mon, 16 Dec 2024 11:10:26 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
	4fb4d7f45d1cf-5d3d2a30afcso6829516a12.3
	for <drbd-dev@lists.linbit.com>; Mon, 16 Dec 2024 02:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20241215065056.879266-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20241215065056.879266-1-zhengbing.huang@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Mon, 16 Dec 2024 11:10:12 +0100
Message-ID: <CAGNP_+W+gELNC_1DmmHYbbAe_7hP0YdXk04cF_X5MqYevhN+jw@mail.gmail.com>
Subject: Re: [PATCH v2] drbd: Fix memory leak
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

Thanks. Applied as
https://github.com/LINBIT/drbd/commit/d64ebe7eb7df8c622b20bca38f3d7f4c7bb033c9

The commit will be merged to master in due course.

Best regards,
Joel
