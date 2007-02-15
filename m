Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3875D2E06985
	for <drbd-dev@lists.linbit.com>; Thu, 15 Feb 2007 16:28:23 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io error
	during resync.
Date: Thu, 15 Feb 2007 16:28:18 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C8F9@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C8F9@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702151628.18909.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 14. Februar 2007 19:03 schrieb Montrose, Ernest:
> Hi all,
> We are overwelmed with panic's after io errors. Seem mdev->bc is null
> due to some race condition.  Here is one instance:
>
> Two node cluster, node A and Node B. Syncsource is node A. While syncing
> Reads are issued on Node B.  I/O errosrs start to occur
> on node A,  Node A panics :
>
[...OOPS... ]

Hi Ernest,

I was not able to understand the cause of the oops on the first
glance.

Could you provide the output of ksymoops when you feed this
OOPS to it ? ( I am interested in the disassebled code)

AND 

I do this debugging by comparing it to the assembler output
of the compiler.
Please provide the .s files from the machine where you build
your drbd (with your compiler, kernel config and kernel source).

Remke DRBD with "make V=1"

The create the .s file:
Replaceing the "-c" option with "-gstabs+ -S" and the -o "foo.o" to
-o "foo.s" in the call of the compiler

Something like this:
(cd $KDIR ; gcc ... /some/path/foo.c )

Thanks,
Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
