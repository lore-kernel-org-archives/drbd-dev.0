Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Cstate stays in "Disconnecting" after Heartbeat link
	down and up
Date: Fri, 6 Oct 2006 09:29:49 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C7F7@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks!  I did not think that my patch was the proper fix :)  Thank you =
for explaining this.  This will help our understanding of the Cstate =
machine.

As for DRBD not noticing the link Up, I accept the current behavior.  =
Some external monitor should notice and wake up drbd. I wanted to =
confirm though.

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Friday, October 06, 2006 9:19 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] Cstate stays in "Disconnecting" after Heartbeat =
link down and up

Am Donnerstag, 5. Oktober 2006 23:37 schrieb Montrose, Ernest:
> Hi all,
> If I do an ifdown and an ifup on the heartbeat link drbd goes into
> CS:Disconnecting .  I cannot manually recover until a reboot. Should =
the
> state be "StandAlone" instead? I include a patch that seems to work =
for
> me.
>

Hi Ernest,

You patch did not fix the root case of the problem. The source of the
problem was the missing dec_net() in drbd_try_connect().

That lead to the receiver thread hang in=20
wait_event( ...,atomic_read(&mdev->net_cnt) =3D=3D 0 ) in =
drbd_disconnect() .

Therefore the receiver thread did not terminate and could not set
the state finally to StandAlone.

see http://lists.linbit.com/pipermail/drbd-cvs/2006-October/001306.html

PS: Regarding the state-engine, you should always request a state
    of "Disconnecting", and let the exiting receiver set it finally
    to "StandAlone".

> A side question:
> Should drbd notice when the link comes up?  He does not seem to.
>

No, we do not do that. In case we discover that we can not bind()
our address we give up.

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
