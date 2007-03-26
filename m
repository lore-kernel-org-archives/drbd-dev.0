Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E30A2E091D3
	for <drbd-dev@lists.linbit.com>; Mon, 26 Mar 2007 12:54:51 +0200 (CEST)
Message-ID: <4607A67A.7060608@ru.mvista.com>
Date: Mon, 26 Mar 2007 14:54:50 +0400
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] drbd-8.0.1 add dependencies to Kconfig
References: <45F82D67.2030105@ru.mvista.com>
	<200703231440.08564.philipp.reisner@linbit.com>
In-Reply-To: <200703231440.08564.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The errors are:

drivers/block/drbd/drbd_compat_wrappers.h: In function `crypto_hash_digest':
drivers/block/drbd/drbd_compat_wrappers.h:306: warning: implicit 
declaration of function `crypto_hmac'


  LD      .tmp_vmlinux1
drivers/built-in.o: In function `crypto_free_hash':
drivers/block/drbd/drbd_compat_wrappers.h:315: undefined reference to 
`crypto_free_tfm'
drivers/block/drbd/drbd_compat_wrappers.h:315: undefined reference to 
`crypto_free_tfm'
drivers/built-in.o: In function `drbd_nl_net_conf':
drivers/block/drbd/drbd_compat_wrappers.h:281: undefined reference to 
`crypto_alloc_tfm'
drivers/built-in.o: In function `crypto_free_hash':
drivers/block/drbd/drbd_compat_wrappers.h:315: undefined reference to 
`crypto_free_tfm'
drivers/block/drbd/drbd_compat_wrappers.h:316: undefined reference to 
`crypto_free_tfm'
make: *** [.tmp_vmlinux1] Error 1


I don't know what is behaviour on latest kernels but on 2.6.18 
CRYPTO_HMAC is required.

Best regards,
Maxim.



Philipp Reisner wrote:

>Am Mittwoch, 14. März 2007 18:14 schrieb Maxim Uvarov:
>  
>
>>Hello all,
>>
>>I have suggestion to add dependencies on CRYPTO and CONNECTOR to the
>>drbr patches
>>to avoid compilation errors due to wrong configuration.
>>What do you think about it? Patches for drbd-8.0.1 are bellow:
>>
>>Best regards,
>>Max Uvarov.
>>
>>
>>--- drbd/Kconfig        2006-11-20 23:05:03.000000000 +0300
>>+++ drbd/Kconfig_new    2007-03-13 19:42:12.000000000 +0300
>>@@ -5,6 +5,9 @@
>>        tristate "DRBD Distributed replicated block device support"
>>        select INET
>>        select PROC_FS
>>+       select CRYPTO
>>+       select CRYPTO_HMAC
>>+       select CONNECTOR
>>        ---help---
>>          Drbd is a block device which is designed to build high
>>availability
>>          clusters.  This is done by mirroring a whole block device via (a
>>
>>    
>>
>
>
>The "select CONNECTOR" is already there, got in after 8.0.1 was released.
>DRBD should actually compile without the Crypto stuff ( I have not
>verified this in therecent time ). Then the shared secret based
>connection authentification is simply not available.
>  
>
>>-ifndef CONFIG_CONNECTOR
>>-       drbd-objs += connector.o cn_queue.o
>>-endif
>>-
>>obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
>>    
>>
>
>
>We will keep that part, because it is possible to use DRBD on 
>early Linux-2.6.x kernels that did not had the connector in the
>main tree.
>
>-Phil
>  
>

