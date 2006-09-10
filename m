Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Sep 2006 18:58:32 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038AFF9F@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 (My) first problem with new requests handling
	code...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Got a pretty quick death running the latest trunk - I think it's this
code in the completed_ok case of _req_done:

		bio_put(req->private_bio);
		req->private_bio =3D NULL;	<<=3D=3D=3D Whoops!
		dec_local(mdev);

		if (bio_data_dir(req->private_bio) =3D=3D WRITE)  <<=3D=3D=3D
BANG!
			mdev->writ_cnt +=3D req->size>>9;
		else
			mdev->read_cnt +=3D req->size>>9;

Presumably the bio_put and clear of req->private_bio should be after
testing the direction ;-)

BTW: It took me quite a while to find this from the panic -- it actually
crashed in drbd_endio_pri and the code generated for this is humungous
and unbelievably complicated (it's about 12KB!) -- I wonder if you are
trying to inline too much and it mightn't be better to have req_mod be a
non-inline function and also have each case be a separate real
function... I'd even suggest having _req_may_be_done() as a separate
function.

Simon
