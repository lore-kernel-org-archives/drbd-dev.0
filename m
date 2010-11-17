Return-Path: <rshriram@gmail.com>
Received: from mail-pv0-f182.google.com (mail-pv0-f182.google.com
	[74.125.83.182])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9E3A71058E82
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2010 23:49:50 +0100 (CET)
Received: by pvc22 with SMTP id 22so708348pvc.27
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2010 14:49:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101117202741.GE9868@barkeeper1-xen.linbit>
References: <AANLkTikZaR_GPaDO=zjq_DyWD0C5-_6DtBHjgbevGwUL@mail.gmail.com>
	<20101117202741.GE9868@barkeeper1-xen.linbit>
Date: Wed, 17 Nov 2010 14:44:38 -0800
Message-ID: <AANLkTikiypr0p8QOKtby=Eq2f1P549jsPomerD+itw=s@mail.gmail.com>
From: Shriram Rajagopalan <rshriram@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=000e0cd29a840df3b90495476b12
Subject: Re: [Drbd-dev] Protocol A,B & submit ee failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--000e0cd29a840df3b90495476b12
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2010 at 12:27 PM, Lars Ellenberg
<lars.ellenberg@linbit.com>wrote:

> On Wed, Nov 17, 2010 at 11:00:03AM -0800, Shriram Rajagopalan wrote:
> > [I apologize if this is a double post]
>
> It's not.
> drbd-dev just happens to be moderated somewhat ;-)
>
> > Hi all,
> > I have recently started hacking into drbd kernel code
>
> Just curious: Why?
> What are you up to?
>
> Well there is this 4th protocol I want to try.
Protocol A + defer writes @ backup until P_BARRIER
(ie buffer the writes in current epoch until an explicit P_BARRIER).

  currently receive_Barrier only blocks on active_ee list, waiting
for completion of pending IOs.
  I want to issue the deferred writes in receive_Barrier and then
fall through the rest of the code.

Consider an App that is moderately io intensive and it needs transactional
view of disk to survive failures. It "buffers" any network output until the
next P_BARRIER.
It issues a P_BARRIER every T "milliseconds" where T =3D 50ms/100ms..whatev=
er.

Since barrier ack implies that both disks are in sync, App @ primary will
send network output
only after receiving the barrier ACK.

Lets ignore the App side of fault tolerance and the network latency aspect
for the moment.
(and the argument that protocol C is almost as good as proto A). I chose
async replication
because this app demands so.

Failure:
On primary failure, secondary "discards" all writes buffered in the current
epoch
& activates secondary disk and spawns App. App @ secondary will always star=
t
with
last consistent sync point.
On secondary failure, primary just moves on.

IOW, always sync from current primary to the node that comes back online.

On resync (assuming primary failure),
 secondary copies all data (using quick-sync bitmap and activity log) since
failover
to primary. Any disk regions touched by by primary before crash
have to be overwritten with a copy from the secondary.

What I am concerned about is that the sudden influx of IOs at every
P_BARRIER, @ secondary
might choke the kernel and cause drbd_submit_ee to fail. If this failure
happens rarely, its ok but
if it occurs regularly, then I would have to control the rate at which the
deferred IOs are flushed
to disk.

If the application were to do say 2000 writes (4k sized writes, so 8MB)
within 50ms under peak load,
will the flush at secondary "fail" or will it be just slower than normal
(because do_generic_request in drbd_submit_ee just blocks) ?

> and I am bit of a newbie to the concept of "bio"s.
> >
> > my question: (all concerning IO at secondary, for Protocol A/B)
> >  In drbd_receiver.c, esp in function receive_Data(..),
> > the backup disconnects from primary when drbd_submit_ee(..) call fails.
> > The comments indicate
> >         /* drbd_submit_ee currently fails for one reason only:
> >          * not being able to allocate enough bios.
> >          * Is dropping the connection going to help? */
> >
> > So, the code just finishes the activity log io, releases the ee and
> returns
> > false,
> > which causes the main loop to disconnect from primary.
> >
> > Why was this choice made?
>
> It grew that way.
>
> It does not happen, I am not aware of that code path having ever been
> taken. If it should be taken some day, we'll likely fix it so it won't
> happen again.
>
> now thats a relief.

> But as long as drbd_submit_ee can fail (in theory) there needs to be an
> error handling branch (that is at least "correct").
>
> Disconnecting/reconnecting was the easiest possible error path here.
>
> But see my comment about biosets below.
>
> > Please correct me if I am wrong:
> > Isnt failure to allocate a bio a temporary issue? I mean the kernel ran
> out
> > of bio's to allocate out of its slabs (or short of memory currently)
> > and thus retrying again after a while might work.
> >
> > I understand that for protocol C, one cannot buffer the IO on
> > secondary. But for Protocol A/B, they can certainly be buffered and
> > retried. Isnt that better than just disconnecting from primary and
> > causing reconnects?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> > On the same note,
> > function "w_e_reissue" callback is used to resubmit a failed IO , if th=
e
> IO
> > had REQ_HARDBARRIER flag.
>
> Which is obsolete, btw, and will go away.  Recent kernels have REQ_FUA |
> REQ_FLUSH, which will not fail but for real IO error.
>
> > Looking at this function, it tries to reissue the IO and
> >  (a) when drbd_submit_ee fails,
> >     it installs itself as the callback handler and re queues the work.
> This
> > contradicts with the receive_Data(..)
>
> So what.
> It does not happen anyways, it just needed to be "correct".
> And, in this case we know that there just now had been enough bios for
> this ee, we just gave them back to the system, it is highly likely that
> we get enough bios back again.
>
> this is kind of what I plan to do, if drbd_submit_ee starts failing when
flushing
the deferred writes. Try to queue up one request for every bio completion.

> > error handling, where drbd_submit_ee call failure leads to connection
> > termination.
> >
> >    Also, this could cause potential looping (probably infinite) when th=
e
> > submit_ee call keeps failing due to ENOMEM.
>
> Did not you yourself suggest retrying, stating that not being able to
> allocate bios was only a temporary problem? ;-)
>
> >    shouldnt there be some sort of "num_attempts" counter that limits
> number
> > of IO retries?
>
> No.
>
> There should probably be a dedicated drbd bioset where we allocate bios
> from.
> It has not been an issue, so we did not implement it yet.
> If you want to do that, it was quite easy,
> would change drbd internal bio_alloc to bio_alloc_bioset from that drbd
> bioset, could make drbd_submit_ee void (won't fail), etc.
> Send patch to this list, or PM, whatever you prefer.
>
> > the comments in this function
> > "@cancel  The connection will be closed anyways (unused in this
> callback)"
> > I cannot find a control path that causes a connection close, before
> reaching
> > this function.
>
> Those are asynchronous, and may happen any time, whenever drbd detects
> that we have a problem with our replication link.
> The worker then calls all callbacks with this "cancel" flag set, so they
> know early on that there is no point in trying to send anything over (in
> case they wanted to).
>
> > On the other hand,
> >  drbd_endio_sec --> drbd_endio_sec_final
>
> which both are void...
>
> >    where this ee is simply requeued, with its callback changed to
> > w_e_reissue which always returns 1.
>
> Yes. We don't want the worker to die.
>
> Again, this "grew that way".
> I think in the long run, the cancel parameter to our work callbacks
> may be dropped, and they may become void. But that's not particularly
> urgent.
>
> >    (unlike e_end_block which returns 0 causing the worker thread to for=
ce
> > connection to go down)
>
> No, that causes the _asender_ thread (not the worker) to _notice_
> that the connection was lost (it has not been able to send an ACK).
> But this again is probably not necessary anymore as we already called
> into the state handling from where the send actually failed,
> and possibly could become void.
>
> hth,
>
> --
> : Lars Ellenberg
> : LINBIT | Your Way to High Availability
> : DRBD/HA support and consulting http://www.linbit.com
>
> DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>



--=20
perception is but an offspring of its own self

--000e0cd29a840df3b90495476b12
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Wed, Nov 17, 2010 at 12:27 PM, Lars Ellen=
berg <span dir=3D"ltr">&lt;<a href=3D"mailto:lars.ellenberg@linbit.com">lar=
s.ellenberg@linbit.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, =
204, 204); padding-left: 1ex;">
<div class=3D"im">On Wed, Nov 17, 2010 at 11:00:03AM -0800, Shriram Rajagop=
alan wrote:<br>
&gt; [I apologize if this is a double post]<br>
<br>
</div>It&#39;s not.<br>
drbd-dev just happens to be moderated somewhat ;-)<br>
<div class=3D"im"><br>
&gt; Hi all,<br>
&gt; I have recently started hacking into drbd kernel code<br>
<br>
</div>Just curious: Why?<br>
What are you up to?<br>
<div class=3D"im"><br></div></blockquote><div>Well there is this 4th protoc=
ol I want to try.<br>Protocol A + defer writes @ backup until P_BARRIER <br=
>(ie buffer the writes in current epoch until an explicit P_BARRIER).<br>
<br>=A0 currently receive_Barrier only blocks on active_ee list, waiting<br=
>for completion of pending IOs. <br>=A0 I want to issue the deferred writes=
 in receive_Barrier and then<br>fall through the rest of the code.<br><br>C=
onsider an App that is moderately io intensive and it needs transactional <=
br>
view of disk to survive failures. It &quot;buffers&quot; any network output=
 until the next P_BARRIER.<br>It issues a P_BARRIER every T &quot;milliseco=
nds&quot; where T =3D 50ms/100ms..whatever. <br>Since barrier ack implies t=
hat both disks are in sync, App @ primary will send network output <br>
only after receiving the barrier ACK.<br><br>Lets ignore the App side of fa=
ult tolerance and the network latency aspect for the moment.<br>(and the ar=
gument that protocol C is almost as good as proto A). I chose async replica=
tion<br>
because this app demands so.<br><br>Failure:<br>On primary failure, seconda=
ry &quot;discards&quot; all writes buffered in the current epoch <br>&amp; =
activates secondary disk and spawns App. App @ secondary will always start =
with<br>
last consistent sync point.<br>On secondary failure, primary just moves on.=
<br><br>IOW, always sync from current primary to the node that comes back o=
nline.<br><br>On resync (assuming primary failure),<br>=A0secondary copies =
all data (using quick-sync bitmap and activity log) since failover<br>
to primary. Any disk regions touched by by primary before crash<br>have to =
be overwritten with a copy from the secondary.<br>=A0<br>What I am concerne=
d about is that the sudden influx of IOs at every P_BARRIER, @ secondary<br=
>
might choke the kernel and cause drbd_submit_ee to fail. If this failure ha=
ppens rarely, its ok but<br>if it occurs regularly, then I would have to co=
ntrol the rate at which the deferred IOs are flushed<br>to disk.<br><br>
If the application were to do say 2000 writes (4k sized writes, so 8MB) wit=
hin 50ms under peak load,<br>will the flush at secondary &quot;fail&quot; o=
r will it be just slower than normal <br>(because do_generic_request in drb=
d_submit_ee just blocks) ?<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.=
8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div cl=
ass=3D"im">&gt; and I am bit of a newbie to the concept of &quot;bio&quot;s=
.<br>

&gt;<br>
&gt; my question: (all concerning IO at secondary, for Protocol A/B)<br>
&gt; =A0In drbd_receiver.c, esp in function receive_Data(..),<br>
&gt; the backup disconnects from primary when drbd_submit_ee(..) call fails=
.<br>
&gt; The comments indicate<br>
&gt; =A0 =A0 =A0 =A0 /* drbd_submit_ee currently fails for one reason only:=
<br>
&gt; =A0 =A0 =A0 =A0 =A0* not being able to allocate enough bios.<br>
&gt; =A0 =A0 =A0 =A0 =A0* Is dropping the connection going to help? */<br>
&gt;<br>
&gt; So, the code just finishes the activity log io, releases the ee and re=
turns<br>
&gt; false,<br>
&gt; which causes the main loop to disconnect from primary.<br>
&gt;<br>
&gt; Why was this choice made?<br>
<br>
</div>It grew that way.<br>
<br>
It does not happen, I am not aware of that code path having ever been<br>
taken. If it should be taken some day, we&#39;ll likely fix it so it won&#3=
9;t<br>
happen again.<br>
<br></blockquote><div>now thats a relief.=A0 <br></div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">
But as long as drbd_submit_ee can fail (in theory) there needs to be an<br>
error handling branch (that is at least &quot;correct&quot;).<br>
<br>
Disconnecting/reconnecting was the easiest possible error path here.<br>
<br>
But see my comment about biosets below.<br>
<div class=3D"im"><br>
&gt; Please correct me if I am wrong:<br>
&gt; Isnt failure to allocate a bio a temporary issue? I mean the kernel ra=
n out<br>
&gt; of bio&#39;s to allocate out of its slabs (or short of memory currentl=
y)<br>
&gt; and thus retrying again after a while might work.<br>
&gt;<br>
&gt; I understand that for protocol C, one cannot buffer the IO on<br>
&gt; secondary. But for Protocol A/B, they can certainly be buffered and<br=
>
&gt; retried. Isnt that better than just disconnecting from primary and<br>
&gt; causing reconnects?<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
<br>
&gt; On the same note,<br>
&gt; function &quot;w_e_reissue&quot; callback is used to resubmit a failed=
 IO , if the IO<br>
&gt; had REQ_HARDBARRIER flag.<br>
<br>
</div>Which is obsolete, btw, and will go away. =A0Recent kernels have REQ_=
FUA |<br>
REQ_FLUSH, which will not fail but for real IO error.<br>
<div class=3D"im"><br>
&gt; Looking at this function, it tries to reissue the IO and<br>
&gt; =A0(a) when drbd_submit_ee fails,<br>
&gt; =A0 =A0 it installs itself as the callback handler and re queues the w=
ork. This<br>
&gt; contradicts with the receive_Data(..)<br>
<br>
</div>So what.<br>
It does not happen anyways, it just needed to be &quot;correct&quot;.<br>
And, in this case we know that there just now had been enough bios for<br>
this ee, we just gave them back to the system, it is highly likely that<br>
we get enough bios back again.<br>
<div class=3D"im"><br></div></blockquote><div>this is kind of what I plan t=
o do, if drbd_submit_ee starts failing when flushing<br>the deferred writes=
. Try to queue up one request for every bio completion. <br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1=
px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">
&gt; error handling, where drbd_submit_ee call failure leads to connection<=
br>
&gt; termination.<br>
&gt;<br>
&gt; =A0 =A0Also, this could cause potential looping (probably infinite) wh=
en the<br>
&gt; submit_ee call keeps failing due to ENOMEM.<br>
<br>
</div>Did not you yourself suggest retrying, stating that not being able to=
<br>
allocate bios was only a temporary problem? ;-)<br>
<div class=3D"im"><br>
&gt; =A0 =A0shouldnt there be some sort of &quot;num_attempts&quot; counter=
 that limits number<br>
&gt; of IO retries?<br>
<br>
</div>No.<br>
<br>
There should probably be a dedicated drbd bioset where we allocate bios fro=
m.<br>
It has not been an issue, so we did not implement it yet.<br>
If you want to do that, it was quite easy,<br>
would change drbd internal bio_alloc to bio_alloc_bioset from that drbd<br>
bioset, could make drbd_submit_ee void (won&#39;t fail), etc.<br>
Send patch to this list, or PM, whatever you prefer.<br>
<div class=3D"im"><br>
&gt; the comments in this function<br>
&gt; &quot;@cancel =A0The connection will be closed anyways (unused in this=
 callback)&quot;<br>
&gt; I cannot find a control path that causes a connection close, before re=
aching<br>
&gt; this function.<br>
<br>
</div>Those are asynchronous, and may happen any time, whenever drbd detect=
s<br>
that we have a problem with our replication link.<br>
The worker then calls all callbacks with this &quot;cancel&quot; flag set, =
so they<br>
know early on that there is no point in trying to send anything over (in<br=
>
case they wanted to).<br>
<div class=3D"im"><br>
&gt; On the other hand,<br>
&gt; =A0drbd_endio_sec --&gt; drbd_endio_sec_final<br>
<br>
</div>which both are void...<br>
<div class=3D"im"><br>
&gt; =A0 =A0where this ee is simply requeued, with its callback changed to<=
br>
&gt; w_e_reissue which always returns 1.<br>
<br>
</div>Yes. We don&#39;t want the worker to die.<br>
<br>
Again, this &quot;grew that way&quot;.<br>
I think in the long run, the cancel parameter to our work callbacks<br>
may be dropped, and they may become void. But that&#39;s not particularly<b=
r>
urgent.<br>
<div class=3D"im"><br>
&gt; =A0 =A0(unlike e_end_block which returns 0 causing the worker thread t=
o force<br>
&gt; connection to go down)<br>
<br>
</div>No, that causes the _asender_ thread (not the worker) to _notice_<br>
that the connection was lost (it has not been able to send an ACK).<br>
But this again is probably not necessary anymore as we already called<br>
into the state handling from where the send actually failed,<br>
and possibly could become void.<br>
<br>
hth,<br>
<br>
--<br>
: Lars Ellenberg<br>
: LINBIT | Your Way to High Availability<br>
: DRBD/HA support and consulting <a href=3D"http://www.linbit.com" target=
=3D"_blank">http://www.linbit.com</a><br>
<br>
DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.<br>
_______________________________________________<br>
drbd-dev mailing list<br>
<a href=3D"mailto:drbd-dev@lists.linbit.com">drbd-dev@lists.linbit.com</a><=
br>
<a href=3D"http://lists.linbit.com/mailman/listinfo/drbd-dev" target=3D"_bl=
ank">http://lists.linbit.com/mailman/listinfo/drbd-dev</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>perception is but an of=
fspring of its own self<br>

--000e0cd29a840df3b90495476b12--
