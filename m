Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Thu, 6 Jul 2006 16:06:25 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671031FB6E8@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I agree completely with the idea of having a local failure cause a retry =
to the peer -- that is actually the subject of the second phase of the =
work I want to do to handle disk errors -- if a read fails locally =
because of a bad block, then retry the read remotely AND when the data =
comes back, actually WRITE it locally as well as returning the result - =
this will nicely fix the error in a lot of cases as the disk will remap =
the block.

Of course, there are some tricky timing windows to watch out for here =
(such as the app performing an explicit write to the same block in the =
meantime).

/simgr

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com] =
On Behalf Of Philipp Reisner
Sent: Thursday, July 06, 2006 10:39 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c

Am Mittwoch, 5. Juli 2006 19:49 schrieb Graham, Simon:
> Thanks again for the review; I understand and agree with your comments =
on
> doing this in 8 versus 7 - anything I do on 7 will just be for =
prototyping
> (because as I said it's much easier for me to test with 7 right now).
>
> I will take the approach of continuing with as much as possible of the
> resync (although as I suspected, it's MUCH easier to simply abort the
> resync as soon as any error is reported).

Ok.=20

> One question -- you said that DRBD disconnects from the disk on the =
first
> (local) error -- I think this is only true if you set on-io-error to
> "Detach" -- we actually run with the default value of PassOn in which =
case
> drbd_io_error does nothing; I think this is actually the best way to =
run
> since it keeps the disk accessible for those blocks that are OK and =
returns
> errors for those that are not.

Hmmm. The current semantic is:

on-io-error =3D passOn

If there is a local read error, DRBD will pass the IO error on to the=20
filesystem without retrying on the peer node.

Maybe we should have one more on-io-error hander. One that=20
retrtries on the peer node, if there is one, and if there is no peer
it returns the IO error, without detaching from the disk.

Good point.=20

I added that thought to my ROADMAP file...

-Philipp
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
