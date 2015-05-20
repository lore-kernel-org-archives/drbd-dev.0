Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 175DD1051881
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:09:05 +0200 (CEST)
Date: Wed, 20 May 2015 14:09:03 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Message-ID: <1438073088.99.1432123743344.JavaMail.open-xchange@ronja.mits.lan>
In-Reply-To: <20150520115527.GU1968@rck.sh>
References: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
	<20150520115527.GU1968@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] cluster initialization with drbdmanage
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
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

> > 1.) Where is the command line to join the node (mentioned in the README
> > above)?
> 
> If the node where you execute "add-node" is able to ssh to the new node,
> everything is fine and the join is executed for you. 

The README tell to execute new-node always on 
"a node of the existing drbdmanage cluster"
So for example, I should run 'add-node' always on the first node?
Is that correct?

> If not, the join
> command gets printed and you have to manually execute the command on the
> new node.
> 
> If you want to know which command that would be, you can use:
> drbdmanage howto-join <nodename>
> 
> > 2.) Does this really destroy all existing resources? If so, how can I add 
> > nodes to a cluster which already have existing resources?
> 
> Resouces managed by drbdmanage 

yes

