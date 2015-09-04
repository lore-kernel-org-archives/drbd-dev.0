Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 904D61055F5A
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 87EEA2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:29 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5q73iV3T57I4 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 648302BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:29 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tlwrhoVnq9qi for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:29 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3DCA12BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:29 +0200 (CEST)
Resent-Message-ID: <20150911132028.GC3436@soda.linbit>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0064.outbound.protection.outlook.com [65.55.169.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9644E10518BD
	for <drbd-dev@lists.linbit.com>; Fri,  4 Sep 2015 18:46:50 +0200 (CEST)
To: <drbd-dev@lists.linbit.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <55E9C763.9050008@sandisk.com>
Date: Fri, 4 Sep 2015 09:31:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH] drbd, drbd-km.spec: Port to openSuSE
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

The package needed to build kernel modules is called kernel-default-devel
on openSuSE. The kernel-syms package is SLES specific and hence the build
fails on openSuSE. Modify the spec file such that the name of the kernel
development RPM is determined automatically. Note: if the kernel development
headers have not been installed as an RPM the %{kernel_devel_rpm} variable
is empty.

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

