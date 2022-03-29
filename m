Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
	[209.85.215.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8112B420192
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 14:29:43 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id t13so13436704pgn.8
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 05:29:43 -0700 (PDT)
Message-ID: <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
Date: Tue, 29 Mar 2022 06:29:40 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@lst.de>
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
	<CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
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

On 3/29/22 1:50 AM, Philipp Reisner wrote:
>> The complete lack of bug reports and maintainer interaction usually
>> suggests low to no use and heavy bitrot.  If that is not the case
>> here that's fine, just asking..
>>
> 
> FYI, feature-wise the in-tree DRBD is frozen. Maintenance only. Users,
> seeking advanced
> features switch to the out-of-tree DRBD and use other means of communication:
> Github issues, linbit's community slack channel, last not least
> linbit's ticketing system.
> 
> That is why you see virtually no activity.

I've been thinking the same thing. Even if most users are out-of-tree, you'd
still expect to see at least some reports on the list. A few followup
questions:

- Why aren't the drbd maintainers responding to posted patches? They seem
  to simply be ignored, and I'm left to pickup the trivial ones that look
  fine to me. In-kernel drbd appears largely unmaintained, and has been for
  years.

- Even if out-of-band communication is used for in-kernel users of drbd,
  that doesn't result in any patches or fixes that should go upstream?

- If there's zero activity for in-kernel drbd, all users are using the
  out-of-tree version?

As far as I can tell, drbd upstream is stone cold dead, and has been for
years. Why shouldn't it just get removed? Is it just bait to get people
to use an out-of-tree version?

-- 
Jens Axboe

