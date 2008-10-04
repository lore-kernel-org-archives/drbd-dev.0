Return-Path: <ivoks@ubuntu.com>
Received: from master.grad.hr (master.grad.hr [161.53.50.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9372E2DF626E
	for <drbd-dev@lists.linbit.com>; Sat,  4 Oct 2008 20:55:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by master.grad.hr (Postfix) with ESMTP id AF849494181
	for <drbd-dev@lists.linbit.com>; Sat,  4 Oct 2008 20:45:44 +0200 (CEST)
Received: from master.grad.hr ([127.0.0.1])
	by localhost (master.grad.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c30VQW+uOmTz for <drbd-dev@lists.linbit.com>;
	Sat,  4 Oct 2008 20:45:44 +0200 (CEST)
Received: from titanium (4-165.dsl.iskon.hr [89.164.4.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by master.grad.hr (Postfix) with ESMTPSA id 3815A49417B
	for <drbd-dev@lists.linbit.com>; Sat,  4 Oct 2008 20:45:44 +0200 (CEST)
Date: Sat, 4 Oct 2008 20:45:42 +0200
From: Ante Karamatic <ivoks@ubuntu.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20081004204542.75781d17@titanium>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Nui=ch7+/H8v2Axid+bSxy1"
Subject: [Drbd-dev] Compatibility with 2.6.27
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--MP_/Nui=ch7+/H8v2Axid+bSxy1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

In 2.6.27, CN_IDX 0x4 is taken by v86d. Since this ID is used by drbd
also, in some cases (when vesafb is loaded) drbd can't be loaded into
kernel and vice versa.

This patch changes CN_IDX_DRBD to 0x6, which is free atm. This, of
course, could change in future, and should be watched for. Other option
would be to contact upstream and request an ID for drbd.

Take care

--=20
Ante Karamati=C4=87, ivoks@ubuntu.com
Ubuntu Server Team

--MP_/Nui=ch7+/H8v2Axid+bSxy1
Content-Type: text/x-patch; name=cn_idx_drbd.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cn_idx_drbd.patch

From c18caf1c9596251c12c3de5e03a71c5ea804228a Mon Sep 17 00:00:00 2001
From: Ante Karamatic <ivoks@ubuntu.com>
Date: Sat, 4 Oct 2008 20:22:46 +0200
Subject: [PATCH] Changed CN_IDX_DRBD to 0x6, since 0x4 is already occupied by v86d in
 Linux kernel.

---
 drbd/linux/drbd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drbd/linux/drbd.h b/drbd/linux/drbd.h
index d43df52..56fe673 100644
--- a/drbd/linux/drbd.h
+++ b/drbd/linux/drbd.h
@@ -343,7 +343,7 @@ enum UuidIndex {
 
 /* The following line should be moved over to linux/connector.h
  * when the time comes */
-#define CN_IDX_DRBD			0x4
+#define CN_IDX_DRBD			0x6
 #define CN_VAL_DRBD			0x1
 
 struct drbd_nl_cfg_req {
-- 
1.5.6.3


--MP_/Nui=ch7+/H8v2Axid+bSxy1--
