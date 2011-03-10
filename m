Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CBED01056F68
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2011 10:57:28 +0100 (CET)
Message-ID: <4D789ED1.6060905@kernel.dk>
Date: Thu, 10 Mar 2011 10:50:09 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <201103091523.51815.philipp.reisner@linbit.com>
In-Reply-To: <201103091523.51815.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD bits for 2.6.39
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-03-09 15:23, Philipp Reisner wrote:
> The following changes since commit cd9bd3a0b4d9f3943753a949fff411c719530f8c:
> 
>   staging: Convert to bdops->check_events() (2011-03-09 10:19:17 +0100)
> 
> are available in the git repository at:
>   git://git.drbd.org/linux-2.6-drbd.git for-jens

Philip, sorry for the extra work, but can I please ask you to rebase
this on the new for-2.6.39/core? Two things happened:

- I pulled in the stack-plug changes, it's causing a few conflicts. All
  of them are trivial, so that's not a real worry.

- I had to rebase for-2.6.39/core to get rid of an OOPS in the
  ->check_events() changes from Tejun.

-- 
Jens Axboe

