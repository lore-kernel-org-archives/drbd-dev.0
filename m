Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 784A21302C40
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 14:48:45 +0200 (CEST)
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com
	[172.24.198.69]) by smtp-out.google.com with ESMTP id o4HCc26e013265
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 05:38:02 -0700
From: Iustin Pop <iustin@google.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 May 2010 14:38:00 +0200
Message-Id: <975167247a473298e086279080c5cfdec9a00458.1274099535.git.iustin@google.com>
In-Reply-To: <cover.1274099535.git.iustin@google.com>
References: <cover.1274099535.git.iustin@google.com>
Cc: Iustin Pop <iustin@google.com>
Subject: [Drbd-dev] [PATCH 3/3] Update documentation for resync-source
	handlers
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 documentation/drbd.conf.xml |   27 ++++++++++++++++++++++++++-
 scripts/drbd.conf.example   |    4 ++++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/documentation/drbd.conf.xml b/documentation/drbd.conf.xml
index 8e4fdfd..656d2ce 100644
--- a/documentation/drbd.conf.xml
+++ b/documentation/drbd.conf.xml
@@ -330,7 +330,8 @@ resource r0 {
     <option>pri-on-incon-degr</option>, <option>pri-lost-after-sb</option>,
     <option>pri-lost</option>, <option>fence-peer</option> (formerly oudate-peer),
     <option>local-io-error</option>, <option>initial-split-brain</option>, <option>split-brain</option>,
-    <option>before-resync-target</option>, <option>after-resync-target</option>.
+    <option>before-resync-target</option>, <option>after-resync-target</option>,
+    <option>before-resync-source</option>, <option>after-resync-source</option>.
   </para>
           </listitem>
         </varlistentry>
@@ -1509,6 +1510,30 @@ the unit is 1 second.
   </para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term>
+            <option>before-resync-source <replaceable>cmd</replaceable></option>
+          </term>
+          <listitem>
+            <para><indexterm significance="normal"><primary>drbd.conf</primary><secondary>before-resync-source </secondary></indexterm>
+  DRBD calls this handler just before a resync beginns on the node
+  that becomes resync source. It might be used to tweak the resync parameters
+  or the backing block device.
+  </para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <option>after-resync-source <replaceable>cmd</replaceable></option>
+          </term>
+          <listitem>
+            <para><indexterm significance="normal"><primary>drbd.conf</primary><secondary>after-resync-source </secondary></indexterm>
+  DRBD calls this handler just after a resync operation finished on
+  the node which served as the resync source. It might be used to
+  unpause any other minors that were suspended, log the resync end, etc.
+  </para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
     <refsect2>
diff --git a/scripts/drbd.conf.example b/scripts/drbd.conf.example
index cc58814..6ae8816 100644
--- a/scripts/drbd.conf.example
+++ b/scripts/drbd.conf.example
@@ -174,6 +174,10 @@ resource r0 {
     # -- <additional lvcreate options>
     #before-resync-target "/usr/lib/drbd/snapshot-resync-target-lvm.sh -p 15 -- -c 16k";
     #after-resync-target /usr/lib/drbd/unsnapshot-resync-target-lvm.sh;
+
+    # Example setting for the resync-source-handlers.
+    #before-resync-source "/usr/bin/logger Begun resync";
+    #after-resync-source "/usr/bin/logger Finished resync";
   }
 
   startup {
-- 
1.7.0.1

