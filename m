Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8BA631608E
	for <drbd-dev@lists.linbit.com>; Tue, 20 Dec 2005 16:43:30 +0100 (CET)
Date: Tue, 20 Dec 2005 16:43:31 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problem with DRBD0.7 on Debian Sarge.
Message-ID: <20051220154331.GC5803@soda.linbit>
References: <43A819F6.3000505@nask.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A819F6.3000505@nask.pl>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-12-20 15:49:26 +0100
\ Szymon Madej:
> Hello!
> 
> I've strange situation at work today. I was doing reboot of secondary
> node in HA HeartBeat cluster, which use DRBD to distributed data, after
> recompilation of it's kernel. Old kernel lacks of High Memory Support.
> I've recompilled it, installed, recompilled the DRBD module for this
> kernel and installed it. Then I've executed lilo to write new bootsector
> and rebooted it. Before reboot primary node has consistent data on both
> DRBD devices that I'm using: drbd0 and drbd1. After reboot using my new
> kernel, (secondary) when DRBD was loaded and connected to primary node
> I've received such kernel mesasges (cutted out timestamp and machine name):

> kernel: drbd0: Resync done (total 1 sec; paused 0 sec; 0 K/sec)
> kernel: drbd1: sock_recvmsg returned -14
> kernel: drbd1: drbd1_receiver [699]: cstate SyncTarget --> BrokenPipe
> kernel: drbd1: short read receiving data block: read -14 expected 4096
> kernel: drbd1: error receiving RSDataReply, l: 4112!

you probably hit the bug which was fixed in 0.7.12:
 * Fixed a connection flip-flop bug when the two peers used different
    user provided sizes.

to verify this, first, do "drbdadm disconnect <bad_resource>".
then "drbdsetup /dev/drbdX show", as well as "cat /proc/partitions",
on both nodes.  compare the results.

the solution is probably to either make sure (using some --size
parameter if possible) that your devices are of the very same size,
or upgrade to 0.7.15, which should fix the problem.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
