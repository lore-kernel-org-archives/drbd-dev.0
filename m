Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 (My) first problem with new requests
	handlingcode...
Date: Mon, 11 Sep 2006 11:32:45 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B00A0@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> and, as the comment at the head of _req_mod says: we probably should
> split the case branches out into "STATIC" functions, and only have the
> _req_mod dispatch, or even remove the _req_mod switch statement again,
> and only have the branch functions...
>=20
> otherwise, what do you thin/have found out about that monster patch?
>=20

Well, since I haven't been able to boot my system yet I don't have any
real experience yet but I really like the idea of centralizing the
request handling -- if the code for the various cases could be moved
into separate routines in drbd_req.c, I think you COULD revert to an
inline top-level function containing just the case statement and the
calls to the various non-inline functions -- the compiler ought to be
able to nicely optimize this and only include the specific case(s) for
the type argument which would translate to direct calls to the per-case
routines...

I see you committed a change to the problem I reported and also to
remove the inline of the function for which I thank you!

BTW - there is another case of accessing a NULL bio pointer in the
read_completed_with_error case:

+	case read_completed_with_error:
+		drbd_set_out_of_sync(mdev,req->sector,req->size);
+		req->rq_state |=3D RQ_LOCAL_COMPLETED;
+		req->rq_state &=3D ~RQ_LOCAL_PENDING;
+
+		bio_put(req->private_bio);
+		req->private_bio =3D NULL;
+		dec_local(mdev);
+		if (bio_rw(req->master_bio) =3D=3D READA)	<<<=3D=3D=3D Bang!
+			/* it is legal to fail READA */
+			break;

That's the only other one I found so far (by inspection).

Also - one other question -- do you have an update on how much more you
plan to do before stabilizing and releasing the first official 8.0
version? I'd like to get 8.0 into my development community so it can get
wider testing but it's a bit hard at the moment...

Thanks for all the hard work,
Simon

