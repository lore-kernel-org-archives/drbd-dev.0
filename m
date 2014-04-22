Return-Path: <ls@numerigraphe.com>
Received: from chr.numerigraphe.com (chr.numerigraphe.com [91.121.34.38])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C28A4101AC75
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 17:53:56 +0200 (CEST)
Received: from localhost.localdomain (ovh3 [5.135.35.94])
	by chr.numerigraphe.com (Postfix) with ESMTP id 7571819600D6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 17:53:55 +0200 (CEST)
Message-ID: <53569092.5010101@numerigraphe.com>
Date: Tue, 22 Apr 2014 17:53:54 +0200
From: Lionel Sausin <ls@numerigraphe.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <535658E0.7060409@numerigraphe.com>
	<20140422125624.GB2209@soda.linbit>
In-Reply-To: <20140422125624.GB2209@soda.linbit>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] drbdsetup legacy utils can't fall back to version 8.3
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

Thanks for your answer.
The Ubuntu maintainer decided to apply the following patch:
     https://launchpadlibrarian.net/173471818/drbdsetup-fix.debdiff
Regards,
Lionel.

Le 22/04/2014 14:56, Lars Ellenberg a écrit :
> "Correct" is whatever works for you.
> As long as you know what version you are using, use the matching tools.
>
> Note that using explicit path (anything with a '/' in it)
> on drbdadm or drbdsetup causes them to expect the respective "legacy"
> binary at that same path, beneath the current executable.
> (on purpose).
>
> So if you want to say /sbin/drbdsetup, and expect that to be able to
> execvp drbdsetup-83, then yes, you have to make that accesible under
> /sbin/drbdsetup-83, adding it to the PATH will not be good enough.
>
> Also, as a heads up, we are in the process on splitting out the DRBD
> userland, providing the "grand unified drbd utils", so this will all
> change again within the next few weeks/month.
