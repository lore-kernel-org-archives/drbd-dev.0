Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A1FB72CDC348
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jul 2006 17:53:37 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Wed, 5 Jul 2006 18:06:51 +0200
References: <342BAC0A5467384983B586A6B0B37671031FB441@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671031FB441@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607051806.51407.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 5. Juli 2006 16:27 schrieb Graham, Simon:
> Thanks Philip,
>
> I realize I will have to rework this for DRBD 8 - oh well!
>
> One thing I think is important here is that when an error occurs in the
> middle of resyncing, I was thinking we should make sure we finish up as
> much as possible of the resync; this allows the disk to become sane again
> if the bad block in question is fixed up -- for example, if a subsequent
> write to the block is done to a bad block and it also allows most accesses
> to be local if we end up failing over primaryness -- so I was thinking we
> should not simply abandon the resync as soon as an error is detected...
>
> On the other hand, perhaps this would be an easier way to handle the issue
> -- simply abandon the current resync as soon as an error is detected and
> live with the fact that there are potentially many following blocks that
> could be synchronized but which will not be -- I suspect this would be mu=
ch
> easier to implement in both 7 and 8... I think the only remaining question
> would then be what the strategy for restarting the resync in this case --
> it would be nice if the disk could eventually become consistent again...
>
> I appreciate your guidance and time,
> Simon
>

Hi Simon,

Although I am today busy with other things that DRBD and I did not found
a lot of time to think about the problem you want to solve, my gut feeling
is that we should try to finish the resync run, even if there are some
IO errors in the course.

I did not had a look at the code to find out what's easiert to implement
by now.

Currently we simply disconnect from a disk as soon as we see a singe IO
error on it. ( =3D State transition disk[ UpToDate -> Failed ] )

The question I want to answer first are:
 Should we have a new disk state. ?  PartiallyFailed ?
 No state change at all ?
 Is "PartiallyFailed" the same thing as "Inconsistent" ?
=20
Simon, please focus on implementing this for drbd-8. Our current plan
is to have drbd-8 ready by September 2006. (And this might get more
strict that the open-source attitude, it is finished when it is ready ;)

Ok, while thinking about it, I begin to understand how that would feel.
E.g. it would be also allowed to force an degraded cluster (=3Dsingle
node) with in inconsistent disk to be accessible (=3Dprimary) but=20
return for all blocks that are out of sync an IO-Error.

Ok, I see, that might be for some cases much more help than the panic,
that DRBD does currently.

I guess that these changes are in the end rather big, and I guess it
is better to not de-stabilize drbd-0.7's code base with such fundamental
changes. This should happen in the development code.

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
