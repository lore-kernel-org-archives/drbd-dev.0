Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB8D91011BA2
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 11:27:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A36C3400B4D
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 11:27:31 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fM8JHdhhDB5B for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 11:27:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 86BC3400B72
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 11:27:31 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yi97VgFYUok7 for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 11:27:31 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 61B8E400B4D
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 11:27:31 +0200 (CEST)
Date: Thu, 31 Mar 2016 11:27:30 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160331092730.GH15462@rck.sh>
References: <CAF6H8oGE3dsx89dD_z7gM=h4HuOeHQbSt9ET-6BpV5Hvows7RQ@mail.gmail.com>
	<20160330121519.GG15462@rck.sh>
	<CAF6H8oF9_1J9FqOWFBdW2VRnfXQfOq3oRAFBubE+YzU6+Buz8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6H8oF9_1J9FqOWFBdW2VRnfXQfOq3oRAFBubE+YzU6+Buz8Q@mail.gmail.com>
Subject: Re: [Drbd-dev] [CASE-38] self uuid may be crashed beacuse of
 garbage bitmap_index value.
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

On Thu, Mar 31, 2016 at 11:13:09AM +0900, Jaeheon Kim wrote:
> Dear Roland,
> 
> Let me send test-steps for reproduce of  SyncSource/SyncSource.
> 
> 1. make resync situation with primary/inconsistent - secondary/uptodate.
> 2. copy big file during resyncing.
> 3. stop the secondary node network by disabling secondary node's VMware
> network icon during copying.
> 4. wait until copy finished
> 5. reconnect network by enabling secondary.
> 6. connect by --discard-my-data connect on the secondary node.
> 7. at this time, the each node status is  SyncSource/SyncSource
> 
> Thanks.

We applied your patch (currently not visible in the public repo, but
should happen soon). Thanks for reporting and the test case!

Regards, rck
