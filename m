Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EB11F10556CA
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 09:30:29 +0100 (CET)
Received: by bkbzs8 with SMTP id zs8so8937410bkb.27
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 00:30:28 -0800 (PST)
Message-ID: <4EBF8022.6020202@hastexo.com>
Date: Sun, 13 Nov 2011 09:30:26 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com,
	The Pacemaker cluster resource manager <pacemaker@oss.clusterlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Cc: "Robinson, Eric" <eric.robinson@psmnv.com>
Subject: [Drbd-dev] crm_attribute --quiet (was Fwd: [Linux-HA] Should This
	Worry Me?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars/Andrew,

While Eric is evidently on a DRBD version whose ocf:linbit:drbd does not
invoke crm_attribute with the flag to suppress logging, I'm mildly
confused as to what the correct flag actually is. ocf:linbit:drbd (in
both 8.3 and 8.4) uses "-Q" whereas Pacemaker expects "-q" as of this
commit:

commit c11ce5e9b0b13ead02b5fc4add928d7e7f95092e
Author: Andrew Beekhof <andrew@beekhof.net>
Date:   Tue Sep 22 17:29:38 2009 +0200

    Medium: Tools: Use -q as the short form for --quiet (for consistency)

    Mercurial revision: 7289e661e4923beee4b7b45bc85592564ccdc438

Should ocf:linbit:drbd be using "-q"?

Cheers,
Florian

-------- Original Message --------
Subject: [Linux-HA] Should This Worry  Me?
Date: Sat, 12 Nov 2011 18:02:51 -0800
From: Robinson, Eric <eric.robinson@psmnv.com>
Reply-To: General Linux-HA mailing list <linux-ha@lists.linux-ha.org>
To: <linux-ha@lists.linux-ha.org>

Should I be concerned that the standby node of a 2-node cluster is
logging these messages about every 15 seconds? This cluster has been up
and running apparently fine for a year.

Nov 12 17:53:59 ha05 crm_attribute: [2420]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:54:14 ha05 crm_attribute: [2455]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:54:29 ha05 crm_attribute: [2482]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:54:44 ha05 crm_attribute: [2510]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:54:59 ha05 crm_attribute: [2537]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:55:14 ha05 crm_attribute: [2574]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:55:29 ha05 crm_attribute: [2603]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
Nov 12 17:55:44 ha05 crm_attribute: [2633]: info: Invoked: crm_attribute
-N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100

--
Eric Robinson
