Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] drbdsetup  events patch to announce Split-brain
Date: Mon, 29 Oct 2007 09:36:25 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A22@EXNA.corp.stratus.com>
In-Reply-To: 200710291119.58122.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C454F479FA@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A1B@EXNA.corp.stratus.com>
	200710291119.58122.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
I think this will work for us actually. So feel free to check it in.

Thanks,

EM--
-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Monday, October 29, 2007 6:20 AM
To: Montrose, Ernest
Cc: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] drbdsetup events patch to announce Split-brain

On Thursday 25 October 2007 14:24:55 Montrose, Ernest wrote:
> Phil,
> Currently we do not use the payload for anything.  I was just being
> paranoid thinking that we might need it in the future.  But you can
drop
> it if you wish.  If we have a pressing need for it in the future,
we'll
> deal with it then.
>

Ernest,

Over the weekend I realized that the split brain event is quite
similar to a number of events we already signal back to userspace.

The invocation of handlers is also visible through the "drbdsetup
events"
interface.

The attached patch creates an handler called "split-brain". If you
can live with that interface as well, I will commit that...

In the future I want to go this way:

  * Allow one to set the usermode_helper to the empty string. Then it=20
    is still possible to get all events through the "drbdsetup events"
    interface.
  * The "outdate-peer" usermode_helper sends an exit code back
    to kernel space. This is not yet possible when one only uses
    the "drbdsetup events" interface. This should get fixed.

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
