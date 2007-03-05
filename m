Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 79FDC2CFF833
	for <drbd-dev@lists.linbit.com>; Mon,  5 Mar 2007 20:35:23 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HOIxa-0004WK-Of
	for drbd-dev@lists.linbit.com; Mon, 05 Mar 2007 20:35:02 +0100
Received: from 84.237.164.150 ([84.237.164.150])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Mon, 05 Mar 2007 20:35:02 +0100
Received: from daliv by 84.237.164.150 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Mon, 05 Mar 2007 20:35:02 +0100
To: drbd-dev@lists.linbit.com
From: "daliv@apollo.lv" <daliv@apollo.lv>
Date: Mon, 05 Mar 2007 21:14:48 +0200
Message-ID: <eshq85$cm0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: news <news@sea.gmane.org>
Subject: [Drbd-dev] Suggestion: secondary socket address
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

suggestion in result of persistent development problems sky2 driver for 
"Marvell Technology" network cards:
add possibility to set backup direction of socket for each drbd resource
example :

on host01.domain {
     device    /dev/drbd0;
     disk      /dev/sdb1;
     address   10.0.2.2:7788;
     address-backup   10.0.1.200:7788;
     meta-disk internal;
}

or may be with backup leveling
     address-backup   10.0.1.200:7788 level 1; // if primary failed - 
then here
     address-backup   10.0.3.200:7788 level 2; // if primary and 
secondary faled - then try to reconnect thru this connection

eth0 : 10.0.1.0/24 - main corporate LAN
eth1 : 10.0.2.0/24 - only interserver network - not for real client
eth2 : 10.0.3.0/24 - additional lan/wan connections

listeners for level 1,2 may be not initialised on startup, but only in 
error state of primary listener.
when primary listener will back (periodical recheck) - drbd 
communication must return automaticaly to that.

+ additionally notifies about channel changes to admin email.

