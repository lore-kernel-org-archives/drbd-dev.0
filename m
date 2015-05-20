Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D91FE1028A59
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 13:55:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CE1A344CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 13:55:28 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id kFMzQ-JoE8Sj for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 13:55:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B185944CAF6
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 13:55:28 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9LiagkqFXMGn for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 13:55:28 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 82E7044CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 13:55:28 +0200 (CEST)
Date: Wed, 20 May 2015 13:55:27 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150520115527.GU1968@rck.sh>
References: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
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

On Wed, May 20, 2015 at 11:26:27AM +0200, Dietmar Maurer wrote:
> I have two questions now:
> 
> 1.) Where is the command line to join the node (mentioned in the README above)?

If the node where you execute "add-node" is able to ssh to the new node,
everything is fine and the join is executed for you. If not, the join
command gets printed and you have to manually execute the command on the
new node.

If you want to know which command that would be, you can use:
drbdmanage howto-join <nodename>

> 2.) Does this really destroy all existing resources? If so, how can I add 
> nodes to a cluster which already have existing resources?

Resouces managed by drbdmanage or other drbd (non drbdmanage manged)
resources?

Regards, rck
