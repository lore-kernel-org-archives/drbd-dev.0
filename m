Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E6C702DD02D4
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2008 11:08:41 +0200 (CEST)
Date: Tue, 1 Jul 2008 11:08:41 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD Reconnection Bug
Message-ID: <20080701090841.GA20245@soda.linbit>
References: <6fbb8fd90806302329i8e041f3kc21e834e8ddf3b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fbb8fd90806302329i8e041f3kc21e834e8ddf3b5f@mail.gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jun 30, 2008 at 11:29:13PM -0700, John Muth wrote:
> I've been testing DRBD 8.2.6 on top of Centos 5.1 for use in a lights-out
> environment.
> 
> I think I ran across a bug.Ha sanyone seen anything like this:
> 
> Background:
> 
> I'm running DRBD on top of LVM. I have a LVM volume named 'sm-vol' on two nodes
> and I've got /dev/drbd0 mapped to it. I replicate using 'protocol C'. At the
> beginning of the test node A is the primary and node B is the secondary. My
> test script does:
> 
>   1. Write verifiable data to /dev/drbd0 on node A. Create a LVM snapshot on
> node B and verify the data.
>   2. Bring down node B using 'service drbd stop' Write more data frm node A.
> Bring the node B back up with 'service drbd start'. When re-sync is complete,
> create a LVM snapshot on the node B and verify that the contents match what was
> written by the node A.
>   3. Bring down node A with 'service drbd stop'. Make the node B into the
> primary (drbdadm primary sm-vol). Write more data to the /dev/drbd0 from node
> B.. Bring node A back with 'service drbd start'. Wait for resync to complete.
> Create LVM snapshot on node A and erify data.
>   4. Run 'drbdadm secondary sm-vol' on node B followed by 'drbdadm primary
> sm-vol' on node A.
>   5  Repeat
> 
> Once every 100 or so loops, DRBD gets wedged during a reconnection. When the
> system gets wedged, I do 'cat /etc/drbd' on both nodes and I see the following:
> 
> On primary:
> 
> [root@vm5 ~]# cat /proc/drbd
> version: 8.2.6 (api:88/proto:86-88)
> GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by
> buildsvn@c5-i386-build, 2008-06-26 16:40:17
>  0: cs:WFBitMapS st:Primary/Secondary ds:UpToDate/Outdated C r---
>     ns:288064 nr:94516 dw:613836 dr:845384 al:122 bm:31 lo:0 pe:0 ua:0 ap:0
> oos:95888
> 
> On secondary:
> 
> [root@vm6 ~]# cat /proc/drbd
> version: 8.2.6 (api:88/proto:86-88)
> GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by
> buildsvn@c5-i386-build, 2008-06-26 16:40:17
>  0: cs:WFBitMapT st:Secondary/Primary ds:Negotiating/UpToDate C r---
>     ns:0 nr:0 dw:0 dr:0 al:106 bm:93 lo:0 pe:0 ua:0 ap:0 oos:95888
> 
> /var/log/messages looks like:
> 
> On primary:
> 
> Jun 30 13:30:08 vm5 kernel: drbd0: peer( Secondary -> Unknown ) conn( Connected
> -> TearDown ) pdsk( UpToDate -> DUnknown )

> On secondary:
> 
> Jun 30 13:28:46 vm6 kernel: drbd0: peer( Primary -> Unknown ) conn( Connected
> -> NetworkFailure ) pdsk( UpToDate -> DUnknown )

since you can "easily" reproduce this,
please get the time in sync on those boxes (ntp),
makes it much easier to read logs.

then post new logs.

> Has anyone seen this before?

there have been numerous race conditions in the state handling code,
it is well posible that there are more.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
