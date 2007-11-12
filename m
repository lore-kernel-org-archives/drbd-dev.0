Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Subject: Re: [Drbd-dev] Handling on-disk caches
Date: Mon, 12 Nov 2007 17:24:12 +0100
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B3767107074F83@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107074F83@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200711121724.12490.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 12 November 2007 16:59:24 Graham, Simon wrote:
> > For item 3 I have an other opinion.
> >
> > On the primary we have a data structure called the "transfer log" or
>
> tl
>
> > in the code. Up to now this was mainly important for protocol A and B.
> >
> > It is a data structure conaining objects for all our self-generated
> > drbd-barriers on the fly, and objects for all write requests between
> > these barriers.
> >
> > If we loose connection in protocol A or B we need to mark everything
> > we find in the transfer_log as out-of-sync in the bitmap.
> >
> > When we also do this for protocol C, _AND_ use BIO_RW_BARRIER for
> > doing writing on the secondary we have solved the issue you
> > described in the first part of the mail.
>
> I like it! MUCH better than marking the GB's of data covered by the
> AL...
>
> I presume you will work on this as part of 8.2 rather than as a fix to
> 8.0? Since I am currently locked on 8.0, I will probably look at
> implementing your suggestions as updates to 8.0 and submit them for
> consideration in 8.2.

Right, I thought about this, and forgot to mention it in the mail.

=46rom a technical point of view it is possible to do the BIO_RW_BARRIER
stuff in DRBD-8.0 since it can be done without changing the protocol.

=46rom the point of view as release manager I get bellyache when considering
such a big change for DRBD-8.0.

Please start the work based on the 8.0 tree, I postpone the
decision if it should go into 8.2 only or into 8.0 (and propagated to=20
8.2 of course as well) until we see the intrusiveness of the patch.

Moving patches between 8.0 and 8.2 is still quite possible...=20

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
