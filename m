Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (port-219-88-246-249.jet.net.nz [219.88.246.249])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 13091142FB
	for <drbd-dev@lists.linbit.com>; Thu, 18 Nov 2004 08:16:37 +0100 (CET)
Date: Thu, 18 Nov 2004 20:16:24 +1300
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.6 release tomorrow...
Message-ID: <uYt2U+UbDZ/RLw8KO53/f/Y=lge@web.de>
References: <200411152259.28960.philipp.reisner@linbit.com>
	<200411172032.59007.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411172032.59007.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-11-17 20:32:58 +0100
\ Philipp Reisner:
> Am Montag, 15. November 2004 22:59 schrieb Philipp Reisner:
> > Hi,
> >
> > I will create the 0.7.6 tarball tomorrow (as long as nobody objects)
> >
> > What exactly should I put into debian/changelog ?
> >
> > -philipp
> 
> I will deley 0.7.6 until either Linux-2.6.10 is released or the strange
> issue of Steven Wilton is resolved (see drbd-user ML)


maybe this does help ?

 :-/



--- linux-2.6.9/include/linux/sched.h	2004-10-20 14:56:03.000000000 +1300
+++ linux-2.6.10/include/linux/sched.h	2004-11-18 19:07:00.000000000 +1300
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/topology.h>
 
 struct exec_domain;
 
@@ -107,8 +108,8 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_STOPPED		4
 #define TASK_TRACED		8
-#define TASK_ZOMBIE		16
-#define TASK_DEAD		32
+#define EXIT_ZOMBIE		16
+#define EXIT_DEAD		32
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)

[ rest snipped ]
