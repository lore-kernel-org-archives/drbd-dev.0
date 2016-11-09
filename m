Return-Path: <axboe@kernel.dk>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
	[209.85.214.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1F5E91056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 18:03:13 +0100 (CET)
Received: by mail-it0-f41.google.com with SMTP id u205so284149895itc.0
	for <drbd-dev@lists.linbit.com>; Wed, 09 Nov 2016 09:03:13 -0800 (PST)
To: Richard Weinberger <richard@nod.at>, wolfgang.glas@iteg.at,
	christoph.lechleitner@iteg.at, philipp.reisner@linbit.com,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, drbd-dev@lists.linbit.com
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
	<497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
	<20161108165204.GC2834@kernel.dk> <20161109153209.GK1382@soda.linbit>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <60514f9b-6f1c-8b7e-429a-490cdaae14d8@kernel.dk>
Date: Wed, 9 Nov 2016 09:55:02 -0700
MIME-Version: 1.0
In-Reply-To: <20161109153209.GK1382@soda.linbit>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix kernel_sendmsg() usage
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 11/09/2016 08:32 AM, Lars Ellenberg wrote:
> On Tue, Nov 08, 2016 at 09:52:04AM -0700, Jens Axboe wrote:
>>>> This should go into 4.9,
>>>> and into all stable branches since and including v4.0,
>>>> which is the first to contain the exposing change.
>>>>
>>>> It is correct for all stable branches older than that as well
>>>> (which contain the DRBD driver; which is 2.6.33 and up).
>>>>
>>>> It requires a small "conflict" resolution for v4.4 and earlier, with v4.5
>>>> we dropped the comment block immediately preceding the kernel_sendmsg().
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Cc: viro@zeniv.linux.org.uk
>>>> Cc: christoph.lechleitner@iteg.at
>>>> Cc: wolfgang.glas@iteg.at
>>>> Reported-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
>>>> Tested-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
>>>
>>> Changing my patch is perfectly fine, but please clearly state it.
>>> I.e. by adding something like that before your S-o-b.
>>> [Lars: Massaged patch to match my personal taste...]
>>
>
>> Lars, are you sending a new one? If you do, add the stable tag as well.
>
> So my "change" against his original patch was
> - rv = kernel_sendmsg(sock, &msg, &iov, 1, size - sent);
> + rv = kernel_sendmsg(sock, &msg, &iov, 1, iov.iov_len);
> to make it "more obviously correct" from looking just at the one line
> without even having to read the context.  And a more verbose commit message.

I'm fine with you making that change, I do that too sometimes for
patches. But Richard is absolutely right in that you need to make a note
of that. It's no longer the patch he signed off on, so it needs to
reflect that.

> Should I sent two patches, one that applies to 4.5 and later,
> and one that applies to 2.6.33 ... 4.4, or are you or stable
> willing to resolve the trivial "missing comment block" conflict yourself?

Since it's a trivial one liner, let's just do one for the current series
and the stable folks should be able to do that one. If not, they will
let us know.

-- 
Jens Axboe

