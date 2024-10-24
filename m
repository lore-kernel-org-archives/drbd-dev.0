Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
	[209.85.218.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 593EF42033E
	for <drbd-dev@lists.linbit.com>; Thu, 24 Oct 2024 13:33:31 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
	a640c23a62f3a-a9a6acac4c3so113422366b.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Oct 2024 04:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241022114151.8050-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20241022114151.8050-1-zhengbing.huang@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 24 Oct 2024 13:33:20 +0200
Message-ID: <CAGNP_+WTu+xCHWZ6Fou8uqCYFauvqTK3Ch8rT-3YhZnrD0Mf5g@mail.gmail.com>
Subject: Re: [PATCH] drbd: Fix seq_num numeric conversion error
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

> seq_num is a 32-bit value and should not be converted with be64_to_cpu().

Thanks. Applied as:
https://github.com/LINBIT/drbd/commit/168bcdd0a56ca80fed4ca9e05589c1188b2aa589

The commit will be merged to master in due course.

Best regards,
Joel
