Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
	[209.85.213.46]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 97C0E105633D
	for <drbd-dev@lists.linbit.com>; Fri, 26 Feb 2016 13:52:38 +0100 (CET)
Received: by mail-vk0-f46.google.com with SMTP id e185so76044714vkb.1
	for <drbd-dev@lists.linbit.com>; Fri, 26 Feb 2016 04:52:38 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 26 Feb 2016 21:52:36 +0900
Message-ID: <CAF6H8oH+3Kc+8drkBvcD+zgDJWULxrCwqyHQJPZL9pU7ZQmO7Q@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a11438eaa069f6e052cabc6d6
Subject: [Drbd-dev] [CASE-7] Sometimes 600 sec timeout occured,
 please check 2PC(2 Phase Commit) protocol
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

--001a11438eaa069f6e052cabc6d6
Content-Type: text/plain; charset=UTF-8

Hi,

Let me re-post my old mail to this newgroup because similar errors are
produced.


1. Old mail

subject: Can dradm-down terminate with 600 seconds timeout?

Dear Lars,
Problem:
   - On Linux, sometimes drbdadm-down-command be hanged as follows;
      "Command 'drbdsetup down r0' did not terminate within 600 seconds"

Env:
   - Linux version:  CentOS-7 Linux 3.10.0-229.7.2.el7.x86_64
   - DRBD Engine version: 9.0.0 (api:2/proto:86-110) GIT-hash:
e0e3bc833053a0ed6b4b593b32e40223a9373fb7  Transports (api:8): tcp (1.0.0)

Test Cluster:
   - 4 node Linux VMs, mesh network on Vmware

Test scenario:
   1) drbdadm-up 4 nodes all
   2) Promote one node to primary
   3) Pause all VMs
       ***Notes: Please use "Pause menu" when stops the node on Vmware.
"Suspend " menu some differs from "Pause".
   4) Resume all VMs
   5) Somtimes, more than one node output 2PC(2 Phase commit) messages
periodically.(See attached information)
   6) At this point, If we run drbdadm-down-command on these nodes, they
will be hanged occasionally with error message as follows;
       "Command 'drbdsetup down r0' did not terminate within 600 seconds"

Attached:

node1:

Nov 12 12:58:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3110839547 (0->2 499/145)
Nov 12 12:58:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3110839547 (30000ms) rv = -23
Nov 12 12:58:14 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 1556788097 because of state change 1200995267
Nov 12 12:58:14 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT
packet 1556788097.
Nov 12 12:58:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1200995267 (0->3 499/145)
Nov 12 12:58:44 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1200995267 (30001ms) rv = -23
Nov 12 12:58:44 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 407232822 because of state change 2876480921
Nov 12 12:58:44 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT
packet 407232822.
Nov 12 12:59:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2876480921 (0->2 499/145)
Nov 12 12:59:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2876480921 (30001ms) rv = -23
Nov 12 12:59:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3839850480 (0->3 499/145)
Nov 12 12:59:44 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3839850480 (30000ms) rv = -23
Nov 12 13:00:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2477663420 (0->2 499/145)
Nov 12 13:00:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2477663420 (30000ms) rv = -23
Nov 12 13:00:14 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 849320515 because of state change 2698322727
Nov 12 13:00:14 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT
packet 849320515.
Nov 12 13:00:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2698322727 (0->3 499/145)
Nov 12 13:00:44 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2698322727 (30000ms) rv = -23
Nov 12 13:00:44 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 743585927 because of state change 2750548712
Nov 12 13:00:44 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT
packet 743585927.
Nov 12 13:01:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2750548712 (0->2 499/145)
Nov 12 13:01:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2750548712 (30000ms) rv = -23
Nov 12 13:01:14 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 1367793350 because of state change 2283776505
Nov 12 13:01:14 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT
packet 1367793350.
Nov 12 13:01:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2283776505 (0->3 499/145)
Nov 12 13:01:44 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2283776505 (30000ms) rv = -23
Nov 12 13:01:44 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 3401865695 because of state change 2283776505
Nov 12 13:01:44 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT
packet 3401865695.
Nov 12 13:02:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 52162850 (0->2 499/145)
Nov 12 13:02:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 52162850 (30001ms) rv = -23
Nov 12 13:02:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 452962539 (0->3 499/145)
Nov 12 13:02:44 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 452962539 (30000ms) rv = -23


node3:

Nov 12 13:00:14 drbd9-03 kernel: drbd r0 drbd9-01: Ignoring P_TWOPC_ABORT
packet 2477663420.
Nov 12 13:00:14 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 849320515.
Nov 12 13:00:22 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:00:33 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:00:40 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:00:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 2698322727.
Nov 12 13:00:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 743585927.
Nov 12 13:00:48 drbd9-03 kernel: drbd_r_r0 D ffff88003d613680 0 36203 2
0x00000084
Nov 12 13:00:52 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:01:03 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:01:14 drbd9-03 kernel: drbd r0 drbd9-01: Ignoring P_TWOPC_ABORT
packet 2750548712.
Nov 12 13:01:14 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 1367793350.
Nov 12 13:01:15 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:01:26 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:01:36 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:01:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 2283776505.
Nov 12 13:01:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 3401865695.
Nov 12 13:01:47 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:01:56 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:02:08 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:02:14 drbd9-03 kernel: drbd r0 drbd9-01: Ignoring P_TWOPC_ABORT
packet 52162850.
Nov 12 13:02:19 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:02:29 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:02:40 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:02:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 452962539.
Nov 12 13:02:48 drbd9-03 kernel: drbd_r_r0 D ffff88003d613680 0 36203 2
0x00000084
Nov 12 13:02:52 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:03:03 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:03:12 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.21 to port 7000
Nov 12 13:03:14 drbd9-03 kernel: drbd r0 drbd9-01: Ignoring P_TWOPC_ABORT
packet 4060565678.
Nov 12 13:03:14 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 3441716583.



2. New question

Ver:
  - drbd-9.0.1-1
  - CentOS 7

Env:
  - configure 4 nodes but use 3 nodes only

Test:
 1) setup node1, 2, 3
 2) node1: primary
 3) node1: mount /dev/drbd1  /mnt
 4) node1 : invalidate-remote
 5) wait for fullsync for all nodes
 6) test network disconnect/connect for all nodes by disable/enable VM's
network icon
 7) node2: down -> up
 8) node3: down is pending until 600 sec timeout!!!

Notes:
  - There is no file copy test.

Logs:
 - node3 log has important messages as follows;

Feb 26 18:36:28 drbd9-03 kernel: INFO: task drbd_r_r0:3114 blocked for more
than 120 seconds.
Feb 26 18:36:28 drbd9-03 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 18:36:28 drbd9-03 kernel: drbd_r_r0       D ffff88003d613680     0
 3114      2 0x00000080
Feb 26 18:36:28 drbd9-03 kernel: ffff8800369a3b70 0000000000000046
ffff88001c8ab8e0 ffff8800369a3fd8
Feb 26 18:36:28 drbd9-03 kernel: ffff8800369a3fd8 ffff8800369a3fd8
ffff88001c8ab8e0 ffff880039f5e960
Feb 26 18:36:28 drbd9-03 kernel: 7fffffffffffffff ffff88001c8ab8e0
0000000000000002 0000000000000000
Feb 26 18:36:28 drbd9-03 kernel: Call Trace:
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff816096a9>] schedule+0x29/0x70
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff816075f9>]
schedule_timeout+0x209/0x2d0
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff810a9512>] ?
default_wake_function+0x12/0x20
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff8109825b>] ?
autoremove_wake_function+0x2b/0x40
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff810b1c7c>] ?
update_curr+0xcc/0x150
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff81608b72>]
__down_common+0xd2/0x14a
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff810b2a6e>] ?
dequeue_task_fair+0x40e/0x620
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff81608c07>] __down+0x1d/0x1f
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff8109d201>] down+0x41/0x50
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa04b23c4>]
state_change_lock+0x54/0x60 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa04b7700>] ?
__change_peer_disk_states+0x70/0x70 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa04b5cc6>]
change_cluster_wide_state+0x46/0xe90 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff8108007e>] ?
try_to_del_timer_sync+0x5e/0x90
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff81080102>] ?
del_timer_sync+0x52/0x60
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff8160756d>] ?
schedule_timeout+0x17d/0x2d0
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff8107ed90>] ?
__internal_add_timer+0x130/0x130
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa04b7336>]
change_cstate+0x86/0xc0 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa0486de1>]
drbd_receiver+0x151/0x630 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa0492521>]
drbd_thread_setup+0x61/0x120 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffffa04924c0>] ?
w_complete+0x20/0x20 [drbd]
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff8109726f>] kthread+0xcf/0xe0
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff810971a0>] ?
kthread_create_on_node+0x140/0x140
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff81614158>]
ret_from_fork+0x58/0x90
Feb 26 18:36:28 drbd9-03 kernel: [<ffffffff810971a0>] ?
kthread_create_on_node+0x140/0x140


Let me attach full log files here:
 - node1: http://pastebin.com/742jzerd
 - node2: http://pastebin.com/dFaaFkeK
 - node3: http://pastebin.com/irk4ykgN

Please see my comments interspersed in above log files.
I think it's very critical problem.

Thanks.

--001a11438eaa069f6e052cabc6d6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, <br><br>Let me re-post my old mail to this newgro=
up because similar errors are produced.<br><br><br>1. Old mail</div><div><b=
r><div>subject: Can dradm-down terminate with 600 seconds timeout?</div><di=
v><br>Dear Lars,<br>Problem:<br>=C2=A0 =C2=A0- On Linux, sometimes drbdadm-=
down-command be hanged as follows;<br>=C2=A0 =C2=A0 =C2=A0 &quot;Command &#=
39;drbdsetup down r0&#39; did not terminate within 600 seconds&quot;<br><br=
>Env:<br>=C2=A0 =C2=A0- Linux version: =C2=A0CentOS-7 Linux 3.10.0-229.7.2.=
el7.x86_64<br>=C2=A0 =C2=A0- DRBD Engine version: 9.0.0 (api:2/proto:86-110=
) GIT-hash: e0e3bc833053a0ed6b4b593b32e40223a9373fb7 =C2=A0Transports (api:=
8): tcp (1.0.0)<br><br>Test Cluster:<br>=C2=A0 =C2=A0- 4 node Linux VMs, me=
sh network on Vmware<br><br>Test scenario:<br>=C2=A0 =C2=A01) drbdadm-up 4 =
nodes all<br>=C2=A0 =C2=A02) Promote one node to primary<br>=C2=A0 =C2=A03)=
 Pause all VMs<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0***Notes: Please use &quot;Pau=
se menu&quot; when stops the node on Vmware. &quot;Suspend &quot; menu some=
 differs from &quot;Pause&quot;.<br>=C2=A0 =C2=A04) Resume all VMs<br>=C2=
=A0 =C2=A05) Somtimes, more than one node output 2PC(2 Phase commit) messag=
es periodically.(See attached information)<br>=C2=A0 =C2=A06) At this point=
, If we run drbdadm-down-command on these nodes, they will be hanged occasi=
onally with error message as follows;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;C=
ommand &#39;drbdsetup down r0&#39; did not terminate within 600 seconds&quo=
t;<br><br>Attached:<br><br>node1:<br><br>Nov 12 12:58:14 drbd9-01 kernel: d=
rbd r0: Preparing cluster-wide state change 3110839547 (0-&gt;2 499/145)<br=
>Nov 12 12:58:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide state chan=
ge 3110839547 (30000ms) rv =3D -23<br>Nov 12 12:58:14 drbd9-01 kernel: drbd=
 r0 drbd9-02: Rejecting concurrent remote state change 1556788097 because o=
f state change 1200995267<br>Nov 12 12:58:14 drbd9-01 kernel: drbd r0 drbd9=
-02: Ignoring P_TWOPC_ABORT packet 1556788097.<br>Nov 12 12:58:44 drbd9-01 =
kernel: drbd r0: Preparing cluster-wide state change 1200995267 (0-&gt;3 49=
9/145)<br>Nov 12 12:58:44 drbd9-01 kernel: drbd r0: Aborting cluster-wide s=
tate change 1200995267 (30001ms) rv =3D -23<br>Nov 12 12:58:44 drbd9-01 ker=
nel: drbd r0 drbd9-02: Rejecting concurrent remote state change 407232822 b=
ecause of state change 2876480921<br>Nov 12 12:58:44 drbd9-01 kernel: drbd =
r0 drbd9-02: Ignoring P_TWOPC_ABORT packet 407232822.<br>Nov 12 12:59:14 dr=
bd9-01 kernel: drbd r0: Preparing cluster-wide state change 2876480921 (0-&=
gt;2 499/145)<br>Nov 12 12:59:14 drbd9-01 kernel: drbd r0: Aborting cluster=
-wide state change 2876480921 (30001ms) rv =3D -23<br>Nov 12 12:59:44 drbd9=
-01 kernel: drbd r0: Preparing cluster-wide state change 3839850480 (0-&gt;=
3 499/145)<br>Nov 12 12:59:44 drbd9-01 kernel: drbd r0: Aborting cluster-wi=
de state change 3839850480 (30000ms) rv =3D -23<br>Nov 12 13:00:14 drbd9-01=
 kernel: drbd r0: Preparing cluster-wide state change 2477663420 (0-&gt;2 4=
99/145)<br>Nov 12 13:00:14 drbd9-01 kernel: drbd r0: Aborting cluster-wide =
state change 2477663420 (30000ms) rv =3D -23<br>Nov 12 13:00:14 drbd9-01 ke=
rnel: drbd r0 drbd9-02: Rejecting concurrent remote state change 849320515 =
because of state change 2698322727<br>Nov 12 13:00:14 drbd9-01 kernel: drbd=
 r0 drbd9-02: Ignoring P_TWOPC_ABORT packet 849320515.<br>Nov 12 13:00:44 d=
rbd9-01 kernel: drbd r0: Preparing cluster-wide state change 2698322727 (0-=
&gt;3 499/145)<br>Nov 12 13:00:44 drbd9-01 kernel: drbd r0: Aborting cluste=
r-wide state change 2698322727 (30000ms) rv =3D -23<br>Nov 12 13:00:44 drbd=
9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent remote state change 743=
585927 because of state change 2750548712<br>Nov 12 13:00:44 drbd9-01 kerne=
l: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT packet 743585927.<br>Nov 12 13:=
01:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 2750548=
712 (0-&gt;2 499/145)<br>Nov 12 13:01:14 drbd9-01 kernel: drbd r0: Aborting=
 cluster-wide state change 2750548712 (30000ms) rv =3D -23<br>Nov 12 13:01:=
14 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent remote state cha=
nge 1367793350 because of state change 2283776505<br>Nov 12 13:01:14 drbd9-=
01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT packet 1367793350.<br>N=
ov 12 13:01:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state chang=
e 2283776505 (0-&gt;3 499/145)<br>Nov 12 13:01:44 drbd9-01 kernel: drbd r0:=
 Aborting cluster-wide state change 2283776505 (30000ms) rv =3D -23<br>Nov =
12 13:01:44 drbd9-01 kernel: drbd r0 drbd9-02: Rejecting concurrent remote =
state change 3401865695 because of state change 2283776505<br>Nov 12 13:01:=
44 drbd9-01 kernel: drbd r0 drbd9-02: Ignoring P_TWOPC_ABORT packet 3401865=
695.<br>Nov 12 13:02:14 drbd9-01 kernel: drbd r0: Preparing cluster-wide st=
ate change 52162850 (0-&gt;2 499/145)<br>Nov 12 13:02:14 drbd9-01 kernel: d=
rbd r0: Aborting cluster-wide state change 52162850 (30001ms) rv =3D -23<br=
>Nov 12 13:02:44 drbd9-01 kernel: drbd r0: Preparing cluster-wide state cha=
nge 452962539 (0-&gt;3 499/145)<br>Nov 12 13:02:44 drbd9-01 kernel: drbd r0=
: Aborting cluster-wide state change 452962539 (30000ms) rv =3D -23<br><br>=
<br>node3:<br><br>Nov 12 13:00:14 drbd9-03 kernel: drbd r0 drbd9-01: Ignori=
ng P_TWOPC_ABORT packet 2477663420.<br>Nov 12 13:00:14 drbd9-03 kernel: drb=
d r0 drbd9-04: Ignoring P_TWOPC_ABORT packet 849320515.<br>Nov 12 13:00:22 =
drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection from 1=
00.100.10.21 to port 7000<br>Nov 12 13:00:33 drbd9-03 kernel: drbd r0 tcp:d=
rbd9-05: Closing unexpected connection from 100.100.10.21 to port 7000<br>N=
ov 12 13:00:40 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected co=
nnection from 100.100.10.21 to port 7000<br>Nov 12 13:00:44 drbd9-03 kernel=
: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT packet 2698322727.<br>Nov 12 13:=
00:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT packet 7435=
85927.<br>Nov 12 13:00:48 drbd9-03 kernel: drbd_r_r0 D ffff88003d613680 0 3=
6203 2 0x00000084<br>Nov 12 13:00:52 drbd9-03 kernel: drbd r0 tcp:drbd9-05:=
 Closing unexpected connection from 100.100.10.21 to port 7000<br>Nov 12 13=
:01:03 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection=
 from 100.100.10.21 to port 7000<br>Nov 12 13:01:14 drbd9-03 kernel: drbd r=
0 drbd9-01: Ignoring P_TWOPC_ABORT packet 2750548712.<br>Nov 12 13:01:14 dr=
bd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT packet 1367793350.<=
br>Nov 12 13:01:15 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpecte=
d connection from 100.100.10.21 to port 7000<br>Nov 12 13:01:26 drbd9-03 ke=
rnel: drbd r0 tcp:drbd9-05: Closing unexpected connection from 100.100.10.2=
1 to port 7000<br>Nov 12 13:01:36 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Cl=
osing unexpected connection from 100.100.10.21 to port 7000<br>Nov 12 13:01=
:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT packet 228377=
6505.<br>Nov 12 13:01:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOP=
C_ABORT packet 3401865695.<br>Nov 12 13:01:47 drbd9-03 kernel: drbd r0 tcp:=
drbd9-05: Closing unexpected connection from 100.100.10.21 to port 7000<br>=
Nov 12 13:01:56 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected c=
onnection from 100.100.10.21 to port 7000<br>Nov 12 13:02:08 drbd9-03 kerne=
l: drbd r0 tcp:drbd9-05: Closing unexpected connection from 100.100.10.21 t=
o port 7000<br>Nov 12 13:02:14 drbd9-03 kernel: drbd r0 drbd9-01: Ignoring =
P_TWOPC_ABORT packet 52162850.<br>Nov 12 13:02:19 drbd9-03 kernel: drbd r0 =
tcp:drbd9-05: Closing unexpected connection from 100.100.10.21 to port 7000=
<br>Nov 12 13:02:29 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpect=
ed connection from 100.100.10.21 to port 7000<br>Nov 12 13:02:40 drbd9-03 k=
ernel: drbd r0 tcp:drbd9-05: Closing unexpected connection from 100.100.10.=
21 to port 7000<br>Nov 12 13:02:44 drbd9-03 kernel: drbd r0 drbd9-04: Ignor=
ing P_TWOPC_ABORT packet 452962539.<br>Nov 12 13:02:48 drbd9-03 kernel: drb=
d_r_r0 D ffff88003d613680 0 36203 2 0x00000084<br>Nov 12 13:02:52 drbd9-03 =
kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection from 100.100.10=
.21 to port 7000<br>Nov 12 13:03:03 drbd9-03 kernel: drbd r0 tcp:drbd9-05: =
Closing unexpected connection from 100.100.10.21 to port 7000<br>Nov 12 13:=
03:12 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection =
from 100.100.10.21 to port 7000<br>Nov 12 13:03:14 drbd9-03 kernel: drbd r0=
 drbd9-01: Ignoring P_TWOPC_ABORT packet 4060565678.<br>Nov 12 13:03:14 drb=
d9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT packet 3441716583.<b=
r><br><br><br>2. New question<br><br>Ver:</div><div>=C2=A0 - drbd-9.0.1-1</=
div><div>=C2=A0 - CentOS 7</div><div><br><div>Env:</div><div>=C2=A0 - confi=
gure 4 nodes but use 3 nodes only</div><div><br></div><div>Test:</div><div>=
=C2=A01) setup node1, 2, 3</div><div>=C2=A02) node1: primary=C2=A0</div><di=
v>=C2=A03) node1: mount /dev/drbd1 =C2=A0/mnt</div><div>=C2=A04) node1 : in=
validate-remote=C2=A0</div><div>=C2=A05) wait for fullsync for all nodes</d=
iv><div>=C2=A06) test network disconnect/connect for all nodes by disable/e=
nable VM&#39;s network icon</div><div>=C2=A07) node2: down -&gt; up</div><d=
iv>=C2=A08) node3: down is pending until 600 sec timeout!!!</div><div><br><=
/div><div>Notes:</div><div>=C2=A0 - There is no file copy test.</div><div><=
br></div><div>Logs:</div><div>=C2=A0- node3 log has important messages as f=
ollows;</div><div><br></div><div><div>Feb 26 18:36:28 drbd9-03 kernel: INFO=
: task drbd_r_r0:3114 blocked for more than 120 seconds.</div><div>Feb 26 1=
8:36:28 drbd9-03 kernel: &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeo=
ut_secs&quot; disables this message.</div><div>Feb 26 18:36:28 drbd9-03 ker=
nel: drbd_r_r0 =C2=A0 =C2=A0 =C2=A0 D ffff88003d613680 =C2=A0 =C2=A0 0 =C2=
=A03114 =C2=A0 =C2=A0 =C2=A02 0x00000080</div><div>Feb 26 18:36:28 drbd9-03=
 kernel: ffff8800369a3b70 0000000000000046 ffff88001c8ab8e0 ffff8800369a3fd=
8</div><div>Feb 26 18:36:28 drbd9-03 kernel: ffff8800369a3fd8 ffff8800369a3=
fd8 ffff88001c8ab8e0 ffff880039f5e960</div><div>Feb 26 18:36:28 drbd9-03 ke=
rnel: 7fffffffffffffff ffff88001c8ab8e0 0000000000000002 0000000000000000</=
div><div>Feb 26 18:36:28 drbd9-03 kernel: Call Trace:</div><div>Feb 26 18:3=
6:28 drbd9-03 kernel: [&lt;ffffffff816096a9&gt;] schedule+0x29/0x70</div><d=
iv>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff816075f9&gt;] schedule_tim=
eout+0x209/0x2d0</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff81=
0a9512&gt;] ? default_wake_function+0x12/0x20</div><div>Feb 26 18:36:28 drb=
d9-03 kernel: [&lt;ffffffff8109825b&gt;] ? autoremove_wake_function+0x2b/0x=
40</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff810b1c7c&gt;] ? =
update_curr+0xcc/0x150</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffff=
ffff81608b72&gt;] __down_common+0xd2/0x14a</div><div>Feb 26 18:36:28 drbd9-=
03 kernel: [&lt;ffffffff810b2a6e&gt;] ? dequeue_task_fair+0x40e/0x620</div>=
<div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff81608c07&gt;] __down+0x1=
d/0x1f</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff8109d201&gt;=
] down+0x41/0x50</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffffa0=
4b23c4&gt;] state_change_lock+0x54/0x60 [drbd]</div><div>Feb 26 18:36:28 dr=
bd9-03 kernel: [&lt;ffffffffa04b7700&gt;] ? __change_peer_disk_states+0x70/=
0x70 [drbd]</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffffa04b5cc=
6&gt;] change_cluster_wide_state+0x46/0xe90 [drbd]</div><div>Feb 26 18:36:2=
8 drbd9-03 kernel: [&lt;ffffffff8108007e&gt;] ? try_to_del_timer_sync+0x5e/=
0x90</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff81080102&gt;] =
? del_timer_sync+0x52/0x60</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;=
ffffffff8160756d&gt;] ? schedule_timeout+0x17d/0x2d0</div><div>Feb 26 18:36=
:28 drbd9-03 kernel: [&lt;ffffffff8107ed90&gt;] ? __internal_add_timer+0x13=
0/0x130</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffffa04b7336&gt=
;] change_cstate+0x86/0xc0 [drbd]</div><div>Feb 26 18:36:28 drbd9-03 kernel=
: [&lt;ffffffffa0486de1&gt;] drbd_receiver+0x151/0x630 [drbd]</div><div>Feb=
 26 18:36:28 drbd9-03 kernel: [&lt;ffffffffa0492521&gt;] drbd_thread_setup+=
0x61/0x120 [drbd]</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffffa=
04924c0&gt;] ? w_complete+0x20/0x20 [drbd]</div><div>Feb 26 18:36:28 drbd9-=
03 kernel: [&lt;ffffffff8109726f&gt;] kthread+0xcf/0xe0</div><div>Feb 26 18=
:36:28 drbd9-03 kernel: [&lt;ffffffff810971a0&gt;] ? kthread_create_on_node=
+0x140/0x140</div><div>Feb 26 18:36:28 drbd9-03 kernel: [&lt;ffffffff816141=
58&gt;] ret_from_fork+0x58/0x90</div><div>Feb 26 18:36:28 drbd9-03 kernel: =
[&lt;ffffffff810971a0&gt;] ? kthread_create_on_node+0x140/0x140</div></div>=
<div><br></div><div><br></div></div><div>Let me attach full log files here:=
 =C2=A0<br>=C2=A0- node1:=C2=A0<a href=3D"http://pastebin.com/742jzerd">htt=
p://pastebin.com/742jzerd</a></div><div>=C2=A0- node2:=C2=A0<a href=3D"http=
://pastebin.com/dFaaFkeK">http://pastebin.com/dFaaFkeK</a></div><div>=C2=A0=
- node3:=C2=A0<a href=3D"http://pastebin.com/irk4ykgN">http://pastebin.com/=
irk4ykgN</a></div><div><br>Please see my comments interspersed in above log=
 files.<br>I think it&#39;s very critical problem.</div><div><br>Thanks.<br=
><span style=3D"font-size:14px;font-weight:normal"><br></span></div></div>
</div>

--001a11438eaa069f6e052cabc6d6--
