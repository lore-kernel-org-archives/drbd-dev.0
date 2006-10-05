Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
Subject: Re: [Drbd-dev] local-io-error parse error in drbd.conf
Date: Thu, 5 Oct 2006 15:23:59 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C7F5@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C7F5@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610051524.00444.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 5. Oktober 2006 15:03 schrieb Montrose, Ernest:
> Hi Phil,
> OK I was not very clear.  It was a little late in the day so forgive me.
> Here are the details:
>
> In /etc/drbd.conf I set:
> handlers{
> local-io-error "echo 0> /proc/sysrq-trigger; halt -f";
> }
>
> In disk I just have:
> Disk{
> on-io-error detach;
> }
>
> If I now do a "drbdadm -d state all" for example I get:
> /etc/drbd.conf:31: Parse eror: 'an option keyword' expected,
>  but got 'local-io-error'.
>
> It seems like the implementation is in the driver but not in drbdsetup(1).
>
> Thanks.

Oh, yes right. You are right, I forgot to add this to drbdadm, and
to drbdadm's scanner/parser. I will do this on Friday, please comment=20
the handler out of your config file in the mean time.

You should be able to see the event in the output of=20
'drbdsetup /dev/drbd0 events -a'.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
