Return-Path: <NWang@suse.com>
Received: from m9a0014g.houston.softwaregrp.com
	(m9a0014g.houston.softwaregrp.com [15.124.64.90])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C6E7A420120
	for <drbd-dev@lists.linbit.com>; Wed, 11 Dec 2019 09:25:58 +0100 (CET)
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY
	m9a0014g.houston.softwaregrp.com WITH ESMTP
	FOR drbd-dev@lists.linbit.com; Wed, 11 Dec 2019 08:25:16 +0000
From: Nick Wang <NWang@suse.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Date: Wed, 11 Dec 2019 08:06:23 +0000
Message-ID: <20191211080601.32276-1-nwang@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Nick Wang <NWang@suse.com>
Subject: [Drbd-dev] [PATCH] drbd: fix zero metadata limit by misaligned with
	page size
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Metadata is aligned on 4k blocks, which is ok for x86 platform.
But may cause a result of zero page with PPC64LE or ARM with
64k page size.

And calculate effective bytes directly from sector size.

Error log:
...
drbd0: Device size clipped from 2097016s to 0s due to metadata size
...

Signed-off-by: Nick Wang <nwang@suse.com>

CC: drbd-dev@lists.linbit.com

---
 drbd/drbd_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index a7294639..336a4177 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -5589,8 +5589,7 @@ u64 directly_connected_nodes(struct drbd_resource *re=
source, enum which_state wh
=20
 static sector_t bm_sect_to_max_capacity(unsigned int bm_max_peers, sector_=
t bm_sect)
 {
-	u64 bm_pages =3D bm_sect >> (PAGE_SHIFT - SECTOR_SHIFT);
-	u64 bm_bytes =3D bm_pages << PAGE_SHIFT;
+	u64 bm_bytes =3D bm_sect << SECTOR_SHIFT;
 	u64 bm_bytes_per_peer =3D div_u64(bm_bytes, bm_max_peers);
 	u64 bm_bits_per_peer =3D bm_bytes_per_peer * BITS_PER_BYTE;
 	return BM_BIT_TO_SECT(bm_bits_per_peer);
--=20
2.16.4

