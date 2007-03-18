Return-Path: <lists@aj.net-lab.net>
Received: from mx1.net-lab.net (ns1.net-lab.net [80.69.32.3])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B2F272E08889
	for <drbd-dev@lists.linbit.com>; Sun, 18 Mar 2007 09:47:57 +0100 (CET)
Message-ID: <45FCFCBA.7030909@aj.net-lab.net>
Date: Sun, 18 Mar 2007 09:47:54 +0100
From: Andreas John <lists@aj.net-lab.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] make KDIR=... kernel-patch fails
References: <45F1DCB7.3020303@aj.net-lab.net>	<20070310114246.GA26492@barkeeper1.linbit>
	<20070313225956.GB29914@barkeeper1.linbit>
In-Reply-To: <20070313225956.GB29914@barkeeper1.linbit>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <Lars.Ellenberg@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

(Resent, the ML doesnt like /me :/ )

Hello Lars,

still there is one "file missing" ?

See below for the beginning of my build log.

rgds,
Andreas

  CC [M]  drivers/block/drbd/drbd_strings.o
  CC [M]  drivers/block/drbd/drbd_nl.o
  CC [M]  fs/hfs/dir.o
drivers/block/drbd/drbd_nl.c:38:22: error: drbd_int.h: No such file or
directory
In file included from drivers/block/drbd/drbd_nl.c:85:
include/linux/drbd_nl.h:14: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:18: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:20: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:30: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:32: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:56: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:58: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:62: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:68: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:69: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:70: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:71: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:72: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:73: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:74: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:75: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:76: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:80: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:85: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:89: error: expected ‚)‚ before ‚*‚ token
In file included from drivers/block/drbd/drbd_nl.c:116:
include/linux/drbd_nl.h:14: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:18: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:20: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:30: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:32: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:56: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:58: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:62: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:68: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:69: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:70: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:71: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:72: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:73: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:74: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:75: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:76: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:80: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:85: error: expected ‚)‚ before ‚*‚ token
include/linux/drbd_nl.h:89: error: expected ‚)‚ before ‚*‚ token
drivers/block/drbd/drbd_nl.c:118: error: expected ‚)‚ before ‚*‚ token
drivers/block/drbd/drbd_nl.c:119: error: expected ‚)‚ before ‚*‚ token
drivers/block/drbd/drbd_nl.c: In function ‚nl_trace_packet‚:
drivers/block/drbd/drbd_nl.c:143: error: expected ‚)‚ before ‚DEVICE_NAME‚
drivers/block/drbd/drbd_nl.c:141: warning: unused variable ‚nlp‚
drivers/block/drbd/drbd_nl.c: In function ‚nl_trace_reply‚:
drivers/block/drbd/drbd_nl.c:155: error: expected ‚)‚ before ‚DEVICE_NAME‚
drivers/block/drbd/drbd_nl.c:153: warning: unused variable ‚nlp‚
drivers/block/drbd/drbd_nl.c: At top level:
drivers/block/drbd/drbd_nl.c:164: error: expected ‚)‚ before ‚*‚ token
drivers/block/drbd/drbd_nl.c:179: error: expected ‚)‚ before ‚*‚ token
drivers/block/drbd/drbd_nl.c:234: error: expected ‚)‚ before ‚*‚ token
drivers/block/drbd/drbd_nl.c:358: error: expected ‚=‚, ‚,‚, ‚;‚, ‚asm‚
or ‚__attribute__‚ before ‚int‚
drivers/block/drbd/drbd_nl.c:374: error: expected ‚=‚, ‚,‚, ‚;‚, ‚asm‚
or ‚__attribute__‚ before ‚int‚
drivers/block/drbd/drbd_nl.c:384: error: expected ‚=‚, ‚,‚, ‚;‚, ‚asm‚
or ‚__attribute__‚ before ‚void‚
drivers/block/drbd/drbd_nl.c:442: warning: ‚struct Drbd_Conf‚ declared
inside parameter list
drivers/block/drbd/drbd_nl.c:442: warning: its scope is only this
definition or declaration, which is probably not what you want
drivers/block/drbd/drbd_nl.c: In function ‚drbd_determin_dev_size‚:
drivers/block/drbd/drbd_nl.c:452: warning: implicit declaration of
function ‚lc_try_lock‚
drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:454: warning: implicit declaration of
function ‚drbd_md_first_sector‚
drivers/block/drbd/drbd_nl.c:454: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:455: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:456: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:459: warning: implicit declaration of
function ‚drbd_md_set_sector_offsets‚
drivers/block/drbd/drbd_nl.c:459: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:461: warning: implicit declaration of
function ‚drbd_new_dev_size‚
drivers/block/drbd/drbd_nl.c:461: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:463: warning: implicit declaration of
function ‚drbd_get_capacity‚
drivers/block/drbd/drbd_nl.c:463: error: dereferencing pointer to
incomplete type
drivers/block/drbd/drbd_nl.c:464: warning: implicit declaration of
function ‚drbd_bm_capacity‚
drivers/block/drbd/drbd_nl.c:466: warning: implicit declaration of
function ‚drbd_bm_resize‚
drivers/block/drbd/drbd_nl.c:471: warning: implicit declaration of

