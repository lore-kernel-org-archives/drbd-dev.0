Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F18E2105EC5A
	for <drbd-dev@lists.linbit.com>; Thu, 27 May 2010 14:02:05 +0200 (CEST)
Resent-Message-ID: <20100527120205.GH26213@soda.linbit>
Received: from xenotime.net (xenotime.net [72.52.115.56])
	by mail09.linbit.com (LINBIT Mail Daemon) with SMTP id 943CC10871CE
	for <drbd-dev@lists.linbit.com>; Thu, 27 May 2010 04:18:55 +0200 (CEST)
Received: from chimera.site ([71.245.98.113]) by xenotime.net for
	<drbd-dev@lists.linbit.com>; Wed, 26 May 2010 19:04:03 -0700
Date: Wed, 26 May 2010 19:04:03 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: drbd-dev@lists.linbit.com
Message-Id: <20100526190403.fcf8d536.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] drbd sparse warnings
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

When I build a Linux kernel with "make C=1" to invoke sparse,
I see 135 sparse warnings like (shorter list):


linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:931:39: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1212:69: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1213:70: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1214:59: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1215:60: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1216:63: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1217:65: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1218:66: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1376:75: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1377:50: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1378:51: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1435:91: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1437:74: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1498:61: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_bitmap.c:751:98: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_bitmap.c:815:50: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_bitmap.c:876:42: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_receiver.c:341:54: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_receiver.c:1116:81: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_receiver.c:1356:79: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_actlog.c:547:69: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_main.c:3498:60: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_main.c:3506:63: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_main.c:3714:59: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_nl.c:513:94: error: attribute 'require_context': unknown attribute
linux-2.6.34-git11/drivers/block/drbd/drbd_nl.c:701:77: error: attribute 'require_context': unknown attribute


What is the meaning and usage of require_context in drbd_int.h?

#ifdef __CHECKER__
# define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
# define __protected_read_by(x)  __attribute__((require_context(x,1,999,"read")))
# define __protected_write_by(x) __attribute__((require_context(x,1,999,"write")))
# define __must_hold(x)       __attribute__((context(x,1,1), require_context(x,1,999,"call")))
#else
# define __protected_by(x)
# define __protected_read_by(x)
# define __protected_write_by(x)
# define __must_hold(x)
#endif


thanks,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
