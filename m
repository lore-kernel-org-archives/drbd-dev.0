Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 035C8105AC57
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F21D12B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:36 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id hCeGR65boojb for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D12022B772F
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:36 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VpbUCirDOAOT for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:36 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B170E2B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:36 +0100 (CET)
Resent-Message-ID: <20131220091636.GD31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:04:47 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <1c21b4a9a0d6c82e201d6e1ee8336414caa56c60.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 03/13] drivers: block: Mark function
 seq_printf_with_thousands_grouping() as static in drbd_proc.c
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

Mark function seq_printf_with_thousands_grouping() as static in
drbd/drbd_proc.c because it is not used outside this file.

This eliminates the following warning in drbd/drbd_proc.c:
drivers/block/drbd/drbd_proc.c:49:6: warning: no previous prototype for =E2=
=80=98seq_printf_with_thousands_grouping=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_pro=
c.c
index bf31d41..84fbe33 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -46,7 +46,7 @@ const struct file_operations drbd_proc_fops =3D {
 	.release	=3D drbd_proc_release,
 };
=20
-void seq_printf_with_thousands_grouping(struct seq_file *seq, long v)
+static void seq_printf_with_thousands_grouping(struct seq_file *seq, lon=
g v)
 {
 	/* v is in kB/sec. We don't expect TiByte/sec yet. */
 	if (unlikely(v >=3D 1000000)) {
--=20
1.7.9.5

