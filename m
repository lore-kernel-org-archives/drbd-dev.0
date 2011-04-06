Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 649841056A67
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2011 02:31:32 +0200 (CEST)
Resent-Message-ID: <20110407003130.GD3726@barkeeper1-xen.linbit>
Received: from smtp.iplink.net (smtp.iplink.net [192.139.81.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8746A1056A67
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2011 22:22:35 +0200 (CEST)
Received: from lework.alteeve.com (fw.iplink.net [192.139.81.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.iplink.net (Postfix) with ESMTP id 21D15B00E9C
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2011 15:50:36 -0400 (EDT)
Message-ID: <4D9CC40C.7070805@alteeve.com>
Date: Wed, 06 Apr 2011 15:50:36 -0400
From: Madison Kelly <mkelly@alteeve.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] diff for adding 'wipe-md' to drbdadm.xml
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I noticed that the 'wipe-md' option wasn't documented. With the help of
adam_g on #drbd, I sorted out how to use it. I cloned the 8.3 repo and
patched drbdadm.xml to document the feature. I'm not entirely sure what
the devs prefer, both in language and diff syntax, so here is my initial
stab and I'm happy to hear feedback/criticism.

--- drbdadm.xml	2010-12-01 11:59:14.283726427 -0500
+++ digimer.drbdadm.xml	2011-04-06 15:45:58.910806575 -0400
@@ -295,6 +295,15 @@
         </listitem>
       </varlistentry>
       <varlistentry>
+        <term>wipe-md</term>
+        <listitem>
+          <para><indexterm
significance="normal"><primary>drbdadm</primary><secondary>wipe-md</secondary></indexterm>
+          Wipes the meta data from the specified resource and it's backing
+	  devices. Must be run on all nodes. Syntax is: drbdadm wipe-md res
+        </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
         <term>outdate</term>
         <listitem>
           <para><indexterm
significance="normal"><primary>drbdadm</primary><secondary>outdate</secondary></indexterm>


-- 
Madison Kelly        647-501-5200
E-Mail:              mkelly@alteeve.com
Papers and Projects: http://alteeve.com
"Without risk, without reward."
