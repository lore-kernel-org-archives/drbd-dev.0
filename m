Return-Path: <bkerensa@gmail.com>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
	[209.85.214.178]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 24CD31056E5E
	for <drbd-dev@lists.linbit.com>; Thu,  2 May 2013 11:38:29 +0200 (CEST)
Received: by mail-ob0-f178.google.com with SMTP id 16so286906obc.23
	for <drbd-dev@lists.linbit.com>; Thu, 02 May 2013 02:38:27 -0700 (PDT)
MIME-Version: 1.0
Sender: bkerensa@gmail.com
From: Benjamin Kerensa <bkerensa@ubuntu.com>
Date: Thu, 2 May 2013 02:11:27 -0700
Message-ID: <CAGOdq5m4ijux9dCw26=3+9svGbD7Z-+cZVLAPY33mZBdZt6jeA@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Drbd-dev] [PATCH] documentation: Adjusted casing and removed white
 unnecessary white space.
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

Adjusted casing and removed white unnecessary white space.

Signed-off-by: Benjamin Kerensa <bkerensa@ubuntu.com>

diff -rupN drbd-8.4.3/documentation/drbd.8 drbd-new/documentation/drbd.8
--- drbd-8.4.3/documentation/drbd.8	2013-02-05 06:35:48.000000000 -0800
+++ drbd-new/documentation/drbd.8	2013-05-02 01:46:58.053265125 -0700
@@ -36,7 +36,7 @@ drbd \- The start and stop script for DR
 .PP
 The
 \fB/etc/init\&.d/drbd\fR
-script is used to start and stop drbd on a system V style init system\&.
+script is used to start and stop DRBD on a system V style init system\&.
 .PP
 In order to use
 \fB/etc/init\&.d/drbd\fR
diff -rupN drbd-8.4.3/documentation/drbdadm.xml
drbd-new/documentation/drbdadm.xml
--- drbd-8.4.3/documentation/drbdadm.xml	2012-12-20 04:07:17.000000000 -0800
+++ drbd-new/documentation/drbdadm.xml	2013-05-02 02:00:48.753293564 -0700
@@ -66,13 +66,13 @@
   <refsect1>
     <title>Description</title>

-    <para><option>Drbdadm</option> is the high level tool of the DRBD
program suite.
+    <para><option>drbdadm</option> is the high level tool of the DRBD
program suite.
     <option>Drbdadm</option> is to <option>drbdsetup</option> and
<option>drbdmeta</option> what
     <option>ifup</option>/<option>ifdown</option> is to
<option>ifconfig</option>.
     <option>Drbdadm</option> reads its configuration file and
performs the specified commands by
     calling the <option>drbdsetup</option> and/or the
<option>drbdmeta</option> program.</para>

-    <para><option>Drbdadm</option> can operate on whole resources or
on individual volumes in a
+    <para><option>drbdadm</option> can operate on whole resources or
on individual volumes in a
     resource. The sub commands: <option>attach</option>,
<option>detach</option>,
     <option>primary</option>, <option>secondary</option>,
<option>invalidate</option>,
     <option>invalidate-remote</option>, <option>outdate</option>,
<option>resize</option>,
diff -rupN drbd-8.4.3/documentation/drbd.conf.xml
drbd-new/documentation/drbd.conf.xml
--- drbd-8.4.3/documentation/drbd.conf.xml	2013-01-29 08:30:07.000000000 -0800
+++ drbd-new/documentation/drbd.conf.xml	2013-05-02 01:56:50.109285394 -0700
@@ -1193,7 +1193,7 @@
                 <term><option>call-pri-lost-after-sb</option></term>

                 <listitem>
-                  <para>Always honor the outcome of the
<option>after-sb-0pri </option> algorithm.
+                  <para>Always honor the outcome of the
<option>after-sb-0pri</option> algorithm.
                   In case it decides the current secondary has the
right data, it calls the
                   "pri-lost-after-sb" handler on the current primary.</para>
                 </listitem>
@@ -1203,7 +1203,7 @@
         </varlistentry>

         <varlistentry>
-          <term><option>after-sb-2pri </option>
<replaceable>policy</replaceable></term>
+          <term><option>after-sb-2pri</option>
<replaceable>policy</replaceable></term>

           <listitem>
             <indexterm significance="normal">
@@ -1263,7 +1263,7 @@
         </varlistentry>

         <varlistentry>
-          <term><option>rr-conflict </option>
<replaceable>policy</replaceable></term>
+          <term><option>rr-conflict</option>
<replaceable>policy</replaceable></term>

           <listitem>
             <indexterm significance="normal">
@@ -1307,7 +1307,7 @@
         </varlistentry>

         <varlistentry>
-          <term><option>data-integrity-alg </option>
<replaceable>alg</replaceable></term>
+          <term><option>data-integrity-alg</option>
<replaceable>alg</replaceable></term>

           <listitem>
             <indexterm significance="normal">
