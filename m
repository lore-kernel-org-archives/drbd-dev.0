Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CE8D31056304
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2016 13:27:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BA3E9362BE7
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2016 13:27:02 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KkhX5NpFkg0N for <drbd-dev@lists.linbit.com>;
	Wed, 27 Jan 2016 13:27:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 764AD362BE9
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2016 13:27:02 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0cJaVxikNjqY for <drbd-dev@lists.linbit.com>;
	Wed, 27 Jan 2016 13:27:02 +0100 (CET)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 37273362BE7
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2016 13:27:02 +0100 (CET)
Date: Wed, 27 Jan 2016 13:27:01 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160127122700.GE1359@rck.sh>
References: <56A86573.2000702@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A86573.2000702@proxmox.com>
Subject: Re: [Drbd-dev] DRBD for linux 4.4
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

On Wed, Jan 27, 2016 at 07:36:35AM +0100, Thomas Lamprecht wrote:
> Hi all,
> 
> I'm currently experimenting with the 4.4 Kernel (used minor patched
> ubuntu/unstable) for PVE and saw that I couldn't build drbd-9 as there
> were minor API changes in the Kernel and thus it's not compatible at
> the moment.  But to be honest as a matter of time I didn't looked into
> what all changed and what is to change in drbd.
> 
> Are there any plans at the moment to fix that?

Sure, we will fix that eventually. This usually happens when we either
do a new release or it bites one of us developers.

Regards, rck
