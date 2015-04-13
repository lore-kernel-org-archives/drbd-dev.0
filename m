Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3DAE81050592
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3457A455828
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3FE6VRKN9yGU for <drbd-dev@lists.linbit.com>;
	Thu, 16 Apr 2015 17:22:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 128C7455A2F
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DgAeYXvjdBUq for <drbd-dev@lists.linbit.com>;
	Thu, 16 Apr 2015 17:22:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id C530E455828
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:42 +0200 (CEST)
Resent-Message-ID: <20150416152242.GC18767@soda.linbit>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 69CFF1005437
	for <drbd-dev@lists.linbit.com>; Tue, 14 Apr 2015 02:16:15 +0200 (CEST)
Received: by wgso17 with SMTP id o17so98498728wgs.1
	for <drbd-dev@lists.linbit.com>; Mon, 13 Apr 2015 17:16:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEBniQ5wGKGuTpQ3OR3eobqYJStc+3zfrqKup3X2rARHwTGGcw@mail.gmail.com>
References: <CAEBniQ5wGKGuTpQ3OR3eobqYJStc+3zfrqKup3X2rARHwTGGcw@mail.gmail.com>
Date: Mon, 13 Apr 2015 17:45:25 -0600
Message-ID: <CAEBniQ506H3-wwBfYMSNv3hDyd3Pg1OwR3QXqQ4GE6rfL49NHA@mail.gmail.com>
From: Fang Sun <sunf2002@gmail.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=047d7bb70b6843a9a50513a3b5e8
Subject: Re: [Drbd-dev] A question about drbd hang in conn_disconnect
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

--047d7bb70b6843a9a50513a3b5e8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi drbd developers,

After some research and tests I feel I found the reason of this problem and
a possible fix in drbd.
Would you please check if my theory is correct?


Let me use 8.4.6 as the code base when I explain it.
When conn_disconnect hang it is hanging at line drbd_receiver.c:5178
static int drbd_disconnected(struct drbd_peer_device *peer_device)
{
........
wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
}

The reason is device has flag BITMAP_IO set.


The reason why flag BITMAP_IO is set and not clear is:
Disk state changes when network is disconnected and after_state_ch is
called.

At drbd_state.c line 1949 drbd_queue_bitmap_io is called inafter_state_ch()
.

I think the real reason is in drbd_queue_bitmap_io. drbd_main.c line 3641.
void drbd_queue_bitmap_io(struct drbd_device *device,
  int (*io_fn)(struct drbd_device *),
  void (*done)(struct drbd_device *, int),
  char *why, enum bm_flag flags)
{
.........
set_bit(BITMAP_IO, &device->flags);
if (atomic_read(&device->ap_bio_cnt) =3D=3D 0) {
if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
drbd_queue_work(&first_peer_device(device)->connection->sender_work,
&device->bm_io_work.w);
}
........
}

In the code the only code to clear BITMAP_IO is in
device->bm_io_work.w(w_bitmap_io). But when
atomic_read(&device->ap_bio_cnt) !=3D 0 the flag BITMAP_IO  is set, however
bm_io_work.w is not called.
Then drbd_disconnected() is blocked.

Should we move set_bit(BITMAP_IO, &device->flags) to the front of
drbd_queue_work()?


Thanks a lot!

Fang



On Thu, Apr 9, 2015 at 12:56 PM, Fang Sun <sunf2002@gmail.com> wrote:

> Hi drbd team,
>
> I am running into a drbd problem recently and I hope I can get some help
> from you.
>
> This problem can be reproduced in 8.4.4,8.4.5 and 8.4.6.
>
> I have a 2 nodes cluster. There are 2 disks. One disk is upToDate and the
> other is syncing.
> I cut the network on standby when one disk is syncing.
> I configured fencing=3Dresource-and-stonith, and I expect my drbd fencing=
 is
> called when network is shutdown. This always works as expected if both di=
sk
> are UpToDate when I shutdown network on standby.
> But when one disk is syncing this caused the drbd to suspend both disks
> and drbd fencing isn't called. And I can see drbd read process is put int=
o
> D state.
>
> Some logs on primary:
>
> Apr  6 16:53:49 shrvm219 kernel: drbd cic: PingAck did not arrive in time=
.
>
> Apr  6 16:53:49 shrvm219 kernel: block drbd1: conn( SyncSource ->
> NetworkFailure )
>
> Apr  6 16:53:49 shrvm219 kernel: block drbd2: conn( Connected ->
> NetworkFailure ) pdsk( UpToDate -> DUnknown )
>
> Apr  6 16:53:49 shrvm219 kernel: drbd cic: peer( Secondary -> Unknown )
> susp( 0 -> 1 )
>
> Apr  6 16:53:49 shrvm219 kernel: drbd cic: susp( 0 -> 1 )
>
> Apr  6 16:53:49 shrvm219 kernel: drbd cic: asender terminated
>
> Apr  6 16:53:49 shrvm219 kernel: drbd cic: Terminating drbd_a_cic
>
> >>>There isn=E2=80=99t Connection closed
>
> Apr  6 16:57:28 shrvm220 kernel: INFO: task xfsalloc/0:805 blocked for
> more than 120 seconds.
>
>
>
> Apr  3 20:57:36 shrvm220 kernel: INFO: task xfsaild/drbd2:16778 blocked
> for more than 120 seconds.
>
>
> [root@shrvm219 ~]# ps -ax | grep drbd
>
> Warning: bad syntax, perhaps a bogus '-'? See
> /usr/share/doc/procps-3.2.8/FAQ
>
> 5683 ?        S      0:00 [drbd-reissue]
>
> 11386 pts/0    S+     0:00 grep drbd
>
> 12098 ?        S      0:00 [drbd_submit]
>
> 12103 ?        S      0:00 [drbd_submit]
>
> 12118 ?        S      0:02 [drbd_w_cic]
>
> 12139 ?        D      0:03 [drbd_r_cic]
>
> 12847 ?        S      0:00 [xfsbufd/drbd2]
>
> 12848 ?        S      0:00 [xfs-cil/drbd2]
>
> 12849 ?        D      0:00 [xfssyncd/drbd2]
>
> 12850 ?        S      0:02 [xfsaild/drbd2]
>
> 13359 ?        S      0:00 [xfsbufd/drbd1]
>
> 13360 ?        S      0:00 [xfs-cil/drbd1]
>
> 13361 ?        D      0:00 [xfssyncd/drbd1]
>
> 13362 ?        S      0:02 [xfsaild/drbd1]
>
>
> This is part of kernel stack, as I thought drbd is stuck at
> conn_disconnect.
>
>
>
> Apr  7 19:34:08 shrvm219 kernel: SysRq : Show Blocked State
>
> Apr  7 19:34:08 shrvm219 kernel:  task                        PC stack
> pid father
>
> Apr  7 19:34:08 shrvm219 kernel: drbd_r_cic    D 0000000000000000     0
> 12139      2 0x00000084
>
> Apr  7 19:34:08 shrvm219 kernel: ffff88023886fd90 0000000000000046
> 0000000000000000 ffff88023886fd54
>
> Apr  7 19:34:08 shrvm219 kernel: ffff88023886fd20 ffff88023fc23040
> 000002b2f338c2ce ffff8800283158c0
>
> Apr  7 19:34:08 shrvm219 kernel: 00000000000005ff 000000010028bb73
> ffff88023ab87058 ffff88023886ffd8
>
> Apr  7 19:34:08 shrvm219 kernel: Call Trace:
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109ee2e>] ?
> prepare_to_wait+0x4e/0x80
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa0394d4d>]
> conn_disconnect+0x22d/0x4f0 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109eb00>] ?
> autoremove_wake_function+0x0/0x40
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa0395120>]
> drbd_receiver+0x110/0x220 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa03a69e0>] ?
> drbd_thread_setup+0x0/0x110 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa03a6a0d>]
> drbd_thread_setup+0x2d/0x110 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa03a69e0>] ?
> drbd_thread_setup+0x0/0x110 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109e66e>] kthread+0x9e/0xc0
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8100c20a>] child_rip+0xa/0x20
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109e5d0>] ? kthread+0x0/0xc0
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8100c200>] ? child_rip+0x0/0x2=
0
>
> Apr  7 19:34:08 shrvm219 kernel: xfssyncd/drbd D 0000000000000001     0
> 12849      2 0x00000080
>
> Apr  7 19:34:08 shrvm219 kernel: ffff880203387ad0 0000000000000046
> 0000000000000000 ffff880203387a94
>
> Apr  7 19:34:08 shrvm219 kernel: ffff880203387a30 ffff88023fc23040
> 000002b60ef7decd ffff8800283158c0
>
> Apr  7 19:34:08 shrvm219 kernel: 0000000000000400 000000010028ef9d
> ffff88023921bab8 ffff880203387fd8
>
> Apr  7 19:34:08 shrvm219 kernel: Call Trace:
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa039c947>]
> drbd_make_request+0x197/0x330 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109eb00>] ?
> autoremove_wake_function+0x0/0x40
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff81270810>]
> generic_make_request+0x240/0x5a0
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa039cbe9>] ?
> drbd_merge_bvec+0x109/0x2a0 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff81270be0>] submit_bio+0x70/0x1=
20
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff81064b90>] ?
> default_wake_function+0x0/0x20
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa0208bba>]
> _xfs_buf_ioapply+0x16a/0x200 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa01ef50a>] ?
> xlog_bdstrat+0x2a/0x60 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa020a87f>]
> xfs_buf_iorequest+0x4f/0xe0 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa01ef50a>]
> xlog_bdstrat+0x2a/0x60 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa01f0ce9>]
> xlog_sync+0x269/0x3e0 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa01f0f13>]
> xlog_state_release_iclog+0xb3/0xf0 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa01f13a2>]
> _xfs_log_force+0x122/0x240 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa01f1688>]
> xfs_log_force+0x38/0x90 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa0214a02>]
> xfs_sync_worker+0x52/0xa0 [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa021491e>] xfssyncd+0x17e/0x21=
0
> [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa02147a0>] ? xfssyncd+0x0/0x21=
0
> [xfs]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109e66e>] kthread+0x9e/0xc0
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8100c20a>] child_rip+0xa/0x20
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109e5d0>] ? kthread+0x0/0xc0
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8100c200>] ? child_rip+0x0/0x2=
0
>
> Apr  7 19:34:08 shrvm219 kernel: xfssyncd/drbd D 0000000000000001     0
> 13361      2 0x00000080
>
> Apr  7 19:34:08 shrvm219 kernel: ffff8802033edad0 0000000000000046
> 0000000000000000 ffff8802033eda94
>
> Apr  7 19:34:08 shrvm219 kernel: 0000000000000000 ffff88023fc23040
> 000002b60ef68ea3 ffff8800283158c0
>
> Apr  7 19:34:08 shrvm219 kernel: 00000000000007fe 000000010028ef9d
> ffff880239c41058 ffff8802033edfd8
>
> Apr  7 19:34:08 shrvm219 kernel: Call Trace:
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa039c947>]
> drbd_make_request+0x197/0x330 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff8109eb00>] ?
> autoremove_wake_function+0x0/0x40
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff81270810>]
> generic_make_request+0x240/0x5a0
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffffa039cbe9>] ?
> drbd_merge_bvec+0x109/0x2a0 [drbd]
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff81270be0>] submit_bio+0x70/0x1=
20
>
> Apr  7 19:34:08 shrvm219 kernel: [<ffffffff81064b90>] ?
> default_wake_function+0x0/0x20
>
>
> Thanks a lot in advance.
>
>
> Fang
>

--047d7bb70b6843a9a50513a3b5e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi drbd developers,<div><br></div><div>After some research=
 and tests I feel I found the reason of this problem and a possible fix in =
drbd.</div><div>Would you please check if my theory is correct?</div><div><=
br></div><div><br></div><div>Let me use 8.4.6 as the code base when I expla=
in it.</div><div>When=C2=A0conn_disconnect hang it is hanging at line drbd_=
receiver.c:5178</div><div>static int drbd_disconnected(struct drbd_peer_dev=
ice *peer_device)<br></div><div>{</div><div>........</div><div>wait_event(d=
evice-&gt;misc_wait, !test_bit(BITMAP_IO, &amp;device-&gt;flags));<br></div=
><div>}</div><div><br></div><div>The reason is device has flag BITMAP_IO se=
t.</div><div><br></div><div><br></div><div>The reason why flag BITMAP_IO is=
 set and not clear is:</div><div>Disk state changes when network is disconn=
ected and=C2=A0after_state_ch is called.</div><div><br></div><div>At drbd_s=
tate.c line 1949=C2=A0drbd_queue_bitmap_io is called inafter_state_ch() .</=
div><div><br></div><div>I think the real reason is in drbd_queue_bitmap_io.=
 drbd_main.c line 3641.<br></div><div><div>void drbd_queue_bitmap_io(struct=
 drbd_device *device,</div><div><span class=3D"" style=3D"white-space:pre">=
			</span> =C2=A0int (*io_fn)(struct drbd_device *),</div><div><span class=
=3D"" style=3D"white-space:pre">			</span> =C2=A0void (*done)(struct drbd_d=
evice *, int),</div><div><span class=3D"" style=3D"white-space:pre">			</sp=
an> =C2=A0char *why, enum bm_flag flags)</div><div>{</div><div><span style=
=3D"white-space:pre">.........</span></div><div><span class=3D"" style=3D"w=
hite-space:pre">	</span>set_bit(BITMAP_IO, &amp;device-&gt;flags);</div><di=
v><span class=3D"" style=3D"white-space:pre">	</span>if (atomic_read(&amp;d=
evice-&gt;ap_bio_cnt) =3D=3D 0) {</div><div><span class=3D"" style=3D"white=
-space:pre">		</span>if (!test_and_set_bit(BITMAP_IO_QUEUED, &amp;device-&g=
t;flags))</div><div><span class=3D"" style=3D"white-space:pre">			</span>dr=
bd_queue_work(&amp;first_peer_device(device)-&gt;connection-&gt;sender_work=
,</div><div><span class=3D"" style=3D"white-space:pre">					</span>&amp;dev=
ice-&gt;bm_io_work.w);</div><div><span class=3D"" style=3D"white-space:pre"=
>	</span>}</div><div><span style=3D"white-space:pre">........</span></div><=
div>}</div></div><div><br></div><div>In the code the only code to clear BIT=
MAP_IO is in device-&gt;bm_io_work.w(w_bitmap_io). But when atomic_read(&am=
p;device-&gt;ap_bio_cnt) !=3D 0 the flag BITMAP_IO =C2=A0is set, however bm=
_io_work.w is not called.</div><div>Then drbd_disconnected() is blocked.</d=
iv><div><br></div><div>Should we move set_bit(BITMAP_IO, &amp;device-&gt;fl=
ags) to the front of drbd_queue_work()?</div><div><br></div><div><br></div>=
<div>Thanks a lot!</div><div><br></div><div>Fang</div><div><br></div><div><=
br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Apr 9, 2015 at 12:56 PM, Fang Sun <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:sunf2002@gmail.com" target=3D"_blank">sunf2002@gmail.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi drbd team,<d=
iv><br></div><div>I am running into a drbd problem recently and I hope I ca=
n get some help from you.</div><div><br></div><div>This problem can be repr=
oduced in 8.4.4,8.4.5 and 8.4.6.</div><div><br></div><div>I have a 2 nodes =
cluster. There are 2 disks. One disk is upToDate and the other is syncing.<=
/div><div>I cut the network on standby when one disk is syncing.=C2=A0</div=
><div>I configured fencing=3Dresource-and-stonith, and I expect my drbd fen=
cing is called when network is shutdown. This always works as expected if b=
oth disk are UpToDate when I shutdown network on standby.</div><div>But whe=
n one disk is syncing this caused the drbd to suspend both disks and drbd f=
encing isn&#39;t called. And I can see drbd read process is put into D stat=
e.</div><div><br></div><div>Some logs on primary:</div><div><p class=3D"Mso=
Normal" style=3D"margin-left:0.5in"><span style=3D"color:black">Apr=C2=A0
6 16:53:49 shrvm219 kernel: drbd cic: PingAck did not arrive in time.</span=
></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:53:49 shrvm219 kernel: block drbd1: conn( SyncSource -&gt; NetworkFail=
ure
)</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:53:49 shrvm219 kernel: block drbd2: conn( Connected -&gt; NetworkFailu=
re )
pdsk( UpToDate -&gt; DUnknown )</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:53:49 shrvm219 kernel: drbd cic: peer( Secondary -&gt; Unknown ) susp(=
 0
-&gt; 1 )</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:53:49 shrvm219 kernel: drbd cic: susp( 0 -&gt; 1 )</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:53:49 shrvm219 kernel: drbd cic: asender terminated</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:53:49 shrvm219 kernel: drbd cic: Terminating drbd_a_cic</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:red=
">&gt;&gt;&gt;There
isn=E2=80=99t Connection closed</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
6 16:57:28 shrvm220 kernel: INFO: task xfsalloc/0:805 blocked for more than=
 120
seconds.</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin-left:0.5in"><span style=3D"color:bla=
ck">Apr=C2=A0
3 20:57:36 shrvm220 kernel: INFO: task xfsaild/drbd2:16778 blocked for more
than 120 seconds.</span></p><p class=3D"MsoNormal" style=3D"margin-left:0.5=
in"><br></p><p class=3D"MsoNormal"><span style=3D"font-size:9pt;font-family=
:&#39;Lucida Console&#39;">[root@shrvm219 ~]# ps -ax | grep drbd</span></p>=
<p class=3D"MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida=
 Console&#39;">Warning: bad syntax, perhaps a bogus &#39;-&#39;? See
/usr/share/doc/procps-3.2.8/FAQ</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;">5683 ?=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [drbd-reissue]</span></p><p class=3D"M=
soNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;=
">11386 pts/0=C2=A0=C2=A0=C2=A0
S+=C2=A0=C2=A0=C2=A0=C2=A0 0:00 grep drbd</span></p><p class=3D"MsoNormal">=
<span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;">12098 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [drbd_submit]</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;"=
>12103 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [drbd_submit]</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;"=
>12118 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:02 [drbd_w_cic]</span></p><p class=3D"Mso=
Normal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;">=
12139 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:03 [drbd_r_cic]</span></p><p class=3D"Mso=
Normal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39;">=
12847 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [xfsbufd/drbd2]</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39=
;">12848 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [xfs-cil/drbd2]</span></p><p cla=
ss=3D"MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Conso=
le&#39;">12849 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [xfssyncd/drbd2]</span></p><p class=3D=
"MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#3=
9;">12850 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:02 [xfsaild/drbd2]</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39=
;">13359 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [xfsbufd/drbd1]</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39=
;">13360 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [xfs-cil/drbd1]</span></p><p class=3D"=
MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lucida Console&#39=
;">13361 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00 [xfssyncd/drbd1]</span></p><p class=3D=
"MsoNormal" style=3D"margin-left:0.5in">





























</p><p class=3D"MsoNormal"><span style=3D"font-size:9pt;font-family:&#39;Lu=
cida Console&#39;">13362 ?=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:02
[xfsaild/drbd1]</span></p><p class=3D"MsoNormal"><span style=3D"font-size:9=
pt;font-family:&#39;Lucida Console&#39;"><br></span></p><p class=3D"MsoNorm=
al"><span style=3D"color:rgb(31,73,125)">This is part of kernel stack, as
I thought drbd is stuck at conn_disconnect. </span></p><p class=3D"MsoNorma=
l"><span style=3D"color:rgb(31,73,125)">=C2=A0</span></p><p class=3D"MsoNor=
mal">Apr=C2=A0 7 19:34:08 shrvm219 kernel: SysRq : Show Blocked
State</p><p class=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:=C2=A0
task=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
PC stack=C2=A0=C2=A0 pid father</p><p class=3D"MsoNormal">Apr=C2=A0 7 19:34=
:08 shrvm219 kernel: <span style=3D"color:rgb(192,0,0)">drbd_r_cic=C2=A0=C2=
=A0=C2=A0 </span>D
0000000000000000=C2=A0=C2=A0=C2=A0=C2=A0 0 12139=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A02 0x00000084</p><p class=3D"MsoNormal">Apr=C2=A0 7 =
19:34:08 shrvm219 kernel: ffff88023886fd90
0000000000000046 0000000000000000 ffff88023886fd54</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: ffff88023886fd20
ffff88023fc23040 000002b2f338c2ce ffff8800283158c0</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: 00000000000005ff
000000010028bb73 ffff88023ab87058 ffff88023886ffd8</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: Call Trace:</p><p class=3D"MsoNorma=
l">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8109ee2e&gt;] ? prepare_to_wait+0x4e/0x80</p><p class=3D"MsoNo=
rmal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa0394d4d&gt;] conn_disconnect+0x22d/0x4f0 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel: [&lt;ffffffff8109eb00&=
gt;]
? autoremove_wake_function+0x0/0x40</p><p class=3D"MsoNormal">Apr=C2=A0 7 1=
9:34:08 shrvm219 kernel:
[&lt;ffffffffa0395120&gt;] drbd_receiver+0x110/0x220 [drbd]</p><p class=3D"=
MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa03a69e0&gt;] ? drbd_thread_setup+0x0/0x110 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa03a6a0d&gt;] drbd_thread_setup+0x2d/0x110 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa03a69e0&gt;] ? drbd_thread_setup+0x0/0x110 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8109e66e&gt;] kthread+0x9e/0xc0</p><p class=3D"MsoNormal">Apr=
=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8100c20a&gt;] child_rip+0xa/0x20</p><p class=3D"MsoNormal">Apr=
=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8109e5d0&gt;] ? kthread+0x0/0xc0</p><p class=3D"MsoNormal">Apr=
=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8100c200&gt;] ? child_rip+0x0/0x20</p><p class=3D"MsoNormal">A=
pr=C2=A0 7 19:34:08 shrvm219 kernel: <span style=3D"color:rgb(192,0,0)">xfs=
syncd/drbd </span>D
0000000000000001=C2=A0=C2=A0=C2=A0=C2=A0 0 12849=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
2 0x00000080</p><p class=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel=
: ffff880203387ad0
0000000000000046 0000000000000000 ffff880203387a94</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: ffff880203387a30
ffff88023fc23040 000002b60ef7decd ffff8800283158c0</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: 0000000000000400
000000010028ef9d ffff88023921bab8 ffff880203387fd8</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: Call Trace:</p><p class=3D"MsoNorma=
l">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa039c947&gt;] drbd_make_request+0x197/0x330 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8109eb00&gt;] ? autoremove_wake_function+0x0/0x40</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff81270810&gt;] generic_make_request+0x240/0x5a0</p><p class=3D"=
MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa039cbe9&gt;] ? drbd_merge_bvec+0x109/0x2a0 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff81270be0&gt;] submit_bio+0x70/0x120</p><p class=3D"MsoNormal">=
Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff81064b90&gt;] ? default_wake_function+0x0/0x20</p><p class=3D"=
MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa0208bba&gt;] _xfs_buf_ioapply+0x16a/0x200 [xfs]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa01ef50a&gt;] ? xlog_bdstrat+0x2a/0x60 [xfs]</p><p class=3D"Ms=
oNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa020a87f&gt;] xfs_buf_iorequest+0x4f/0xe0 [xfs]</p><p class=3D=
"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa01ef50a&gt;] xlog_bdstrat+0x2a/0x60 [xfs]</p><p class=3D"MsoN=
ormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa01f0ce9&gt;] xlog_sync+0x269/0x3e0 [xfs]</p><p class=3D"MsoNo=
rmal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa01f0f13&gt;] xlog_state_release_iclog+0xb3/0xf0 [xfs]</p><p c=
lass=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa01f13a2&gt;] _xfs_log_force+0x122/0x240 [xfs]</p><p class=3D"=
MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa01f1688&gt;] xfs_log_force+0x38/0x90 [xfs]</p><p class=3D"Mso=
Normal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa0214a02&gt;] xfs_sync_worker+0x52/0xa0 [xfs]</p><p class=3D"M=
soNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa021491e&gt;] xfssyncd+0x17e/0x210 [xfs]</p><p class=3D"MsoNor=
mal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa02147a0&gt;] ? xfssyncd+0x0/0x210 [xfs]</p><p class=3D"MsoNor=
mal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8109e66e&gt;] kthread+0x9e/0xc0</p><p class=3D"MsoNormal">Apr=
=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8100c20a&gt;] child_rip+0xa/0x20</p><p class=3D"MsoNormal">Apr=
=C2=A0 7 19:34:08 shrvm219 kernel: [&lt;ffffffff8109e5d0&gt;]
? kthread+0x0/0xc0</p><p class=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 =
kernel:
[&lt;ffffffff8100c200&gt;] ? child_rip+0x0/0x20</p><p class=3D"MsoNormal">A=
pr=C2=A0 7 19:34:08 shrvm219 kernel<span style=3D"color:rgb(192,0,0)">:
xfssyncd/drbd </span>D 0000000000000001=C2=A0=C2=A0=C2=A0=C2=A0 0
13361=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 0x00000080</p><p class=3D"MsoNormal">=
Apr=C2=A0 7 19:34:08 shrvm219 kernel: ffff8802033edad0
0000000000000046 0000000000000000 ffff8802033eda94</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: 0000000000000000
ffff88023fc23040 000002b60ef68ea3 ffff8800283158c0</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: 00000000000007fe
000000010028ef9d ffff880239c41058 ffff8802033edfd8</p><p class=3D"MsoNormal=
">Apr=C2=A0 7 19:34:08 shrvm219 kernel: Call Trace:</p><p class=3D"MsoNorma=
l">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa039c947&gt;] drbd_make_request+0x197/0x330 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff8109eb00&gt;] ? autoremove_wake_function+0x0/0x40</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff81270810&gt;] generic_make_request+0x240/0x5a0</p><p class=3D"=
MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffffa039cbe9&gt;] ? drbd_merge_bvec+0x109/0x2a0 [drbd]</p><p class=
=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff81270be0&gt;] submit_bio+0x70/0x120</p><p class=3D"MsoNormal">















































































































</p><p class=3D"MsoNormal">Apr=C2=A0 7 19:34:08 shrvm219 kernel:
[&lt;ffffffff81064b90&gt;] ? default_wake_function+0x0/0x20</p><p class=3D"=
MsoNormal"><br></p><p class=3D"MsoNormal">Thanks a lot in advance.</p><span=
 class=3D"HOEnZb"><font color=3D"#888888"><p class=3D"MsoNormal"><br></p><p=
 class=3D"MsoNormal">Fang</p></font></span></div></div>
</blockquote></div><br></div>

--047d7bb70b6843a9a50513a3b5e8--
