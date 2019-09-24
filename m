Return-Path: <NWang@suse.com>
Received: from m9a0003g.houston.softwaregrp.com
	(m9a0003g.houston.softwaregrp.com [15.124.64.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 776634200BE
	for <drbd-dev@lists.linbit.com>; Tue, 24 Sep 2019 11:24:28 +0200 (CEST)
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY
	m9a0003g.houston.softwaregrp.com WITH ESMTP
	FOR drbd-dev@lists.linbit.com; Tue, 24 Sep 2019 09:23:49 +0000
From: Nick Wang <NWang@suse.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Date: Tue, 24 Sep 2019 07:37:37 +0000
Message-ID: <20190924073719.9240-1-nwang@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	Nick Wang <NWang@suse.com>
Subject: [Drbd-dev] [PATCH] pacemaker: fix the outdate return value of
	updating cib
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

pcmk_err_old_data(205) is internal return value for error
"Update was older than existing configuration" of cibadmin.
CRM will return CRM_EX_OLD(103) to fence-peer instead.

Refer to "lib/common/results.c" of pacemaker for the value.

Signed-off-by: Nick Wang <nwang@suse.com>
---
 scripts/crm-fence-peer.9.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/crm-fence-peer.9.sh b/scripts/crm-fence-peer.9.sh
index 0417c7aa..a4522a2a 100755
--- a/scripts/crm-fence-peer.9.sh
+++ b/scripts/crm-fence-peer.9.sh
@@ -146,7 +146,7 @@ create_or_modify_constraint()
 			break
 			;;
=20
-		205)	: "205 aka pcmk_err_old_data =3D=3D> going to retry in a bit"
+		103)	: "103 CRM_EX_OLD, aka 205 pcmk_err_old_data =3D=3D> going to retry=
 in a bit"
 			(( $SECONDS >=3D $timeout )) && break
 			sleep 1
 			continue
--=20
2.16.4

