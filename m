Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E0EA11051881
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:40:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CE00944CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:40:12 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OR3thTbjtiRU for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 14:40:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B19FB44CFEB
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:40:12 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zcePrpYPDlAT for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 14:40:12 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 7E5BD44CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:40:12 +0200 (CEST)
Date: Wed, 20 May 2015 14:40:10 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150520124010.GW1968@rck.sh>
References: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
	<20150520115527.GU1968@rck.sh>
	<1438073088.99.1432123743344.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438073088.99.1432123743344.JavaMail.open-xchange@ronja.mits.lan>
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

On Wed, May 20, 2015 at 02:09:03PM +0200, Dietmar Maurer wrote:
> > > 1.) Where is the command line to join the node (mentioned in the README
> > > above)?
> > 
> > If the node where you execute "add-node" is able to ssh to the new node,
> > everything is fine and the join is executed for you. 
> 
> The README tell to execute new-node always on 
> "a node of the existing drbdmanage cluster"
> So for example, I should run 'add-node' always on the first node?
> Is that correct?

On any node that is already in the cluster... I always use the first
node.

> 
> > If not, the join
> > command gets printed and you have to manually execute the command on the
> > new node.
> > 
> > If you want to know which command that would be, you can use:
> > drbdmanage howto-join <nodename>
> > 
> > > 2.) Does this really destroy all existing resources? If so, how can I add 
> > > nodes to a cluster which already have existing resources?
> > 
> > Resouces managed by drbdmanage 
> 
> yes
> 

In that case it is exactly as drbdmanage told you:

CAUTION! Note that:
* Any previous drbdmanage cluster information may be removed
* Any remaining resources managed by a previous drbdmanage installation
that still exist on this system will no longer be managed by drbdmanage

The control volume gets overwritten, the old information is lost.

Regards, rck

P.S.:
1) Don't TO/CC me, I'm on the list.
2) Use the drbd-user list for that kind of questions.

