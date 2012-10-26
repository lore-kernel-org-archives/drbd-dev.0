Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1BA88103B4B1
	for <drbd-dev@lists.linbit.com>; Fri, 26 Oct 2012 15:18:28 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gld-drbd-dev@m.gmane.org>) id 1TRjZQ-0002rQ-Iz
	for drbd-dev@lists.linbit.com; Fri, 26 Oct 2012 15:03:28 +0200
Received: from host66-62-static.43-88-b.business.telecomitalia.it
	([88.43.62.66]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 26 Oct 2012 15:03:28 +0200
Received: from alessandro.bono by
	host66-62-static.43-88-b.business.telecomitalia.it with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 26 Oct 2012 15:03:28 +0200
To: drbd-dev@lists.linbit.com
From: Alessandro Bono <alessandro.bono@gmail.com>
Date: Fri, 26 Oct 2012 13:03:01 +0000 (UTC)
Message-ID: <k6e1m5$n09$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] fix %preun script in drbd-km.spec from 8.3 package
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi

%preun script in drbd-km.spec try to unload drbd.ko if present without check kernel version running
without this patch it's not possible to remove drbd-km package of old kernel

--- drbd-8.3.13/drbd-km.spec    2012-10-26 13:43:43.163366400 +0200
+++ drbd-8.3.13.my/drbd-km.spec 2012-10-26 13:44:33.368384889 +0200
@@ -80,10 +80,12 @@
 rm -rf %{buildroot}

 %preun %{krelver}
+if [ 'uname -r' = %{kernelversion} ]; then
 lsmod | grep drbd > /dev/null 2>&1
 if [ $? -eq 0 ]; then
     rmmod drbd
 fi
+fi

 %post %{krelver}
 # hack for distribution kernel packages,                                  

