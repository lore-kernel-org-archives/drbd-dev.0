Return-Path: <rshriram@gmail.com>
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com
	[209.85.214.182])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5BF0D1058E85
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2010 20:06:43 +0100 (CET)
Received: by iwn39 with SMTP id 39so2568757iwn.27
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2010 11:06:42 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 17 Nov 2010 11:00:03 -0800
Message-ID: <AANLkTikZaR_GPaDO=zjq_DyWD0C5-_6DtBHjgbevGwUL@mail.gmail.com>
From: Shriram Rajagopalan <rshriram@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=00032557a35eeaa2a804954447dd
Subject: [Drbd-dev] Protocol A,B & submit ee failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--00032557a35eeaa2a804954447dd
Content-Type: text/plain; charset=ISO-8859-1

[I apologize if this is a double post]
Hi all,
I have recently started hacking into drbd kernel code and I am bit of a
newbie to the concept of "bio"s.

my question: (all concerning IO at secondary, for Protocol A/B)
 In drbd_receiver.c, esp in function receive_Data(..),
the backup disconnects from primary when drbd_submit_ee(..) call fails.
The comments indicate
        /* drbd_submit_ee currently fails for one reason only:
         * not being able to allocate enough
bios.

         * Is dropping the connection going to help? */

So, the code just finishes the activity log io, releases the ee and returns
false,
which causes the main loop to disconnect from primary.

Why was this choice made?
Please correct me if I am wrong:
Isnt failure to allocate a bio a temporary issue? I mean the kernel ran out
of
bio's to allocate out of its slabs (or short of memory currently) and thus
retrying again after a while might work.

I understand that for protocol C, one cannot buffer the IO on secondary. But
for Protocol A/B, they
can certainly be buffered and retried. Isnt that better than just
disconnecting from primary and causing
reconnects?
==========
On the same note,
function "w_e_reissue" callback is used to resubmit a failed IO , if the IO
had REQ_HARDBARRIER flag.
Looking at this function, it tries to reissue the IO and
 (a) when drbd_submit_ee fails,
    it installs itself as the callback handler and re queues the work. This
contradicts with the receive_Data(..)
error handling, where drbd_submit_ee call failure leads to connection
termination.

   Also, this could cause potential looping (probably infinite) when the
submit_ee call keeps failing due to ENOMEM.
   shouldnt there be some sort of "num_attempts" counter that limits number
of IO retries?

the comments in this function
"@cancel  The connection will be closed anyways (unused in this callback)"
I cannot find a control path that causes a connection close, before reaching
this function. On the other hand,
 drbd_endio_sec --> drbd_endio_sec_final
   where this ee is simply requeued, with its callback changed to
w_e_reissue which always returns 1.
   (unlike e_end_block which returns 0 causing the worker thread to force
connection to go down)
=========

shriram


-- 
perception is but an offspring of its own self

--00032557a35eeaa2a804954447dd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[I apologize if this is a double post]<br>Hi all,<br>I have recently starte=
d hacking into drbd kernel code and I am bit of a newbie to the concept of =
&quot;bio&quot;s. <br><br>my question: (all concerning IO at secondary, for=
 Protocol A/B)<br>
=A0In drbd_receiver.c, esp in function receive_Data(..),<br>

the backup disconnects from primary when drbd_submit_ee(..) call fails.<br>=
The comments indicate <br>=A0=A0=A0=A0=A0=A0=A0 /* drbd_submit_ee currently=
 fails for one reason only:<br><div id=3D":1hu"><div>
=A0=A0=A0=A0=A0=A0=A0=A0 * not being able to allocate enough bios.=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <b=
r>


=A0=A0=A0=A0=A0=A0=A0=A0 * Is dropping the connection going to help? */<br>=
<br>So, the code just finishes the activity log io, releases the ee and ret=
urns false, <br>which causes the main loop to disconnect from primary.<br><=
br>Why was this choice made? <br>


Please correct me if I am wrong: <br>Isnt failure to allocate a bio a tempo=
rary issue? I mean the kernel ran out of<br>bio&#39;s to allocate out of it=
s slabs (or short of memory currently) and thus <br>retrying again after a =
while might work.<br>


<br>I understand that for protocol C, one cannot buffer the IO on secondary=
. But for Protocol A/B, they<br>can certainly be buffered and retried. Isnt=
 that better than just disconnecting from primary and causing<br>reconnects=
?<br>


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>On the same note, <br>function &quot;w_e_=
reissue&quot; callback is used to resubmit a failed IO , if the IO had REQ_=
HARDBARRIER flag.<br>Looking at this function, it tries to reissue the IO a=
nd <br>=A0(a) when drbd_submit_ee fails, <br>


=A0=A0=A0 it installs itself as the callback handler and re queues the work=
. This contradicts with the receive_Data(..)<br>error handling, where drbd_=
submit_ee call failure leads to connection termination.<br><br>=A0=A0 Also,=
 this could cause potential looping (probably infinite) when the submit_ee =
call keeps failing due to ENOMEM.<br>


=A0=A0 shouldnt there be some sort of &quot;num_attempts&quot; counter that=
 limits number of IO retries?<br><br>the comments in this function<br>&quot=
;@cancel=A0 The connection will be closed anyways (unused in this callback)=
&quot;<br>


I cannot find a control path that causes a connection close, before reachin=
g this function. On the other hand,<br>=A0drbd_endio_sec --&gt; drbd_endio_=
sec_final <br>=A0=A0 where this ee is simply requeued, with its callback ch=
anged to w_e_reissue which always returns 1.<br>


=A0=A0 (unlike e_end_block which returns 0 causing the worker thread to for=
ce connection to go down)<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><font color=3D"=
#888888"><font color=3D"#888888"><br>shriram</font></font></div></div><br c=
lear=3D"all"><br>-- <br>
perception is but an offspring of its own self<br>

--00032557a35eeaa2a804954447dd--
