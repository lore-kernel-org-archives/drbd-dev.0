Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 (My) first problem with new requests
	handlingcode...
Date: Mon, 11 Sep 2006 15:07:52 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B0151@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks for the update (and yes, you are of course right about the test
of master_bio versus private_bio - Doh!)

Glad to hear that major upheaval is done now -- we'll get on with
testing this and will submit patch suggestions as we find things (I just
tried this mornings trunk and hit another crash when the 2nd node comes
up - will let you know what it is as soon as I figure it out!)

Simon

> -----Original Message-----
> From: Lars Ellenberg [mailto:Lars.Ellenberg@linbit.com]
> Sent: Monday, September 11, 2006 1:43 PM
> To: Graham, Simon
> Cc: drbd-dev@linbit.com
> Subject: Re: [Drbd-dev] DRBD-8 (My) first problem with new requests
> handlingcode...
>=20
> / 2006-09-11 11:32:45 -0400 \ Graham, Simon:
> > > and, as the comment at the head of _req_mod says:
> > > we probably should split the case branches out into
> > > "STATIC" functions, and only have the _req_mod
> > > dispatch, or even remove the _req_mod switch
> > > statement again, and only have the branch
> > > functions...
> > >
> > > otherwise, what do you think/have found out about
> > > that monster patch?
> > >
> >
> > Well, since I haven't been able to boot my system yet
> > I don't have any real experience yet but I really
> > like the idea of centralizing the request handling --
> > if the code for the various cases could be moved into
> > separate routines in drbd_req.c, I think you COULD
> > revert to an inline top-level function containing
> > just the case statement and the calls to the various
> > non-inline functions -- the compiler ought to be able
> > to nicely optimize this and only include the specific
> > case(s) for the type argument which would translate
> > to direct calls to the per-case routines...
>=20
> that has been the rational for declaring it inline at
> first...  but anyways.
>=20
> > I see you committed a change to the problem I reported and also to
> > remove the inline of the function for which I thank you!
>=20
> >
> > BTW - there is another case of accessing a NULL bio pointer in the
> > read_completed_with_error case:
> >
> > +	case read_completed_with_error:
> > +		drbd_set_out_of_sync(mdev,req->sector,req->size);
> > +		req->rq_state |=3D RQ_LOCAL_COMPLETED;
> > +		req->rq_state &=3D ~RQ_LOCAL_PENDING;
> > +
> > +		bio_put(req->private_bio);
> > +		req->private_bio =3D NULL;
> > +		dec_local(mdev);
> > +		if (bio_rw(req->master_bio) =3D=3D READA)	<<<=3D=3D=3D Bang!
> > +			/* it is legal to fail READA */
> > +			break;
>=20
> no. that is the master_bio (I should have used that in
> the other place as well). we cannot possibly have
> completed the master bio yet...
> anyways, unfortunately I did not yet really proofread
> neither test myself, obviously.  I'm currently more a
> road warrior, and not in a good position to test and
> debug stuff. I'll be back in the office/lab next week.
> and I guess phil is busy with customer stuff and
> getting the kernel-userland interface code in good
> shape again.
>=20
> > That's the only other one I found so far (by
> > inspection).
> >
> > Also - one other question -- do you have an update on
> > how much more you plan to do before stabilizing and
> > releasing the first official 8.0 version?
>=20
> not too much. we are basically "feature complete".
> it needs to be thouroughly tested and debugged now.
> there is no more structural or architechtural
> revolution pending, if that was your question.
> this request stuff just had to be done, I found it to
> be too hard to get right when it was spread all over
> the code.
>=20
> > I'd like to get 8.0 into my development community so
> > it can get wider testing but it's a bit hard at the
> > moment...
>=20
> I know. sorry about that. the storm should be over now :)
>=20
> well, the connector stuff is done, and should
> get some debugging and polish, we need to make sure it
> works for at least sles9 and rhel 4 and is straight
> forward to compile, install and package.
>=20
> we need to put in the conflict detection logic again,
> and get it really correct this time. those parts are
> currently marked with "missing code" and other
> comments. its "done in my head", I just have to write
> it down. there probably will be a side effect that
> might (hopefully) simplify the resynch code, and make
> it easier to get the resync code right when you have
> both nodes primary.
>=20
> and, well, get the remaining bugs out. actually, I had
> already been in this stage when I decided that it would
> be easier to restructur the request stuff first.
>=20
> cheers,
>=20
> --
> : Lars Ellenberg                                  Tel +43-1-8178292-55
> :
> : LINBIT Information Technologies GmbH            Fax +43-1-8178292-82
> :
> : Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com
> :
