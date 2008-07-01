Return-Path: <muth@parascale.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 260232DF6541
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2008 16:35:21 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id k57so239095rnd.13
	for <drbd-dev@lists.linbit.com>; Tue, 01 Jul 2008 07:35:20 -0700 (PDT)
Message-ID: <6fbb8fd90807010728q216d9dau6c246808e8034854@mail.gmail.com>
Date: Tue, 1 Jul 2008 07:28:25 -0700
From: "John Muth" <muth@parascale.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD Reconnection Bug
In-Reply-To: <20080701095359.GD20245@soda.linbit>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2452_29176892.1214922505463"
References: <6fbb8fd90806302329i8e041f3kc21e834e8ddf3b5f@mail.gmail.com>
	<20080701090841.GA20245@soda.linbit>
	<20080701095359.GD20245@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

------=_Part_2452_29176892.1214922505463
Content-Type: multipart/alternative;
	boundary="----=_Part_2453_27799689.1214922505463"

------=_Part_2453_27799689.1214922505463
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Lars,

I've attached the script.

I'm using STAF to do the remote execution stuff. Calls to
'$mgr->start_process' starts a process on a remote note. '$mgr->wait_all'
waits for completion. Similarly '$mgr->start_copy_file' starts a file copy.

I'm afraid I'm pretty clueless WRT to building from source. If you could
send some instructions on how to get the git source and build it on my
system, I'll be glad to try it for you.

Thanks,
John Muth

On 7/1/08, Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
>
> On Tue, Jul 01, 2008 at 11:08:41AM +0200, Lars Ellenberg wrote:
> > On Mon, Jun 30, 2008 at 11:29:13PM -0700, John Muth wrote:
> > > I've been testing DRBD 8.2.6 on top of Centos 5.1 for use in a
> lights-out
> > > environment.
> > >
> > > I think I ran across a bug.Ha sanyone seen anything like this:
> > >
> > > Background:
> > >
> > > I'm running DRBD on top of LVM. I have a LVM volume named 'sm-vol' on
> two nodes
> > > and I've got /dev/drbd0 mapped to it. I replicate using 'protocol C'.
> At the
> > > beginning of the test node A is the primary and node B is the
> secondary. My
> > > test script does:
> > >
> > >   1. Write verifiable data to /dev/drbd0 on node A. Create a LVM
> snapshot on
> > > node B and verify the data.
> > >   2. Bring down node B using 'service drbd stop' Write more data frm
> node A.
> > > Bring the node B back up with 'service drbd start'. When re-sync is
> complete,
> > > create a LVM snapshot on the node B and verify that the contents match
> what was
> > > written by the node A.
> > >   3. Bring down node A with 'service drbd stop'. Make the node B into
> the
> > > primary (drbdadm primary sm-vol). Write more data to the /dev/drbd0
> from node
> > > B.. Bring node A back with 'service drbd start'. Wait for resync to
> complete.
> > > Create LVM snapshot on node A and erify data.
> > >   4. Run 'drbdadm secondary sm-vol' on node B followed by 'drbdadm
> primary
> > > sm-vol' on node A.
> > >   5  Repeat
> > >
> > > Once every 100 or so loops, DRBD gets wedged during a reconnection.
> When the
> > > system gets wedged, I do 'cat /etc/drbd' on both nodes and I see the
> following:
> > >
> > > On primary:
> > >
> > > [root@vm5 ~]# cat /proc/drbd
> > > version: 8.2.6 (api:88/proto:86-88)
> > > GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by
> > > buildsvn@c5-i386-build, 2008-06-26 16:40:17
> > >  0: cs:WFBitMapS st:Primary/Secondary ds:UpToDate/Outdated C r---
> > >     ns:288064 nr:94516 dw:613836 dr:845384 al:122 bm:31 lo:0 pe:0 ua:0
> ap:0
> > > oos:95888
> > >
> > > On secondary:
> > >
> > > [root@vm6 ~]# cat /proc/drbd
> > > version: 8.2.6 (api:88/proto:86-88)
> > > GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by
> > > buildsvn@c5-i386-build, 2008-06-26 16:40:17
> > >  0: cs:WFBitMapT st:Secondary/Primary ds:Negotiating/UpToDate C r---
> > >     ns:0 nr:0 dw:0 dr:0 al:106 bm:93 lo:0 pe:0 ua:0 ap:0 oos:95888
> > >
> > > /var/log/messages looks like:
> > >
> > > On primary:
> > >
> > > Jun 30 13:30:08 vm5 kernel: drbd0: peer( Secondary -> Unknown ) conn(
> Connected
> > > -> TearDown ) pdsk( UpToDate -> DUnknown )
> >
> > > On secondary:
> > >
> > > Jun 30 13:28:46 vm6 kernel: drbd0: peer( Primary -> Unknown ) conn(
> Connected
> > > -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
> >
> > since you can "easily" reproduce this,
> > please get the time in sync on those boxes (ntp),
> > makes it much easier to read logs.
> >
> > then post new logs.
>
>
> but.
>
>
> > Jun 30 13:28:46 vm6 kernel: drbd0: receiver (re)started
> > Jun 30 13:28:46 vm6 kernel: drbd0: conn( Unconnected -> WFConnection )
> > Jun 30 13:28:46 vm6 kernel: drbd0: disk( UpToDate -> Diskless )
> > Jun 30 13:28:46 vm6 kernel: drbd0: Handshake successful: Agreed network
> protocol version 88
> > Jun 30 13:28:46 vm6 kernel: drbd0: conn( WFConnection -> WFReportParams )
> > Jun 30 13:28:46 vm6 kernel: drbd0: Starting asender thread (from
> drbd0_receiver [9457])
> > Jun 30 13:28:46 vm6 kernel: drbd0: data-integrity-alg: <not-used>
> > Jun 30 13:28:46 vm6 kernel: drbd0: peer( Unknown -> Primary ) conn(
> WFReportParams -> Connected ) pdsk( DUnknown -> UpToDate )
>
>
> hm. going Connected while still "Diskless"...
>
>
> > Jun 30 13:28:55 vm6 kernel: drbd0: disk( Diskless -> Attaching )
>
>
> then attaching the disk,
>
>
> > Jun 30 13:28:55 vm6 kernel: drbd0: Found 4 transactions (145 active
> extents) in activity log.
> > Jun 30 13:28:55 vm6 kernel: drbd0: max_segment_size ( = BIO size ) =
> 32768
> > Jun 30 13:28:55 vm6 kernel: drbd0: reading of bitmap took 1 jiffies
> > Jun 30 13:28:55 vm6 kernel: drbd0: recounting of set bits took additional
> 0 jiffies
> > Jun 30 13:28:55 vm6 kernel: drbd0: 0 KB (0 bits) marked out-of-sync by on
> disk bit-map.
> > Jun 30 13:28:55 vm6 kernel: drbd0: disk( Attaching -> Negotiating )
>
>
> going "Negotiating"
>
>
> > Jun 30 13:28:55 vm6 kernel: drbd0: Writing meta data super block now.
>
>
> > Jun 30 13:28:55 vm6 kernel: drbd0: unexpected cstate (Connected) in
> receive_bitmap
>
>
> right there.
>
>
> > Jun 30 13:28:55 vm6 kernel: drbd0: conn( Connected -> WFBitMapT )
>
>
> according to this, it likely is a race between attaching the disk and
> establishing the connection.  we had similar races before, the were
> believed to be fixed :(
>
> do you mind retrying with the latest git checkout?
>
> can you please post your excerciser script?
> which drbdadm / drbdsetup commands get executed in which order?
>
>
>
> --
> : Lars Ellenberg                            Tel +43-1-8178292-55 :
> : LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
> : Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>

------=_Part_2453_27799689.1214922505463
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Lars,<br><br>I&#39;ve attached the script.<br><br>I&#39;m using STAF to do the remote execution stuff. Calls to &#39;$mgr-&gt;start_process&#39; starts a process on a remote note. &#39;$mgr-&gt;wait_all&#39; waits for completion. Similarly &#39;$mgr-&gt;start_copy_file&#39; starts a file copy.<br>
<br>I&#39;m afraid I&#39;m pretty clueless WRT to building from source. If you could send some instructions on how to get the git source and build it on my system, I&#39;ll be glad to try it for you.<br><br>Thanks,<br>John Muth<br>
<br><div><span class="gmail_quote">On 7/1/08, <b class="gmail_sendername">Lars Ellenberg</b> &lt;<a href="mailto:lars.ellenberg@linbit.com">lars.ellenberg@linbit.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, Jul 01, 2008 at 11:08:41AM +0200, Lars Ellenberg wrote:<br> &gt; On Mon, Jun 30, 2008 at 11:29:13PM -0700, John Muth wrote:<br> &gt; &gt; I&#39;ve been testing DRBD 8.2.6 on top of Centos 5.1 for use in a lights-out<br>
 &gt; &gt; environment.<br> &gt; &gt;<br> &gt; &gt; I think I ran across a bug.Ha sanyone seen anything like this:<br> &gt; &gt;<br> &gt; &gt; Background:<br> &gt; &gt;<br> &gt; &gt; I&#39;m running DRBD on top of LVM. I have a LVM volume named &#39;sm-vol&#39; on two nodes<br>
 &gt; &gt; and I&#39;ve got /dev/drbd0 mapped to it. I replicate using &#39;protocol C&#39;. At the<br> &gt; &gt; beginning of the test node A is the primary and node B is the secondary. My<br> &gt; &gt; test script does:<br>
 &gt; &gt;<br> &gt; &gt;&nbsp;&nbsp; 1. Write verifiable data to /dev/drbd0 on node A. Create a LVM snapshot on<br> &gt; &gt; node B and verify the data.<br> &gt; &gt;&nbsp;&nbsp; 2. Bring down node B using &#39;service drbd stop&#39; Write more data frm node A.<br>
 &gt; &gt; Bring the node B back up with &#39;service drbd start&#39;. When re-sync is complete,<br> &gt; &gt; create a LVM snapshot on the node B and verify that the contents match what was<br> &gt; &gt; written by the node A.<br>
 &gt; &gt;&nbsp;&nbsp; 3. Bring down node A with &#39;service drbd stop&#39;. Make the node B into the<br> &gt; &gt; primary (drbdadm primary sm-vol). Write more data to the /dev/drbd0 from node<br> &gt; &gt; B.. Bring node A back with &#39;service drbd start&#39;. Wait for resync to complete.<br>
 &gt; &gt; Create LVM snapshot on node A and erify data.<br> &gt; &gt;&nbsp;&nbsp; 4. Run &#39;drbdadm secondary sm-vol&#39; on node B followed by &#39;drbdadm primary<br> &gt; &gt; sm-vol&#39; on node A.<br> &gt; &gt;&nbsp;&nbsp; 5&nbsp;&nbsp;Repeat<br>
 &gt; &gt;<br> &gt; &gt; Once every 100 or so loops, DRBD gets wedged during a reconnection. When the<br> &gt; &gt; system gets wedged, I do &#39;cat /etc/drbd&#39; on both nodes and I see the following:<br> &gt; &gt;<br>
 &gt; &gt; On primary:<br> &gt; &gt;<br> &gt; &gt; [root@vm5 ~]# cat /proc/drbd<br> &gt; &gt; version: 8.2.6 (api:88/proto:86-88)<br> &gt; &gt; GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by<br> &gt; &gt; buildsvn@c5-i386-build, 2008-06-26 16:40:17<br>
 &gt; &gt;&nbsp;&nbsp;0: cs:WFBitMapS st:Primary/Secondary ds:UpToDate/Outdated C r---<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; ns:288064 nr:94516 dw:613836 dr:845384 al:122 bm:31 lo:0 pe:0 ua:0 ap:0<br> &gt; &gt; oos:95888<br> &gt; &gt;<br> &gt; &gt; On secondary:<br>
 &gt; &gt;<br> &gt; &gt; [root@vm6 ~]# cat /proc/drbd<br> &gt; &gt; version: 8.2.6 (api:88/proto:86-88)<br> &gt; &gt; GIT-hash: 3e69822d3bb4920a8c1bfdf7d647169eba7d2eb4 build by<br> &gt; &gt; buildsvn@c5-i386-build, 2008-06-26 16:40:17<br>
 &gt; &gt;&nbsp;&nbsp;0: cs:WFBitMapT st:Secondary/Primary ds:Negotiating/UpToDate C r---<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; ns:0 nr:0 dw:0 dr:0 al:106 bm:93 lo:0 pe:0 ua:0 ap:0 oos:95888<br> &gt; &gt;<br> &gt; &gt; /var/log/messages looks like:<br>
 &gt; &gt;<br> &gt; &gt; On primary:<br> &gt; &gt;<br> &gt; &gt; Jun 30 13:30:08 vm5 kernel: drbd0: peer( Secondary -&gt; Unknown ) conn( Connected<br> &gt; &gt; -&gt; TearDown ) pdsk( UpToDate -&gt; DUnknown )<br> &gt;<br>
 &gt; &gt; On secondary:<br> &gt; &gt;<br> &gt; &gt; Jun 30 13:28:46 vm6 kernel: drbd0: peer( Primary -&gt; Unknown ) conn( Connected<br> &gt; &gt; -&gt; NetworkFailure ) pdsk( UpToDate -&gt; DUnknown )<br> &gt;<br> &gt; since you can &quot;easily&quot; reproduce this,<br>
 &gt; please get the time in sync on those boxes (ntp),<br> &gt; makes it much easier to read logs.<br> &gt;<br> &gt; then post new logs.<br> <br> <br>but.<br> <br><br> &gt; Jun 30 13:28:46 vm6 kernel: drbd0: receiver (re)started<br>
 &gt; Jun 30 13:28:46 vm6 kernel: drbd0: conn( Unconnected -&gt; WFConnection )<br> &gt; Jun 30 13:28:46 vm6 kernel: drbd0: disk( UpToDate -&gt; Diskless )<br> &gt; Jun 30 13:28:46 vm6 kernel: drbd0: Handshake successful: Agreed network protocol version 88<br>
 &gt; Jun 30 13:28:46 vm6 kernel: drbd0: conn( WFConnection -&gt; WFReportParams )<br> &gt; Jun 30 13:28:46 vm6 kernel: drbd0: Starting asender thread (from drbd0_receiver [9457])<br> &gt; Jun 30 13:28:46 vm6 kernel: drbd0: data-integrity-alg: &lt;not-used&gt;<br>
 &gt; Jun 30 13:28:46 vm6 kernel: drbd0: peer( Unknown -&gt; Primary ) conn( WFReportParams -&gt; Connected ) pdsk( DUnknown -&gt; UpToDate )<br> <br> <br>hm. going Connected while still &quot;Diskless&quot;...<br> <br><br>
 &gt; Jun 30 13:28:55 vm6 kernel: drbd0: disk( Diskless -&gt; Attaching )<br> <br> <br>then attaching the disk,<br> <br><br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: Found 4 transactions (145 active extents) in activity log.<br>
 &gt; Jun 30 13:28:55 vm6 kernel: drbd0: max_segment_size ( = BIO size ) = 32768<br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: reading of bitmap took 1 jiffies<br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: recounting of set bits took additional 0 jiffies<br>
 &gt; Jun 30 13:28:55 vm6 kernel: drbd0: 0 KB (0 bits) marked out-of-sync by on disk bit-map.<br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: disk( Attaching -&gt; Negotiating )<br> <br> <br>going &quot;Negotiating&quot;<br> <br>
<br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: Writing meta data super block now.<br> <br> <br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: unexpected cstate (Connected) in receive_bitmap<br> <br> <br>right there.<br> <br><br> &gt; Jun 30 13:28:55 vm6 kernel: drbd0: conn( Connected -&gt; WFBitMapT )<br>
 <br> <br>according to this, it likely is a race between attaching the disk and<br> establishing the connection.&nbsp;&nbsp;we had similar races before, the were<br> believed to be fixed :(<br> <br> do you mind retrying with the latest git checkout?<br>
 <br> can you please post your excerciser script?<br> which drbdadm / drbdsetup commands get executed in which order?<br> <br><br> <br> --<br> : Lars Ellenberg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tel +43-1-8178292-55 :<br> : LINBIT Information Technologies GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax +43-1-8178292-82 :<br>
 : Vivenotgasse 48, A-1120 Vienna/Europe&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.linbit.com">http://www.linbit.com</a> :<br> _______________________________________________<br> drbd-dev mailing list<br> <a href="mailto:drbd-dev@lists.linbit.com">drbd-dev@lists.linbit.com</a><br>
 <a href="http://lists.linbit.com/mailman/listinfo/drbd-dev">http://lists.linbit.com/mailman/listinfo/drbd-dev</a><br> </blockquote></div><br>

------=_Part_2453_27799689.1214922505463--

------=_Part_2452_29176892.1214922505463
Content-Type: application/octet-stream; name=test_drbd.pl
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fi4l9xdv
Content-Disposition: attachment; filename=test_drbd.pl

IyEvdXNyL2Jpbi9wZXJsCiMKIyBUZXN0IExWTSBEUkJEIGNvbmZpZ3VyYXRpb24gZm9yIHVzZSBp
biB0aGUgUGFyYXNjYWxlIGNsb3VkCiMKCnVzZSBHZXRvcHQ6Okxvbmc7CnVzZSBQU0NTVEFGOwoK
c3ViIHVzYWdlIHsKCXByaW50IFNUREVSUiAidXNhZ2UgJHswfSA8Y29uZl9maWxlPlxuIjsKfQoK
bXkgJG5vZGUxID0gInZtNS5qbSI7Cm15ICRub2RlMiA9ICJ2bTYuam0iOwpteSAkZHJiZF9kZXYg
PSAiL2Rldi9kcmJkMCI7Cm15ICRkcmJkX3ZnID0gInNtLXZnIjsKbXkgJGRyYmRfdm9sID0gInNt
LXZvbCI7Cm15ICRkaXRzX25hbWUgPSAiJHtkcmJkX3ZvbH0iOwpteSAkZHJiZF9uYW1lID0gInNt
LXZvbCI7Cm15ICRsb29wcyA9IDE7Cm15ICRkaXRzX2xvb3BzID0gMTAwOwoKR2V0T3B0aW9ucygJ
J2xvb3BzPWknID0+IFwkbG9vcHMsCgkJJ3ZnPWknID0+IFwkZHJiZF92ZywKCQkndm9sPWknID0+
IFwkZHJiZF92b2wKCSk7CgojIEdldCBjb25maWcgZmlsZQpteSAkY29uZmlnID0gc2hpZnQ7Cmlm
ICghZGVmaW5lZCAkY29uZmlnKSB7Cgl1c2FnZSgpOwoJZXhpdCAxOwp9CmlmICghIC1mICRjb25m
aWcpIHsKCXByaW50IFNUREVSUiAiY29uZmlndXJhdGlvbiBmaWxlICcke2NvbmZpZ30nIGRvZXMg
bm90IGV4aXN0XG4iOwoJdXNhZ2UoKTsKCWV4aXQgMTsKfQoKIyBsb2FkIHRoZSBjb25maWcgZmls
ZQpyZXF1aXJlICR7Y29uZmlnfTsKCm15ICRkaXRzX2RpciA9IHNoaWZ0OwppZiAoIWRlZmluZWQg
JGRpdHNfZGlyKSB7Cgl1c2FnZSgpOwoJZXhpdCAxOwp9CgojaWYgKCEgLWQgJGRpdHMtZGlyKSB7
CiMJcHJpbnQgU1RERVJSICInJHtkaXRzX2Rpcn0nIGlzIG5vdCBhIGRpcmVjdG9yeVxuIjsKIwll
eGl0IDE7CiN9CgppZiAoISAtZiAiJHtkaXRzX2Rpcn0vc3JjL2RpdHMuYyIpIHsKCXByaW50IFNU
REVSUiAiJyR7ZGl0c19kaXJ9IGRvZXMgbm90IGNvbnRhaW4gZGl0cy5jXG4iOwoJZXhpdCAxOwp9
CgpteSAkbWdyID0gUFNDU1RBRjo6TWFuYWdlci0+bmV3KCIvTGFuZy9QZXJsL3BzYy92bXdhcmUi
KTsKaWYgKCFkZWZpbmVkICRtZ3IpIHsKCXByaW50IFNUREVSUiAiRXJyb3I6ICR7UFNDU1RBRjo6
ZXJyc3RyfVxuIjsKCWV4aXQgMjsKfQoKaWYgKCFkZWZpbmVkICRzbmxpc3QpIHsKCXByaW50IFNU
REVSUiAibm8gc25saXN0IGRlZmluZWQuIGV4aXRpbmdcbiI7CglleGl0IDI7Cn0KCmlmIChAeyRz
bmxpc3R9IDwgMikgewoJcHJpbnQgU1RERVJSICJub3QgZW5vdWdoIGVudHJpZXMgaW4gc25saXN0
IG5lZWQgMlxuIjsKCWV4aXQgMjsKfQoKIyA9PT0gQ29uZmlnIHN0ZXBzOgojIFJvbGwgYmFjayAk
bm9kZTEgYW5kICRub2RlMiB1c2luZyBWTSBBUEkncwojIGluc3RhbGwgJ2ttb2QtZHJiZDgyJyBv
biAkbm9kZTEgYW5kICRub2RlMgojIGNvbmZpZ3VyZSBMVk0gVkcncyBhbmQgVm9sdW1lIG9uIGJv
dGggbm9kZXMgKHRoaXMgaXMgbmV3IHByb2R1Y3QgQ04gc2NyaXB0KQojIGNvbmZpZ3VyZSBEUkJE
IG9uIGJvdGggbm9kZXMgICh0aGlzIGlzIGlzIGEgbmV3IHByb2R1Y3QgQ04gc2NyaXB0KQojIHBp
Y2sgYSBwcmltYXJ5IGFuZCBzeW5jIGl0CgojIHRlc3RzCiMgMS4gUnVuIGRpdHMgb24gcHJpbWFy
eS4gV2hlbiBmaW5pc2hlZCwgY3JlYXRlIGFuIHNuYXBzaG90IG9uIHNlY29uZGFyeSBhbmQKIyAg
ICB2ZXJpZnkgY29udGVudHMuIERlbGV0ZSB0aGUgc25hcHNob3QuCiMgMi4gU3RvcCBEUkJEIG9u
IHNlY29uZGFyeS4gUnVuIGRpdHMgb24gcHJpbWFyeS4gV2hlbiBmaW5pc2hlZCwgcmUtc3RhcnQK
IyAgICBEUkJEIG9uIHNlY29uZGFyeSBhbmQgd2FpdCBmb3IgcmVzeW5jLiBWZXJpZnkgY29udGVu
dHMuCgoKbXkgJHJkaXRzX2RpciA9ICIvdmFyL3RtcC9kaXRzX3NyYyI7CgpteSAkcmMgPSBpbnN0
YWxsX2RpdHMoJGRpdHNfZGlyLCAkcmRpdHNfZGlyLCAkbm9kZTEsICRub2RlMik7CmlmICghJHJj
KSB7CglwcmludCBTVERFUlIgIkVycm9yOiBpbnN0YWxsX2RpdHMgRmFpbGVkXG4iOwoJZXhpdCAx
Owp9CgoKIyBpbml0aWFsaXplX2RpdHMoJHJlbW90ZWRpciwgJG5vZGUsICRkcmJkX2RldiwgJHNp
emUpCm15ICRyYyA9IGluaXRpYWxpemVfZGl0cygiJHJkaXRzX2Rpci9zcmMiLCAkZHJiZF92b2ws
ICRub2RlMSwgJGRyYmRfZGV2LCAxMDAwMDAwKTsKaWYgKCEkcmMpIHsKCXByaW50IFNUREVSUiAi
RXJyb3I6IGluaXRpYWxpemVfZGl0cyBGYWlsZWRcbiI7CglleGl0IDE7Cn0KCiMgdmVyaWZ5X2Rp
dHMoJHJlbW90ZV9kaXIsICRuYW1lLCAkcG5vZGUsICRwZGV2LCAkcm5vZGUsICRydmcsICRydm9s
KQpteSAkcmMgPSB2ZXJpZnlfZGl0cygiJHJkaXRzX2Rpci9zcmMiLCAkZHJiZF92b2wsICRub2Rl
MSwgJGRyYmRfZGV2LCAkbm9kZTIsICRkcmJkX3ZnLCAkZHJiZF92b2wpOwppZiAoISRyYykgewoJ
cHJpbnQgU1RERVJSICJFcnJvcjogdmVyaWZ5X2RpdHMgRmFpbGVkXG4iOwoJZXhpdCAxOwp9Cgpw
cmludCAiKioqKioqICR7bG9vcHN9IGxvb3BzIHRocm91Z2ggdGVzdHMgLSBjb3VudGRvd25cbiI7
Cgp3aGlsZSAoJGxvb3BzID4gMCkgewoJCglwcmludCAiXG4qKioqIFN0YXJ0IExvb3A6ICR7bG9v
cHN9IHJlbWFpbmluZ1xuXG4iOwoKCWlmICghdGVzdF9iYXNpYygpKSB7CgkJcHJpbnQgU1RERVJS
ICJFcnJvcjogRmFpbGVkIENvcmUgcmVwbGljYXRpb25cbiI7CgkJZXhpdCAxOwoJfQoKCWlmICgh
dGVzdF9zaHV0ZG93bl9zZWNvbmRhcnkoKSkgewoJCXByaW50IFNUREVSUiAiRXJyb3I6IEZhaWxl
ZCBTZWNvbmRhcnkgdXAvZG93blxuIjsKCQlleGl0IDE7Cgl9CgoJaWYgKCF0ZXN0X3NodXRkb3du
X3ByaW1hcnkoKSkgewoJCXByaW50IFNUREVSUiAiRXJyb3I6IEZhaWxlZCBGYWlsb3Zlci9GYWls
YmFja1xuIjsKCQlleGl0IDE7Cgl9CgoJJGxvb3BzLS07Cn0KCmV4aXQgMDsKCnN1YiB0ZXN0X2Jh
c2ljIHsKCXByaW50ICI9PT09PSBCYXNpYyBSZXBsaWNhdGlvbiBUZXN0XG4iOwoJIyBydW5fZGl0
cygkcmVtb3RlZGlyLCAkbmFtZSwgJG5vZGUsICRkcmJkX2RldikKCW15ICRyYyA9IHJ1bl9kaXRz
KCIkcmRpdHNfZGlyL3NyYyIsICRkcmJkX3ZvbCwgJG5vZGUxLCAkZHJiZF9kZXYsIAoJCQkJJGRp
dHNfbG9vcHMpOwoJaWYgKCEkcmMpIHsKCQlwcmludCBTVERFUlIgIkVycm9yOiBydW5fZGl0cyBG
YWlsZWRcbiI7CgkJcmV0dXJuIHVuZGVmOwoJfQoJbXkgJHJjID0gdmVyaWZ5X2RpdHMoIiRyZGl0
c19kaXIvc3JjIiwgJGRyYmRfdm9sLCAkbm9kZTEsICRkcmJkX2RldiwgCgkJCQkkbm9kZTIsICRk
cmJkX3ZnLCAkZHJiZF92b2wpOwoJaWYgKCEkcmMpIHsKCQlwcmludCBTVERFUlIgIkVycm9yOiB2
ZXJpZnlfZGl0cyBGYWlsZWRcbiI7CgkJcmV0dXJuIHVuZGVmOwoJfQoJcmV0dXJuIDE7Cn0KCnN1
YiB0ZXN0X3NodXRkb3duX3NlY29uZGFyeSB7CgkjIFRlc3QgY2FzZSAyIC0gRW5zdXJlIHRoYXQg
YSBkb3duIHNlY29uZGFyeSByZWNvdmVycwoJbXkgJHJjID0gZHJiZF9kb3duKCRub2RlMik7Cglp
ZiAoISRyYykgewoJCXByaW50IFNUREVSUiAiRXJyb3I6IGRyYmRfZG93biBGYWlsZWRcbiI7CgkJ
cmV0dXJuIHVuZGVmOwoJfQoKCSMgcnVuX2RpdHMoJHJlbW90ZWRpciwgJG5hbWUsICRub2RlLCAk
ZHJiZF9kZXYpCglteSAkcmMgPSBydW5fZGl0cygiJHJkaXRzX2Rpci9zcmMiLCAkZHJiZF92b2ws
ICRub2RlMSwgJGRyYmRfZGV2LAoJCQkJJGRpdHNfbG9vcHMpOwoJaWYgKCEkcmMpIHsKCQlwcmlu
dCBTVERFUlIgIkVycm9yOiB2ZXJpZnlfZGl0cyBGYWlsZWRcbiI7CgkJcmV0dXJuIHVuZGVmOwoJ
fQoKCSMgRFJCRCBVcAoJbXkgJHJjID0gZHJiZF91cCgkbm9kZTIpOwoJaWYgKCEkcmMpIHsKCQlw
cmludCBTVERFUlIgImRyYmRfdXAoJHtub2RlMn0pIGZhaWxlZFxuIjsKCQlyZXR1cm4gdW5kZWY7
Cgl9CgoJbXkgJHJjID0gZHJiZF93YWl0X3Jlc3luYygkbm9kZTIsICRkcmJkX25hbWUpOwoJaWYg
KCEkcmMpIHsKCQlwcmludCBTVERFUlIgImRyYmRfd2FpdF9yZXN5bmMoJHtub2RlMn0pIGZhaWxl
ZFxuIjsKCQlyZXR1cm4gdW5kZWY7Cgl9CgoJbXkgJHJjID0gdmVyaWZ5X2RpdHMoIiRyZGl0c19k
aXIvc3JjIiwgJGRyYmRfdm9sLCAkbm9kZTEsICRkcmJkX2RldiwgCgkJJG5vZGUyLCAkZHJiZF92
ZywgJGRyYmRfdm9sKTsKCWlmICghJHJjKSB7CgkJcHJpbnQgU1RERVJSICJFcnJvcjogdmVyaWZ5
X2RpdHMgRmFpbGVkXG4iOwoJCXJldHVybiB1bmRlZjsKCX0KCXJldHVybiAxOwp9CgpzdWIgdGVz
dF9zaHV0ZG93bl9wcmltYXJ5IHsKCglteSAkcmM7CgoJJHJjID0gZHJiZF9kb3duKCRub2RlMSk7
CglpZiAoISRyYykgewoJCXJldHVybiB1bmRlZjsKCX0KCgkkcmMgPSBkcmJkX21ha2VfcHJpbWFy
eSgkbm9kZTIpOwoJaWYgKCEkcmMpIHsKCQlyZXR1cm4gdW5kZWY7Cgl9CgkjIHJ1bl9kaXRzKCRy
ZW1vdGVkaXIsICRuYW1lLCAkbm9kZSwgJGRyYmRfZGV2KQoJbXkgJHJjID0gcnVuX2RpdHMoIiRy
ZGl0c19kaXIvc3JjIiwgJGRyYmRfdm9sLCAkbm9kZTIsICRkcmJkX2RldiwKCQkJCSRkaXRzX2xv
b3BzKTsKCWlmICghJHJjKSB7CgkJcmV0dXJuIHVuZGVmOwoJfQoJIyBEUkJEIFVwCglteSAkcmMg
PSBkcmJkX3VwKCRub2RlMSk7CglpZiAoISRyYykgewoJCXJldHVybiB1bmRlZjsKCX0KCglteSAk
cmMgPSBkcmJkX3dhaXRfcmVzeW5jKCRub2RlMSwgJGRyYmRfbmFtZSk7CglpZiAoISRyYykgewoJ
CXJldHVybiB1bmRlZjsKCX0KCglteSAkcmMgPSB2ZXJpZnlfZGl0cygiJHJkaXRzX2Rpci9zcmMi
LCAkZHJiZF92b2wsICRub2RlMiwgJGRyYmRfZGV2LCAKCQkkbm9kZTEsICRkcmJkX3ZnLCAkZHJi
ZF92b2wpOwoJaWYgKCEkcmMpIHsKCQlyZXR1cm4gdW5kZWY7Cgl9CgoJJHJjID0gZHJiZF9tYWtl
X3NlY29uZGFyeSgkbm9kZTIpOwoJaWYgKCEkcmMpIHsKCQlyZXR1cm4gdW5kZWY7Cgl9CgoJJHJj
ID0gZHJiZF9tYWtlX3ByaW1hcnkoJG5vZGUxKTsKCWlmICghJHJjKSB7CgkJcmV0dXJuIHVuZGVm
OwoJfQoKCXJldHVybiAxOwp9CgpzdWIgbG9nX3Byb2NfbGlzdGVuZXIgewoJbXkgJGwgPSBzaGlm
dDsKCglwcmludCAiLS0tIFJlbW90ZSBQcm9jZXNzIENvbXBsZXRlIC0tLVxuIjsKCXByaW50ICJu
b2RlOiAgICIgLiAkbC0+bm9kZSAuICJcbiI7CglwcmludCAiZGlyOiAgICAiIC4gJGwtPmRpciAu
ICJcbiI7CglwcmludCAiY21kOiAgICAiIC4gJGwtPmNtZGxpbmUgLiAiXG4iOwoJcHJpbnQgInJj
OiAgICAgIiAuICRsLT5yYyAuICJcbiI7CglwcmludCAib3V0cHV0OlxuIjsKCWZvcmVhY2ggbXkg
JGxpbmUgKHNwbGl0IC9cbi8sICRsLT5zdGRvdXQpIHsKCQlwcmludCAiXHQke2xpbmV9XG4iOwoJ
fQp9CgpzdWIgbG9nX2ZzX2xpc3RlbmVyIHsKCW15ICRsID0gc2hpZnQ7CgoJcHJpbnQgIi0tLSBG
aWxlIFN5c3RlbSBPcGVyYXRpb24gQ29tcGxldGUgLS0tXG4iOwoJcHJpbnQgIm5vZGU6ICIgLiAk
bC0+bm9kZSAuICJcbiI7CglwcmludCAiY21kOiAgIiAuICRsLT5jbWRsaW5lIC4gIlxuIjsKCXBy
aW50ICJyYzogICAiIC4gICRsLT5yYyAuICJcbiI7Cn0KCiMgZHJiZF9tYWtlX3ByaW1hcnkoJG5v
ZGUpCnN1YiBkcmJkX21ha2VfcHJpbWFyeSB7CglteSAkbm9kZSA9IHNoaWZ0OwoKCXByaW50ICI9
PT0gTWFrZSAke25vZGV9IHNlY29uZGFyeVxuIjsKCW15ICRsID0gJG1nci0+c3RhcnRfcHJvY2Vz
cygkbm9kZSwgIi8iLCAiZHJiZGFkbSIsCgkJCQkJInByaW1hcnkgJHtkcmJkX25hbWV9Iik7Cgkk
bWdyLT53YWl0X2FsbCgpOwoJbG9nX3Byb2NfbGlzdGVuZXIoJGwpOwoJaWYgKCRsLT5yYykgewoJ
CXJldHVybiB1bmRlZjsKCX0KCXJldHVybiAxOwp9CgojIGRyYmRfbWFrZV9zZWNvbmRhcnkoJG5v
ZGUpCnN1YiBkcmJkX21ha2Vfc2Vjb25kYXJ5IHsKCW15ICRub2RlID0gc2hpZnQ7CgoJcHJpbnQg
Ij09PSBNYWtlICR7bm9kZX0gc2Vjb25kYXJ5XG4iOwoJbXkgJGwgPSAkbWdyLT5zdGFydF9wcm9j
ZXNzKCRub2RlLCAiLyIsICJkcmJkYWRtIiwKCQkJCQkic2Vjb25kYXJ5ICR7ZHJiZF9uYW1lfSIp
OwoJJG1nci0+d2FpdF9hbGwoKTsKCWxvZ19wcm9jX2xpc3RlbmVyKCRsKTsKCWlmICgkbC0+cmMp
IHsKCQlyZXR1cm4gdW5kZWY7Cgl9CglyZXR1cm4gMTsKfQoKIyBkcmJkX3dhaXRfcmVzeW5jKCRu
b2RlLCAkZHJiZF9uYW1lKQpzdWIgZHJiZF93YWl0X3Jlc3luYyB7CglteSAkbm9kZSA9IHNoaWZ0
OwoJbXkgJGRyYmRfbmFtZSA9IHNoaWZ0OwoKCXByaW50ICI9PT0gV2FpdCBmb3IgRFJEQiBzeW5j
OiBub2RlOiAke25vZGV9IGRldjoke2RyYmRfbmFtZX1cbiI7CgkjIHdhaXQgZm9yIERSQkQgdG8g
cmVzeW5jCglteSAkcmVzeW5jID0gMTsKCXdoaWxlICgkcmVzeW5jKSB7CgkJc2xlZXAgNTsKCQlt
eSAkbCA9ICRtZ3ItPnN0YXJ0X3Byb2Nlc3MoJG5vZGUsICIvIiwgImRyYmRhZG0iLCAKCQkJCQki
ZHN0YXRlICR7ZHJiZF9uYW1lfSIpOwoJCSRtZ3ItPndhaXRfYWxsKCk7CgkJbG9nX3Byb2NfbGlz
dGVuZXIoJGwpOwoJCWlmICgkbC0+cmMpIHsKCQkJcHJpbnQgImRpdHMgY2hlY2sgRFJCRCBzdGF0
dXMgZmFpbGVkIG9uIG5vZGUgIiAuICRsLT5ub2RlIC4gCgkJCQkiIHJjOiIgLiAkbC0+cmMgLiAi
XG4iOwoJCQlwcmludCAkbC0+c3Rkb3V0OwoJCQlyZXR1cm4gdW5kZWY7CgkJfQoJCW15ICRzbyA9
ICRsLT5zdGRvdXQ7CgkJY2hvbXAgJHNvOwoJCWlmICgkc28gZXEgIlVwVG9EYXRlL1VwVG9EYXRl
IikgewoJCQkkcmVzeW5jID0gMDsKCQl9CgkJaWYgKCRzbyBlcSAiTmVnb3RpYXRpbmcvVXBUb0Rh
dGUiKSB7CgkJCXByaW50IFNUREVSUiAiV2UgZGlkbid0IGNvbWUgYmFja1xuIjsKCQkJcmV0dXJu
IHVuZGVmOwoJCX0KCQlpZiAoJHNvIGVxICJVcFRvRGF0ZS9OZWdvdGlhdGluZyIpIHsKCQkJcHJp
bnQgU1RERVJSICJXZSBkaWRuJ3QgY29tZSBiYWNrXG4iOwoJCQlyZXR1cm4gdW5kZWY7CgkJfQoJ
fQoJcmV0dXJuIDE7Cn0KCiMgZHJiZF9kb3duKCRub2RlKQpzdWIgZHJiZF9kb3duIHsKCW15ICRu
b2RlID0gc2hpZnQ7CgoJcHJpbnQgIj09PSBTdG9wIERSQkQgb24gJHtub2RlfVxuIjsKCW15ICRs
ID0gJG1nci0+c3RhcnRfcHJvY2Vzcygkbm9kZSwgIi8iLCAic2VydmljZSIsICJkcmJkIHN0b3Ai
KTsKCSRtZ3ItPndhaXRfYWxsKCk7Cglsb2dfcHJvY19saXN0ZW5lcigkbCk7CglpZiAoJGwtPnJj
KSB7CgkJcmV0dXJuIHVuZGVmOwoJfQoJcmV0dXJuIDE7Cgp9CgojIGRyYmRfdXAoJG5vZGUpCnN1
YiBkcmJkX3VwIHsKCW15ICRub2RlID0gc2hpZnQ7CgoJcHJpbnQgIj09PSBTdGFydCBEUkJEIG9u
ICR7bm9kZX1cbiI7CglteSAkbCA9ICRtZ3ItPnN0YXJ0X3Byb2Nlc3MoJG5vZGUsICIvIiwgInNl
cnZpY2UiLCAiZHJiZCBzdGFydCIpOwoJJG1nci0+d2FpdF9hbGwoKTsKCWxvZ19wcm9jX2xpc3Rl
bmVyKCRsKTsKCWlmICgkbC0+cmMpIHsKCQlyZXR1cm4gdW5kZWY7Cgl9CglyZXR1cm4gMTsKfQoK
IyB2ZXJpZnlfZGl0cygkcmVtb3RlX2RpciwgJG5hbWUsICRwbm9kZSwgJHBkZXYsICRybm9kZSwg
JHJ2ZywgJHJ2b2wpCnN1YiB2ZXJpZnlfZGl0cyB7CglteSAkZGlyID0gc2hpZnQ7CglteSAkbmFt
ZSA9IHNoaWZ0OwoJbXkgJHBub2RlID0gc2hpZnQ7CglteSAkcGRldiA9IHNoaWZ0OwoJbXkgJHJu
b2RlID0gc2hpZnQ7CglteSAkcnZnID0gc2hpZnQ7CglteSAkcnZvbCA9IHNoaWZ0OwoKCglwcmlu
dCAiPT09IFZlcmlmeSBkaXRzIHdvcmthcmVhOiBub2RlczogJHtwbm9kZX0gJHtybm9kZX1cbiI7
CglpZiAoZGVmaW5lZCAkcm5vZGUpIHsKCQkjIGNvcHkgZGl0cyByZXN1bHRzIHRvIHNlY29uZGFy
eQoJCXByaW50ICJcbj09PSBjb3B5IGRpdHMgc3RhdGUgdG8gc2Vjb25kYXJ5XG4iOwoJCW15ICRk
aXRzX3N0YXRlID0gIi92YXIvdG1wL2RpdHMtcnRjay0ke25hbWV9IjsKCQlteSAkbCA9ICRtZ3It
PnN0YXJ0X2NvcHlfZmlsZSgkcG5vZGUsICRkaXRzX3N0YXRlLCAkcm5vZGUsICRkaXRzX3N0YXRl
KTsKCQkkbWdyLT53YWl0X2FsbCgpOwoJCWxvZ19mc19saXN0ZW5lcigkbCk7CgkJaWYgKCRsLT5y
YykgewoJCQlyZXR1cm4gdW5kZWY7CgkJfQoKCQkjIENyZWF0ZSBzbmFwc2hvdCBvbiBzZWNvbmRh
cnkKCQlwcmludCAiXG49PT0gY3JlYXRlIHNuYXBzaG90IG9uIHNlY29uZGFyeVxuIjsKCQlteSAk
bCA9ICRtZ3ItPnN0YXJ0X3Byb2Nlc3MoJHJub2RlLCAiLyIsICJsdmNyZWF0ZSIsCgkJCQkJCSIt
cyAtTDIwTSAtbiAke3J2b2x9LXNuYXAgIiAuCgkJCQkJCSIvZGV2LyR7cnZnfS8ke3J2b2x9Iik7
CgkJJG1nci0+d2FpdF9hbGwoKTsKCQlsb2dfcHJvY19saXN0ZW5lcigkbCk7CgkJaWYgKCRsLT5y
YykgewoJCQlyZXR1cm4gdW5kZWY7CgkJfQoJfQoKCSMgVGhlIGRpdHMgY2hlY2sgY2FuIHRha2Ug
YSB3aGlsZSwgc28gZG8gdGhlbSBpbiBwYXJhbGxlbC4KCXByaW50ICJcbj09PSBWZXJpZnkgZGF0
YVxuIjsKCW15ICRsbGlzdCA9IFtdOwoJaWYgKGRlZmluZWQgJHJub2RlKSB7CgkJIyBDaGVjayBk
cmJkIHNuYXBzaG90IG9uIHNlY29uZGFyeQoJCW15ICRsID0gJG1nci0+c3RhcnRfcHJvY2Vzcygk
cm5vZGUsICIke3JkaXRzX2Rpcn0vc3JjIiwgCgkJCQkJCSIuL2RpdHMiLAoJCQkJCQkiLU4gJHtu
YW1lfSAtY3YiIC4KCQkJCQkJIiAvZGV2LyR7cnZnfS8ke3J2b2x9LXNuYXAiKTsKCQlwdXNoKEB7
JGxsaXN0fSwgJGwpOwoJfQoKCWlmICgkcG5vZGUgbmUgIiIpIHsKCQkjIENoZWNrIGRyYmQgZGV2
aWNlIG9uIHByaW1hcnkKCQlteSAkbCA9ICRtZ3ItPnN0YXJ0X3Byb2Nlc3MoJHBub2RlLCAiJHtk
aXJ9IiwgIi4vZGl0cyIsCgkJCQkJCSItTiAke25hbWV9IC1jdiAke3BkZXZ9Iik7CgkJcHVzaChA
eyRsbGlzdH0sICRsKTsKCX0KCgkkbWdyLT53YWl0X2FsbCgpOwoKCW15ICRlcnJvcnMgPSAwOwoJ
Zm9yZWFjaCBteSAkbCAoQHskbGxpc3R9KSB7CgkJbG9nX3Byb2NfbGlzdGVuZXIoJGwpOwoJCWlm
ICgkbC0+cmMpIHsKCQkJJGVycm9ycysrOwoJCX0KCX0KCWlmICgkZXJyb3JzKSB7CgkJcmV0dXJu
IHVuZGVmOwoJfQoKCSMgSWYgd2UgcmFuIG9uIHJlbW90ZSwgY2xlYW4gdXAgc25hcHNob3QKCWlm
IChkZWZpbmVkICRybm9kZSkgewoJCSMgUmVtb3ZlIHNuYXBzaG90IG9uIHNlY29uZGFyeQoJCXBy
aW50ICJcbj09PSByZW1vdmUgc25hcHNob3Qgb24gc2Vjb25kYXJ5XG4iOwoJCW15ICRsID0gJG1n
ci0+c3RhcnRfcHJvY2Vzcygkcm5vZGUsICIvIiwgImx2cmVtb3ZlIiwKCQkJCQkJIi1mIC9kZXYv
JHtydmd9LyR7cnZvbH0tc25hcCIpOwoJCSRtZ3ItPndhaXRfYWxsKCk7CgkJbG9nX3Byb2NfbGlz
dGVuZXIoJGwpOwoJCWlmICgkbC0+cmMpIHsKCQkJcmV0dXJuIHVuZGVmOwoJCX0KCX0KCXJldHVy
biAxOwp9CgojIHJ1bl9kaXRzKCRyZW1vdGVkaXIsICRuYW1lLCAkbm9kZSwgJGRyYmRfZGV2LCAk
ZGl0c19sb29wcykKc3ViIHJ1bl9kaXRzIHsKCW15ICRkaXIgPSBzaGlmdDsKCW15ICRkaXRzX25h
bWUgPSBzaGlmdDsKCW15ICRub2RlID0gc2hpZnQ7CglteSAkZHJiZF9kZXYgPSBzaGlmdDsKCW15
ICRkaXRzX2xvb3BzID0gc2hpZnQ7CgoJIyB3cml0ZSBvbiBkaXRzIGZpbGUKCXByaW50ICJcbj09
PSBydW4gJ2RpdHMgLXR2IC1JJHtkaXRzX2xvb3BzfSAkZHJiZF9kZXZ9JyBvbiAke25vZGV9XG4i
OwoJbXkgJGwgPSAkbWdyLT5zdGFydF9wcm9jZXNzKCRub2RlLCAiJHtkaXJ9IiwgIi4vZGl0cyIs
ICItdHYiIC4KCQkJCQkiIC1OICR7ZGl0c19uYW1lfSAtSSR7ZGl0c19sb29wc30iIC4KCQkJCQki
ICR7ZHJiZF9kZXZ9Iik7CgkkbWdyLT53YWl0X2FsbCgpOwoJbG9nX3Byb2NfbGlzdGVuZXIoJGwp
OwoJaWYgKCRsLT5yYykgewoJCXJldHVybiB1bmRlZjsKCX0KCglyZXR1cm4gMTsKfQoKIyBpbml0
aWFsaXplX2RpdHMoJHJlbW90ZWRpciwgJG5hbWUsICRub2RlLCAkZHJiZF9kZXYsICRzaXplKQpz
dWIgaW5pdGlhbGl6ZV9kaXRzIHsKCW15ICRkaXIgPSBzaGlmdDsKCW15ICRuYW1lID0gc2hpZnQ7
CglteSAkbm9kZSA9IHNoaWZ0OwoJbXkgJGRyYmRfZGV2ID0gc2hpZnQ7CglteSAkc2l6ZSA9IHNo
aWZ0OwoKCXByaW50ICI9PT0gZGl0cyBpbml0OiBub2RlOiR7bm9kZX0gZGV2OiR7ZHJiZF9kZXZ9
IHNpemU6JHtzaXplfVxuIjsKCW15ICRsID0gJG1nci0+c3RhcnRfcHJvY2Vzcygkbm9kZSwgIiR7
ZGlyfSIsICIuL2RpdHMiLAoJCQkJCSItTiAke25hbWV9IC1pdiAke2RyYmRfZGV2fSAke3NpemV9
Iik7CgkkbWdyLT53YWl0X2FsbCgpOwoJbG9nX3Byb2NfbGlzdGVuZXIoJGwpOwoJaWYgKCRsLT5y
YykgewoJCXJldHVybiB1bmRlZjsKCX0KCXJldHVybiAxOwp9CgojIGluc3RhbGxfZGl0cygkbG9j
YWxkaXIsICRyZW1vdGVkaXIsICRub2RlIC4uLikKc3ViIGluc3RhbGxfZGl0cyB7CglteSAkZGl0
c19kaXIgPSBzaGlmdDsKCW15ICRyZGl0c19kaXIgPSBzaGlmdDsKCgkjIHJlbW92ZSBvbGQgZGl0
cyBkaXJlY3RvcnkKCXByaW50ICJcbj09PSBSZW1vdmUgb2xkIGRpdHMgc291cmNlIChpZiBpdCBl
eGlzdHMpXG4iOwoJbXkgJGxsaXN0ID0gW107Cglmb3JlYWNoIG15ICRuIChAXykgewoJCW15ICRs
ID0gJG1nci0+c3RhcnRfcm1kaXIoJG4sICRyZGl0c19kaXIpOwoJCXB1c2goQHskbGxpc3R9LCAk
bCk7Cgl9CgkkbWdyLT53YWl0X2FsbCgpOwoJbXkgJGVycm9ycyA9IDA7Cglmb3JlYWNoIG15ICRs
IChAeyRsbGlzdH0pIHsKCQlsb2dfZnNfbGlzdGVuZXIoJGwpOwoJCWlmICgkbC0+cmMgJiYgJGwt
PnJjICE9IDQ4KSB7CgkJCSRlcnJvcnMrKzsKCQl9Cgl9CglpZiAoJGVycm9ycykgewoJCXJldHVy
biB1bmRlZjsKCX0KCgkjIGNvcHkgb3ZlciBuZXcgZGl0cyBzb3VyY2UKCXByaW50ICJcbj09PSBD
b3B5IGRpdHMgc291cmNlIHRvIHJlbW90ZSBub2Rlc1xuIjsKCW15ICRsbGlzdCA9IFtdOwoJZm9y
ZWFjaCBteSAkbiAoQF8pIHsKCQlteSAkbCA9ICRtZ3ItPnN0YXJ0X2NwZGlyKCJsb2NhbCIsICRk
aXRzX2RpciwgJG4sICRyZGl0c19kaXIpOwoJCXB1c2goQHskbGxpc3R9LCAkbCk7Cgl9CgkkbWdy
LT53YWl0X2FsbCgpOwoJbXkgJGVycm9ycyA9IDA7Cglmb3JlYWNoIG15ICRsIChAeyRsbGlzdH0p
IHsKCQlsb2dfZnNfbGlzdGVuZXIoJGwpOwoJCWlmICgkbC0+cmMpIHsKCQkJJGVycm9ycysrOwoJ
CX0KCX0KCWlmICgkZXJyb3JzKSB7CgkJcmV0dXJuIHVuZGVmOwoJfQoKCXByaW50ICJcbj09PSBD
b25maWd1cmUgZGl0cyBidWlsZCB0byByZW1vdGUgbm9kZXNcbiI7CglteSAkbGxpc3QgPSBbXTsK
CWZvcmVhY2ggbXkgJG4gKEBfKSB7CgkJbXkgJGwgPSAkbWdyLT5zdGFydF9wcm9jZXNzKCRuLCAk
cmRpdHNfZGlyLCAiL2Jpbi9iYXNoIiwgIi4vY29uZmlndXJlIik7CgkJcHVzaChAeyRsbGlzdH0s
ICRsKTsKCX0KCSRtZ3ItPndhaXRfYWxsKCk7CglteSAkZXJyb3JzID0gMDsKCWZvcmVhY2ggbXkg
JGwgKEB7JGxsaXN0fSkgewoJCWxvZ19wcm9jX2xpc3RlbmVyKCRsKTsKCQlpZiAoJGwtPnJjKSB7
CgkJCSRlcnJvcnMrKzsKCQl9Cgl9CglpZiAoJGVycm9ycykgewoJCXJldHVybiB1bmRlZjsKCX0K
CglwcmludCAiXG49PT0gbWFrZSBkaXRzIGJ1aWxkIG9uIHJlbW90ZSBub2Rlc1xuIjsKCW15ICRs
bGlzdCA9IFtdOwoJZm9yZWFjaCBteSAkbiAoQF8pIHsKCQlteSAkbCA9ICRtZ3ItPnN0YXJ0X3By
b2Nlc3MoJG4sICRyZGl0c19kaXIsICJtYWtlIik7CgkJcHVzaChAeyRsbGlzdH0sICRsKTsKCX0K
CSRtZ3ItPndhaXRfYWxsKCk7CglteSAkZXJyb3JzID0gMDsKCWZvcmVhY2ggbXkgJGwgKEB7JGxs
aXN0fSkgewoJCWxvZ19wcm9jX2xpc3RlbmVyKCRsKTsKCQlpZiAoJGwtPnJjKSB7CgkJCSRlcnJv
cnMrKzsKCQl9Cgl9CglpZiAoJGVycm9ycykgewoJCXJldHVybiB1bmRlZjsKCX0KCXJldHVybiAx
Owp9Cg==
------=_Part_2452_29176892.1214922505463--
