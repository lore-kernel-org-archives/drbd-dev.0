Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 305621056471
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 17:47:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E92BF2B6357
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 17:47:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 56KA38So3mLV for <drbd-dev@lists.linbit.com>;
	Wed,  9 Nov 2016 17:47:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 98B122B6BC9
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 17:47:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Jyq1vhEoYy5j for <drbd-dev@lists.linbit.com>;
	Wed,  9 Nov 2016 17:47:45 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6EC5B2B6357
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 17:47:45 +0100 (CET)
Resent-Message-ID: <20161109164745.GM1382@soda.linbit>
Received: from radon.swed.at (b.ns.miles-group.at [95.130.255.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 98AC11056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 16:47:17 +0100 (CET)
To: Jens Axboe <axboe@kernel.dk>, wolfgang.glas@iteg.at,
	christoph.lechleitner@iteg.at, philipp.reisner@linbit.com,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, drbd-dev@lists.linbit.com
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
	<497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
	<20161108165204.GC2834@kernel.dk> <20161109153209.GK1382@soda.linbit>
From: Richard Weinberger <richard@nod.at>
Message-ID: <af05f705-1d2a-6296-ff53-ec047d7fefee@nod.at>
Date: Wed, 9 Nov 2016 16:47:15 +0100
MIME-Version: 1.0
In-Reply-To: <20161109153209.GK1382@soda.linbit>
Content-Type: text/plain; charset=windows-1252
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

On 09.11.2016 16:32, Lars Ellenberg wrote:
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
> 
> If that requires yet additional noise, sure, so be it :)
> 
> Should I sent two patches, one that applies to 4.5 and later,
> and one that applies to 2.6.33 ... 4.4, or are you or stable
> willing to resolve the trivial "missing comment block" conflict yourself?

BTW: Why did you drop the "Fixes:" tag too?

Thanks,
//richard
