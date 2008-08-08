Return-Path: <drbd.niko@gmail.com>
Received: from mail-gx0-f27.google.com (mail-gx0-f27.google.com
	[209.85.217.27])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6E4F22E0903F
	for <drbd-dev@lists.linbit.com>; Fri,  8 Aug 2008 10:30:20 +0200 (CEST)
Received: by gxk8 with SMTP id 8so5964795gxk.3
	for <drbd-dev@lists.linbit.com>; Fri, 08 Aug 2008 01:30:19 -0700 (PDT)
From: niko <drbd.niko@gmail.com>
To: drbd-dev@lists.linbit.com
In-Reply-To: <20080806100003.E28A12E3A53E@mail.linbit.com>
References: <20080806100003.E28A12E3A53E@mail.linbit.com>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 16:16:43 +0800
Message-Id: <1218183403.3749.16.camel@niko.infocore.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] The drbd resync process
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Consider node A crashed as primary and rejoining the cluster,B as the
surviving node.
What's the resync process ?

I can't find how the drbd_start_resync () function call the
w_make_resync_request() to send RSDataRequest message to the SyncSource

When the peer node recovers or the connection is re-established, DRBD
combines the bitmap information from both nodes to determine the total
data set that it must re-synchronize.

Why DRBD needs to combines the bitmap information from both nodes since
one is Primary,the other is Secondary?

Thanks ,I'm just a learner.

