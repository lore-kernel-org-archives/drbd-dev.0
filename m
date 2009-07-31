Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A0793101AC7F
	for <drbd-dev@lists.linbit.com>; Thu,  6 Aug 2009 10:36:18 +0200 (CEST)
Resent-Message-ID: <20090806083617.GB8018@barkeeper1-xen.linbit>
Received: from hapkido.dreamhost.com (hapkido.dreamhost.com [66.33.216.122])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ED8D7101AC56
	for <drbd-dev@lists.linbit.com>; Fri, 31 Jul 2009 23:05:07 +0200 (CEST)
Received: from swarthymail-a1.g.dreamhost.com (caibbdcaaaaf.dreamhost.com
	[208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id A792517AAC8
	for <drbd-dev@lists.linbit.com>; Fri, 31 Jul 2009 13:33:38 -0700 (PDT)
Received: from [192.168.1.3] (pool-71-185-254-146.phlapa.fios.verizon.net
	[71.185.254.146]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 2DC308F2F4
	for <drbd-dev@lists.linbit.com>; Fri, 31 Jul 2009 13:33:35 -0700 (PDT)
Message-Id: <FF5EE638-446A-46F9-A920-7FBFD3B22959@computer.org>
From: Anthony D'Ambrosio <anthony_d@computer.org>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Fri, 31 Jul 2009 16:33:33 -0400
Subject: [Drbd-dev] Fix for patch-kernl in scripts directory
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I have been using DRBD for about 5 years now and think you folks have  
done some great work.  We recently have been working an a new base  
distribution of our OS and I ran into a problem while trying to build  
DRBD into a kernel.

We patch our kernel and I wanted to run some tests with the latest  
DRDB and the Linux 2.6.30 kernel.  We found an error trying to  
generate the patch file for the kernel:

root@appbuild2:/root/drbd-8.3.2 >make KDIR=/root/linux-2.6.30 kernel- 
patch
make -C drbd drbd_buildtag.c
make[1]: Entering directory `/root/drbd-8.3.2/drbd'
make[1]: Leaving directory `/root/drbd-8.3.2/drbd'
set -o errexit; \
         kbase=$(basename /root/linux-2.6.30); \
         d=patch-$kbase-drbd-8.3.2; \
         test -e $d && cp -fav --backup=numbered $d $d; \
         bash scripts/patch-kernel /root/linux-2.6.30 . > $d
cp: cannot stat `/root/drbd-8.3.2/drbd/lru_cache.h': No such file or  
directory
make: *** [kernel-patch] Error 1

After looking at the error, and an older version of DRBD it appears  
that the lru_cache.h file has moved.  I have created a patch for our  
build process:

root@appbuild2:/root/drbd-8.3.2 >cat ../patch-kernel_8.3.2.patch
97c97
<       lru_cache.c"
---
 >       lru_cache.c lru_cache.h"
113,114d112
< cp -a $DRBD/drbd/linux/lru_cache.h    $DRBD_SUB
<

Please tell me if you need more, or if I should supply this type of  
information in the future in some other manner.

Thanks for the excellent software - it works like a champ for us!

A. D'Ambrosio
BT Diamond IP
