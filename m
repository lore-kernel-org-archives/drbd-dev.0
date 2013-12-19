Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C79AC105AC58
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C0D552B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:44 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id mwKhaJPdkUls for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A0BDD2B7730
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:44 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sqqmT-pHmP0n for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:44 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7EB502B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:44 +0100 (CET)
Resent-Message-ID: <20131220091644.GG31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:11:09 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <fe63e86117a10a434e59db1222b3b08b015551a2.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 06/13] drivers: block: Mark functions as static
 in drbd_receiver.c
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

Mark functions conn_wait_active_ee_empty() and
drbd_crypto_alloc_digest_safe() as static in drbd/drbd_receiver.c
because they are not used outside this file.

This eliminates the following warning in drbd/drbd_receiver.c:
drivers/block/drbd/drbd_receiver.c:1401:6: warning: no previous prototype=
 for =E2=80=98conn_wait_active_ee_empty=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_receiver.c:3259:21: warning: no previous prototyp=
e for =E2=80=98drbd_crypto_alloc_digest_safe=E2=80=99 [-Wmissing-prototyp=
es]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_receiver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
index 6fa6673..c31c7a2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1398,7 +1398,7 @@ static void drbd_remove_epoch_entry_interval(struct=
 drbd_conf *mdev,
 		wake_up(&mdev->misc_wait);
 }
=20
-void conn_wait_active_ee_empty(struct drbd_tconn *tconn)
+static void conn_wait_active_ee_empty(struct drbd_tconn *tconn)
 {
 	struct drbd_conf *mdev;
 	int vnr;
@@ -3256,6 +3256,7 @@ disconnect:
  * return: NULL (alg name was "")
  *         ERR_PTR(error) if something goes wrong
  *         or the crypto hash ptr, if it worked out ok. */
+static
 struct crypto_hash *drbd_crypto_alloc_digest_safe(const struct drbd_conf=
 *mdev,
 		const char *alg, const char *name)
 {
--=20
1.7.9.5

