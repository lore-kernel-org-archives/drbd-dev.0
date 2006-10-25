Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: pri-lost-after-sb handler not kicking in on
	Split-brain or so it seems
Date: Wed, 25 Oct 2006 16:37:37 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C812@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C812@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610251637.37785.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 25. Oktober 2006 16:20 schrieb Montrose, Ernest:
> Phil,
> Thanks for the clarification on the algorithm. Actually, I may not have an
> immediate need any longer for the handler to be called every time based on
> what you explained.  But I think that if it is called every time it gives
> increased flexibility.  Besides, if it is called every time we would still
> keep the current behavior while adding that extra bit of flexibility. I m=
ay
> just be paranoid here thinking that I will need this somehow soon. Though=
 I
> cannot think of what it would really be good and critical for at this
> moment:)

Hi Ernest,

Since there is no obvious need for such a handler, and for more non
obvious uses you could do something around the "drbdsetup events"=20
interface I will leave it now the way it is...

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
