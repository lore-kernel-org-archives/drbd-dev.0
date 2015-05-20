Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9F0B31045C28
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 15:23:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 91FA844CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 15:23:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JrOoOEPxaJBs for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 15:23:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6BA9C44D0BB
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 15:23:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rKqE08fx8Qal for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 15:23:06 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 408C244CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 15:23:06 +0200 (CEST)
Date: Wed, 20 May 2015 15:23:05 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150520132305.GY1968@rck.sh>
References: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
	<20150520115527.GU1968@rck.sh>
	<1438073088.99.1432123743344.JavaMail.open-xchange@ronja.mits.lan>
	<20150520124010.GW1968@rck.sh>
	<2051305130.123.1432126495128.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2051305130.123.1432126495128.JavaMail.open-xchange@ronja.mits.lan>
Subject: Re: [Drbd-dev] cluster initialization with drbdmanage
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

On Wed, May 20, 2015 at 02:54:54PM +0200, Dietmar Maurer wrote:
> > In that case it is exactly as drbdmanage told you:
> > 
> > CAUTION! Note that:
> > * Any previous drbdmanage cluster information may be removed
> > * Any remaining resources managed by a previous drbdmanage installation
> > that still exist on this system will no longer be managed by drbdmanage
> > 
> > The control volume gets overwritten, the old information is lost.
> 
> But what if I want to add additional nodes to a cluster later?

It is fine to add additional nodes later as long as they are really new
and do not contain a control volume or you are willing to overwrite the
existing control volume of that node. The state of your cluster is not
affected by that, only the new node.

I guess, what you mean by "add additional nodes" is merging two
clusters, right? So adding a node node X to cluster A, that was
previously in cluster B and contains resources from the old cluster B.
Right? If it would not have been part of some kind of cluster B, it
would not have a control volume. "add-node" is synonymous for
"new-node". And "new-node" means that this node becomes part of the new
cluster and its old information is not required anymore.

It is the third time I ask you to switch to drbd-user and to not TO/CC
me. Is it really that difficult?

Regards, rck
