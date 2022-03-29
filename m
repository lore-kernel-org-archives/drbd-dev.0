Return-Path: <philipp.reisner@linbit.com>
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
	[209.85.221.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AAAA942018F
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 09:24:44 +0200 (CEST)
Received: by mail-vk1-f181.google.com with SMTP id 47so3919818vki.12
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 00:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de>
In-Reply-To: <20220329070618.GA20396@lst.de>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 29 Mar 2022 09:24:33 +0200
Message-ID: <CADGDV=XrhzSxLyES9dtKj1-cQq6Zh32psipLJCoDGRNzAYaZwA@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] state of drbd in mainline
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

Hi Christoph,

what do you expect for the DRBD changes? Usually, they fall into the
category: yes, obviously. When you are changing the block layer in
this way, then that is necessary for the in-tree DRBD code.

Regarding users: Yes, there are users of the in-tree DRBD code. Very
big corporations. And, yes, we see pressure building up that we get
our act together and re-sync the in-tree DRBD with the out-of tree
DRBD.

best regards,
 Phil


On Tue, Mar 29, 2022 at 9:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> while I've been reworking large parts of the block layer over the
> last months I've basically never gotten drbd reviews, and in general
> drbd seems to be completely maintained upstream.  Do we even have users
> for it?  Is it time to drop drbd from the kernel tree?
>
> Thanks,
>         Christoph
