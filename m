Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 995BF1089A62
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jun 2010 11:45:10 +0200 (CEST)
Message-ID: <4C15FA1C.1080901@kernel.dk>
Date: Mon, 14 Jun 2010 11:45:00 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <20100610135203.4649453a.sfr@canb.auug.org.au>
	<20100614112639.ef45a777.sfr@canb.auug.org.au>
	<4C15F18C.3050905@kernel.dk>
	<201006141143.42783.philipp.reisner@linbit.com>
In-Reply-To: <201006141143.42783.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with the
	block trees
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2010-06-14 11:43, Philipp Reisner wrote:
> Am Montag, 14. Juni 2010, um 11:08:28 schrieb Jens Axboe:
>> On 2010-06-14 03:26, Stephen Rothwell wrote:
>>> Hi Jens, Philipp,
>>>
>>> On Thu, 10 Jun 2010 08:01:35 +0200 Jens Axboe <axboe@kernel.dk> wrote:
>>>> I'm starting to think that it would be a little easier if you did not
>>>> pull the drbd tree, I really should be pulling that into my -next branch
>>>> instead.
>>>
>>> Given that the drbd tree has not been updated to match the increasingly
>>> different block tree, I have dropped it for today.
>>>
>>> There a a few possibilities here:
>>> 	- I just drop the drbd tree completely and it only gets merged
>>>
>>> into the block tree.
>>>
>>> 	- if the drbd tree doesn't actually depend on any of the features
>>>
>>> in the block tree then it could be rebased onto Linus tree (and I would
>>> cope with any merge fixups - as I do with many other trees).
>>>
>>> 	- if it does depend on things in the block tree, those particular
>>>
>>> features in the block tree could be put in a separate branch that is
>>> never rebased and then that branch could be merged into both the block
>>> and drbd trees (this has been done before e.g. stuff in the vfs tree.
>>>
>>> 	- the drbd tree could be rebased on tom of the current block tree
>>>
>>> (but then it must be kept up to date if the block tree is rebased).
>>
>> The thing with the dependencies is that sometimes they are true,
>> sometimes they are not. What I suggested to the drbd team is that they
>> always just base off Linus and then ask me to pull their changes, then I
>> will resolve any potential conflicts when that happens. The consequence
>> would be that you stop pulling the drbd tree separately.
> 
> Ok, from now on I will use Linus most recent -rc as base and put DRBD
> patches on top of that. -- I will do this today (CEST timezone).

You want to continue to use for-2.6.xx for your next version updates, as
that has a larger risk of containing things you need to adapt to. But
for current version patches, Linus' branch is fine.

-- 
Jens Axboe

