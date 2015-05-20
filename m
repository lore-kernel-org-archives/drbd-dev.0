Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E782D105058C
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:01:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C23F844CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:01:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Vl6QjpMbUGjm for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 14:01:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A47F544CAF6
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:01:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yLa3Be7eKofg for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 14:01:49 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 58AC544CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:01:49 +0200 (CEST)
Date: Wed, 20 May 2015 14:01:48 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150520120147.GV1968@rck.sh>
References: <1335158101.57.1432118468143.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1335158101.57.1432118468143.JavaMail.open-xchange@ronja.mits.lan>
Subject: Re: [Drbd-dev] howto enable auto-promote
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

On Wed, May 20, 2015 at 12:41:08PM +0200, Dietmar Maurer wrote:
> I am trying to live migrate a kvm based VM which uses a 
> drbd9 image created with drbdmanage. But I get the 
> following error:
> 
> [ 7268.069023] drbd vm-100-disk-1: Auto-promote failed: Multiple primaries not
> allowed by config
> 
> So how can I enable the auto-promote feature?

Auto-promote is enabled. As you can see it failed, and it can only fail
if it was enabled... Your problem is the "multiple primaries" thingy.
Please tell us which drbdmanage commands you executed. The granularity
of "trying to live migrate" is a bit too coarse to reproduce the issue.
At least for me.

Regards, rck
