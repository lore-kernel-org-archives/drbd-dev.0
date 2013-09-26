Return-Path: <drbd@ew.ewheeler.org>
Received: from hapkido.dreamhost.com (hapkido.dreamhost.com [66.33.216.122])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E931101AC79
	for <drbd-dev@lists.linbit.com>; Thu, 26 Sep 2013 21:09:06 +0200 (CEST)
Received: from homiemail-a7.g.dreamhost.com (mailbigip.dreamhost.com
	[208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 2FC1BDE550
	for <drbd-dev@lists.linbit.com>; Thu, 26 Sep 2013 12:02:43 -0700 (PDT)
Received: from homiemail-a7.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a7.g.dreamhost.com (Postfix) with ESMTP id 5A61E25C074
	for <drbd-dev@lists.linbit.com>; Thu, 26 Sep 2013 12:01:44 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ewheeler@ewheeler.net)
	by homiemail-a7.g.dreamhost.com (Postfix) with ESMTPSA id 1FBD525C06E
	for <drbd-dev@lists.linbit.com>; Thu, 26 Sep 2013 12:01:44 -0700 (PDT)
Date: Thu, 26 Sep 2013 12:01:40 -0700 (PDT)
From: Eric Wheeler <drbd@ew.ewheeler.org>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.DEB.2.00.1309261150420.47088@ware.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Subject: [Drbd-dev] DRBD Trim/discard
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


Hello all,


We would like to run DRBD backed by thin-provisioned volumes (think ZFS or 
dm-thinp) which require discard support to dereference unused block 
allocations.  (I searched around for DRBD trim/discard support with little 
commentary except the reference [1] below which does not apply to our use 
case.)


Is discard support on the roadmap?

What are the technical considerations for implementation?

I'm guessing this would be a relatively simple patch, just need to add a 
discard flag to the wire protocol and pass that to the backing device 
(after calculating the metadata offset, if any).

If you can comment on the desired implementation of such a feature and 
point me in the right direction I may be able to write a patch and test.

Any help you can offer would be greatly appreciated!

-Eric

[1] http://lists.linbit.com/pipermail/drbd-user/2012-March/017987.html


--
Eric Wheeler
eWheeler Inc.
http://www.globallinuxsecurity.pro/


