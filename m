Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust154.tnt5.ber2.deu.da.uu.net [149.225.86.154])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9815F142F2
	for <drbd-dev@lists.linbit.com>; Sat, 21 Aug 2004 00:09:44 +0200 (CEST)
Date: Sat, 21 Aug 2004 00:11:39 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <OV4HgwTatHb8LrbiI2ItmW8=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] version tag in drbd.conf
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

I think it would be a good idea to put some version tag into the
drbd.conf, it could be masked with a comment character to be compatible
with current drbdadm.

we should require it to be within the first (few...) line(s) of the
file. once introduced, in case we add more options later, we could give
an error message like "please update your user tools" instead of
"unknown token"...

just a thought...

	lge

