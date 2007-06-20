Return-Path: <lars.ellenberg@linbit.com>
Resent-Message-ID: <20070620171058.GF27737@ogo.aicooma.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B34242E051BE
	for <drbd-dev@lists.linbit.com>; Wed, 20 Jun 2007 18:59:02 +0200 (CEST)
Received: from [10.50.1.77] (blade.az.mvista.com [10.50.1.77])
	by hermes.mvista.com (Postfix) with ESMTP id 9B38A1DBD1
	for <drbd-dev@lists.linbit.com>; Wed, 20 Jun 2007 09:32:38 -0700 (PDT)
Message-ID: <467956FB.5060507@mvista.com>
Date: Wed, 20 Jun 2007 09:34:03 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------020508000806070401070006"
Subject: [Drbd-dev] drbdadm segfaults with incorrect drbd.conf
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------020508000806070401070006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

It seems that when the resources aren't setup exactly right in drbd.conf
drbdadm can segfault due to using a pointer that is NULL. Attached is a patch
that fixes the issue.

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------


--------------020508000806070401070006
Content-Type: text/x-patch;
 name="drbd_check_valid_ptr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drbd_check_valid_ptr.patch"

diff -Naurp drbd-8.0.3/user/drbdadm_main.c drbd-8.0.3-mod/user/drbdadm_main.c
--- drbd-8.0.3/user/drbdadm_main.c	2007-05-02 02:13:37.000000000 -0700
+++ drbd-8.0.3-mod/user/drbdadm_main.c	2007-06-20 09:27:45.000000000 -0700
@@ -1029,6 +1029,7 @@ struct d_resource* res_by_minor(const ch
   mm = m_strtoll(id+6,1);
 
   for_each_resource(res,t,config) {
+    if( !res->me ) continue;
     if( mm == dt_minor_of_dev(res->me->device)) return res;
   }
   return NULL;
@@ -1818,7 +1819,9 @@ int main(int argc, char** argv)
 
     highest_minor=0;
     for_each_resource(res,tmp,config) {
-      int m = dt_minor_of_dev(res->me->device);
+      int m;
+      if ( !res->me ) continue;
+      m = dt_minor_of_dev(res->me->device);
       if ( m > highest_minor ) highest_minor = m;
       nr_resources++;
     }

--------------020508000806070401070006--

