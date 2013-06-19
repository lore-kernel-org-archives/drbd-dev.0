Return-Path: <koverstreet@google.com>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
	[209.85.160.45]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 63C9E1057D3D
	for <drbd-dev@lists.linbit.com>; Wed, 19 Jun 2013 02:03:05 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so4442927pbc.4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2013 17:03:03 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: akpm@linux-foundation.org, tj@kernel.org, axboe@kernel.dk,
	nab@linux-iscsi.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2013 17:02:27 -0700
Message-Id: <1371600150-23557-8-git-send-email-koverstreet@google.com>
In-Reply-To: <1371600150-23557-1-git-send-email-koverstreet@google.com>
References: <1371600150-23557-1-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: James Smart <james.smart@emulex.com>, Wolfram Sang <wsa@the-dreams.de>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
	Kent Overstreet <koverstreet@google.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Anil Gurumurthy <agurumur@brocade.com>,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	David Howells <dhowells@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@canonical.com>,
	dm-devel@redhat.com, "Hans J. Koch" <hjk@hansjkoch.de>,
	Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Sean Hefty <sean.hefty@intel.com>, Michel Lespinasse <walken@google.com>,
	Dan Magenheimer <dan.magenheimer@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Chas Williams <chas@cmf.nrl.navy.mil>, Willem Riede <osst@riede.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	Vinod Koul <vinod.koul@intel.com>, Dmitry Torokhov <dtor@vmware.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Eduardo Valentin <eduardo.valentin@ti.com>,
	Christine Caulfield <ccaulfie@redhat.com>,
	Li Zefan <lizefan@huawei.com>, Alon Levy <alevy@redhat.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Doug Gilbert <dgilbert@interlog.com>,
	Grant Likely <grant.likely@linaro.org>, Dave Airlie <airlied@redhat.com>,
	Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Rik van Riel <riel@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>,
	Roland Dreier <roland@kernel.org>,
	Tatyana Nikolova <Tatyana.E.Nikolova@intel.com>,
	Alex Dubov <oakad@yahoo.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steve Wise <swise@chelsio.com>, Thomas Hellstrom <thellstrom@vmware.com>,
	Mark Fasheh <mfasheh@suse.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Vijaya Mohan Guvva <vmohan@brocade.com>, Inki Dae <inki.dae@samsung.com>,
	Mike Marciniszyn <infinipath@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Hoang-Nam Nguyen <hnguyen@de.ibm.com>, Joel Becker <jlbec@evilplan.org>,
	Sasha Levin <sasha.levin@oracle.com>,
	Omar Ramirez Luna <omar.ramirez@copitl.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <davidlohr.bueso@hp.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Haggai Eran <haggaie@mellanox.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Eric Dumazet <edumazet@google.com>, Masanari Iida <standby24x7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
	Erez Shitrit <erezsh@mellanox.co.il>, Brian Paul <brianp@vmware.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Anton Vorontsov <cbou@mail.ru>, Kyungmin Park <kyungmin.park@samsung.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>, Arnd Bergmann <arnd@arndb.de>,
	Tim Gardner <tim.gardner@canonical.com>,
	Dan Williams <djbw@fb.com>, David Teigland <teigland@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andy Grover <agrover@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>, Guo Chao <yan@linux.vnet.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [Drbd-dev] [PATCH 07/10] idr: Rename idr_alloc() ->
	idr_alloc_range()
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

Then also add an idr_alloc() wrapper, without the start/end arguments -
for consistency with the ida interfaces.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Roland Dreier <roland@kernel.org>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Steve Wise <swise@chelsio.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>
Cc: Mike Marciniszyn <infinipath@intel.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Vorontsov <cbou@mail.ru>
Cc: Rodolfo Giometti <giometti@enneenne.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Anil Gurumurthy <agurumur@brocade.com>
Cc: Vijaya Mohan Guvva <vmohan@brocade.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: James Smart <james.smart@emulex.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Willem Riede <osst@riede.org>
Cc: "Kai Mäkisara" <Kai.Makisara@kolumbus.fi>
Cc: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Christine Caulfield <ccaulfie@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Mark Fasheh <mfasheh@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Alon Levy <alevy@redhat.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Brian Paul <brianp@vmware.com>
Cc: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: Dmitry Torokhov <dtor@vmware.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Erez Shitrit <erezsh@mellanox.co.il>
Cc: Tatyana Nikolova <Tatyana.E.Nikolova@intel.com>
Cc: Haggai Eran <haggaie@mellanox.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Magenheimer <dan.magenheimer@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andy Grover <agrover@redhat.com>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Tim Gardner <tim.gardner@canonical.com>
Cc: Davidlohr Bueso <davidlohr.bueso@hp.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Michel Lespinasse <walken@google.com>
---
 block/bsg.c                                |  2 +-
 block/genhd.c                              |  2 +-
 drivers/atm/nicstar.c                      |  4 ++--
 drivers/block/drbd/drbd_main.c             |  4 ++--
 drivers/block/loop.c                       |  4 ++--
 drivers/dca/dca-sysfs.c                    |  2 +-
 drivers/dma/dmaengine.c                    |  2 +-
 drivers/firewire/core-cdev.c               |  3 +--
 drivers/firewire/core-device.c             |  2 +-
 drivers/gpio/gpiolib.c                     |  2 +-
 drivers/gpu/drm/drm_context.c              |  2 +-
 drivers/gpu/drm/drm_crtc.c                 |  2 +-
 drivers/gpu/drm/drm_gem.c                  |  4 ++--
 drivers/gpu/drm/drm_stub.c                 |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c    |  2 +-
 drivers/gpu/drm/i915/i915_gem_context.c    |  2 +-
 drivers/gpu/drm/qxl/qxl_cmd.c              |  2 +-
 drivers/gpu/drm/qxl/qxl_release.c          |  2 +-
 drivers/gpu/drm/sis/sis_mm.c               |  2 +-
 drivers/gpu/drm/via/via_mm.c               |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c   |  2 +-
 drivers/i2c/i2c-core.c                     |  4 ++--
 drivers/infiniband/core/cm.c               |  2 +-
 drivers/infiniband/core/cma.c              |  2 +-
 drivers/infiniband/core/sa_query.c         |  2 +-
 drivers/infiniband/core/ucm.c              |  2 +-
 drivers/infiniband/core/ucma.c             |  4 ++--
 drivers/infiniband/core/uverbs_cmd.c       |  2 +-
 drivers/infiniband/hw/cxgb3/iwch.h         |  2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h     |  2 +-
 drivers/infiniband/hw/ehca/ehca_cq.c       |  2 +-
 drivers/infiniband/hw/ehca/ehca_qp.c       |  2 +-
 drivers/infiniband/hw/ipath/ipath_driver.c |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c |  2 +-
 drivers/infiniband/hw/qib/qib_init.c       |  2 +-
 drivers/md/dm.c                            |  4 ++--
 drivers/memstick/core/memstick.c           |  2 +-
 drivers/memstick/core/mspro_block.c        |  2 +-
 drivers/mfd/rtsx_pcr.c                     |  2 +-
 drivers/misc/c2port/core.c                 |  2 +-
 drivers/misc/tifm_core.c                   |  2 +-
 drivers/mmc/core/host.c                    |  2 +-
 drivers/mtd/mtdcore.c                      |  2 +-
 drivers/net/macvtap.c                      |  2 +-
 drivers/net/ppp/ppp_generic.c              |  4 ++--
 drivers/power/bq2415x_charger.c            |  2 +-
 drivers/power/bq27x00_battery.c            |  2 +-
 drivers/power/ds2782_battery.c             |  2 +-
 drivers/pps/kapi.c                         |  2 +-
 drivers/pps/pps.c                          |  4 ++--
 drivers/remoteproc/remoteproc_core.c       |  2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c           |  4 ++--
 drivers/scsi/bfa/bfad_im.c                 |  2 +-
 drivers/scsi/ch.c                          |  2 +-
 drivers/scsi/lpfc/lpfc_init.c              |  2 +-
 drivers/scsi/sg.c                          |  2 +-
 drivers/scsi/st.c                          |  2 +-
 drivers/staging/tidspbridge/rmgr/drv.c     |  4 ++--
 drivers/staging/zcache/ramster/tcp.c       |  2 +-
 drivers/target/iscsi/iscsi_target.c        |  2 +-
 drivers/target/iscsi/iscsi_target_login.c  |  2 +-
 drivers/thermal/cpu_cooling.c              |  2 +-
 drivers/thermal/thermal_core.c             |  2 +-
 drivers/uio/uio.c                          |  2 +-
 drivers/vfio/vfio.c                        |  2 +-
 fs/dlm/lock.c                              |  2 +-
 fs/dlm/recover.c                           |  2 +-
 fs/nfs/nfs4client.c                        |  2 +-
 fs/ocfs2/cluster/tcp.c                     |  2 +-
 include/linux/idr.h                        |  7 ++++++-
 ipc/util.c                                 |  2 +-
 kernel/cgroup.c                            |  2 +-
 kernel/events/core.c                       |  2 +-
 kernel/workqueue.c                         |  4 ++--
 lib/idr.c                                  | 32 +++++++++++++++---------------
 net/9p/util.c                              |  2 +-
 net/mac80211/tx.c                          |  2 +-
 77 files changed, 109 insertions(+), 105 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 420a5a9..fc13d24 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -1016,7 +1016,7 @@ int bsg_register_queue(struct request_queue *q, struct device *parent,
 
 	mutex_lock(&bsg_mutex);
 
-	ret = idr_alloc(&bsg_minor_idr, bcd, 0, BSG_MAX_DEVS, GFP_KERNEL);
+	ret = idr_alloc_range(&bsg_minor_idr, bcd, 0, BSG_MAX_DEVS, GFP_KERNEL);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			printk(KERN_ERR "bsg: too many bsg devices\n");
diff --git a/block/genhd.c b/block/genhd.c
index 20625ee..1094d41 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -421,7 +421,7 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 
 	/* allocate ext devt */
 	mutex_lock(&ext_devt_mutex);
-	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_KERNEL);
+	idx = idr_alloc_range(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_KERNEL);
 	mutex_unlock(&ext_devt_mutex);
 	if (idx < 0)
 		return idx == -ENOSPC ? -EBUSY : idx;
diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 6587dc2..0a735d6 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -1025,11 +1025,11 @@ static void push_rxbufs(ns_dev * card, struct sk_buff *skb)
 				card->lbfqc += 2;
 		}
 
-		id1 = idr_alloc(&card->idr, handle1, 0, 0, GFP_ATOMIC);
+		id1 = idr_alloc(&card->idr, handle1, GFP_ATOMIC);
 		if (id1 < 0)
 			goto out;
 
-		id2 = idr_alloc(&card->idr, handle2, 0, 0, GFP_ATOMIC);
+		id2 = idr_alloc(&card->idr, handle2, GFP_ATOMIC);
 		if (id2 < 0)
 			goto out;
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b84e4b2..98b232c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2675,7 +2675,7 @@ enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor,
 	mdev->read_requests = RB_ROOT;
 	mdev->write_requests = RB_ROOT;
 
-	minor_got = idr_alloc(&minors, mdev, minor, minor + 1, GFP_KERNEL);
+	minor_got = idr_alloc_range(&minors, mdev, minor, minor + 1, GFP_KERNEL);
 	if (minor_got < 0) {
 		if (minor_got == -ENOSPC) {
 			err = ERR_MINOR_EXISTS;
@@ -2684,7 +2684,7 @@ enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor,
 		goto out_no_minor_idr;
 	}
 
-	vnr_got = idr_alloc(&tconn->volumes, mdev, vnr, vnr + 1, GFP_KERNEL);
+	vnr_got = idr_alloc_range(&tconn->volumes, mdev, vnr, vnr + 1, GFP_KERNEL);
 	if (vnr_got < 0) {
 		if (vnr_got == -ENOSPC) {
 			err = ERR_INVALID_REQUEST;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d92d50f..220f9f4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1620,11 +1620,11 @@ static int loop_add(struct loop_device **l, int i)
 
 	/* allocate id, if @id >= 0, we're requesting that specific id */
 	if (i >= 0) {
-		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
+		err = idr_alloc_range(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, lo, GFP_KERNEL);
 	}
 	if (err < 0)
 		goto out_free_dev;
diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index 126cf29..effda66 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -58,7 +58,7 @@ int dca_sysfs_add_provider(struct dca_provider *dca, struct device *dev)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&dca_idr_lock);
 
-	ret = idr_alloc(&dca_idr, dca, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&dca_idr, dca, GFP_NOWAIT);
 	if (ret >= 0)
 		dca->id = ret;
 
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 93f7992..0300f5b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -697,7 +697,7 @@ static int get_dma_id(struct dma_device *device)
 
 	mutex_lock(&dma_list_mutex);
 
-	rc = idr_alloc(&dma_idr, NULL, 0, 0, GFP_KERNEL);
+	rc = idr_alloc(&dma_idr, NULL, GFP_KERNEL);
 	if (rc >= 0)
 		device->dev_id = rc;
 
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 7ef316f..436debf 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -496,8 +496,7 @@ static int add_client_resource(struct client *client,
 	if (client->in_shutdown)
 		ret = -ECANCELED;
 	else
-		ret = idr_alloc(&client->resource_idr, resource, 0, 0,
-				GFP_NOWAIT);
+		ret = idr_alloc(&client->resource_idr, resource, GFP_NOWAIT);
 	if (ret >= 0) {
 		resource->handle = ret;
 		client_get(client);
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 664a6ff..9470257 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1015,7 +1015,7 @@ static void fw_device_init(struct work_struct *work)
 
 	fw_device_get(device);
 	down_write(&fw_device_rwsem);
-	minor = idr_alloc(&fw_device_idr, device, 0, 1 << MINORBITS,
+	minor = idr_alloc_range(&fw_device_idr, device, 0, 1 << MINORBITS,
 			GFP_KERNEL);
 	up_write(&fw_device_rwsem);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c2534d6..cc86d1b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -414,7 +414,7 @@ static int gpio_setup_irq(struct gpio_desc *desc, struct device *dev,
 			goto err_out;
 		}
 
-		ret = idr_alloc(&dirent_idr, value_sd, 1, 0, GFP_KERNEL);
+		ret = idr_alloc_range(&dirent_idr, value_sd, 1, 0, GFP_KERNEL);
 		if (ret < 0)
 			goto free_sd;
 		id = ret;
diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index 725968d..9a5c0c8 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -77,7 +77,7 @@ static int drm_ctxbitmap_next(struct drm_device * dev)
 	int ret;
 
 	mutex_lock(&dev->struct_mutex);
-	ret = idr_alloc(&dev->ctx_idr, NULL, DRM_RESERVED_CONTEXTS, 0,
+	ret = idr_alloc_range(&dev->ctx_idr, NULL, DRM_RESERVED_CONTEXTS, 0,
 			GFP_KERNEL);
 	mutex_unlock(&dev->struct_mutex);
 	return ret;
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index e7e9242..9108e36 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -271,7 +271,7 @@ static int drm_mode_object_get(struct drm_device *dev,
 	int ret;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.crtc_idr, obj, 1, 0, GFP_KERNEL);
+	ret = idr_alloc_range(&dev->mode_config.crtc_idr, obj, 1, 0, GFP_KERNEL);
 	if (ret >= 0) {
 		/*
 		 * Set up the object linking under the protection of the idr
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index cf919e3..1c897b9 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -276,7 +276,7 @@ drm_gem_handle_create(struct drm_file *file_priv,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 
-	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_range(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
 
 	spin_unlock(&file_priv->table_lock);
 	idr_preload_end();
@@ -452,7 +452,7 @@ drm_gem_flink_ioctl(struct drm_device *dev, void *data,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&dev->object_name_lock);
 	if (!obj->name) {
-		ret = idr_alloc(&dev->object_name_idr, obj, 1, 0, GFP_NOWAIT);
+		ret = idr_alloc_range(&dev->object_name_idr, obj, 1, 0, GFP_NOWAIT);
 		obj->name = ret;
 		args->name = (uint64_t) obj->name;
 		spin_unlock(&dev->object_name_lock);
diff --git a/drivers/gpu/drm/drm_stub.c b/drivers/gpu/drm/drm_stub.c
index 16f3ec5..64a2cbb 100644
--- a/drivers/gpu/drm/drm_stub.c
+++ b/drivers/gpu/drm/drm_stub.c
@@ -121,7 +121,7 @@ static int drm_minor_get_id(struct drm_device *dev, int type)
         }
 
 	mutex_lock(&dev->struct_mutex);
-	ret = idr_alloc(&drm_minors_idr, NULL, base, limit, GFP_KERNEL);
+	ret = idr_alloc_range(&drm_minors_idr, NULL, base, limit, GFP_KERNEL);
 	mutex_unlock(&dev->struct_mutex);
 
 	return ret == -ENOSPC ? -EINVAL : ret;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index be1e884..d8bc8d2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -166,7 +166,7 @@ static int ipp_create_id(struct idr *id_idr, struct mutex *lock, void *obj,
 
 	/* do the allocation under our mutexlock */
 	mutex_lock(lock);
-	ret = idr_alloc(id_idr, obj, 1, 0, GFP_KERNEL);
+	ret = idr_alloc_range(id_idr, obj, 1, 0, GFP_KERNEL);
 	mutex_unlock(lock);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/i915/i915_gem_context.c b/drivers/gpu/drm/i915/i915_gem_context.c
index a1e8ecb..c8ce882 100644
--- a/drivers/gpu/drm/i915/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/i915_gem_context.c
@@ -171,7 +171,7 @@ create_hw_context(struct drm_device *dev,
 
 	ctx->file_priv = file_priv;
 
-	ret = idr_alloc(&file_priv->context_idr, ctx, DEFAULT_CONTEXT_ID + 1, 0,
+	ret = idr_alloc_range(&file_priv->context_idr, ctx, DEFAULT_CONTEXT_ID + 1, 0,
 			GFP_KERNEL);
 	if (ret < 0)
 		goto err_out;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index f867714..2f99a68 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -450,7 +450,7 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 again:
 	idr_preload(GFP_ATOMIC);
 	spin_lock(&qdev->surf_id_idr_lock);
-	idr_ret = idr_alloc(&qdev->surf_id_idr, NULL, 1, 0, GFP_NOWAIT);
+	idr_ret = idr_alloc_range(&qdev->surf_id_idr, NULL, 1, 0, GFP_NOWAIT);
 	spin_unlock(&qdev->surf_id_idr_lock);
 	idr_preload_end();
 	if (idr_ret < 0)
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index b443d67..61c1b0c 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -59,7 +59,7 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&qdev->release_idr_lock);
-	idr_ret = idr_alloc(&qdev->release_idr, release, 1, 0, GFP_NOWAIT);
+	idr_ret = idr_alloc_range(&qdev->release_idr, release, 1, 0, GFP_NOWAIT);
 	spin_unlock(&qdev->release_idr_lock);
 	idr_preload_end();
 	handle = idr_ret;
diff --git a/drivers/gpu/drm/sis/sis_mm.c b/drivers/gpu/drm/sis/sis_mm.c
index 9a43d98..ec9fd4a 100644
--- a/drivers/gpu/drm/sis/sis_mm.c
+++ b/drivers/gpu/drm/sis/sis_mm.c
@@ -128,7 +128,7 @@ static int sis_drm_alloc(struct drm_device *dev, struct drm_file *file,
 	if (retval)
 		goto fail_alloc;
 
-	retval = idr_alloc(&dev_priv->object_idr, item, 1, 0, GFP_KERNEL);
+	retval = idr_alloc_range(&dev_priv->object_idr, item, 1, 0, GFP_KERNEL);
 	if (retval < 0)
 		goto fail_idr;
 	user_key = retval;
diff --git a/drivers/gpu/drm/via/via_mm.c b/drivers/gpu/drm/via/via_mm.c
index 0ab93ff..8dc9731 100644
--- a/drivers/gpu/drm/via/via_mm.c
+++ b/drivers/gpu/drm/via/via_mm.c
@@ -148,7 +148,7 @@ int via_mem_alloc(struct drm_device *dev, void *data,
 	if (retval)
 		goto fail_alloc;
 
-	retval = idr_alloc(&dev_priv->object_idr, item, 1, 0, GFP_KERNEL);
+	retval = idr_alloc_range(&dev_priv->object_idr, item, 1, 0, GFP_KERNEL);
 	if (retval < 0)
 		goto fail_idr;
 	user_key = retval;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index bc78425..ccbaed1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -180,7 +180,7 @@ int vmw_resource_alloc_id(struct vmw_resource *res)
 	idr_preload(GFP_KERNEL);
 	write_lock(&dev_priv->resource_lock);
 
-	ret = idr_alloc(idr, res, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_range(idr, res, 1, 0, GFP_NOWAIT);
 	if (ret >= 0)
 		res->id = ret;
 
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 48e31ed..239b405 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1087,7 +1087,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int	id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1,
+	id = idr_alloc_range(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1,
 		       GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (id < 0)
@@ -1124,7 +1124,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc_range(&i2c_adapter_idr, adapter,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (id < 0)
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 784b97c..86008a9 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -388,7 +388,7 @@ static int cm_alloc_id(struct cm_id_private *cm_id_priv)
 	idr_preload(GFP_KERNEL);
 	spin_lock_irqsave(&cm.lock, flags);
 
-	id = idr_alloc(&cm.local_id_table, cm_id_priv, next_id, 0, GFP_NOWAIT);
+	id = idr_alloc_range(&cm.local_id_table, cm_id_priv, next_id, 0, GFP_NOWAIT);
 	if (id >= 0)
 		next_id = max(id + 1, 0);
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 71c2c71..8326551 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2149,7 +2149,7 @@ static int cma_alloc_port(struct idr *ps, struct rdma_id_private *id_priv,
 	if (!bind_list)
 		return -ENOMEM;
 
-	ret = idr_alloc(ps, bind_list, snum, snum + 1, GFP_KERNEL);
+	ret = idr_alloc_range(ps, bind_list, snum, snum + 1, GFP_KERNEL);
 	if (ret < 0)
 		goto err;
 
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 934f45e..509d5a6 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -619,7 +619,7 @@ static int send_mad(struct ib_sa_query *query, int timeout_ms, gfp_t gfp_mask)
 		idr_preload(gfp_mask);
 	spin_lock_irqsave(&idr_lock, flags);
 
-	id = idr_alloc(&query_idr, query, 0, 0, GFP_NOWAIT);
+	id = idr_alloc(&query_idr, query, GFP_NOWAIT);
 
 	spin_unlock_irqrestore(&idr_lock, flags);
 	if (preload)
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index f2f6393..f66dc51 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -187,7 +187,7 @@ static struct ib_ucm_context *ib_ucm_ctx_alloc(struct ib_ucm_file *file)
 	INIT_LIST_HEAD(&ctx->events);
 
 	mutex_lock(&ctx_id_mutex);
-	ctx->id = idr_alloc(&ctx_id_table, ctx, 0, 0, GFP_KERNEL);
+	ctx->id = idr_alloc(&ctx_id_table, ctx, GFP_KERNEL);
 	mutex_unlock(&ctx_id_mutex);
 	if (ctx->id < 0)
 		goto error;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5ca44cd..fdfa319 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -156,7 +156,7 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
 	ctx->file = file;
 
 	mutex_lock(&mut);
-	ctx->id = idr_alloc(&ctx_idr, ctx, 0, 0, GFP_KERNEL);
+	ctx->id = idr_alloc(&ctx_idr, ctx, GFP_KERNEL);
 	mutex_unlock(&mut);
 	if (ctx->id < 0)
 		goto error;
@@ -178,7 +178,7 @@ static struct ucma_multicast* ucma_alloc_multicast(struct ucma_context *ctx)
 		return NULL;
 
 	mutex_lock(&mut);
-	mc->id = idr_alloc(&multicast_idr, mc, 0, 0, GFP_KERNEL);
+	mc->id = idr_alloc_range(&multicast_idr, mc, 0, 0, GFP_KERNEL);
 	mutex_unlock(&mut);
 	if (mc->id < 0)
 		goto error;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a7d00f6..775431a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -128,7 +128,7 @@ static int idr_add_uobj(struct idr *idr, struct ib_uobject *uobj)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&ib_uverbs_idr_lock);
 
-	ret = idr_alloc(idr, uobj, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(idr, uobj, GFP_NOWAIT);
 	if (ret >= 0)
 		uobj->id = ret;
 
diff --git a/drivers/infiniband/hw/cxgb3/iwch.h b/drivers/infiniband/hw/cxgb3/iwch.h
index 8378622..f28c585 100644
--- a/drivers/infiniband/hw/cxgb3/iwch.h
+++ b/drivers/infiniband/hw/cxgb3/iwch.h
@@ -157,7 +157,7 @@ static inline int insert_handle(struct iwch_dev *rhp, struct idr *idr,
 	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&rhp->lock);
 
-	ret = idr_alloc(idr, handle, id, id + 1, GFP_NOWAIT);
+	ret = idr_alloc_range(idr, handle, id, id + 1, GFP_NOWAIT);
 
 	spin_unlock_irq(&rhp->lock);
 	idr_preload_end();
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 485183a..50e5a3f 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -266,7 +266,7 @@ static inline int _insert_handle(struct c4iw_dev *rhp, struct idr *idr,
 		spin_lock_irq(&rhp->lock);
 	}
 
-	ret = idr_alloc(idr, handle, id, id + 1, GFP_ATOMIC);
+	ret = idr_alloc_range(idr, handle, id, id + 1, GFP_ATOMIC);
 
 	if (lock) {
 		spin_unlock_irq(&rhp->lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 212150c..0bc5c51 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -165,7 +165,7 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe, int comp_vector,
 
 	idr_preload(GFP_KERNEL);
 	write_lock_irqsave(&ehca_cq_idr_lock, flags);
-	my_cq->token = idr_alloc(&ehca_cq_idr, my_cq, 0, 0x2000000, GFP_NOWAIT);
+	my_cq->token = idr_alloc_range(&ehca_cq_idr, my_cq, 0, 0x2000000, GFP_NOWAIT);
 	write_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 	idr_preload_end();
 
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 00d6861..758a265 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -639,7 +639,7 @@ static struct ehca_qp *internal_create_qp(
 	idr_preload(GFP_KERNEL);
 	write_lock_irqsave(&ehca_qp_idr_lock, flags);
 
-	ret = idr_alloc(&ehca_qp_idr, my_qp, 0, 0x2000000, GFP_NOWAIT);
+	ret = idr_alloc_range(&ehca_qp_idr, my_qp, 0, 0x2000000, GFP_NOWAIT);
 	if (ret >= 0)
 		my_qp->token = ret;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index bd0caed..83a40a5 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -204,7 +204,7 @@ static struct ipath_devdata *ipath_alloc_devdata(struct pci_dev *pdev)
 	idr_preload(GFP_KERNEL);
 	spin_lock_irqsave(&ipath_devs_lock, flags);
 
-	ret = idr_alloc(&unit_table, dd, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&unit_table, dd, GFP_NOWAIT);
 	if (ret < 0) {
 		printk(KERN_ERR IPATH_DRV_NAME
 		       ": Could not allocate unit ID: error %d\n", -ret);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 48928c8..cc45a45 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -404,7 +404,7 @@ static struct ocrdma_dev *ocrdma_add(struct be_dev_info *dev_info)
 		goto idr_err;
 
 	memcpy(&dev->nic_info, dev_info, sizeof(*dev_info));
-	dev->id = idr_alloc(&ocrdma_dev_id, NULL, 0, 0, GFP_KERNEL);
+	dev->id = idr_alloc(&ocrdma_dev_id, NULL, GFP_KERNEL);
 	if (dev->id < 0)
 		goto idr_err;
 
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 173f805..503619c 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1069,7 +1069,7 @@ struct qib_devdata *qib_alloc_devdata(struct pci_dev *pdev, size_t extra)
 	idr_preload(GFP_KERNEL);
 	spin_lock_irqsave(&qib_devs_lock, flags);
 
-	ret = idr_alloc(&qib_unit_table, dd, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&qib_unit_table, dd, GFP_NOWAIT);
 	if (ret >= 0) {
 		dd->unit = ret;
 		list_add(&dd->list, &qib_dev_list);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d5370a9..8ba4fdb 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1793,7 +1793,7 @@ static int specific_minor(int minor)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&_minor_lock);
 
-	r = idr_alloc(&_minor_idr, MINOR_ALLOCED, minor, minor + 1, GFP_NOWAIT);
+	r = idr_alloc_range(&_minor_idr, MINOR_ALLOCED, minor, minor + 1, GFP_NOWAIT);
 
 	spin_unlock(&_minor_lock);
 	idr_preload_end();
@@ -1809,7 +1809,7 @@ static int next_free_minor(int *minor)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&_minor_lock);
 
-	r = idr_alloc(&_minor_idr, MINOR_ALLOCED, 0, 1 << MINORBITS, GFP_NOWAIT);
+	r = idr_alloc_range(&_minor_idr, MINOR_ALLOCED, 0, 1 << MINORBITS, GFP_NOWAIT);
 
 	spin_unlock(&_minor_lock);
 	idr_preload_end();
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index ffcb10a..70fb07c 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -515,7 +515,7 @@ int memstick_add_host(struct memstick_host *host)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&memstick_host_lock);
 
-	rc = idr_alloc(&memstick_host_idr, host, 0, 0, GFP_NOWAIT);
+	rc = idr_alloc(&memstick_host_idr, host, GFP_NOWAIT);
 	if (rc >= 0)
 		host->id = rc;
 
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index f4176ca..5ea13de 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1211,7 +1211,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	msb->page_size = be16_to_cpu(sys_info->unit_size);
 
 	mutex_lock(&mspro_block_disk_lock);
-	disk_id = idr_alloc(&mspro_block_disk_idr, card, 0, 256, GFP_KERNEL);
+	disk_id = idr_alloc_range(&mspro_block_disk_idr, card, 0, 256, GFP_KERNEL);
 	mutex_unlock(&mspro_block_disk_lock);
 	if (disk_id < 0)
 		return disk_id;
diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index e968c01..905513d 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -1098,7 +1098,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&rtsx_pci_lock);
-	ret = idr_alloc(&rtsx_pci_idr, pcr, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&rtsx_pci_idr, pcr, GFP_NOWAIT);
 	if (ret >= 0)
 		pcr->id = ret;
 	spin_unlock(&rtsx_pci_lock);
diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index f32550a..8a1ab10 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -899,7 +899,7 @@ struct c2port_device *c2port_device_register(char *name,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&c2port_idr_lock);
-	ret = idr_alloc(&c2port_idr, c2dev, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&c2port_idr, c2dev, GFP_NOWAIT);
 	spin_unlock_irq(&c2port_idr_lock);
 	idr_preload_end();
 
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index 0ab7c92..c828c27 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -198,7 +198,7 @@ int tifm_add_adapter(struct tifm_adapter *fm)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&tifm_adapter_lock);
-	rc = idr_alloc(&tifm_adapter_idr, fm, 0, 0, GFP_NOWAIT);
+	rc = idr_alloc(&tifm_adapter_idr, fm, GFP_NOWAIT);
 	if (rc >= 0)
 		fm->id = rc;
 	spin_unlock(&tifm_adapter_lock);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2a3593d..335873c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -437,7 +437,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->rescan_disable = 1;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
+	err = idr_alloc(&mmc_host_idr, host, GFP_NOWAIT);
 	if (err >= 0)
 		host->index = err;
 	spin_unlock(&mmc_host_lock);
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index eaa1fcc..1667468 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -347,7 +347,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	BUG_ON(mtd->writesize == 0);
 	mutex_lock(&mtd_table_mutex);
 
-	i = idr_alloc(&mtd_idr, mtd, 0, 0, GFP_KERNEL);
+	i = idr_alloc(&mtd_idr, mtd, GFP_KERNEL);
 	if (i < 0)
 		goto fail_locked;
 
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 59e9605..40094b9 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -281,7 +281,7 @@ static int macvtap_get_minor(struct macvlan_dev *vlan)
 	int retval = -ENOMEM;
 
 	mutex_lock(&minor_lock);
-	retval = idr_alloc(&minor_idr, vlan, 1, MACVTAP_NUM_DEVS, GFP_KERNEL);
+	retval = idr_alloc_range(&minor_idr, vlan, 1, MACVTAP_NUM_DEVS, GFP_KERNEL);
 	if (retval >= 0) {
 		vlan->minor = retval;
 	} else if (retval == -ENOSPC) {
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 72ff14b..0818f4f 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2958,7 +2958,7 @@ static int unit_set(struct idr *p, void *ptr, int n)
 {
 	int unit;
 
-	unit = idr_alloc(p, ptr, n, n + 1, GFP_KERNEL);
+	unit = idr_alloc_range(p, ptr, n, n + 1, GFP_KERNEL);
 	if (unit == -ENOSPC)
 		unit = -EINVAL;
 	return unit;
@@ -2967,7 +2967,7 @@ static int unit_set(struct idr *p, void *ptr, int n)
 /* get new free unit number and associate pointer with it */
 static int unit_get(struct idr *p, void *ptr)
 {
-	return idr_alloc(p, ptr, 0, 0, GFP_KERNEL);
+	return idr_alloc_range(p, ptr, 0, 0, GFP_KERNEL);
 }
 
 /* put unit number back to a pool */
diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 0727f92..65c6a2e 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1516,7 +1516,7 @@ static int bq2415x_probe(struct i2c_client *client,
 
 	/* Get new ID for the new device */
 	mutex_lock(&bq2415x_id_mutex);
-	num = idr_alloc(&bq2415x_id, client, 0, 0, GFP_KERNEL);
+	num = idr_alloc(&bq2415x_id, client, GFP_KERNEL);
 	mutex_unlock(&bq2415x_id_mutex);
 	if (num < 0)
 		return num;
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 26037ca..5aea239 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -792,7 +792,7 @@ static int bq27x00_battery_probe(struct i2c_client *client,
 
 	/* Get new ID for the new battery device */
 	mutex_lock(&battery_mutex);
-	num = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
+	num = idr_alloc(&battery_id, client, GFP_KERNEL);
 	mutex_unlock(&battery_mutex);
 	if (num < 0)
 		return num;
diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
index 5631748..a945e2b7 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -396,7 +396,7 @@ static int ds278x_battery_probe(struct i2c_client *client,
 
 	/* Get an ID for this battery */
 	mutex_lock(&battery_lock);
-	ret = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&battery_id, client, GFP_KERNEL);
 	mutex_unlock(&battery_lock);
 	if (ret < 0)
 		goto fail_id;
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index cdad4d9..613622d 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -102,7 +102,7 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 		goto pps_register_source_exit;
 	}
 
-	/* These initializations must be done before calling idr_alloc()
+	/* These initializations must be done before calling idr_alloc_range()
 	 * in order to avoid reces into pps_event().
 	 */
 	pps->params.api_version = PPS_API_VERS;
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 7173e3a..7bd62a1 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -296,10 +296,10 @@ int pps_register_cdev(struct pps_device *pps)
 
 	mutex_lock(&pps_idr_lock);
 	/*
-	 * Get new ID for the new PPS source.  After idr_alloc() calling
+	 * Get new ID for the new PPS source.  After idr_alloc_range() calling
 	 * the new source will be freely available into the kernel.
 	 */
-	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
+	err = idr_alloc_range(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			pr_err("%s: too many PPS sources in the system\n",
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1e2009e..6c83096 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -217,7 +217,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	 * TODO: assign a notifyid for rvdev updates as well
 	 * TODO: support predefined notifyids (via resource table)
 	 */
-	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&rproc->notifyids, rvring, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", ret);
 		dma_free_coherent(dev->parent, size, va, dma);
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index b6135d4..aaee678 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -242,9 +242,9 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
 	mutex_lock(&vrp->endpoints_lock);
 
 	/* bind the endpoint to an rpmsg address (and allocate one if needed) */
-	id = idr_alloc(&vrp->endpoints, ept, id_min, id_max, GFP_KERNEL);
+	id = idr_alloc_range(&vrp->endpoints, ept, id_min, id_max, GFP_KERNEL);
 	if (id < 0) {
-		dev_err(dev, "idr_alloc failed: %d\n", id);
+		dev_err(dev, "idr_alloc_range failed: %d\n", id);
 		goto free_ept;
 	}
 	ept->addr = id;
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 5864f98..e9a1774 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -523,7 +523,7 @@ bfad_im_scsi_host_alloc(struct bfad_s *bfad, struct bfad_im_port_s *im_port,
 	int error = 1;
 
 	mutex_lock(&bfad_mutex);
-	error = idr_alloc(&bfad_im_port_index, im_port, 0, 0, GFP_KERNEL);
+	error = idr_alloc(&bfad_im_port_index, im_port, GFP_KERNEL);
 	if (error < 0) {
 		mutex_unlock(&bfad_mutex);
 		printk(KERN_WARNING "idr_alloc failure\n");
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 2a32374..c264bed 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -907,7 +907,7 @@ static int ch_probe(struct device *dev)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&ch_index_lock);
-	ret = idr_alloc(&ch_index_idr, ch, 0, CH_MAX_DEVS + 1, GFP_NOWAIT);
+	ret = idr_alloc_range(&ch_index_idr, ch, 0, CH_MAX_DEVS + 1, GFP_NOWAIT);
 	spin_unlock(&ch_index_lock);
 	idr_preload_end();
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index cb465b2..402601d 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3211,7 +3211,7 @@ lpfc_get_instance(void)
 {
 	int ret;
 
-	ret = idr_alloc(&lpfc_hba_index, NULL, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&lpfc_hba_index, NULL, GFP_KERNEL);
 	return ret < 0 ? -1 : ret;
 }
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index df5e961..23856c8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1395,7 +1395,7 @@ static Sg_device *sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	idr_preload(GFP_KERNEL);
 	write_lock_irqsave(&sg_index_lock, iflags);
 
-	error = idr_alloc(&sg_index_idr, sdp, 0, SG_MAX_DEVS, GFP_NOWAIT);
+	error = idr_alloc_range(&sg_index_idr, sdp, 0, SG_MAX_DEVS, GFP_NOWAIT);
 	if (error < 0) {
 		if (error == -ENOSPC) {
 			sdev_printk(KERN_WARNING, scsidp,
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 2a32036..743fd72 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4184,7 +4184,7 @@ static int st_probe(struct device *dev)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&st_index_lock);
-	error = idr_alloc(&st_index_idr, tpnt, 0, ST_MAX_TAPES + 1, GFP_NOWAIT);
+	error = idr_alloc_range(&st_index_idr, tpnt, 0, ST_MAX_TAPES + 1, GFP_NOWAIT);
 	spin_unlock(&st_index_lock);
 	idr_preload_end();
 	if (error < 0) {
diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging/tidspbridge/rmgr/drv.c
index be26917..fb59732 100644
--- a/drivers/staging/tidspbridge/rmgr/drv.c
+++ b/drivers/staging/tidspbridge/rmgr/drv.c
@@ -83,7 +83,7 @@ int drv_insert_node_res_element(void *hnode, void *node_resource,
 		return -ENOMEM;
 
 	(*node_res_obj)->node = hnode;
-	retval = idr_alloc(ctxt->node_id, *node_res_obj, 0, 0, GFP_KERNEL);
+	retval = idr_alloc(ctxt->node_id, *node_res_obj, GFP_KERNEL);
 	if (retval >= 0) {
 		(*node_res_obj)->id = retval;
 		return 0;
@@ -199,7 +199,7 @@ int drv_proc_insert_strm_res_element(void *stream_obj,
 		return -EFAULT;
 
 	(*pstrm_res)->stream = stream_obj;
-	retval = idr_alloc(ctxt->stream_id, *pstrm_res, 0, 0, GFP_KERNEL);
+	retval = idr_alloc(ctxt->stream_id, *pstrm_res, GFP_KERNEL);
 	if (retval >= 0) {
 		(*pstrm_res)->id = retval;
 		return 0;
diff --git a/drivers/staging/zcache/ramster/tcp.c b/drivers/staging/zcache/ramster/tcp.c
index f6e1e52..2dc645e 100644
--- a/drivers/staging/zcache/ramster/tcp.c
+++ b/drivers/staging/zcache/ramster/tcp.c
@@ -303,7 +303,7 @@ static int r2net_prep_nsw(struct r2net_node *nn, struct r2net_status_wait *nsw)
 	int ret;
 
 	spin_lock(&nn->nn_lock);
-	ret = idr_alloc(&nn->nn_status_idr, nsw, 0, 0, GFP_ATOMIC);
+	ret = idr_alloc(&nn->nn_status_idr, nsw, GFP_ATOMIC);
 	if (ret >= 0) {
 		nsw->ns_id = ret;
 		list_add_tail(&nsw->ns_node_item, &nn->nn_status_list);
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index d7705e5..b06d2a8 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -150,7 +150,7 @@ struct iscsi_tiqn *iscsit_add_tiqn(unsigned char *buf)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&tiqn_lock);
 
-	ret = idr_alloc(&tiqn_idr, NULL, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&tiqn_idr, NULL, GFP_NOWAIT);
 	if (ret < 0) {
 		pr_err("idr_alloc() failed for tiqn->tiqn_index\n");
 		spin_unlock(&tiqn_lock);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index bb5d5c5..87a82b6 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -291,7 +291,7 @@ static int iscsi_login_zero_tsih_s1(
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_bh(&sess_idr_lock);
-	ret = idr_alloc(&sess_idr, NULL, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&sess_idr, NULL, GFP_NOWAIT);
 	if (ret >= 0)
 		sess->session_index = ret;
 	spin_unlock_bh(&sess_idr_lock);
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c94bf2e..4e5de56 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -75,7 +75,7 @@ static int get_idr(struct idr *idr, int *id)
 	int ret;
 
 	mutex_lock(&cooling_cpufreq_lock);
-	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(idr, NULL, GFP_KERNEL);
 	mutex_unlock(&cooling_cpufreq_lock);
 	if (unlikely(ret < 0))
 		return ret;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d755440..788063d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -133,7 +133,7 @@ static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 
 	if (lock)
 		mutex_lock(lock);
-	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(idr, NULL, GFP_KERNEL);
 	if (lock)
 		mutex_unlock(lock);
 	if (unlikely(ret < 0))
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index b645c47..3f4126c 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -371,7 +371,7 @@ static int uio_get_minor(struct uio_device *idev)
 	int retval = -ENOMEM;
 
 	mutex_lock(&minor_lock);
-	retval = idr_alloc(&uio_idr, idev, 0, UIO_MAX_DEVICES, GFP_KERNEL);
+	retval = idr_alloc_range(&uio_idr, idev, 0, UIO_MAX_DEVICES, GFP_KERNEL);
 	if (retval >= 0) {
 		idev->minor = retval;
 		retval = 0;
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 6d78736..ce667cb 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(vfio_unregister_iommu_driver);
 static int vfio_alloc_group_minor(struct vfio_group *group)
 {
 	/* index 0 is used by /dev/vfio/vfio */
-	return idr_alloc(&vfio.group_idr, group, 1, MINORMASK + 1, GFP_KERNEL);
+	return idr_alloc_range(&vfio.group_idr, group, 1, MINORMASK + 1, GFP_KERNEL);
 }
 
 static void vfio_free_group_minor(int minor)
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1b11466..85bba95 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1201,7 +1201,7 @@ static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
 
 	idr_preload(GFP_NOFS);
 	spin_lock(&ls->ls_lkbidr_spin);
-	rv = idr_alloc(&ls->ls_lkbidr, lkb, 1, 0, GFP_NOWAIT);
+	rv = idr_alloc_range(&ls->ls_lkbidr, lkb, 1, 0, GFP_NOWAIT);
 	if (rv >= 0)
 		lkb->lkb_id = rv;
 	spin_unlock(&ls->ls_lkbidr_spin);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index a6bc63f..2babe5e 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -313,7 +313,7 @@ static int recover_idr_add(struct dlm_rsb *r)
 		rv = -1;
 		goto out_unlock;
 	}
-	rv = idr_alloc(&ls->ls_recover_idr, r, 1, 0, GFP_NOWAIT);
+	rv = idr_alloc_range(&ls->ls_recover_idr, r, 1, 0, GFP_NOWAIT);
 	if (rv < 0)
 		goto out_unlock;
 
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 4cbad5d..786aac37 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -32,7 +32,7 @@ static int nfs_get_cb_ident_idr(struct nfs_client *clp, int minorversion)
 		return ret;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->nfs_client_lock);
-	ret = idr_alloc(&nn->cb_ident_idr, clp, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&nn->cb_ident_idr, clp, GFP_NOWAIT);
 	if (ret >= 0)
 		clp->cl_cb_ident = ret;
 	spin_unlock(&nn->nfs_client_lock);
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index aa88bd8..910fe1d 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -307,7 +307,7 @@ static int o2net_prep_nsw(struct o2net_node *nn, struct o2net_status_wait *nsw)
 	int ret;
 
 	spin_lock(&nn->nn_lock);
-	ret = idr_alloc(&nn->nn_status_idr, nsw, 0, 0, GFP_ATOMIC);
+	ret = idr_alloc(&nn->nn_status_idr, nsw, GFP_ATOMIC);
 	if (ret >= 0) {
 		nsw->ns_id = ret;
 		list_add_tail(&nsw->ns_node_item, &nn->nn_status_list);
diff --git a/include/linux/idr.h b/include/linux/idr.h
index ae3a3b4..4bce55c 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -205,7 +205,7 @@ struct idr {
 
 void *idr_find_slowpath(struct idr *idp, int id);
 void idr_preload(gfp_t gfp_mask);
-int idr_alloc(struct idr *idp, void *ptr, int start, int end, gfp_t gfp_mask);
+int idr_alloc_range(struct idr *idp, void *ptr, int start, int end, gfp_t gfp_mask);
 int idr_alloc_cyclic(struct idr *idr, void *ptr, int start, int end, gfp_t gfp_mask);
 int idr_for_each(struct idr *idp,
 		 int (*fn)(int id, void *p, void *data), void *data);
@@ -216,6 +216,11 @@ void idr_free(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
 
+static inline int idr_alloc(struct idr *idr, void *ptr, gfp_t gfp)
+{
+	return idr_alloc_range(idr, ptr, 0, 0, gfp);
+}
+
 /**
  * idr_preload_end - end preload section started with idr_preload()
  *
diff --git a/ipc/util.c b/ipc/util.c
index 809ec5e..749511d 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -269,7 +269,7 @@ int ipc_addid(struct ipc_ids* ids, struct kern_ipc_perm* new, int size)
 	rcu_read_lock();
 	spin_lock(&new->lock);
 
-	id = idr_alloc(&ids->ipcs_idr, new,
+	id = idr_alloc_range(&ids->ipcs_idr, new,
 		       (next_id < 0) ? 0 : ipcid_to_idx(next_id), 0,
 		       GFP_NOWAIT);
 	idr_preload_end();
diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index fd0fa32..54a591bb 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -5170,7 +5170,7 @@ static struct css_id *get_new_cssid(struct cgroup_subsys *ss, int depth)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&ss->id_lock);
 	/* Don't use 0. allocates an ID of 1-65535 */
-	ret = idr_alloc(&ss->idr, newid, 1, CSS_ID_MAX + 1, GFP_NOWAIT);
+	ret = idr_alloc_range(&ss->idr, newid, 1, CSS_ID_MAX + 1, GFP_NOWAIT);
 	spin_unlock(&ss->id_lock);
 	idr_preload_end();
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9dc297f..1567135 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5968,7 +5968,7 @@ int perf_pmu_register(struct pmu *pmu, char *name, int type)
 	pmu->name = name;
 
 	if (type < 0) {
-		type = idr_alloc(&pmu_idr, pmu, PERF_TYPE_MAX, 0, GFP_KERNEL);
+		type = idr_alloc_range(&pmu_idr, pmu, PERF_TYPE_MAX, 0, GFP_KERNEL);
 		if (type < 0) {
 			ret = type;
 			goto free_pdc;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ee8e29a..b45694f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -511,7 +511,7 @@ static int worker_pool_assign_id(struct worker_pool *pool)
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	ret = idr_alloc(&worker_pool_idr, pool, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&worker_pool_idr, pool, GFP_KERNEL);
 	if (ret >= 0) {
 		pool->id = ret;
 		return 0;
@@ -1693,7 +1693,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&pool->lock);
 
-	id = idr_alloc(&pool->worker_idr, NULL, 0, 0, GFP_NOWAIT);
+	id = idr_alloc(&pool->worker_idr, NULL, GFP_NOWAIT);
 
 	spin_unlock_irq(&pool->lock);
 	idr_preload_end();
diff --git a/lib/idr.c b/lib/idr.c
index 21f86e8..d0f05e9 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -894,7 +894,7 @@ static struct idr_layer *idr_layer_alloc(gfp_t gfp_mask, struct idr *layer_idr)
 
 	/*
 	 * Try to allocate directly from kmem_cache.  We want to try this
-	 * before preload buffer; otherwise, non-preloading idr_alloc()
+	 * before preload buffer; otherwise, non-preloading idr_alloc_range()
 	 * users will end up taking advantage of preloading ones.  As the
 	 * following is allowed to fail for preloaded cases, suppress
 	 * warning this time.
@@ -1148,24 +1148,24 @@ static void idr_fill_slot(struct idr *idr, void *ptr, int id,
 }
 
 /**
- * idr_preload - preload for idr_alloc()
+ * idr_preload - preload for idr_alloc_range()
  * @gfp_mask: allocation mask to use for preloading
  *
- * Preload per-cpu layer buffer for idr_alloc().  Can only be used from
+ * Preload per-cpu layer buffer for idr_alloc_range().  Can only be used from
  * process context and each idr_preload() invocation should be matched with
  * idr_preload_end().  Note that preemption is disabled while preloaded.
  *
- * The first idr_alloc() in the preloaded section can be treated as if it
+ * The first idr_alloc_range() in the preloaded section can be treated as if it
  * were invoked with @gfp_mask used for preloading.  This allows using more
  * permissive allocation masks for idrs protected by spinlocks.
  *
- * For example, if idr_alloc() below fails, the failure can be treated as
- * if idr_alloc() were called with GFP_KERNEL rather than GFP_NOWAIT.
+ * For example, if idr_alloc_range() below fails, the failure can be treated as
+ * if idr_alloc_range() were called with GFP_KERNEL rather than GFP_NOWAIT.
  *
  *	idr_preload(GFP_KERNEL);
  *	spin_lock(lock);
  *
- *	id = idr_alloc(idr, ptr, start, end, GFP_NOWAIT);
+ *	id = idr_alloc_range(idr, ptr, start, end, GFP_NOWAIT);
  *
  *	spin_unlock(lock);
  *	idr_preload_end();
@@ -1184,10 +1184,10 @@ void idr_preload(gfp_t gfp_mask)
 	preempt_disable();
 
 	/*
-	 * idr_alloc() is likely to succeed w/o full idr_layer buffer and
-	 * return value from idr_alloc() needs to be checked for failure
+	 * idr_alloc_range() is likely to succeed w/o full idr_layer buffer and
+	 * return value from idr_alloc_range() needs to be checked for failure
 	 * anyway.  Silently give up if allocation fails.  The caller can
-	 * treat failures from idr_alloc() as if idr_alloc() were called
+	 * treat failures from idr_alloc_range() as if idr_alloc() were called
 	 * with @gfp_mask which should be enough.
 	 */
 	while (__this_cpu_read(idr_preload_cnt) < MAX_IDR_FREE) {
@@ -1208,7 +1208,7 @@ void idr_preload(gfp_t gfp_mask)
 EXPORT_SYMBOL(idr_preload);
 
 /**
- * idr_alloc - allocate new idr entry
+ * idr_alloc_range - allocate new idr entry
  * @idr: the (initialized) idr
  * @ptr: pointer to be associated with the new id
  * @start: the minimum id (inclusive)
@@ -1227,7 +1227,7 @@ EXPORT_SYMBOL(idr_preload);
  * or iteration can be performed under RCU read lock provided the user
  * destroys @ptr in RCU-safe way after removal from idr.
  */
-int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp_mask)
+int idr_alloc_range(struct idr *idr, void *ptr, int start, int end, gfp_t gfp_mask)
 {
 	int max = end > 0 ? end - 1 : INT_MAX;	/* inclusive upper limit */
 	struct idr_layer *pa[MAX_IDR_LEVEL + 1];
@@ -1251,7 +1251,7 @@ int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp_mask)
 	idr_fill_slot(idr, ptr, id, pa);
 	return id;
 }
-EXPORT_SYMBOL_GPL(idr_alloc);
+EXPORT_SYMBOL_GPL(idr_alloc_range);
 
 /**
  * idr_alloc_cyclic - allocate new idr entry in a cyclical fashion
@@ -1261,7 +1261,7 @@ EXPORT_SYMBOL_GPL(idr_alloc);
  * @end: the maximum id (exclusive, <= 0 for max)
  * @gfp_mask: memory allocation flags
  *
- * Essentially the same as idr_alloc, but prefers to allocate progressively
+ * Essentially the same as idr_alloc_range, but prefers to allocate progressively
  * higher ids if it can. If the "cur" counter wraps, then it will start again
  * at the "start" end of the range and allocate one that has already been used.
  */
@@ -1270,9 +1270,9 @@ int idr_alloc_cyclic(struct idr *idr, void *ptr, int start, int end,
 {
 	int id;
 
-	id = idr_alloc(idr, ptr, max(start, idr->cur), end, gfp_mask);
+	id = idr_alloc_range(idr, ptr, max(start, idr->cur), end, gfp_mask);
 	if (id == -ENOSPC)
-		id = idr_alloc(idr, ptr, start, end, gfp_mask);
+		id = idr_alloc_range(idr, ptr, start, end, gfp_mask);
 
 	if (likely(id >= 0))
 		idr->cur = id + 1;
diff --git a/net/9p/util.c b/net/9p/util.c
index 59f278e..cc31c62 100644
--- a/net/9p/util.c
+++ b/net/9p/util.c
@@ -94,7 +94,7 @@ int p9_idpool_get(struct p9_idpool *p)
 	spin_lock_irqsave(&p->lock, flags);
 
 	/* no need to store exactly p, we just need something non-null */
-	i = idr_alloc(&p->pool, p, 0, 0, GFP_NOWAIT);
+	i = idr_alloc(&p->pool, p, GFP_NOWAIT);
 
 	spin_unlock_irqrestore(&p->lock, flags);
 	idr_preload_end();
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9972e07..9769f18 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1987,7 +1987,7 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 			int id;
 
 			spin_lock_irqsave(&local->ack_status_lock, flags);
-			id = idr_alloc(&local->ack_status_frames, orig_skb,
+			id = idr_alloc_range(&local->ack_status_frames, orig_skb,
 				       1, 0x10000, GFP_ATOMIC);
 			spin_unlock_irqrestore(&local->ack_status_lock, flags);
 
-- 
1.8.3.1

