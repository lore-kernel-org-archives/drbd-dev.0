Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
	[209.85.218.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6CA994201D4
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2022 17:07:01 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id u15so12870439ejf.11
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2022 08:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNP_+VZLZhCuMymZO+qwSDZmFjYgyJHLfsPLwGZaGE+E5cD_Q@mail.gmail.com>
	<ALwAwgD0IQVS18p0UFmrbKrn.3.1649679152288.Hmail.rui.xu@easystack.cn>
In-Reply-To: <ALwAwgD0IQVS18p0UFmrbKrn.3.1649679152288.Hmail.rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Mon, 11 Apr 2022 17:06:49 +0200
Message-ID: <CAGNP_+U6QZGQmRyWZPtX7CvoQoACFNtBYFSuV2sN0odQRZtQwA@mail.gmail.com>
To: Xu Rui <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: create new uuid even we dont have
	quorum
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

> By the way, have you focused on DRBD9.1 and is there a stable verison of it?

We have stopped working on 9.0. The final release was 9.0.32 (see the
release announcement). For now, we are continuing to apply fixes to
allow it to be built for newer kernels, but otherwise the 9.0 branch
is end-of-life.

DRBD 9.1 is as stable as 9.0 was. The most recent release is 9.1.6.

Since 9.1.6, the 9.1 branch has received significant work in the area
of handling suspended IO due to quorum loss. It looks like this might
be relevant for you. There will be a 9.1.7 release soon containing
these fixes.

Best regards,
Joel
