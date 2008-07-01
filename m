Return-Path: <muth@parascale.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 79C1D2DD03BF
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2008 08:35:47 +0200 (CEST)
Received: by yw-out-2324.google.com with SMTP id 5so931493ywh.33
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jun 2008 23:35:42 -0700 (PDT)
Message-ID: <6fbb8fd90806302329i8e041f3kc21e834e8ddf3b5f@mail.gmail.com>
Date: Mon, 30 Jun 2008 23:29:13 -0700
From: "John Muth" <muth@parascale.com>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26558_6759455.1214893753723"
Subject: [Drbd-dev] DRBD Reconnection Bug
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

------=_Part_26558_6759455.1214893753723
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been testing DRBD 8.2.6 on top of Centos 5.1 for use in a lights-out
environment.

I think I ran across a bug.Ha sanyone seen anything like this:

Background:

I'm running DRBD on top of LVM. I have a LVM volume named 'sm-vol' on two
nodes and I've got /dev/drbd0 mapped to it. I replicate using 'protocol C'.
At the beginning of the test node A is the primary and node B is the
secondary. My test script does:

  1. Write verifiable data to /dev/drbd0 on node A. Create a LVM snapshot on
node B and verify the data.
  2. Bring down node B using 'service drbd stop' Write more data frm node A.
Bring the node B back up with 'service drbd start'. When re-sync is
complete, create a LVM snapshot on the node B and verify that the contents
match what was written by the node A.
  3. Bring down node A with 'service drbd stop'. Make the node B into the
primary (drbdadm primary sm-vol). Write more data to the /dev/drbd0 from
node B.. Bring node A back with 'service drbd start'. Wait for resync to
complete. Create LVM snapshot on node A and erify data.
  4. Run 'drbdadm secondary sm-vol' on node B followed by 'drbdadm primary
sm-vol' on node A.
  5  Repeat

Once every 100 or so loops, DRBD gets wedged during a reconnection. When the
system gets wedged, I do 'cat /etc/drbd' on both nodes and I see the
following:

On primary:

[root@vm5 ~]# cat /proc/drbd
version: 8.2.6 (api:88/proto:86-88)
GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by
buildsvn@c5-i386-build, 2008-06-26 16:40:17
 0: cs:WFBitMapS st:Primary/Secondary ds:UpToDate/Outdated C r---
    ns:288064 nr:94516 dw:613836 dr:845384 al:122 bm:31 lo:0 pe:0 ua:0 ap:0
oos:95888

On secondary:

[root@vm6 ~]# cat /proc/drbd
version: 8.2.6 (api:88/proto:86-88)
GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by
buildsvn@c5-i386-build, 2008-06-26 16:40:17
 0: cs:WFBitMapT st:Secondary/Primary ds:Negotiating/UpToDate C r---
    ns:0 nr:0 dw:0 dr:0 al:106 bm:93 lo:0 pe:0 ua:0 ap:0 oos:95888

/var/log/messages looks like:

On primary:

Jun 30 13:30:08 vm5 kernel: drbd0: peer( Secondary -> Unknown ) conn(
Connected -> TearDown ) pdsk( UpToDate -> DUnknown )
Jun 30 13:30:08 vm5 kernel: drbd0: Writing meta data super block now.
Jun 30 13:30:08 vm5 kernel: drbd0: Creating new current UUID
Jun 30 13:30:08 vm5 kernel: drbd0: Writing meta data super block now.
Jun 30 13:30:08 vm5 kernel: drbd0: asender terminated
Jun 30 13:30:08 vm5 kernel: drbd0: Terminating asender thread
Jun 30 13:30:08 vm5 kernel: drbd0: tl_clear()
Jun 30 13:30:08 vm5 kernel: drbd0: Connection closed
Jun 30 13:30:08 vm5 kernel: drbd0: conn( TearDown -> Unconnected )
Jun 30 13:30:08 vm5 kernel: drbd0: receiver terminated
Jun 30 13:30:08 vm5 kernel: drbd0: receiver (re)started
Jun 30 13:30:08 vm5 kernel: drbd0: conn( Unconnected -> WFConnection )
Jun 30 13:30:08 vm5 kernel: drbd0: Handshake successful: Agreed network
protocol version 88
Jun 30 13:30:08 vm5 kernel: drbd0: conn( WFConnection -> WFReportParams )
Jun 30 13:30:08 vm5 kernel: drbd0: Starting asender thread (from
drbd0_receiver [12327])
Jun 30 13:30:08 vm5 kernel: drbd0: data-integrity-alg: <not-used>
Jun 30 13:30:08 vm5 kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> Connected ) pdsk( DUnknown -> Diskless )
Jun 30 13:30:08 vm5 kernel: drbd0: Writing meta data super block now.
Jun 30 13:30:17 vm5 kernel: drbd0: real peer disk state = Consistent
Jun 30 13:30:17 vm5 kernel: drbd0: conn( Connected -> WFBitMapS ) pdsk(
Diskless -> Outdated )
Jun 30 13:30:17 vm5 kernel: drbd0: Writing meta data super block now.


On secondary:

Jun 30 13:28:46 vm6 kernel: drbd0: peer( Primary -> Unknown ) conn(
Connected -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Jun 30 13:28:46 vm6 kernel: drbd0: asender terminated
Jun 30 13:28:46 vm6 kernel: drbd0: Terminating asender thread
Jun 30 13:28:46 vm6 kernel: drbd0: Writing meta data super block now.
Jun 30 13:28:46 vm6 kernel: drbd0: sock was shut down by peer
Jun 30 13:28:46 vm6 kernel: drbd0: short read expecting header on sock: r=0
Jun 30 13:28:46 vm6 kernel: drbd0: tl_clear()
Jun 30 13:28:46 vm6 kernel: drbd0: Connection closed
Jun 30 13:28:46 vm6 kernel: drbd0: conn( NetworkFailure -> Unconnected )
Jun 30 13:28:46 vm6 kernel: drbd0: receiver terminated
Jun 30 13:28:46 vm6 kernel: drbd0: receiver (re)started
Jun 30 13:28:46 vm6 kernel: drbd0: conn( Unconnected -> WFConnection )
Jun 30 13:28:46 vm6 kernel: drbd0: disk( UpToDate -> Diskless )
Jun 30 13:28:46 vm6 kernel: drbd0: Handshake successful: Agreed network
protocol version 88
Jun 30 13:28:46 vm6 kernel: drbd0: conn( WFConnection -> WFReportParams )
Jun 30 13:28:46 vm6 kernel: drbd0: Starting asender thread (from
drbd0_receiver [9457])
Jun 30 13:28:46 vm6 kernel: drbd0: data-integrity-alg: <not-used>
Jun 30 13:28:46 vm6 kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> Connected ) pdsk( DUnknown -> UpToDate )
Jun 30 13:28:55 vm6 kernel: drbd0: disk( Diskless -> Attaching )
Jun 30 13:28:55 vm6 kernel: drbd0: Found 4 transactions (145 active extents)
in activity log.
Jun 30 13:28:55 vm6 kernel: drbd0: max_segment_size ( = BIO size ) = 32768
Jun 30 13:28:55 vm6 kernel: drbd0: reading of bitmap took 1 jiffies
Jun 30 13:28:55 vm6 kernel: drbd0: recounting of set bits took additional 0
jiffies
Jun 30 13:28:55 vm6 kernel: drbd0: 0 KB (0 bits) marked out-of-sync by on
disk bit-map.
Jun 30 13:28:55 vm6 kernel: drbd0: disk( Attaching -> Negotiating )
Jun 30 13:28:55 vm6 kernel: drbd0: Writing meta data super block now.
Jun 30 13:28:55 vm6 kernel: drbd0: unexpected cstate (Connected) in
receive_bitmap
Jun 30 13:28:55 vm6 kernel: drbd0: conn( Connected -> WFBitMapT )

Has anyone seen this before?

-John Muth
Parascale Software

------=_Part_26558_6759455.1214893753723
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve been testing DRBD 8.2.6 on top of Centos 5.1 for use in a lights-out environment.<br><br>I think I ran across a bug.Ha sanyone seen anything like this:<br><br>Background:<br><br>I&#39;m running DRBD on top of LVM. I have a LVM volume named &#39;sm-vol&#39; on two nodes and I&#39;ve got /dev/drbd0 mapped to it. I replicate using &#39;protocol C&#39;. At the beginning of the test node A is the primary and node B is the secondary. My test script does:<br>
<br>&nbsp; 1. Write verifiable data to /dev/drbd0 on node A. Create a LVM snapshot on node B and verify the data.<br>&nbsp; 2. Bring down node B using &#39;service drbd stop&#39; Write more data frm node A. Bring the node B back up with &#39;service drbd start&#39;. When re-sync is complete, create a LVM snapshot on the node B and verify that the contents match what was written by the node A.<br>
&nbsp; 3. Bring down node A with &#39;service drbd stop&#39;. Make the node B into the primary (drbdadm primary sm-vol). Write more data to the /dev/drbd0 from node B.. Bring node A back with &#39;service drbd start&#39;. Wait for resync to complete. Create LVM snapshot on node A and erify data.<br>
&nbsp; 4. Run &#39;drbdadm secondary sm-vol&#39; on node B followed by &#39;drbdadm primary sm-vol&#39; on node A.<br>&nbsp; 5&nbsp; Repeat<br><br>Once every 100 or so loops, DRBD gets wedged during a reconnection. When the system gets wedged, I do &#39;cat /etc/drbd&#39; on both nodes and I see the following:<br>
<br>On primary:<br><br>[root@vm5 ~]# cat /proc/drbd<br>version: 8.2.6 (api:88/proto:86-88)<br>GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by buildsvn@c5-i386-build, 2008-06-26 16:40:17<br>&nbsp;0: cs:WFBitMapS st:Primary/Secondary ds:UpToDate/Outdated C r---<br>
&nbsp;&nbsp;&nbsp; ns:288064 nr:94516 dw:613836 dr:845384 al:122 bm:31 lo:0 pe:0 ua:0 ap:0 oos:95888<br><br>On secondary:<br><br>[root@vm6 ~]# cat /proc/drbd<br>version: 8.2.6 (api:88/proto:86-88)<br>GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by buildsvn@c5-i386-build, 2008-06-26 16:40:17<br>
&nbsp;0: cs:WFBitMapT st:Secondary/Primary ds:Negotiating/UpToDate C r---<br>&nbsp;&nbsp;&nbsp; ns:0 nr:0 dw:0 dr:0 al:106 bm:93 lo:0 pe:0 ua:0 ap:0 oos:95888<br><br>/var/log/messages looks like:<br><br>On primary:<br><br>Jun 30 13:30:08 vm5 kernel: drbd0: peer( Secondary -&gt; Unknown ) conn( Connected -&gt; TearDown ) pdsk( UpToDate -&gt; DUnknown )<br>
Jun 30 13:30:08 vm5 kernel: drbd0: Writing meta data super block now.<br>Jun 30 13:30:08 vm5 kernel: drbd0: Creating new current UUID<br>Jun 30 13:30:08 vm5 kernel: drbd0: Writing meta data super block now.<br>Jun 30 13:30:08 vm5 kernel: drbd0: asender terminated<br>
Jun 30 13:30:08 vm5 kernel: drbd0: Terminating asender thread<br>Jun 30 13:30:08 vm5 kernel: drbd0: tl_clear()<br>Jun 30 13:30:08 vm5 kernel: drbd0: Connection closed<br>Jun 30 13:30:08 vm5 kernel: drbd0: conn( TearDown -&gt; Unconnected )<br>
Jun 30 13:30:08 vm5 kernel: drbd0: receiver terminated<br>Jun 30 13:30:08 vm5 kernel: drbd0: receiver (re)started<br>Jun 30 13:30:08 vm5 kernel: drbd0: conn( Unconnected -&gt; WFConnection )<br>Jun 30 13:30:08 vm5 kernel: drbd0: Handshake successful: Agreed network protocol version 88<br>
Jun 30 13:30:08 vm5 kernel: drbd0: conn( WFConnection -&gt; WFReportParams )<br>Jun 30 13:30:08 vm5 kernel: drbd0: Starting asender thread (from drbd0_receiver [12327])<br>Jun 30 13:30:08 vm5 kernel: drbd0: data-integrity-alg: &lt;not-used&gt;<br>
Jun 30 13:30:08 vm5 kernel: drbd0: peer( Unknown -&gt; Secondary ) conn( WFReportParams -&gt; Connected ) pdsk( DUnknown -&gt; Diskless )<br>Jun 30 13:30:08 vm5 kernel: drbd0: Writing meta data super block now.<br>Jun 30 13:30:17 vm5 kernel: drbd0: real peer disk state = Consistent<br>
Jun 30 13:30:17 vm5 kernel: drbd0: conn( Connected -&gt; WFBitMapS ) pdsk( Diskless -&gt; Outdated )<br>Jun 30 13:30:17 vm5 kernel: drbd0: Writing meta data super block now.<br><br><br>On secondary:<br><br>Jun 30 13:28:46 vm6 kernel: drbd0: peer( Primary -&gt; Unknown ) conn( Connected -&gt; NetworkFailure ) pdsk( UpToDate -&gt; DUnknown )<br>
Jun 30 13:28:46 vm6 kernel: drbd0: asender terminated<br>Jun 30 13:28:46 vm6 kernel: drbd0: Terminating asender thread<br>Jun 30 13:28:46 vm6 kernel: drbd0: Writing meta data super block now.<br>Jun 30 13:28:46 vm6 kernel: drbd0: sock was shut down by peer<br>
Jun 30 13:28:46 vm6 kernel: drbd0: short read expecting header on sock: r=0<br>Jun 30 13:28:46 vm6 kernel: drbd0: tl_clear()<br>Jun 30 13:28:46 vm6 kernel: drbd0: Connection closed<br>Jun 30 13:28:46 vm6 kernel: drbd0: conn( NetworkFailure -&gt; Unconnected )<br>
Jun 30 13:28:46 vm6 kernel: drbd0: receiver terminated<br>Jun 30 13:28:46 vm6 kernel: drbd0: receiver (re)started<br>Jun 30 13:28:46 vm6 kernel: drbd0: conn( Unconnected -&gt; WFConnection )<br>Jun 30 13:28:46 vm6 kernel: drbd0: disk( UpToDate -&gt; Diskless )<br>
Jun 30 13:28:46 vm6 kernel: drbd0: Handshake successful: Agreed network protocol version 88<br>Jun 30 13:28:46 vm6 kernel: drbd0: conn( WFConnection -&gt; WFReportParams )<br>Jun 30 13:28:46 vm6 kernel: drbd0: Starting asender thread (from drbd0_receiver [9457])<br>
Jun 30 13:28:46 vm6 kernel: drbd0: data-integrity-alg: &lt;not-used&gt;<br>Jun 30 13:28:46 vm6 kernel: drbd0: peer( Unknown -&gt; Primary ) conn( WFReportParams -&gt; Connected ) pdsk( DUnknown -&gt; UpToDate )<br>Jun 30 13:28:55 vm6 kernel: drbd0: disk( Diskless -&gt; Attaching )<br>
Jun 30 13:28:55 vm6 kernel: drbd0: Found 4 transactions (145 active extents) in activity log.<br>Jun 30 13:28:55 vm6 kernel: drbd0: max_segment_size ( = BIO size ) = 32768<br>Jun 30 13:28:55 vm6 kernel: drbd0: reading of bitmap took 1 jiffies<br>
Jun 30 13:28:55 vm6 kernel: drbd0: recounting of set bits took additional 0 jiffies<br>Jun 30 13:28:55 vm6 kernel: drbd0: 0 KB (0 bits) marked out-of-sync by on disk bit-map.<br>Jun 30 13:28:55 vm6 kernel: drbd0: disk( Attaching -&gt; Negotiating )<br>
Jun 30 13:28:55 vm6 kernel: drbd0: Writing meta data super block now.<br>Jun 30 13:28:55 vm6 kernel: drbd0: unexpected cstate (Connected) in receive_bitmap<br>Jun 30 13:28:55 vm6 kernel: drbd0: conn( Connected -&gt; WFBitMapT )<br>
<br>Has anyone seen this before?<br><br>-John Muth<br>Parascale Software<br><br><br>

------=_Part_26558_6759455.1214893753723--
