Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E2D21056F99
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2013 12:38:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 09EBC44E4E8
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2013 12:38:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZWW_sDK9OVXj for <drbd-dev@lists.linbit.com>;
	Fri, 18 Oct 2013 12:38:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DCC6844E55C
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2013 12:38:05 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MauCyJ08jvF4 for <drbd-dev@lists.linbit.com>;
	Fri, 18 Oct 2013 12:38:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTP id 80DE144E55B
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2013 12:38:05 +0200 (CEST)
Date: Fri, 18 Oct 2013 12:38:04 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20131018103804.GT17724@soda.linbit>
References: <alpine.DEB.2.00.1309261150420.47088@ware.dreamhost.com>
	<20130927124748.GD16596@soda.linbit>
	<alpine.DEB.2.00.1310171558200.1745@ware.dreamhost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1310171558200.1745@ware.dreamhost.com>
Subject: Re: [Drbd-dev] DRBD Trim/discard
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

On Thu, Oct 17, 2013 at 04:00:54PM -0700, Eric Wheeler wrote:
> 
> On Fri, 27 Sep 2013, Lars Ellenberg wrote:
> >On Thu, Sep 26, 2013 at 12:01:40PM -0700, Eric Wheeler wrote:
> >>We would like to run DRBD backed by thin-provisioned volumes (think
> >>ZFS or dm-thinp) which require discard support to dereference unused
> >>block allocations.
> >
> >We are integrating DISCARD / TRIM support into our currently
> >pending DRBD 8.4.4 release, right now. Code changes expected to be
> >pushed with the RC2, latest early next week.
> >
> >Thanks for testing and feedback,
> 
> I just sat down to look into TRIM support in the git tree, none of
> the commits in the shortlog are obvious. Has this already been
> committed? If so, do you have a commit number or alternate git tree
> that I can pull down?

You've been grepping for TRIM, I guess, where we used DISCARD ;-)

Look for "DISCARD" in the commit subjects.
I think it starts with
    drbd: prepare receiving side for REQ_DISCARD

Then a few more, and a few fixes for when exactly to expose QUEUE_FLAG_DISCARD.

Cheers,
	Lars

