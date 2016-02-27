Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB63D105632B
	for <drbd-dev@lists.linbit.com>; Sat, 27 Feb 2016 09:02:13 +0100 (CET)
Received: by mail-vk0-f51.google.com with SMTP id c3so96286307vkb.3
	for <drbd-dev@lists.linbit.com>; Sat, 27 Feb 2016 00:02:12 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 27 Feb 2016 17:02:11 +0900
Message-ID: <CAF6H8oFyCP8TH+zgokHFCWpbyG_OyRdhDGmmZ5dHtsDaTdSAsg@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a1143f1543cc7b7052cbbd5a1
Subject: [Drbd-dev] [CASE-26] some node be changed to unexpected
	"Standalone" after re-connect
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--001a1143f1543cc7b7052cbbd5a1
Content-Type: text/plain; charset=UTF-8

Hi,

Please check.

Ver:
  - drbd-9.0.1-1
  - CentOS 7

Env:
  - 4 nodes configured but used 3 nodes only
 - sync(C) replication mode.
  - VM network bandwith: 100Mbps(slow)

Test:
 01) setup node1, 2, 3, UpToDate all
 02) node1: primary
 03) node1: mount /dev/drbd1  /mnt
 04) node1: copy 1Gfile /mnt ( it takes 2 and half minutes)
 05) during copy
 06) node2: disconnect
 07) node3: down
 08) node2: connect
 09) node3: up
 10) node2: changed from Connecting to Standalone
 11) node2: disconnect again
 12) node2: connect again
 13) node2: changed to normal Connected status(2nd connect try is
successful.)

Notes:
 -  Check please node2 log at the time of Test-10) step

34378 Feb 27 15:32:52 drbd9-02 kernel: drbd r0 drbd9-01: conn( Unconnected
-> Connecting )
34379 Feb 27 15:32:52 drbd9-02 kernel: drbd r0 tcp:drbd9-01: initial packet
S crossed
34380 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Handshake
successful: Agreed network protocol version 111
34381 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Feature flags
enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
34382 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Starting ack_recv
thread (from drbd_r_r0 [6617])
34383 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: meta connection
shut down by peer.
34384 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting
-> NetworkFailure )
34385 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: ack_receiver
terminated
34386 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Terminating
ack_recv thread
34387 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: sock was shut down
by peer
34388 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed
34389 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: conn(
NetworkFailure -> Unconnected )
34390 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Restarting
receiver thread
34391 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: conn( Unconnected
-> Connecting )
34392 Feb 27 15:32:54 drbd9-02 kernel: drbd r0 tcp:drbd9-01: initial packet
S crossed
34393 Feb 27 15:32:55 drbd9-02 kernel: drbd r0 drbd9-01: Handshake
successful: Agreed network protocol version 111
34394 Feb 27 15:32:55 drbd9-02 kernel: drbd r0 drbd9-01: Feature flags
enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
34395 Feb 27 15:32:55 drbd9-02 kernel: drbd r0 drbd9-01: Starting ack_recv
thread (from drbd_r_r0 [6617])
34396 Feb 27 15:32:55 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote
state change 56227800 (primary_nodes=0, weak_nodes=0)
34397 Feb 27 15:33:25 drbd9-02 kernel: drbd r0: Two-phase commit 56227800
timeout
34398 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1: peer does not
support WRITE_SAME
34399 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01:
drbd_sync_handshake:
34400 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01: self
E22074C65B6BE5A2:0000000000000000:15F5D43C9A0B7F26:351C9E61C6B06FB6 bits:0
flags:0
34401 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01: peer
4784B438C8271CE9:E22074C65B6BE5A2:15F5D43C9A0B7F26:0000000000000000
bits:427126 flags:120
34402 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01:
uuid_compare()=-2 by rule 50
34403 Feb 27 15:33:46 drbd9-02 kernel: drbd r0: State change failed: Need a
connection to start verify or resync
34404 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: Failed: conn(
Connecting -> Connected ) peer( Unknown -> Primary )
34405 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01: Failed:
pdsk( DUnknown -> UpToDate ) repl( Off -> WFBitMapT )
34406 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting
-> Disconnecting )
34407 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: error receiving
P_STATE, e: -5 l: 0!
34408 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: ack_receiver
terminated
34409 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: Terminating
ack_recv thread
34410 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed
34411 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: conn(
Disconnecting -> StandAlone )
34412 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: Terminating
receiver thread
34413 Feb 27 15:33:49 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing
unexpected connection from 100.100.10.11
34414 Feb 27 15:33:55 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing
unexpected connection from 100.100.10.11
34415 Feb 27 15:34:04 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing
unexpected connection from 100.100.10.11
34416 Feb 27 15:34:15 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing
unexpected connection from 100.100.10.11
34417 Feb 27 15:34:26 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing
unexpected connection from 100.100.10.11
34418 Feb 27 15:34:36 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing
unexpected connection from 100.100.10.11
34419 Feb 27 15:34:47 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-03: unexpected


Let me attach full log files here:
 - node1: http://pastebin.com/BbUGy2Yn
 - node2: http://pastebin.com/2z7auSA2
 - node3: http://pastebin.com/jn5JLg1P

Please see my comments interspersed in above log files.

I think the first disconnect-connect step(Test-06,Test-08) on node2 is
normal.
Nevertheless, node2 was changed to not "Connected" but "Standalone" after
uuid_compare.
Why?


Thanks.

--001a1143f1543cc7b7052cbbd5a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Please check.</div><div>=
<br></div><div>Ver:</div><div>=C2=A0 - drbd-9.0.1-1</div><div>=C2=A0 - Cent=
OS 7</div><div><br></div><div>Env:</div><div>=C2=A0 - 4 nodes configured bu=
t used 3 nodes only</div><div>=C2=A0- sync(C) replication mode.</div><div>=
=C2=A0 - VM network bandwith: 100Mbps(slow)</div><div><br></div><div>Test:<=
/div><div>=C2=A001) setup node1, 2, 3, UpToDate all</div><div>=C2=A002) nod=
e1: primary</div><div>=C2=A003) node1: mount /dev/drbd1 =C2=A0/mnt</div><di=
v>=C2=A004) node1: copy 1Gfile /mnt ( it takes 2 and half minutes)</div><di=
v>=C2=A005) during copy</div><div>=C2=A006) node2: disconnect=C2=A0</div><d=
iv>=C2=A007) node3: down</div><div>=C2=A008) node2: connect=C2=A0</div><div=
>=C2=A009) node3: up</div><div>=C2=A010) node2: changed from Connecting to =
Standalone</div><div>=C2=A011) node2: disconnect again</div><div>=C2=A012) =
node2: connect again</div><div>=C2=A013) node2: changed to normal Connected=
 status(2nd connect try is successful.)</div><div><br></div><div>Notes:</di=
v><div>=C2=A0- =C2=A0Check please node2 log at the time of Test-10) step</d=
iv><div>=C2=A0</div><div>34378 Feb 27 15:32:52 drbd9-02 kernel: drbd r0 drb=
d9-01: conn( Unconnected -&gt; Connecting )</div><div>34379 Feb 27 15:32:52=
 drbd9-02 kernel: drbd r0 tcp:drbd9-01: initial packet S crossed</div><div>=
34380 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Handshake successf=
ul: Agreed network protocol version 111</div><div>34381 Feb 27 15:32:53 drb=
d9-02 kernel: drbd r0 drbd9-01: Feature flags enabled on protocol level: 0x=
7 TRIM THIN_RESYNC WRITE_SAME.</div><div>34382 Feb 27 15:32:53 drbd9-02 ker=
nel: drbd r0 drbd9-01: Starting ack_recv thread (from drbd_r_r0 [6617])</di=
v><div>34383 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: meta connec=
tion shut down by peer.</div><div>34384 Feb 27 15:32:53 drbd9-02 kernel: dr=
bd r0 drbd9-01: conn( Connecting -&gt; NetworkFailure )</div><div>34385 Feb=
 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: ack_receiver terminated</di=
v><div>34386 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Terminating=
 ack_recv thread</div><div>34387 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 d=
rbd9-01: sock was shut down by peer</div><div>34388 Feb 27 15:32:53 drbd9-0=
2 kernel: drbd r0 drbd9-01: Connection closed</div><div>34389 Feb 27 15:32:=
53 drbd9-02 kernel: drbd r0 drbd9-01: conn( NetworkFailure -&gt; Unconnecte=
d )</div><div>34390 Feb 27 15:32:53 drbd9-02 kernel: drbd r0 drbd9-01: Rest=
arting receiver thread</div><div>34391 Feb 27 15:32:53 drbd9-02 kernel: drb=
d r0 drbd9-01: conn( Unconnected -&gt; Connecting )</div><div>34392 Feb 27 =
15:32:54 drbd9-02 kernel: drbd r0 tcp:drbd9-01: initial packet S crossed</d=
iv><div>34393 Feb 27 15:32:55 drbd9-02 kernel: drbd r0 drbd9-01: Handshake =
successful: Agreed network protocol version 111</div><div>34394 Feb 27 15:3=
2:55 drbd9-02 kernel: drbd r0 drbd9-01: Feature flags enabled on protocol l=
evel: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>34395 Feb 27 15:32:55 drbd=
9-02 kernel: drbd r0 drbd9-01: Starting ack_recv thread (from drbd_r_r0 [66=
17])</div><div>34396 Feb 27 15:32:55 drbd9-02 kernel: drbd r0 drbd9-01: Pre=
paring remote state change 56227800 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>34397 Feb 27 15:33:25 drbd9-02 kernel: drbd r0: Two-phase commit 562=
27800 timeout</div><div>34398 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 dr=
bd1: peer does not support WRITE_SAME</div><div>34399 Feb 27 15:33:46 drbd9=
-02 kernel: drbd r0/0 drbd1 drbd9-01: drbd_sync_handshake:</div><div>34400 =
Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01: self E22074C65B6=
BE5A2:0000000000000000:15F5D43C9A0B7F26:351C9E61C6B06FB6 bits:0 flags:0</di=
v><div>34401 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-01: pee=
r 4784B438C8271CE9:E22074C65B6BE5A2:15F5D43C9A0B7F26:0000000000000000 bits:=
427126 flags:120</div><div>34402 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0=
 drbd1 drbd9-01: uuid_compare()=3D-2 by rule 50</div><div>34403 Feb 27 15:3=
3:46 drbd9-02 kernel: drbd r0: State change failed: Need a connection to st=
art verify or resync</div><div>34404 Feb 27 15:33:46 drbd9-02 kernel: drbd =
r0 drbd9-01: Failed: conn( Connecting -&gt; Connected ) peer( Unknown -&gt;=
 Primary )</div><div>34405 Feb 27 15:33:46 drbd9-02 kernel: drbd r0/0 drbd1=
 drbd9-01: Failed: pdsk( DUnknown -&gt; UpToDate ) repl( Off -&gt; WFBitMap=
T )</div><div>34406 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: conn=
( Connecting -&gt; Disconnecting )</div><div>34407 Feb 27 15:33:46 drbd9-02=
 kernel: drbd r0 drbd9-01: error receiving P_STATE, e: -5 l: 0!</div><div>3=
4408 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: ack_receiver termin=
ated</div><div>34409 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: Ter=
minating ack_recv thread</div><div>34410 Feb 27 15:33:46 drbd9-02 kernel: d=
rbd r0 drbd9-01: Connection closed</div><div>34411 Feb 27 15:33:46 drbd9-02=
 kernel: drbd r0 drbd9-01: conn( Disconnecting -&gt; StandAlone )</div><div=
>34412 Feb 27 15:33:46 drbd9-02 kernel: drbd r0 drbd9-01: Terminating recei=
ver thread</div><div>34413 Feb 27 15:33:49 drbd9-02 kernel: drbd r0 tcp:drb=
d9-05: Closing unexpected connection from 100.100.10.11</div><div>34414 Feb=
 27 15:33:55 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected conn=
ection from 100.100.10.11</div><div>34415 Feb 27 15:34:04 drbd9-02 kernel: =
drbd r0 tcp:drbd9-05: Closing unexpected connection from 100.100.10.11</div=
><div>34416 Feb 27 15:34:15 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing =
unexpected connection from 100.100.10.11</div><div>34417 Feb 27 15:34:26 dr=
bd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection from 100=
.100.10.11</div><div>34418 Feb 27 15:34:36 drbd9-02 kernel: drbd r0 tcp:drb=
d9-05: Closing unexpected connection from 100.100.10.11</div><div>34419 Feb=
 27 15:34:47 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-03: unexpected</div><di=
v><br></div><div><br></div><div>Let me attach full log files here:</div><di=
v>=C2=A0- node1: <a href=3D"http://pastebin.com/BbUGy2Yn">http://pastebin.c=
om/BbUGy2Yn</a></div><div>=C2=A0- node2: <a href=3D"http://pastebin.com/2z7=
auSA2">http://pastebin.com/2z7auSA2</a></div><div>=C2=A0- node3: <a href=3D=
"http://pastebin.com/jn5JLg1P">http://pastebin.com/jn5JLg1P</a></div><div><=
br></div><div>Please see my comments interspersed in above log files.</div>=
<div><br></div><div>I think the first disconnect-connect step(Test-06,Test-=
08) on node2 is normal.</div><div>Nevertheless, node2 was changed to not &q=
uot;Connected&quot; but &quot;Standalone&quot; after uuid_compare.</div><di=
v>Why?</div><div><br></div><div><br></div><div>Thanks.</div><div><br></div>=
<div><br></div>
</div>

--001a1143f1543cc7b7052cbbd5a1--
