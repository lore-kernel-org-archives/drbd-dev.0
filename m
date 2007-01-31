Return-Path: <philipp@hug.cx>
Received: from postman.abacus.ch (postman.abacus.ch [193.246.101.142])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0C2E92D9DED8
	for <drbd-dev@lists.linbit.com>; Wed, 31 Jan 2007 14:35:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by postman.abacus.ch (Postfix) with ESMTP id C835A12F76E
	for <drbd-dev@lists.linbit.com>; Wed, 31 Jan 2007 14:35:21 +0100 (CET)
Received: from postman.abacus.ch ([127.0.0.1])
	by localhost (postman [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13572-01-21 for <drbd-dev@lists.linbit.com>;
	Wed, 31 Jan 2007 14:35:18 +0100 (CET)
Received: from hug64.int.abacus.ch (unknown [172.16.34.85])
	by postman.abacus.ch (Postfix) with ESMTP id 1583112F73A
	for <drbd-dev@lists.linbit.com>; Wed, 31 Jan 2007 14:35:18 +0100 (CET)
From: Philipp Hug <philipp@hug.cx>
To: drbd-dev@lists.linbit.com
Date: Wed, 31 Jan 2007 14:35:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701311435.17357.philipp@hug.cx>
Subject: [Drbd-dev] any chance for a drbdmeta backport to 0.7?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello everyone,

I got a bug report/feature request to implement a feature to delete existing 
metadata on a disk.
This feature seems to be implemented in 0.8. Any chance this will be 
backported?

See here: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=409161

Thanks
Philipp
