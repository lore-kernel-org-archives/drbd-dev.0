Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8878F10556B0
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:37:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7A2A946D1B0
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:37:39 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id o_g0c5y1KJGT for <drbd-dev@lists.linbit.com>;
	Wed,  9 Sep 2015 10:37:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6040F46D1BF
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:37:39 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aY59yBe9dUtl for <drbd-dev@lists.linbit.com>;
	Wed,  9 Sep 2015 10:37:39 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 2EFDE46D1B0
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:37:39 +0200 (CEST)
Date: Wed, 9 Sep 2015 10:37:38 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150909083737.GC1313@rck.sh>
References: <55EF7BEA.5060409@alteeve.ca> <55EFD2FD.6010500@alteeve.ca>
	<20150909082106.GB1313@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150909082106.GB1313@rck.sh>
Subject: Re: [Drbd-dev] rhcs_fence
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

On Wed, Sep 09, 2015 at 10:21:07AM +0200, Roland Kammerer wrote:
> On Wed, Sep 09, 2015 at 02:34:37AM -0400, Digimer wrote:
> > On 08/09/15 08:23 PM, Digimer wrote:
> > > Is rhcs_fence not shipped with drbd 8.4?
> > 
> > If not (it appears not), and if there is interest in adding it, I've
> > moved it's development into the main striker repo:
> > 
> > https://github.com/digimer/striker/blob/master/tools/rhcs_fence
> > 
> 
> Mind the repo-split... There is one in drbd-utils/scripts
> 

Oh, ours is the bash version Lars wrote, yours is the one in perl.

It's neither my expertise nor my decision, but FWIW: My (evil) plan is
to get rid of the existing perl code (AFAIK drbd-overview.pl), so
personally I am not a fan of merging perl code. I would like to drop the
perl dependency. For example RHEL7 does not ship perl in its minimal setup
configuration if I remember correctly.

Regards, rck
