Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 47ED12E2E1FA
	for <drbd-dev@lists.linbit.com>; Fri, 16 Jan 2009 15:02:15 +0100 (CET)
Resent-Message-ID: <20090116140214.GB8356@barkeeper1-xen.linbit>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 356112E2E1FA
	for <drbd-dev@lists.linbit.com>; Fri, 16 Jan 2009 13:19:29 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so807789fgg.13
	for <drbd-dev@lists.linbit.com>; Fri, 16 Jan 2009 04:19:27 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 16 Jan 2009 13:11:24 +0100
Message-ID: <9bb5e33f0901160411m5cb5efd7j1ee68e8f8b522308@mail.gmail.com>
From: Mario Wolff <wolfshoehle@googlemail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Get dump even with no valid resource
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I need it to get all used hosts to auto-distribute the configuration
from a management system with no running drbd!
Now you can force a dump(-xml) with -f

*** drbdadm_main.c.orig 2009-01-16 13:46:19.000000000 +0100
--- drbdadm_main.c      2009-01-16 13:50:03.000000000 +0100
***************
*** 2903,2909 ****
         * but command is dump / dump-xml, so implitict "all",
         * or an explicit "all" argument is given */
        all_resources = 1;
!       die_if_no_resources();
        /* verify ips first, for all of them */
          for_each_resource(res,tmp,config) {
          verify_ips(res);
--- 2903,2911 ----
         * but command is dump / dump-xml, so implitict "all",
         * or an explicit "all" argument is given */
        all_resources = 1;
!       if(!is_dump||force==0){
!         die_if_no_resources();
!       }
        /* verify ips first, for all of them */
          for_each_resource(res,tmp,config) {
          verify_ips(res);
