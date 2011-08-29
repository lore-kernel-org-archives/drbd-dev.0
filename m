Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EDF2D10003D7
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 18:07:50 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Greg Freemyer <greg.freemyer@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Mon, 29 Aug 2011 18:07:43 +0200
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<201108291346.29847.philipp.reisner@linbit.com>
	<CAGpXXZK4wSCoVfyGpwt7ygN_8mqQ1cNzuVD4XsWXunJzUvEX+g@mail.gmail.com>
In-Reply-To: <CAGpXXZK4wSCoVfyGpwt7ygN_8mqQ1cNzuVD4XsWXunJzUvEX+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201108291807.43402.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
	support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 29. August 2011, 15:26:16 schrieb Greg Freemyer:
> On Mon, Aug 29, 2011 at 7:46 AM, Philipp Reisner
>=20
> <philipp.reisner@linbit.com> wrote:
> > Am Freitag, 26. August 2011, 15:20:51 schrieb Greg Freemyer:
> >> On Thu, Aug 25, 2011 at 11:06 AM, Philipp Reisner <
> >>=20
> >> philipp.reisner@linbit.com> wrote:
> >> > This the first request for review of drbd-8.4. The complete set has
> >> > 500 patches. In this first series there are only 118 of these.
> >>=20
> >> Lars,
> >>=20
> >> I've only taken a quick glance, but is drbd functional between applying
> >> each patch?
> >>=20
> >> It doesn't look like it to me, but I didn't look that close.  I also s=
aw
> >> at least one patch that introduced a new function with no caller to
> >> test it.
> >>=20
> >> The idea is that a patch series leave a testable / functional kernel
> >> after each patch in the series is applied sequentially.
> >>=20
> >> That is the only way git bisect can do its job.
> >>=20
> >> ie. Introducing a new function but no new caller makes a change, but
> >> there is no way to test it.  Therefore there is no real value in not
> >> merging that patch with one that has the new call in it.
> >=20
> > Greg,
> >=20
> > You replied to mail 000. Please point out to which patch/function you
> > refer, so that we can fix this.
> >=20
> > Best,
> >  Phil
>=20
> Phillip,
>=20
> Take a look at patch 115 of 118 in your series.  I did not review the
> whole series, I just poked around briefly and noticed this one.
>=20
> Greg

Ok, I merged 115 into 117, that gives a new 116:

=46rom dbe9017ffee428c11cbbf4243fbcf9ed633d7b82 Mon Sep 17 00:00:00 2001
=46rom: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 15 Feb 2011 11:09:33 +0100
Subject: [PATCH 116/117] drbd: implemented receiving of P_CONN_ST_CHG_REQ

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
=2D--
 drivers/block/drbd/drbd_int.h      |    1 +
 drivers/block/drbd/drbd_main.c     |   10 ++++++++++
 drivers/block/drbd/drbd_receiver.c |   10 ++++++++--
 drivers/block/drbd/drbd_state.h    |    1 +
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 0cf5196..26ea665 100644
=2D-- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1219,6 +1219,7 @@ extern int drbd_send_ov_request(struct drbd_conf *mde=
v,sector_t=20
sector,int size)
 extern int drbd_send_bitmap(struct drbd_conf *mdev);
 extern int _drbd_send_bitmap(struct drbd_conf *mdev);
 extern int drbd_send_sr_reply(struct drbd_conf *mdev, enum drbd_state_rv r=
etcode);
+extern int conn_send_sr_reply(struct drbd_tconn *tconn, enum drbd_state_rv=
 retcode);
 extern void drbd_free_bc(struct drbd_backing_dev *ldev);
 extern void drbd_mdev_cleanup(struct drbd_conf *mdev);
 void drbd_print_uuids(struct drbd_conf *mdev, const char *text);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index d8fd6dd..910dff7 100644
=2D-- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -990,6 +990,16 @@ int drbd_send_sr_reply(struct drbd_conf *mdev, enum dr=
bd_state_rv=20
retcode)
        return drbd_send_cmd(mdev, USE_META_SOCKET, P_STATE_CHG_REPLY, &p.h=
ead, sizeof(p));
 }
=20
+int conn_send_sr_reply(struct drbd_tconn *tconn, enum drbd_state_rv retcod=
e)
+{
+       struct p_req_state_reply p;
+       enum drbd_packet cmd =3D tconn->agreed_pro_version < 100 ? P_STATE_=
CHG_REPLY :=20
P_CONN_ST_CHG_REPLY;
+
+       p.retcode    =3D cpu_to_be32(retcode);
+
+       return conn_send_cmd(tconn, 0, USE_META_SOCKET, cmd, &p.head, sizeo=
f(p));
+}
+
 int fill_bitmap_rle_bits(struct drbd_conf *mdev,
        struct p_compressed_bm *p,
        struct bm_xfer_ctx *c)
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_r=
eceiver.c
index bdd3f00..e346245 100644
=2D-- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3235,9 +3235,14 @@ static int receive_req_state(struct drbd_conf *mdev,=
 enum=20
drbd_packet cmd,
        mask =3D convert_state(mask);
        val =3D convert_state(val);
=20
=2D       rv =3D drbd_change_state(mdev, CS_VERBOSE, mask, val);
+       if (cmd =3D=3D P_CONN_ST_CHG_REQ) {
+               rv =3D conn_request_state(mdev->tconn, mask, val, CS_VERBOS=
E |=20
CS_LOCAL_ONLY);
+               conn_send_sr_reply(mdev->tconn, rv);
+       } else {
+               rv =3D drbd_change_state(mdev, CS_VERBOSE, mask, val);
+               drbd_send_sr_reply(mdev, rv);
+       }
=20
=2D       drbd_send_sr_reply(mdev, rv);
        drbd_md_sync(mdev);
=20
        return true;
@@ -3771,6 +3776,7 @@ static struct data_cmd drbd_cmd_handler[] =3D {
        [P_CSUM_RS_REQUEST] =3D { 1, sizeof(struct p_block_req), receive_Da=
taRequest },
        [P_DELAY_PROBE]     =3D { 0, sizeof(struct p_delay_probe93), receiv=
e_skip },
        [P_OUT_OF_SYNC]     =3D { 0, sizeof(struct p_block_desc), receive_o=
ut_of_sync },
+       [P_CONN_ST_CHG_REQ] =3D { 0, sizeof(struct p_req_state), receive_re=
q_state },
        /* anything missing from this table is in
         * the asender_tbl, see get_asender_cmd */
        [P_MAX_CMD]         =3D { 0, 0, NULL },
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_stat=
e.h
index d312d84..5fdbdf0 100644
=2D-- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -63,6 +63,7 @@ enum chg_state_flags {
        CS_SERIALIZE    =3D 8,
        CS_ORDERED      =3D CS_WAIT_COMPLETE + CS_SERIALIZE,
        CS_NO_CSTATE_CHG =3D 16, /* Do not display changes in cstate. Inter=
nal to=20
drbd_state.c */
+       CS_LOCAL_ONLY =3D 32, /* Do not consider a device pair wide state c=
hange */
 };
=20
 extern enum drbd_state_rv drbd_change_state(struct drbd_conf *mdev,
=2D-=20
1.7.4.1

=2D-=20
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
