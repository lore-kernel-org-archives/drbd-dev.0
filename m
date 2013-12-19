Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 191D2105B0A1
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C24362B7731
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fgTBTdFqo2TU for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AB7B82B7733
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:46 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DQTZlkyAX76P for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:46 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8E6752B7731
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:46 +0100 (CET)
Resent-Message-ID: <20131220091646.GI31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:12:27 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <bed1e9bacd23651dac1fdcc20049fe9f930c804b.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 07/13] drivers: block: Mark functions as static
	in drbd_req.c
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

Mark functions drbd_request_prepare() and find_oldest_request() as
static in drbd/drbd_req.c because they are not used outside this file.

This eliminates the following warnings in drbd/drbd_req.c:
drivers/block/drbd/drbd_req.c:1037:1: warning: no previous prototype for =
=E2=80=98drbd_request_prepare=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_req.c:1323:22: warning: no previous prototype for=
 =E2=80=98find_oldest_request=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_req.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.=
c
index fec7bef..771697b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1033,7 +1033,7 @@ static void drbd_queue_write(struct drbd_conf *mdev=
, struct drbd_request *req)
  * request on the submitter thread.
  * Returns ERR_PTR(-ENOMEM) if we cannot allocate a drbd_request.
  */
-struct drbd_request *
+static struct drbd_request *
 drbd_request_prepare(struct drbd_conf *mdev, struct bio *bio, unsigned l=
ong start_time)
 {
 	const int rw =3D bio_data_dir(bio);
@@ -1320,7 +1320,7 @@ int drbd_merge_bvec(struct request_queue *q, struct=
 bvec_merge_data *bvm, struct
 	return limit;
 }
=20
-struct drbd_request *find_oldest_request(struct drbd_tconn *tconn)
+static struct drbd_request *find_oldest_request(struct drbd_tconn *tconn=
)
 {
 	/* Walk the transfer log,
 	 * and find the oldest not yet completed request */
--=20
1.7.9.5

