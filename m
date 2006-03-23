Return-Path: <ldenel@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.200])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8438216AD6
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2006 09:08:36 +0100 (CET)
Received: by xproxy.gmail.com with SMTP id s13so284183wxc
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2006 00:08:35 -0800 (PST)
Message-ID: <6ed4c8790603230008t155b855djc4c77b5366357526@mail.gmail.com>
Date: Thu, 23 Mar 2006 09:08:21 +0100
From: "Laurent Denel" <ldenel@gmail.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] freeze under postmark io bench
In-Reply-To: <20060322223502.GB6223@barkeeper1.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
	<20060311163505.GC3816@soda.linbit>
	<6ed4c8790603221046w6fedd871p8786bc427eafd8b@mail.gmail.com>
	<20060322223502.GB6223@barkeeper1.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

Quick answer, I'll try to get some more time on that later today.

> what do you mean by "crashed the host"?

The host is inside a server room, I don't have any quick access to it
yet, I'll configure the iLO remote management stuff later today. So
far the crash is :
- ssh console frozen
- no more ssh access (timeout)
- ping still ok
- "Unknown" status for the host seen on the other node
- automated reboot by HP's bios after 15 min.

> any output anywhere?

nothing into the syslog files as usual when the kernel has hard time ;)
but here is the output of drdb before the crash (maybe to validate my conf)=
 :

Mar 22 19:03:42 bwinf5401 kernel: drbd: initialised. Version: 0.7.17
(api:77/proto:74)
Mar 22 19:03:42 bwinf5401 kernel: drbd: SVN Revision: 2111 build by
root@wingate03, 2006-03-20 14:26:07
Mar 22 19:03:42 bwinf5401 kernel: drbd: registered as block device major 14=
7
Mar 22 19:04:54 bwinf5401 kernel: drbd0: resync bitmap: bits=3D18578276
words=3D580572
Mar 22 19:04:54 bwinf5401 kernel: drbd0: size =3D 70 GB (74313104 KB)
Mar 22 19:04:55 bwinf5401 kernel: drbd0: 0 KB marked out-of-sync by on
disk bit-map.
Mar 22 19:04:55 bwinf5401 kernel: drbd0: Found 6 transactions (324
active extents) in activity log.
Mar 22 19:04:55 bwinf5401 kernel: drbd0: drbdsetup [1850]: cstate
Unconfigured --> StandAlone
Mar 22 19:04:55 bwinf5401 kernel: drbd0: drbdsetup [1853]: cstate
StandAlone --> Unconnected
Mar 22 19:04:55 bwinf5401 kernel: drbd0: drbd0_receiver [1854]: cstate
Unconnected --> WFConnection
Mar 22 19:06:29 bwinf5401 kernel: bcm5700: eth1 NIC Link is Down
Mar 22 19:06:40 bwinf5401 kernel: bcm5700: eth1 NIC Link is Up, 1000
Mbps full duplex
Mar 22 19:07:55 bwinf5401 kernel: bcm5700: eth1 NIC Link is Down
Mar 22 19:07:57 bwinf5401 kernel: bcm5700: eth1 NIC Link is Up, 1000
Mbps full duplex, receive & transmit flow control ON
Mar 22 19:09:23 bwinf5401 kernel: drbd0: drbd0_receiver [1854]: cstate
WFConnection --> WFReportParams
Mar 22 19:09:23 bwinf5401 kernel: drbd0: Handshake successful: DRBD
Network Protocol version 74
Mar 22 19:09:23 bwinf5401 kernel: drbd0: Connection established.
Mar 22 19:09:23 bwinf5401 kernel: drbd0: I am(S):
1:00000002:00000001:0000000e:00000005:00
Mar 22 19:09:23 bwinf5401 kernel: drbd0: Peer(S):
1:00000002:00000001:0000000e:00000005:00
Mar 22 19:09:23 bwinf5401 kernel: drbd0: drbd0_receiver [1854]: cstate
WFReportParams --> Connected
Mar 22 19:09:23 bwinf5401 kernel: drbd0: Secondary/Unknown -->
Secondary/Secondary
Mar 22 19:09:53 bwinf5401 kernel: drbd0: drbdsetup [2129]: cstate
Connected --> Unconnected
Mar 22 19:09:53 bwinf5401 kernel: drbd0: drbd0_receiver [1854]: cstate
Unconnected --> BrokenPipe
Mar 22 19:09:53 bwinf5401 kernel: drbd0: short read expecting header
on sock: r=3D-512
Mar 22 19:09:53 bwinf5401 kernel: drbd0: worker terminated
Mar 22 19:09:53 bwinf5401 kernel: drbd0: asender terminated
Mar 22 19:09:53 bwinf5401 kernel: drbd0: drbd0_receiver [1854]: cstate
BrokenPipe --> StandAlone
Mar 22 19:09:53 bwinf5401 kernel: drbd0: Connection lost.
Mar 22 19:09:53 bwinf5401 kernel: drbd0: receiver terminated
Mar 22 19:09:53 bwinf5401 kernel: drbd0: drbdsetup [2129]: cstate
StandAlone --> StandAlone
Mar 22 19:09:53 bwinf5401 kernel: drbd0: drbdsetup [2129]: cstate
StandAlone --> Unconfigured
Mar 22 19:09:53 bwinf5401 kernel: drbd0: worker terminated
Mar 22 19:10:05 bwinf5401 kernel: drbd0: resync bitmap: bits=3D18578276
words=3D580572
Mar 22 19:10:05 bwinf5401 kernel: drbd0: size =3D 70 GB (74313104 KB)
Mar 22 19:10:06 bwinf5401 kernel: drbd0: 0 KB marked out-of-sync by on
disk bit-map.
Mar 22 19:10:06 bwinf5401 kernel: drbd0: Found 6 transactions (324
active extents) in activity log.
Mar 22 19:10:06 bwinf5401 kernel: drbd0: drbdsetup [2194]: cstate
Unconfigured --> StandAlone
Mar 22 19:10:06 bwinf5401 kernel: drbd0: drbdsetup [2197]: cstate
StandAlone --> Unconnected
Mar 22 19:10:06 bwinf5401 kernel: drbd0: drbd0_receiver [2198]: cstate
Unconnected --> WFConnection
Mar 22 19:10:06 bwinf5401 kernel: drbd0: drbd0_receiver [2198]: cstate
WFConnection --> WFReportParams
Mar 22 19:10:06 bwinf5401 kernel: drbd0: Handshake successful: DRBD
Network Protocol version 74
Mar 22 19:10:06 bwinf5401 kernel: drbd0: Connection established.
Mar 22 19:10:06 bwinf5401 kernel: drbd0: I am(S):
1:00000002:00000001:0000000e:00000005:01
Mar 22 19:10:06 bwinf5401 kernel: drbd0: Peer(S):
1:00000002:00000001:0000000e:00000005:01
Mar 22 19:10:06 bwinf5401 kernel: drbd0: drbd0_receiver [2198]: cstate
WFReportParams --> Connected
Mar 22 19:10:06 bwinf5401 kernel: drbd0: Secondary/Unknown -->
Secondary/Secondary
Mar 22 19:10:31 bwinf5401 kernel: drbd0: Secondary/Secondary -->
Primary/Secondary


> any reaction to ping, keyboard, numlock-led-toggle, sysrq keys?
> nmi-watchdog enabled? does it trigger?
> are you comfortable to recompile the kernel with the kernel debugger enab=
led,
> and go into the kernel debugger when it "crashes" again, and see what it
> thinks it does, where it thinks it is stuck?

no problem to recompile a kernel with the debugger
this will be my first time using it but I'm looking forward to learn...

LD
