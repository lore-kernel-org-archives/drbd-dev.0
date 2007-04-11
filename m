Return-Path: <lists@aj.net-lab.net>
Received: from imap.internetcave.org (mx1.of.net-lab.net [80.69.37.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 79ABD2E2716C
	for <drbd-dev@lists.linbit.com>; Wed, 11 Apr 2007 15:49:15 +0200 (CEST)
Message-ID: <461CE75A.3040402@aj.net-lab.net>
Date: Wed, 11 Apr 2007 15:49:14 +0200
From: Andreas John <lists@aj.net-lab.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] make KDIR=... kernel-patch fails
References: <45F1DCB7.3020303@aj.net-lab.net>	<20070310114246.GA26492@barkeeper1.linbit>	<20070313225956.GB29914@barkeeper1.linbit>
	<45FCFCBA.7030909@aj.net-lab.net>
In-Reply-To: <45FCFCBA.7030909@aj.net-lab.net>
Content-Type: text/plain; charset=ISO-8859-15
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

Hello All,
Hello Lars,

I don't want to bug you, but is there are chance that the problem gets
fixed?

Rgds,
Andreas

Andreas John schrieb:
> (Resent, the ML doesnt like /me :/ )
> 
> Hello Lars,
> 
> still there is one "file missing" ?
> 
> See below for the beginning of my build log.
> 
> rgds,
> Andreas
> 
>   CC [M]  drivers/block/drbd/drbd_strings.o
>   CC [M]  drivers/block/drbd/drbd_nl.o
>   CC [M]  fs/hfs/dir.o
> drivers/block/drbd/drbd_nl.c:38:22: error: drbd_int.h: No such file or
> directory
> In file included from drivers/block/drbd/drbd_nl.c:85:
> include/linux/drbd_nl.h:14: error: expected â)â before â*â token
> include/linux/drbd_nl.h:18: error: expected â)â before â*â token
> include/linux/drbd_nl.h:20: error: expected â)â before â*â token
> include/linux/drbd_nl.h:30: error: expected â)â before â*â token
> include/linux/drbd_nl.h:32: error: expected â)â before â*â token
> include/linux/drbd_nl.h:56: error: expected â)â before â*â token
> include/linux/drbd_nl.h:58: error: expected â)â before â*â token
> include/linux/drbd_nl.h:62: error: expected â)â before â*â token
> include/linux/drbd_nl.h:68: error: expected â)â before â*â token
> include/linux/drbd_nl.h:69: error: expected â)â before â*â token
> include/linux/drbd_nl.h:70: error: expected â)â before â*â token
> include/linux/drbd_nl.h:71: error: expected â)â before â*â token
> include/linux/drbd_nl.h:72: error: expected â)â before â*â token
> include/linux/drbd_nl.h:73: error: expected â)â before â*â token
> include/linux/drbd_nl.h:74: error: expected â)â before â*â token
> include/linux/drbd_nl.h:75: error: expected â)â before â*â token
> include/linux/drbd_nl.h:76: error: expected â)â before â*â token
> include/linux/drbd_nl.h:80: error: expected â)â before â*â token
> include/linux/drbd_nl.h:85: error: expected â)â before â*â token
> include/linux/drbd_nl.h:89: error: expected â)â before â*â token
> In file included from drivers/block/drbd/drbd_nl.c:116:
> include/linux/drbd_nl.h:14: error: expected â)â before â*â token
> include/linux/drbd_nl.h:18: error: expected â)â before â*â token
> include/linux/drbd_nl.h:20: error: expected â)â before â*â token
> include/linux/drbd_nl.h:30: error: expected â)â before â*â token
> include/linux/drbd_nl.h:32: error: expected â)â before â*â token
> include/linux/drbd_nl.h:56: error: expected â)â before â*â token
> include/linux/drbd_nl.h:58: error: expected â)â before â*â token
> include/linux/drbd_nl.h:62: error: expected â)â before â*â token
> include/linux/drbd_nl.h:68: error: expected â)â before â*â token
> include/linux/drbd_nl.h:69: error: expected â)â before â*â token
> include/linux/drbd_nl.h:70: error: expected â)â before â*â token
> include/linux/drbd_nl.h:71: error: expected â)â before â*â token
> include/linux/drbd_nl.h:72: error: expected â)â before â*â token
> include/linux/drbd_nl.h:73: error: expected â)â before â*â token
> include/linux/drbd_nl.h:74: error: expected â)â before â*â token
> include/linux/drbd_nl.h:75: error: expected â)â before â*â token
> include/linux/drbd_nl.h:76: error: expected â)â before â*â token
> include/linux/drbd_nl.h:80: error: expected â)â before â*â token
> include/linux/drbd_nl.h:85: error: expected â)â before â*â token
> include/linux/drbd_nl.h:89: error: expected â)â before â*â token
> drivers/block/drbd/drbd_nl.c:118: error: expected â)â before â*â token
> drivers/block/drbd/drbd_nl.c:119: error: expected â)â before â*â token
> drivers/block/drbd/drbd_nl.c: In function ânl_trace_packetâ:
> drivers/block/drbd/drbd_nl.c:143: error: expected â)â before âDEVICE_NAMEâ
> drivers/block/drbd/drbd_nl.c:141: warning: unused variable ânlpâ
> drivers/block/drbd/drbd_nl.c: In function ânl_trace_replyâ:
> drivers/block/drbd/drbd_nl.c:155: error: expected â)â before âDEVICE_NAMEâ
> drivers/block/drbd/drbd_nl.c:153: warning: unused variable ânlpâ
> drivers/block/drbd/drbd_nl.c: At top level:
> drivers/block/drbd/drbd_nl.c:164: error: expected â)â before â*â token
> drivers/block/drbd/drbd_nl.c:179: error: expected â)â before â*â token
> drivers/block/drbd/drbd_nl.c:234: error: expected â)â before â*â token
> drivers/block/drbd/drbd_nl.c:358: error: expected â=â, â,â, â;â, âasmâ
> or â__attribute__â before âintâ
> drivers/block/drbd/drbd_nl.c:374: error: expected â=â, â,â, â;â, âasmâ
> or â__attribute__â before âintâ
> drivers/block/drbd/drbd_nl.c:384: error: expected â=â, â,â, â;â, âasmâ
> or â__attribute__â before âvoidâ
> drivers/block/drbd/drbd_nl.c:442: warning: âstruct Drbd_Confâ declared
> inside parameter list
> drivers/block/drbd/drbd_nl.c:442: warning: its scope is only this
> definition or declaration, which is probably not what you want
> drivers/block/drbd/drbd_nl.c: In function âdrbd_determin_dev_sizeâ:
> drivers/block/drbd/drbd_nl.c:452: warning: implicit declaration of
> function âlc_try_lockâ
> drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:452: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:454: warning: implicit declaration of
> function âdrbd_md_first_sectorâ
> drivers/block/drbd/drbd_nl.c:454: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:455: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:456: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:459: warning: implicit declaration of
> function âdrbd_md_set_sector_offsetsâ
> drivers/block/drbd/drbd_nl.c:459: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:461: warning: implicit declaration of
> function âdrbd_new_dev_sizeâ
> drivers/block/drbd/drbd_nl.c:461: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:463: warning: implicit declaration of
> function âdrbd_get_capacityâ
> drivers/block/drbd/drbd_nl.c:463: error: dereferencing pointer to
> incomplete type
> drivers/block/drbd/drbd_nl.c:464: warning: implicit declaration of
> function âdrbd_bm_capacityâ
> drivers/block/drbd/drbd_nl.c:466: warning: implicit declaration of
> function âdrbd_bm_resizeâ
> drivers/block/drbd/drbd_nl.c:471: warning: implicit declaration of
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
> 

