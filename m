Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 812D9105AC58
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 12F2D2B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id O6rA3g0Q6Bgy for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E49892B7730
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:42 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1hYnLzP99dD0 for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:42 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BF3A42B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:42 +0100 (CET)
Resent-Message-ID: <20131220091642.GE31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:06:10 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <34369b05532be286682cad1591276af1d6b702fb.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 04/13] drivers: block: Mark the function as
 static in drbd_worker.c
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

Mark functions drbd_endio_read_sec_final(), drbd_send_barrier(),
need_to_send_barrier(), dequeue_work_batch(), dequeue_work_item() and
wait_for_work() as static in drbd/drbd_worker.c because they are not
used outside this file.

This eliminates the following warnings in drbd/drbd_worker.c:
drivers/block/drbd/drbd_worker.c:99:6: warning: no previous prototype for=
 =E2=80=98drbd_endio_read_sec_final=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_worker.c:1276:5: warning: no previous prototype f=
or =E2=80=98drbd_send_barrier=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_worker.c:1774:6: warning: no previous prototype f=
or =E2=80=98need_to_send_barrier=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_worker.c:1798:6: warning: no previous prototype f=
or =E2=80=98dequeue_work_batch=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_worker.c:1806:6: warning: no previous prototype f=
or =E2=80=98dequeue_work_item=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_worker.c:1815:6: warning: no previous prototype f=
or =E2=80=98wait_for_work=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_worker.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_w=
orker.c
index 891c0ec..2733ae3 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -96,7 +96,7 @@ void drbd_md_io_complete(struct bio *bio, int error)
 /* reads on behalf of the partner,
  * "submitted" by the receiver
  */
-void drbd_endio_read_sec_final(struct drbd_peer_request *peer_req) __rel=
eases(local)
+static void drbd_endio_read_sec_final(struct drbd_peer_request *peer_req=
) __releases(local)
 {
 	unsigned long flags =3D 0;
 	struct drbd_conf *mdev =3D peer_req->w.mdev;
@@ -1273,7 +1273,7 @@ int w_prev_work_done(struct drbd_work *w, int cance=
l)
  * and to be able to wait for them.
  * See also comment in drbd_adm_attach before drbd_suspend_io.
  */
-int drbd_send_barrier(struct drbd_tconn *tconn)
+static int drbd_send_barrier(struct drbd_tconn *tconn)
 {
 	struct p_barrier *p;
 	struct drbd_socket *sock;
@@ -1771,7 +1771,7 @@ void drbd_start_resync(struct drbd_conf *mdev, enum=
 drbd_conns side)
  * (because we have not yet seen new requests), we should send the
  * corresponding barrier now.  Must be checked within the same spinlock
  * that is used to check for new requests. */
-bool need_to_send_barrier(struct drbd_tconn *connection)
+static bool need_to_send_barrier(struct drbd_tconn *connection)
 {
 	if (!connection->send.seen_any_write_yet)
 		return false;
@@ -1795,7 +1795,7 @@ bool need_to_send_barrier(struct drbd_tconn *connec=
tion)
 	return true;
 }
=20
-bool dequeue_work_batch(struct drbd_work_queue *queue, struct list_head =
*work_list)
+static bool dequeue_work_batch(struct drbd_work_queue *queue, struct lis=
t_head *work_list)
 {
 	spin_lock_irq(&queue->q_lock);
 	list_splice_init(&queue->q, work_list);
@@ -1803,7 +1803,7 @@ bool dequeue_work_batch(struct drbd_work_queue *que=
ue, struct list_head *work_li
 	return !list_empty(work_list);
 }
=20
-bool dequeue_work_item(struct drbd_work_queue *queue, struct list_head *=
work_list)
+static bool dequeue_work_item(struct drbd_work_queue *queue, struct list=
_head *work_list)
 {
 	spin_lock_irq(&queue->q_lock);
 	if (!list_empty(&queue->q))
@@ -1812,7 +1812,7 @@ bool dequeue_work_item(struct drbd_work_queue *queu=
e, struct list_head *work_lis
 	return !list_empty(work_list);
 }
=20
-void wait_for_work(struct drbd_tconn *connection, struct list_head *work=
_list)
+static void wait_for_work(struct drbd_tconn *connection, struct list_hea=
d *work_list)
 {
 	DEFINE_WAIT(wait);
 	struct net_conf *nc;
--=20
1.7.9.5

