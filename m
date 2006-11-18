Return-Path: <mekats@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5524F2DF6547
	for <drbd-dev@lists.linbit.com>; Sat, 18 Nov 2006 13:20:58 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u52so629857pyb
	for <drbd-dev@lists.linbit.com>; Sat, 18 Nov 2006 04:20:57 -0800 (PST)
Message-ID: <5e77099e0611180420p6c400880j19a22a0dcb7fd62e@mail.gmail.com>
Date: Sat, 18 Nov 2006 12:20:56 +0000
From: "Sudhakar Mekathotti" <mekats@gmail.com>
To: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
In-Reply-To: <5e77099e0611180419s77b9e3f5u172d853634174bd8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_25554_15502321.1163852456211"
References: <342BAC0A5467384983B586A6B0B37671040347F7@EXNA.corp.stratus.com>
	<5e77099e0611180419s77b9e3f5u172d853634174bd8@mail.gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

------=_Part_25554_15502321.1163852456211
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/16/06, Graham, Simon <Simon.Graham@stratus.com> wrote:
>
> Not sure I agree that the current behavior is protecting users from
> themselves -- it only causes the split-brain if you lose the n/w and during
> 'normal' operation and there is nothing that protects against mounting a
> 1-node fs on both nodes of a primary-primary DRBD cluster.
>
> Running primary-secondary doesn't work if you are in a situation where it
> is not possible to switch primaryness when failing over; a good example of
> that is if you want to run a Xen virtual machine on top of a DRBD partition
> and support live migration of the VM (the problem is that Xen doesn't
> provide the means to execute a script to change primaryness at the required
> point in the migration). Of course you could argue that this is a Xen bug
> _but_ pragmatically, the proposed patch to delay updating the UUID until an
> actual write occurs preserves (I believe) correctness in DRBD and works
> without introducing new features into Xen.
>
> Recovering from split-brain automatically is of course something that is
> incredibly valuable but I think it can be treated orthogonally to the
> proposed fix.


I think from a technical perspective, automatically recovering from
split-brain is nice to have. But from a user perspective, I would in almost
all cases refrain from using that feature as I would like to make double
sure my data is consistent and makes 'business sense' before electing which
disk to be primary.

-----Original Message-----

> From: Philipp Reisner [mailto: philipp.reisner@linbit.com]
> Sent: Thursday, November 16, 2006 4:10 AM
> To: drbd-dev@linbit.com
> Cc: Montrose, Ernest; Graham, Simon
> Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on
> Primary/primary potential patch
>
> Am Dienstag, 7. November 2006 00:47 schrieb Montrose, Ernest:
> > When running Primary/Primary if the Heartbeat connection goes down when
> > we recover we always split brain.  Simon had an idea which I have
> > implemented. He is on vacation  so this may not reflect his exact idea.
> >
> > Essentially with this change, we do not create a new current UUID on the
> > node unless I/O is seen. This prevent Split-Brain mitigation when both
> > nodes are primary but only one node is originating I/O and never the
> > other.  He is only stand-by in that case.
> >
> > Take a look and let me know.
>
>
[snip]

------=_Part_25554_15502321.1163852456211
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="q"><span class="gmail_quote">On 11/16/06, <b class="gmail_sendername">Graham, Simon</b> &lt;<a href="mailto:Simon.Graham@stratus.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
Simon.Graham@stratus.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Not sure I agree that the current behavior is protecting users from themselves -- it only causes the split-brain if you lose the n/w and during 'normal' operation and there is nothing that protects against mounting a 1-node fs on both nodes of a primary-primary DRBD cluster.
<br><br>Running primary-secondary doesn't work if you are in a situation where it is not possible to switch primaryness when failing over; a good example of that is if you want to run a Xen virtual machine on top of a DRBD partition and support live migration of the VM (the problem is that Xen doesn't provide the means to execute a script to change primaryness at the required point in the migration). Of course you could argue that this is a Xen bug _but_ pragmatically, the proposed patch to delay updating the UUID until an actual write occurs preserves (I believe) correctness in DRBD and works without introducing new features into Xen.
<br><br>Recovering from split-brain automatically is of course something that is incredibly valuable but I think it can be treated orthogonally to the proposed fix.</blockquote></span><div><br>I think from a technical perspective, automatically recovering from split-brain is nice to have. But from a user perspective, I would in almost all cases refrain from using that feature as I would like to make double sure my data is consistent and makes 'business sense' before electing which disk to be primary.
<br>&nbsp;</div><span class="q">-----Original Message-----<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">From: Philipp Reisner [mailto:<a href="mailto:philipp.reisner@linbit.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

philipp.reisner@linbit.com</a>]<br>Sent: Thursday, November 16, 2006 4:10 AM<br>To: <a href="mailto:drbd-dev@linbit.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">drbd-dev@linbit.com</a><br>Cc: Montrose, Ernest; Graham, Simon
<br>Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary potential patch
<br><br>Am Dienstag, 7. November 2006 00:47 schrieb Montrose, Ernest:<br>&gt; When running Primary/Primary if the Heartbeat connection goes down when<br>&gt; we recover we always split brain.&nbsp;&nbsp;Simon had an idea which I have
<br>&gt; implemented. He is on vacation&nbsp;&nbsp;so this may not reflect his exact idea.<br>&gt;<br>&gt; Essentially with this change, we do not create a new current UUID on the<br>&gt; node unless I/O is seen. This prevent Split-Brain mitigation when both
<br>&gt; nodes are primary but only one node is originating I/O and never the<br>&gt; other.&nbsp;&nbsp;He is only stand-by in that case.<br>&gt;<br>&gt; Take a look and let me know.<br><br></blockquote></span></div><br>[snip]


------=_Part_25554_15502321.1163852456211--
