Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
	[209.85.218.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 329B34203CF
	for <drbd-dev@lists.linbit.com>; Tue, 24 May 2022 15:43:23 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id ck4so31162451ejb.8
	for <drbd-dev@lists.linbit.com>; Tue, 24 May 2022 06:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220519100508.3143-1-kunyu@nfschina.com>
In-Reply-To: <20220519100508.3143-1-kunyu@nfschina.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Tue, 24 May 2022 15:43:13 +0200
Message-ID: <CAGNP_+WSAwSzfp7sX+6dK_+skrVA6oXkpq6Jbwvf59bW3qkV4A@mail.gmail.com>
To: Li kunyu <kunyu@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: The process_twopc() function does not
 use a return val and could be changed to void
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

Applied as
https://github.com/LINBIT/drbd/commit/a0cd0ae02fb5c125a6f87284e162decc0965b176

Thanks!
Joel
