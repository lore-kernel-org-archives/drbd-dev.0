Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DF4611057FAD
	for <drbd-dev@lists.linbit.com>; Mon, 10 Apr 2017 14:45:21 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id y18so8508641wmh.0
	for <drbd-dev@lists.linbit.com>; Mon, 10 Apr 2017 05:45:21 -0700 (PDT)
Received: from soda.linbit ([217.196.73.213]) by smtp.gmail.com with ESMTPSA id
	n6sm17334305wrb.62.2017.04.10.05.45.20
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 10 Apr 2017 05:45:20 -0700 (PDT)
Resent-Message-ID: <20170410124519.GD29829@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D3E32105633D
	for <drbd-dev@lists.linbit.com>; Mon, 10 Apr 2017 04:23:43 +0200 (CEST)
From: NeilBrown <neilb@suse.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon, 10 Apr 2017 12:06:30 +1000
Message-ID: <87mvbpxbh5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drdb: don't check for failure from
	mempool_alloc()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


mempool_alloc() cannot fail if the gfp flags allow
it to sleep, and GFP_NOIO allows for sleeping.
So drbd_req_new() cannot fail, and drbd_request_prepare() doesn't need
to check if it did.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 drivers/block/drbd/drbd_req.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 652114ae1a8a..2e796f79b324 100644
=2D-- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -52,8 +52,6 @@ static struct drbd_request *drbd_req_new(struct drbd_devi=
ce *device, struct bio
 	struct drbd_request *req;
=20
 	req =3D mempool_alloc(drbd_request_mempool, GFP_NOIO);
=2D	if (!req)
=2D		return NULL;
 	memset(req, 0, sizeof(*req));
=20
 	drbd_req_make_private_bio(req, bio_src);
@@ -1214,15 +1212,6 @@ drbd_request_prepare(struct drbd_device *device, str=
uct bio *bio, unsigned long
=20
 	/* allocate outside of all locks; */
 	req =3D drbd_req_new(device, bio);
=2D	if (!req) {
=2D		dec_ap_bio(device);
=2D		/* only pass the error to the upper layers.
=2D		 * if user cannot handle io errors, that's not our business. */
=2D		drbd_err(device, "could not kmalloc() req\n");
=2D		bio->bi_error =3D -ENOMEM;
=2D		bio_endio(bio);
=2D		return ERR_PTR(-ENOMEM);
=2D	}
 	req->start_jif =3D start_jif;
=20
 	if (!get_ldev(device)) {
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAljq6KYACgkQOeye3VZi
gbluOQ//VUeQ0kFn8y8cJqJOUcqch2ysOU1XxP5kSdyhyXeKeRQuPsSxHH7GlCjY
6h2ZpaN02xS6dRSSf7YNCki6lHQyhWBv8IJ2+IGkZjQIaC9cL4yeSJDtF4rS56pn
njf6m980TBpvLTO9gvh4PjlbBsIcFCxLaMC9tRr0Mm7hymEsd/NPi+AAA4/ytHl1
QJBbku2B7g7QBilORM87Q+TXYiyK31G5EPtnOBzlf3LHrBA2R/ZLBGrJEKWRxzL0
W7w9Zi+81K8BYPqGOE74wxJjY/rfuBBPTwqYtiEULwgLTFXtNBXJ5igTZ+zzxzvQ
6PtWOymX6Csik0iQNXTRyY8Uh0YOm4eU7YHNXvtilyUtQuJzeAA+DI9MDTrl5Csj
nx7xAy4QVjhhm0ZHFX5py5RglEobtprVqABYkUdgrSXYVtsmRDLFH+keiuC6pmTw
t6+nhanEcUZ8BQeKbH3sM2lp1IqpSZHwYknXZhsOz2GPU2NujAzha7GQeCAgppMW
evtWUTRM5+R4E6SJdev77kVJ/RyJZfxNGXFxuJeGABP8CYJrch+H8bnDpak96VoC
0Hspkc41fktx/jk/awntociloraDhgpPkMvBI48nc7KY8auPT9VQpnw3MQKen4Zw
h48z5QoDC1NX97vyB++S2LX8MluZyUPjWDiRMnbJJeFDe9Yzc5w=
=6+jF
-----END PGP SIGNATURE-----
--=-=-=--
