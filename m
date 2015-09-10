Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0096.outbound.protection.outlook.com [65.55.169.96])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C39A7100EC11
	for <drbd-dev@lists.linbit.com>; Thu, 10 Sep 2015 19:33:10 +0200 (CEST)
To: <drbd-dev@lists.linbit.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <55F1BECF.1000409@sandisk.com>
Date: Thu, 10 Sep 2015 10:33:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH] drbd-km.spec: Port to openSuSE
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

Currently building an RPM with the drbd-km.spec fails on openSuSE
because of an incorrect build dependency (kernel-syms instead of
kernel-default-devel). Fix the algorithm in the spec file for
determining the kernel development RPM name. Note: if the kernel
development headers have not been installed as an RPM the
%{kernel_devel_rpm} variable will be empty.

This patch has been tested on openSuSE 13.2, CentOS 7.1 and SLES11 SP3.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 drbd-km.spec | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drbd-km.spec b/drbd-km.spec
index e5ad36b..a738b58 100644
--- a/drbd-km.spec
+++ b/drbd-km.spec
@@ -3,6 +3,14 @@
 # PLEASE: provide both (correctly) or none!!
 %{!?kernelversion: %{expand: %%define kernelversion %(uname -r)}}
 %{!?kdir: %{expand: %%define kdir /lib/modules/%(uname -r)/build}}
+%define kernel_devel_rpm %{expand:%%(rpm -q --quiet -f %{kdir}/ 2>/dev/null &&
+          rpm -q --qf '%%%%{name}\\n' -f %{kdir}/ | uniq)}
+%{echo:kernelversion=%{kernelversion}
+}
+%{echo:kdir=%{kdir}
+}
+%{echo:kernel_devel_rpm=%{kernel_devel_rpm}
+}
 
 # encode - to _ to be able to include that in a package name or release "number"
 %global krelver  %(echo %{kernelversion} | tr -s '-' '_')
@@ -17,9 +25,7 @@ ExclusiveOS: linux
 Group: System Environment/Kernel
 URL: http://www.drbd.org/
 BuildRoot: %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
-BuildRequires: gcc
-%(test -e /etc/redhat-release && echo BuildRequires: kernel-devel)
-%(test -e /etc/SuSE-release && echo BuildRequires: kernel-syms)
+BuildRequires: gcc %{kernel_devel_rpm}
 
 %description
 DRBD mirrors a block device over the network to another machine.
-- 
2.1.4

