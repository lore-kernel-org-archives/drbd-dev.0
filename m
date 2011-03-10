Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CEAC81056F66
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2011 12:26:05 +0100 (CET)
Message-ID: <4D78B54B.2060803@kernel.dk>
Date: Thu, 10 Mar 2011 12:26:03 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <201103091523.51815.philipp.reisner@linbit.com>
	<4D789ED1.6060905@kernel.dk>
	<201103101200.24005.philipp.reisner@linbit.com>
In-Reply-To: <201103101200.24005.philipp.reisner@linbit.com>
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

On 2011-03-10 12:00, Philipp Reisner wrote:
> [...]
>> Philip, sorry for the extra work, but can I please ask you to rebase
>> this on the new for-2.6.39/core? Two things happened:
>>
>> - I pulled in the stack-plug changes, it's causing a few conflicts. All
>>   of them are trivial, so that's not a real worry.
>>
>> - I had to rebase for-2.6.39/core to get rid of an OOPS in the
>>   ->check_events() changes from Tejun.
> 
> Hi Jens,
> 
> Done, it is rebased:
> 
> The following changes since commit 4c63f5646e405b5010cc9499419060bf2e838f5b:
> 
>   Merge branch 'for-2.6.39/stack-plug' into for-2.6.39/core (2011-03-10 
> 08:58:35 +0100)
> 
> are available in the git repository at:
> 
>   git://git.drbd.org/linux-2.6-drbd.git for-jens

Awesome, thanks!

Now that I have your attention... Did you look at the plugging changes?
As Christoph mentioned, you seem to be passing plugging information on
the wire. What is the reason for that? With the on-stack plugging, these
events are not seen by the block device anymore.

> BTW, since we got a request for a "summary change-log":

Yes, please do that in the future, it's good to have a verbalized
summary outside of the shortlog.

-- 
Jens Axboe

