Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Cstate stays in "Disconnecting" after Heartbeat link
	down and up
Date: Fri, 6 Oct 2006 15:18:35 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C7F6@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C7F6@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610061518.35416.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 5. Oktober 2006 23:37 schrieb Montrose, Ernest:
> Hi all,
> If I do an ifdown and an ifup on the heartbeat link drbd goes into
> CS:Disconnecting .  I cannot manually recover until a reboot. Should the
> state be "StandAlone" instead? I include a patch that seems to work for
> me.
>

Hi Ernest,

You patch did not fix the root case of the problem. The source of the
problem was the missing dec_net() in drbd_try_connect().

That lead to the receiver thread hang in=20
wait_event( ...,atomic_read(&mdev->net_cnt) =3D=3D 0 ) in drbd_disconnect()=
 .

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

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
