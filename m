Return-Path: <lists@alteeve.ca>
Received: from vm08-mail01.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 752A4101AC75
	for <drbd-dev@lists.linbit.com>; Thu, 19 Jun 2014 23:52:54 +0200 (CEST)
Received: from lemass.alteeve.ca (dhcp-108-168-20-202.cable.user.start.ca
	[108.168.20.202])
	by vm08-mail01.alteeve.ca (Postfix) with ESMTPSA id 0AEF1200DD
	for <drbd-dev@lists.linbit.com>; Thu, 19 Jun 2014 17:46:49 -0400 (EDT)
Message-ID: <53A35A4B.4050408@alteeve.ca>
Date: Thu, 19 Jun 2014 17:46:51 -0400
From: Digimer <lists@alteeve.ca>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Patch for stonith_admin-fence-peer.sh
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

This will help with debugging by telling pacemaker who called stonith_admin.

--- /usr/lib/drbd/stonith_admin-fence-peer.sh.orig	2014-06-19 
15:15:31.281041648 -0400
+++ /usr/lib/drbd/stonith_admin-fence-peer.sh	2014-06-19 
17:38:37.532311566 -0400
@@ -30,7 +30,7 @@
  fi

  for p in $DRBD_PEERS; do
-  stonith_admin --fence $p
+  stonith_admin --tag drbd --fence $p
    rc=$?
    if [ $rc -eq 0 ]; then
      log "stonith_admin successfully fenced peer $p."



-- 
Digimer
Papers and Projects: https://alteeve.ca/w/
What if the cure for cancer is trapped in the mind of a person without 
access to education?
