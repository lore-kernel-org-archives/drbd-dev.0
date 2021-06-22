Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
	[209.85.218.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AA71242032D
	for <drbd-dev@lists.linbit.com>; Tue, 22 Jun 2021 11:21:39 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id nb6so33307716ejc.10
	for <drbd-dev@lists.linbit.com>; Tue, 22 Jun 2021 02:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMgLiBtVkgEaTiY6UaoYcimywHmurz6-yETyKyDUdycgAOzkOA@mail.gmail.com>
In-Reply-To: <CAMgLiBtVkgEaTiY6UaoYcimywHmurz6-yETyKyDUdycgAOzkOA@mail.gmail.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Tue, 22 Jun 2021 11:21:28 +0200
Message-ID: <CAGNP_+XoT9k3UALO7Wakg286w8HvUcN2AtZYuzaO480e8P1KSg@mail.gmail.com>
To: fei luo <morphyluo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Fix drbd adding volume dynamically problem
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

This sounds similar to an issue that we are already aware of. Are you
using Linstor and a thin-provisioned backing pool perhaps?

This is not that high on our priorities because it is an unusual
use-case. Multiple volumes are used to form a consistency group.
Generally when you need a consistency group, you know at the point
when you create the volumes, so you create all the volumes at once. If
I have understood correctly, this issue only occurs when you add a
volume to a resource which is already up. What is your use-case where
you need to do this?

I have not looked at the patch in detail yet.

Best regards,
Joel
