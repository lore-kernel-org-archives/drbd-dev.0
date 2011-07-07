Return-Path: <mrten@ii.nl>
Received: from mail1.ii.nl (mail1.ii.nl [82.94.191.120])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B3DF0105669B
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jul 2011 18:00:13 +0200 (CEST)
From: Mrten <mrten+drbd@ii.nl>
To: drbd-dev@lists.linbit.com
Date: Thu,  7 Jul 2011 17:42:29 +0200
Message-Id: <1310053349-14778-1-git-send-email-mrten+drbd@ii.nl>
Subject: [Drbd-dev] [PATCH] more information about differences between
	flexible- and meta-disk
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 documentation/drbd.conf.xml |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/documentation/drbd.conf.xml b/documentation/drbd.conf.xml
index 0248350..894694e 100644
--- a/documentation/drbd.conf.xml
+++ b/documentation/drbd.conf.xml
@@ -524,15 +524,22 @@ resource r0 {
             <option>flexible-meta-disk <replaceable>device </replaceable></option>
           </term>
           <listitem>
-            <para><indexterm significance="normal"><primary>drbd.conf</primary><secondary>meta-disk</secondary></indexterm><indexterm significance="normal"><primary>drbd.conf</primary><secondary>flexible-meta-disk</secondary></indexterm>
+            <para><indexterm significance="normal"><primary>drbd.conf</primary><secondary>meta-disk</secondary>
+            </indexterm><indexterm significance="normal"><primary>drbd.conf</primary><secondary>flexible-meta-disk</secondary></indexterm>
     Internal means that the last part of the backing device is used to store
     the meta-data. You must not use <replaceable>[index]</replaceable> with
     internal. Note: Regardless of whether you use the <option>meta-disk</option> or
     the <option>flexible-meta-disk</option> keyword, it will always be of
     the size needed for the remaining storage size.
   </para>
-            <para>   You can use a single block <replaceable>device</replaceable> to store
-   meta-data of multiple DRBD devices.
+  
+  <para>For internal, there is no difference between <option>meta-disk</option> and <option>flexible-meta-disk</option>.
+  For external, <option>meta-disk</option> always uses 128 MB of the device for the meta-data. This means that
+  the DRBD devicesize is limited to 4.0TB. This limit goes away with <option>flexible-meta-disk</option>, however, with
+  <option>flexible-meta-disk</option> you can only put one meta-disk on one device.</para>
+  
+   <para>   You can use a single block <replaceable>device</replaceable> to store
+   meta-data of multiple DRBD devices. 
    E.g. use meta-disk /dev/sde6[0]; and meta-disk /dev/sde6[1];
    for two different resources. In this case the meta-disk
    would need to be at least 256 MB in size.
-- 
1.7.0.4

