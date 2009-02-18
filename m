Return-Path: <dk@in-telegence.net>
Received: from mail.in-telegence.net (mail.in-telegence.net [83.125.45.125])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DE95D1011BB5
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:57:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.in-telegence.net (Postfix) with ESMTP id 213D74B7959
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:38:31 +0100 (CET)
Received: from 127.0.0.1/32:45434 (from=<dk@in-telegence.net>;
	helo=mail.in-telegence.net)
	by eXpurgate V1.3.53.1, id=150498::090218143830-003B0400-27BDD7A3
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:38:30 +0100
Received: from [10.2.20.85] (DK.in-telegence.net [10.2.20.85])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail.in-telegence.net (Postfix) with ESMTP id 9263D488AAA
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:38:30 +0100 (CET)
Message-ID: <499C0F88.3050303@in-telegence.net>
Date: Wed, 18 Feb 2009 14:39:20 +0100
From: Dominik Klein <dk@in-telegence.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------080504030905050401090608"
Subject: [Drbd-dev] Patch: drbdadm.sh
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------080504030905050401090608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

When using the bash completion feature on machines with currently
unconfigured drbd resources, it kept throwing error messages rendering
the cmdline unreadable.

Typing "drbdadm pr<tab> <tab>" would give s.th. like

dktest3:~ # drbdadm primary /dev/drbd0: Failure: (127) Device minor not
allocated
Command 'drbdsetup /dev/drbd0 state' terminated with exit code 10
kvm2

Consider the attached patch.

Regards
Dominik

--------------080504030905050401090608
Content-Type: text/x-patch;
 name="drbdadm.sh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="drbdadm.sh.patch"

--- /etc/bash_completion.d/drbdadm.sh	2009-02-18 14:25:18.000000000 +0100
+++ /etc/bash_completion.d/drbdadm.sh	2009-02-18 14:28:05.000000000 +0100
@@ -36,7 +36,7 @@
 	local resources="$(drbdadm sh-resources)"
 	local filtered_resources
 	for res in $resources; do
-		local resource_status="$(drbdadm $status_type $res 2>/dev/null)"
+		local resource_status="$(drbdadm $status_type $res)"
 		local i
 		for i in $status_filter; do
 			if [ "${resource_status%%/*}" = $i ]; then

--------------080504030905050401090608--
