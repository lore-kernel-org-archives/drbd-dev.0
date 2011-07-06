Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 545921056835
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jul 2011 20:20:19 +0200 (CEST)
Resent-Message-ID: <20110707182018.GE5862@barkeeper1-xen.linbit>
Received: from smtp5.server.rpi.edu (smtp5.server.rpi.edu [128.113.2.225])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E2C7D1056672
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jul 2011 00:35:34 +0200 (CEST)
Received: from [129.161.1.45] (bree.ccni.rpi.edu [129.161.1.45])
	by smtp5.server.rpi.edu (8.13.1/8.13.1) with ESMTP id p66LO7KX017506
	for <drbd-dev@lists.linbit.com>; Wed, 6 Jul 2011 17:24:07 -0400
Message-ID: <4E14D277.4050106@rpi.edu>
Date: Wed, 06 Jul 2011 17:24:07 -0400
From: Lindsay Todd <toddr@rpi.edu>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------000202070705000500050207"
Subject: [Drbd-dev] Building drbd RPM on Scientific Linux 6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------000202070705000500050207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I needed to build DRBD 8.3.11 on a Scientific Linux 6 (Red Hat 6 clone)
system with support for rgmanager.  However, the resulting RPMs require
rgmanager < 3.  The attached patch to the spec file fixes that problem.

-- 
R. Lindsay Todd, PhD                 email: toddr@rpi.edu
Senior Systems Programmer            phone: 518-276-2605
Rensselaer Polytechnic Institute     fax:   518-276-2809
Troy, NY 12180-3590                  WWW:   http://www.rpi.edu/~toddr

The views, opinions, and judgments expressed in this message are
solely those of the author. The message contents have not been
reviewed or approved by Rensselaer.


--------------000202070705000500050207
Content-Type: text/x-patch;
 name="drbd-8.3.11-sl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="drbd-8.3.11-sl.diff"

--- drbd.spec.in.ORIG	2011-07-06 15:52:39.292317940 -0400
+++ drbd.spec.in	2011-07-06 15:55:35.161538906 -0400
@@ -208,7 +208,11 @@
 %package rgmanager
 Summary: Red Hat Cluster Suite agent for DRBD
 Group: System Environment/Base
+%if 0%{?centos} != 6 && 0%{?rhel} != 6
 Requires: %{name}-utils = %{version}-%{release}, rgmanager < 3
+%else
+Requires: %{name}-utils = %{version}-%{release}
+%endif
 # RHEL 6 removed some scripts from upstream version,
 # including drbd. Heuristic only...
 %if 0%{?centos} != 6 && 0%{?rhel} != 6

--------------000202070705000500050207--
