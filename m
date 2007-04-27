Return-Path: <stf_xl@wp.pl>
Received: from bxn46.internetdsl.tpnet.pl (HELO asus.local)
	(stf_xl@wp.pl@[83.18.247.46]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <drbd-dev@lists.linbit.com>; 27 Apr 2007 11:19:20 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: drbd-dev@lists.linbit.com
Date: Fri, 27 Apr 2007 11:21:44 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oCcMGbJgD3CC11b"
Message-Id: <200704271121.44336.stf_xl@wp.pl>
Subject: [Drbd-dev] [PATCH] dynamic creation/removal more then 256 drbd
	devices
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_oCcMGbJgD3CC11b
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hallo,

I did patch for dynamic creation/removal drbd devices.
Drbd have already dynamic drbd creation, but no removal.
Also my patch breaks limit of 256 drbd devices - linked list
is used for keeping devices; minor_table is removed, 
idr structure form include/linux/idr.h is used instead. 
Please comment. Is there a chance it will be applied?

Patch is divided into 2 parts: kernel and user space.

-- 
Regards
Stanislaw Gruszka

--Boundary-00=_oCcMGbJgD3CC11b
Content-Type: text/x-diff; charset="us-ascii";
	name="drbd-dynamic-devs-kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="drbd-dynamic-devs-kernel.patch"

Index: trunk/drbd/drbd_proc.c
===================================================================
--- trunk/drbd/drbd_proc.c	(revision 2864)
+++ trunk/drbd/drbd_proc.c	(working copy)
@@ -172,9 +172,9 @@
 
 STATIC int drbd_seq_show(struct seq_file *seq, void *v)
 {
-	int i,hole=0;
 	const char *sn;
 	drbd_dev *mdev;
+	struct list_head *p;
 
 	seq_printf(seq, "version: " REL_VERSION " (api:%d/proto:%d)\n%s\n",
 		    API_VERSION,PRO_VERSION, drbd_buildtag());
@@ -192,28 +192,22 @@
 	  al .. access log write count
 	*/
 
-	for (i = 0; i < minor_count; i++) {
-		mdev = minor_to_mdev(i);
-		if(!mdev) {
-			hole=1;
-			continue;
-		}
-		if( hole ) {
-			hole=0;
-			seq_printf( seq, "\n");
-		}
+	down(&drbd_devs_mutex);
+	list_for_each(p, &drbd_devs_list) {
+		mdev = list_entry(p, struct Drbd_Conf, devs_list);
 
 		sn = conns_to_name(mdev->state.conn);
 
 		if ( mdev->state.conn == StandAlone &&
 		     mdev->state.disk == Diskless) {
-			seq_printf( seq, "%2d: cs:Unconfigured\n", i);
+			seq_printf( seq, "%2d: cs:Unconfigured\n",
+			  mdev_to_minor(mdev));
 		} else {
 			seq_printf( seq,
 			   "%2d: cs:%s st:%s/%s ds:%s/%s %c %c%c%c%c\n"
 			   "    ns:%u nr:%u dw:%u dr:%u al:%u bm:%u "
 			   "lo:%d pe:%d ua:%d ap:%d\n",
-			   i, sn,
+			   mdev_to_minor(mdev), sn,
 			   roles_to_name(mdev->state.role),
 			   roles_to_name(mdev->state.peer),
 			   disks_to_name(mdev->state.disk),
@@ -255,7 +249,7 @@
 #endif
 
 	}
-
+	up(&drbd_devs_mutex);
 	return 0;
 }
 
Index: trunk/drbd/drbd_receiver.c
===================================================================
--- trunk/drbd/drbd_receiver.c	(revision 2864)
+++ trunk/drbd/drbd_receiver.c	(working copy)
@@ -194,7 +194,7 @@
 	int free_it;
 
 	spin_lock_irqsave(&drbd_pp_lock,flags);
-	if (drbd_pp_vacant > (DRBD_MAX_SEGMENT_SIZE/PAGE_SIZE)*minor_count) {
+	if (drbd_pp_vacant > (DRBD_MAX_SEGMENT_SIZE/PAGE_SIZE)*prealloc_segments) {
 		free_it = 1;
 	} else {
 		set_page_private(page, (unsigned long)drbd_pp_pool);
Index: trunk/drbd/drbd_worker.c
===================================================================
--- trunk/drbd/drbd_worker.c	(revision 2864)
+++ trunk/drbd/drbd_worker.c	(working copy)
@@ -714,11 +714,12 @@
 STATIC void drbd_global_lock(void)
 {
 	drbd_dev *mdev;
-	int i;
+	struct list_head *p;
 
+	down(&drbd_devs_mutex);
 	local_irq_disable();
-	for (i=0; i < minor_count; i++) {
-		if(!(mdev = minor_to_mdev(i))) continue;
+	list_for_each(p, &drbd_devs_list) {
+		mdev = list_entry(p, struct Drbd_Conf, devs_list);
 		spin_lock(&mdev->req_lock);
 	}
 }
@@ -726,13 +727,14 @@
 STATIC void drbd_global_unlock(void)
 {
 	drbd_dev *mdev;
-	int i;
+	struct list_head *p;
 
-	for (i=0; i < minor_count; i++) {
-		if(!(mdev = minor_to_mdev(i))) continue;
+	list_for_each(p, &drbd_devs_list) {
+		mdev = list_entry(p, struct Drbd_Conf, devs_list);
 		spin_unlock(&mdev->req_lock);
 	}
 	local_irq_enable();
+	up(&drbd_devs_mutex);;
 }
 
 STATIC int _drbd_may_sync_now(drbd_dev *mdev)
@@ -759,10 +761,11 @@
 STATIC int _drbd_pause_after(drbd_dev *mdev)
 {
 	drbd_dev *odev;
-	int i, rv = 0;
+	struct list_head *p;
+	int rv = 0;
 
-	for (i=0; i < minor_count; i++) {
-		if( !(odev = minor_to_mdev(i)) ) continue;
+	list_for_each(p, &drbd_devs_list) {
+		odev = list_entry(p, struct Drbd_Conf, devs_list); 
 		if (! _drbd_may_sync_now(odev)) {
 			rv |= ( _drbd_set_state(_NS(odev,aftr_isp,1),
 						ChgStateHard|ScheduleAfter)
@@ -782,10 +785,11 @@
 STATIC int _drbd_resume_next(drbd_dev *mdev)
 {
 	drbd_dev *odev;
-	int i, rv = 0;
+	struct list_head *p;
+	int rv = 0;
 
-	for (i=0; i < minor_count; i++) {
-		if( !(odev = minor_to_mdev(i)) ) continue;
+	list_for_each(p, &drbd_devs_list) {
+		odev = list_entry(p, struct Drbd_Conf, devs_list);
 		if ( odev->state.aftr_isp ) {
 			if (_drbd_may_sync_now(odev)) {
 				rv |= ( _drbd_set_state(_NS(odev,aftr_isp,0),
Index: trunk/drbd/drbd_nl.c
===================================================================
--- trunk/drbd/drbd_nl.c	(revision 2864)
+++ trunk/drbd/drbd_nl.c	(working copy)
@@ -354,7 +354,22 @@
 	return r;
 }
 
+STATIC int drbd_nl_create(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
+			   struct drbd_nl_cfg_reply *reply)
+{
+	reply->ret_code = drbd_create_device(nlp->drbd_minor);
 
+	return 0;
+}
+
+STATIC int drbd_nl_remove(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
+			   struct drbd_nl_cfg_reply *reply)
+{
+	reply->ret_code = drbd_remove_device(mdev);
+
+	return 0;
+}
+
 STATIC int drbd_nl_primary(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
 			   struct drbd_nl_cfg_reply *reply)
 {
@@ -1012,7 +1027,7 @@
 STATIC int drbd_nl_net_conf(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
 			    struct drbd_nl_cfg_reply *reply)
 {
-	int i,ns;
+	int ns;
 	enum ret_codes retcode;
 	struct net_conf *new_conf = NULL;
 	struct crypto_hash *tfm = NULL;
@@ -1020,6 +1035,7 @@
 	struct hlist_head *new_ee_hash = NULL;
 	drbd_dev *odev;
 	char hmac_name[HMAC_NAME_L];
+	struct list_head *p;
 
 	if (mdev->state.conn > StandAlone) {
 		retcode=HaveNetConfig;
@@ -1075,9 +1091,10 @@
 #define O_ADDR(A) (((struct sockaddr_in *)&A->peer_addr)->sin_addr.s_addr)
 #define O_PORT(A) (((struct sockaddr_in *)&A->peer_addr)->sin_port)
 	retcode = NoError;
-	for(i=0;i<minor_count;i++) {
-		odev = minor_to_mdev(i);
-		if(!odev || odev == mdev) continue;
+	down(&drbd_devs_mutex);
+	list_for_each(p, &drbd_devs_list) {
+		odev = list_entry(p, struct Drbd_Conf, devs_list);
+		if(odev == mdev) continue;
 		if( inc_net(odev)) {
 			if( M_ADDR(new_conf) == M_ADDR(odev->net_conf) &&
 			    M_PORT(new_conf) == M_PORT(odev->net_conf) ) {
@@ -1088,9 +1105,13 @@
 				retcode=OAAlreadyInUse;
 			}
 			dec_net(odev);
-			if(retcode != NoError) goto fail;
+			if(retcode != NoError) {
+				up(&drbd_devs_mutex);
+				goto fail;
+			}
 		}
 	}
+	up(&drbd_devs_mutex);
 #undef M_ADDR
 #undef M_PORT
 #undef O_ADDR
@@ -1515,27 +1536,10 @@
 
 STATIC drbd_dev *ensure_mdev(struct drbd_nl_cfg_req *nlp)
 {
-	drbd_dev *mdev;
+	drbd_dev *mdev = minor_to_mdev(nlp->drbd_minor);
 
-	mdev = minor_to_mdev(nlp->drbd_minor);
-
-	if(!mdev && (nlp->flags & DRBD_NL_CREATE_DEVICE)) {
-		mdev = drbd_new_device(nlp->drbd_minor);
-
-		spin_lock_irq(&drbd_pp_lock);
-		if( minor_table[nlp->drbd_minor] == NULL) {
-			minor_table[nlp->drbd_minor] = mdev;
-			mdev = NULL;
-		}
-		spin_unlock_irq(&drbd_pp_lock);
-
-		if(mdev) {
-			if(mdev->app_reads_hash) kfree(mdev->app_reads_hash);
-			if(mdev->md_io_page) __free_page(mdev->md_io_page);
-			kfree(mdev);
-			mdev = NULL;
-		}
-
+	if(!mdev && (nlp->flags & DRBD_NL_CREATE_DEVICE)) { 
+		drbd_create_device(nlp->drbd_minor);
 		mdev = minor_to_mdev(nlp->drbd_minor);
 	}
 
@@ -1550,6 +1554,8 @@
 };
 
 static struct cn_handler_struct cnd_table[] = {
+	[ P_create ]		= { &drbd_nl_create,		0 },
+	[ P_remove ]		= { &drbd_nl_remove,		0 },
 	[ P_primary ]		= { &drbd_nl_primary,		0 },
 	[ P_secondary ]		= { &drbd_nl_secondary,		0 },
 	[ P_disk_conf ]		= { &drbd_nl_disk_conf,		0 },
@@ -1585,7 +1591,7 @@
 	struct cn_handler_struct *cm;
 	struct cn_msg *cn_reply;
 	struct drbd_nl_cfg_reply* reply;
-	drbd_dev *mdev;
+	drbd_dev *mdev = NULL;
 	int retcode,rr;
 	int reply_size = sizeof(struct cn_msg)
 		+ sizeof(struct drbd_nl_cfg_reply)
@@ -1595,10 +1601,13 @@
 		printk(KERN_ERR DEVICE_NAME "try_module_get() failed!\n");
 		return;
 	}
-
-	if( !(mdev = ensure_mdev(nlp)) ) {
-		retcode=MinorNotKnown;
-		goto fail;
+	
+	if (nlp->packet_type != P_create) {
+		mdev = ensure_mdev(nlp);
+		if (!mdev) {
+			retcode = MinorNotKnown;
+			goto fail;
+		}
 	}
 
 	TRACE(TraceTypeNl, TraceLvlSummary, nl_trace_packet(data););
Index: trunk/drbd/linux/drbd.h
===================================================================
--- trunk/drbd/linux/drbd.h	(revision 2864)
+++ trunk/drbd/linux/drbd.h	(working copy)
@@ -113,6 +113,9 @@
 	HaveNoDiskConfig,
 	ProtocolCRequired,
 
+	MinorInUse,
+	MinorInvalid,
+
 	/* insert new ones above this line */
 	AfterLastRetCode
 };
Index: trunk/drbd/linux/drbd_nl.h
===================================================================
--- trunk/drbd/linux/drbd_nl.h	(revision 2864)
+++ trunk/drbd/linux/drbd_nl.h	(working copy)
@@ -90,6 +90,9 @@
 	STRING(		38,	T_MAY_IGNORE,	helper,		32)
 )
 
+PACKET(create, 21, )
+PACKET(remove, 22, )
+
 #undef PACKET
 #undef INTEGER
 #undef INT64
Index: trunk/drbd/drbd_main.c
===================================================================
--- trunk/drbd/drbd_main.c	(revision 2864)
+++ trunk/drbd/drbd_main.c	(working copy)
@@ -46,6 +46,7 @@
 #include <linux/reboot.h>
 #include <linux/notifier.h>
 #include <linux/byteorder/swabb.h>
+#include <linux/idr.h>
 
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
@@ -81,15 +82,13 @@
 MODULE_AUTHOR("Philipp Reisner <phil@linbit.com>, Lars Ellenberg <lars@linbit.com>");
 MODULE_DESCRIPTION("drbd - Distributed Replicated Block Device v" REL_VERSION);
 MODULE_LICENSE("GPL");
-MODULE_PARM_DESC(minor_count, "Maximum number of drbd devices (1-255)");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LANANA_DRBD_MAJOR);
 
 #include <linux/moduleparam.h>
 /* allow_open_on_secondary */
 MODULE_PARM_DESC(allow_oos, "DONT USE!");
 /* thanks to these macros, if compiled into the kernel (not-module),
- * this becomes the boot parameter drbd.minor_count */
-module_param(minor_count, int,0);
+ * this becomes the boot parameter */
 module_param(allow_oos, bool,0);
 
 #ifdef DRBD_ENABLE_FAULTS
@@ -105,7 +104,6 @@
 
 // module parameter, defined
 int major_nr = LANANA_DRBD_MAJOR;
-int minor_count = 32;
 
 int allow_oos = 0;
 
@@ -122,11 +120,6 @@
 // global panic flag
 volatile int drbd_did_panic = 0;
 
-/* in 2.6.x, our device mapping and config info contains our virtual gendisks
- * as member "struct gendisk *vdisk;"
- */
-struct Drbd_Conf **minor_table = NULL;
-
 drbd_kmem_cache_t *drbd_request_cache;
 drbd_kmem_cache_t *drbd_ee_cache;
 mempool_t *drbd_request_mempool;
@@ -143,6 +136,10 @@
 int          drbd_pp_vacant;
 wait_queue_head_t drbd_pp_wait;
 
+unsigned int prealloc_segments = 32;
+module_param(prealloc_segments,uint,0664);
+MODULE_PARM_DESC(prealloc_segments, "number of preallocated segments, default 32");
+
 STATIC struct block_device_operations drbd_ops = {
 	.owner =   THIS_MODULE,
 	.open =    drbd_open,
@@ -151,6 +148,12 @@
 
 #define ARRY_SIZE(A) (sizeof(A)/sizeof(A[0]))
 
+DECLARE_MUTEX(drbd_devs_mutex);
+LIST_HEAD(drbd_devs_list);
+
+STATIC DECLARE_MUTEX(_minor_lock);
+STATIC DEFINE_IDR(_minor_idr);
+
 /************************* The transfer log start */
 STATIC int tl_init(drbd_dev *mdev)
 {
@@ -1955,8 +1958,66 @@
 					0 } };
 }
 
-void drbd_init_set_defaults(drbd_dev *mdev)
+STATIC void drbd_list_add(drbd_dev *mdev)
 {
+	list_add_tail(&mdev->devs_list, &drbd_devs_list);
+}
+
+STATIC void drbd_list_del(drbd_dev *mdev)
+{
+	list_del(&mdev->devs_list);
+}
+
+drbd_dev *drbd_find_minor(int minor)
+{
+	return idr_find(&_minor_idr, minor);
+}
+
+STATIC int drbd_get_minor(drbd_dev *mdev, int minor)
+{
+	int r, m;
+
+	if (minor >= (1 << MINORBITS))
+		return MinorInvalid;
+
+	down(&_minor_lock);
+
+	if (idr_find(&_minor_idr, minor)) {
+		r = MinorInUse;
+		goto out;
+	}
+
+	if (!idr_pre_get(&_minor_idr, GFP_KERNEL)) {
+		r = KMallocFailed;
+		goto out;
+	}
+
+	if (idr_get_new_above(&_minor_idr, mdev, minor, &m)) {
+		r = KMallocFailed;
+		goto out;
+	}
+
+	if (m != minor) {
+		idr_remove(&_minor_idr, m);
+		r = MinorInUse;
+		goto out;
+	}
+
+	r = NoError;
+out:
+	up(&_minor_lock);
+	return r;
+}
+
+STATIC void drbd_put_minor(int minor)
+{
+	down(&_minor_lock);
+	idr_remove(&_minor_idr, minor);
+	up(&_minor_lock);
+}
+
+void drbd_init_set_defaults(drbd_dev *mdev, int minor)
+{
 	// the memset(,0,) did most of this
 	// note: only assignments, no allocation in here
 
@@ -2019,6 +2080,26 @@
 	drbd_thread_init(mdev, &mdev->worker, drbd_worker);
 	drbd_thread_init(mdev, &mdev->asender, drbd_asender);
 
+	mdev->rq_queue->queuedata = mdev;
+	mdev->rq_queue->max_segment_size = DRBD_MAX_SEGMENT_SIZE;
+
+	set_disk_ro(mdev->vdisk, TRUE);
+	mdev->vdisk->queue = mdev->rq_queue;
+	mdev->vdisk->major = MAJOR_NR;
+	mdev->vdisk->first_minor = minor;
+	mdev->vdisk->minors = 1;
+	mdev->vdisk->fops = &drbd_ops;
+	sprintf(mdev->vdisk->disk_name, DEVICE_NAME "%d", minor);
+	mdev->this_bdev = bdget(MKDEV(MAJOR_NR,minor));
+
+	// we have no partitions. we contain only ourselves.
+	mdev->this_bdev->bd_contains = mdev->this_bdev;
+	blk_queue_make_request(mdev->rq_queue, drbd_make_request_26);
+	blk_queue_merge_bvec(mdev->rq_queue, drbd_merge_bvec);
+	mdev->rq_queue->queue_lock = &mdev->req_lock; // needed since we use
+	// plugging on a queue, that actually has no requests!
+	mdev->rq_queue->unplug_fn = drbd_unplug_fn;
+
 #ifdef __arch_um__
 	INFO("mdev = 0x%p\n",mdev);
 #endif
@@ -2107,7 +2188,6 @@
 
 }
 
-
 void drbd_destroy_mempools(void)
 {
 	struct page *page;
@@ -2119,7 +2199,7 @@
 		drbd_pp_vacant--;
 	}
 
-	/* D_ASSERT(atomic_read(&drbd_pp_vacant)==0); */
+	/* D_ASSERT(drbd_pp_vacant==0); */
 
 	if (drbd_ee_mempool) mempool_destroy(drbd_ee_mempool);
 	if (drbd_request_mempool) mempool_destroy(drbd_request_mempool);
@@ -2137,7 +2217,7 @@
 int drbd_create_mempools(void)
 {
 	struct page *page;
-	const int number = (DRBD_MAX_SEGMENT_SIZE/PAGE_SIZE) * minor_count;
+	const int number = (DRBD_MAX_SEGMENT_SIZE/PAGE_SIZE) * prealloc_segments;
 	int i;
 
 	// prepare our caches and mempools
@@ -2171,6 +2251,7 @@
 		goto Enomem;
 
 	// drbd's page pool
+	init_waitqueue_head(&drbd_pp_wait);
 	spin_lock_init(&drbd_pp_lock);
 
 	for (i=0;i< number;i++) {
@@ -2201,165 +2282,190 @@
 STATIC struct notifier_block drbd_notifier = {
 	.notifier_call = drbd_notify_sys,
 };
+void drbd_free_device(drbd_dev *mdev)
+{
+	int rr;
 
+	drbd_free_resources(mdev);
 
-STATIC void __exit drbd_cleanup(void)
-{
-	int i, rr;
+	if (mdev->vdisk) {
+		if (mdev->vdisk->private_data)
+			del_gendisk(mdev->vdisk);
+		if (mdev->rq_queue)
+			blk_put_queue(mdev->rq_queue);
+		put_disk(mdev->vdisk);
+	}
+	
+	D_ASSERT(mdev->open_cnt == 0);
+	if (mdev->this_bdev) bdput(mdev->this_bdev);
 
-	unregister_reboot_notifier(&drbd_notifier);
+	tl_cleanup(mdev);
+	if (mdev->bitmap) drbd_bm_cleanup(mdev);
+	if (mdev->resync) lc_free(mdev->resync);
 
-	drbd_nl_cleanup();
+	rr = drbd_release_ee(mdev,&mdev->active_ee);
+	if(rr) ERR("%d EEs in active list found!\n",rr);
 
-	if (minor_table) {
-		if (drbd_proc)
-			remove_proc_entry("drbd",&proc_root);
-		i=minor_count;
-		while (i--) {
-			drbd_dev        *mdev  = minor_to_mdev(i);
-			struct gendisk  **disk = &mdev->vdisk;
-			request_queue_t **q    = &mdev->rq_queue;
+	rr = drbd_release_ee(mdev,&mdev->sync_ee);
+	if(rr) ERR("%d EEs in sync list found!\n",rr);
 
-			if(!mdev) continue;
-			drbd_free_resources(mdev);
+	rr = drbd_release_ee(mdev,&mdev->read_ee);
+	if(rr) ERR("%d EEs in read list found!\n",rr);
 
-			if (*disk) {
-				del_gendisk(*disk);
-				put_disk(*disk);
-				*disk = NULL;
-			}
-			if (*q) blk_put_queue(*q);
-			*q = NULL;
+	rr = drbd_release_ee(mdev,&mdev->done_ee);
+	if(rr) ERR("%d EEs in done list found!\n",rr);
 
-			D_ASSERT(mdev->open_cnt == 0);
-			if (mdev->this_bdev) bdput(mdev->this_bdev);
+	rr = drbd_release_ee(mdev,&mdev->net_ee);
+	if(rr) ERR("%d EEs in net list found!\n",rr);
 
-			tl_cleanup(mdev);
-			if (mdev->bitmap) drbd_bm_cleanup(mdev);
-			if (mdev->resync) lc_free(mdev->resync);
+	ERR_IF (!list_empty(&mdev->data.work.q)) {
+		struct list_head *lp;
+		list_for_each(lp,&mdev->data.work.q) {
+				DUMPP(lp);
+		}
+	};
 
-			rr = drbd_release_ee(mdev,&mdev->active_ee);
-			if(rr) ERR("%d EEs in active list found!\n",rr);
+	if (mdev->md_io_page)
+		__free_page(mdev->md_io_page);
 
-			rr = drbd_release_ee(mdev,&mdev->sync_ee);
-			if(rr) ERR("%d EEs in sync list found!\n",rr);
+	if (mdev->md_io_tmpp)
+		__free_page(mdev->md_io_tmpp);
 
-			rr = drbd_release_ee(mdev,&mdev->read_ee);
-			if(rr) ERR("%d EEs in read list found!\n",rr);
+	if (mdev->act_log) lc_free(mdev->act_log);
 
-			rr = drbd_release_ee(mdev,&mdev->done_ee);
-			if(rr) ERR("%d EEs in done list found!\n",rr);
+	if(mdev->ee_hash) {
+		kfree(mdev->ee_hash);
+		mdev->ee_hash_s = 0;
+		mdev->ee_hash = NULL;
+	}
+	if(mdev->tl_hash) {
+		kfree(mdev->tl_hash);
+		mdev->tl_hash_s = 0;
+		mdev->tl_hash = NULL;
+	}
+	if(mdev->app_reads_hash) {
+		kfree(mdev->app_reads_hash);
+		mdev->app_reads_hash = NULL;
+	}
+	if ( mdev->p_uuid ) {
+		kfree(mdev->p_uuid);
+		mdev->p_uuid = NULL;
+	}
+}
 
-			rr = drbd_release_ee(mdev,&mdev->net_ee);
-			if(rr) ERR("%d EEs in net list found!\n",rr);
+STATIC int drbd_alloc_device(drbd_dev *mdev, int minor)
+{
+	mdev->rq_queue = blk_alloc_queue(GFP_KERNEL);
+	if (!mdev->rq_queue)
+		goto Enomem;
 
-			ERR_IF (!list_empty(&mdev->data.work.q)) {
-				struct list_head *lp;
-				list_for_each(lp,&mdev->data.work.q) {
-					DUMPP(lp);
-				}
-			};
+	mdev->vdisk = alloc_disk(1);
+	if (!mdev->vdisk)
+		goto Enomem;
+	
+	drbd_init_set_defaults(mdev, minor);
 
-			if (mdev->md_io_page)
-				__free_page(mdev->md_io_page);
+	mdev->md_io_page = alloc_page(GFP_KERNEL);
+	if (!mdev->md_io_page)
+		goto Enomem;
 
-			if (mdev->md_io_tmpp)
-				__free_page(mdev->md_io_tmpp);
+	if (drbd_bm_init(mdev))
+		goto Enomem;
+	
+	// FIXME: lock access, if not module initializing ?
+	// no need to lock access, we are still initializing the module.
+	if (!tl_init(mdev))
+		goto Enomem;
 
-			if (mdev->act_log) lc_free(mdev->act_log);
+	mdev->app_reads_hash = kzalloc(APP_R_HSIZE*sizeof(void*),GFP_KERNEL);
+	if (!mdev->app_reads_hash)
+		goto Enomem;
+	
+	return NoError;
 
-			if(mdev->ee_hash) {
-				kfree(mdev->ee_hash);
-				mdev->ee_hash_s = 0;
-				mdev->ee_hash = NULL;
-			}
-			if(mdev->tl_hash) {
-				kfree(mdev->tl_hash);
-				mdev->tl_hash_s = 0;
-				mdev->tl_hash = NULL;
-			}
-			if(mdev->app_reads_hash) {
-				kfree(mdev->app_reads_hash);
-				mdev->app_reads_hash = NULL;
-			}
-			if ( mdev->p_uuid ) {
-				kfree(mdev->p_uuid);
-				mdev->p_uuid = NULL;
-			}
-		}
-		drbd_destroy_mempools();
-	}
+Enomem:
+	drbd_free_device(mdev);
+	return KMallocFailed;
+}
 
-	kfree(minor_table);
+int drbd_remove_device(drbd_dev *mdev)
+{
+	if (mdev->state.disk != Diskless)
+		return HaveDiskConfig;
 
-	if (unregister_blkdev(MAJOR_NR, DEVICE_NAME) != 0)
-		printk(KERN_ERR DEVICE_NAME": unregister of device failed\n");
+	if (mdev->state.conn != StandAlone)
+		return HaveNetConfig; 
 
-	printk(KERN_INFO DEVICE_NAME": module cleanup done.\n");
+	down(&drbd_devs_mutex);
+	drbd_list_del(mdev);
+	up(&drbd_devs_mutex);
+
+	/* wait all work will be finished */
+	drbd_thread_stop(&mdev->receiver);
+	drbd_thread_stop(&mdev->worker);
+
+	drbd_free_device(mdev);
+	drbd_put_minor(mdev_to_minor(mdev));
+	kfree(mdev);
+	module_put(THIS_MODULE);
+
+	return NoError;
 }
 
-drbd_dev *drbd_new_device(int minor)
+int drbd_create_device(int minor)
 {
-	drbd_dev *mdev = NULL;
-	struct gendisk *disk;
-	request_queue_t *q;
+	int rv = KMallocFailed;
+	drbd_dev *mdev;
 
+	if (!try_module_get(THIS_MODULE))
+		goto err0;
+
 	mdev = kzalloc(sizeof(drbd_dev),GFP_KERNEL);
-	if(!mdev) goto Enomem;
+	if (!mdev)
+		goto err1;
 
-	mdev->minor = minor;
+	rv = drbd_get_minor(mdev, minor);
+	if (rv != NoError)
+		goto err2;
 
-	drbd_init_set_defaults(mdev);
+	rv = drbd_alloc_device(mdev, minor);
+	if (rv != NoError)
+		goto err3;
 
-	q = blk_alloc_queue(GFP_KERNEL);
-	if (!q) goto Enomem;
-	mdev->rq_queue = q;
-	q->queuedata   = mdev;
-	q->max_segment_size = DRBD_MAX_SEGMENT_SIZE;
+	down(&drbd_devs_mutex);
+	drbd_list_add(mdev);
+	up(&drbd_devs_mutex);
 
-	disk = alloc_disk(1);
-	if (!disk) goto Enomem;
-	mdev->vdisk = disk;
+	// now any callback can be called
+	mdev->vdisk->private_data = mdev;
+	add_disk(mdev->vdisk);
+	return NoError;
 
-	set_disk_ro( disk, TRUE );
+err3:
+	drbd_put_minor(minor);
+err2:
+	kfree(mdev);
+err1:
+	module_put(THIS_MODULE);
+err0:
+	return rv;
+}
 
-	disk->queue = q;
-	disk->major = MAJOR_NR;
-	disk->first_minor = minor;
-	disk->fops = &drbd_ops;
-	sprintf(disk->disk_name, DEVICE_NAME "%d", minor);
-	disk->private_data = mdev;
-	add_disk(disk);
+STATIC void __exit drbd_cleanup(void)
+{
+	unregister_reboot_notifier(&drbd_notifier);
 
-	mdev->this_bdev = bdget(MKDEV(MAJOR_NR,minor));
-	// we have no partitions. we contain only ourselves.
-	mdev->this_bdev->bd_contains = mdev->this_bdev;
+	drbd_nl_cleanup();
 
-	blk_queue_make_request(q, drbd_make_request_26);
-	blk_queue_merge_bvec(q, drbd_merge_bvec);
-	q->queue_lock = &mdev->req_lock; // needed since we use
-		// plugging on a queue, that actually has no requests!
-	q->unplug_fn = drbd_unplug_fn;
+	if (drbd_proc)
+		remove_proc_entry("drbd",&proc_root);
 
-	mdev->md_io_page = alloc_page(GFP_KERNEL);
-	if(!mdev->md_io_page) goto Enomem;
+	if (unregister_blkdev(MAJOR_NR, DEVICE_NAME) != 0)
+		printk(KERN_ERR DEVICE_NAME": unregister of device failed\n");
 
-	if (drbd_bm_init(mdev)) goto Enomem;
-	// no need to lock access, we are still initializing the module.
-	if (!tl_init(mdev)) goto Enomem;
-
-	mdev->app_reads_hash=kzalloc(APP_R_HSIZE*sizeof(void*),GFP_KERNEL);
-	if (!mdev->app_reads_hash) goto Enomem;
-
-	return mdev;
-
- Enomem:
-	if(mdev) {
-		if(mdev->app_reads_hash) kfree(mdev->app_reads_hash);
-		if(mdev->md_io_page) __free_page(mdev->md_io_page);
-		kfree(mdev);
-	}
-	return NULL;
+	drbd_destroy_mempools();
+	
+	printk(KERN_INFO DEVICE_NAME": module cleanup done.\n");
 }
 
 int __init drbd_init(void)
@@ -2409,16 +2515,6 @@
 		return -EINVAL;
 	}
 
-	if (1 > minor_count||minor_count > 255) {
-		printk(KERN_ERR DEVICE_NAME
-			": invalid minor_count (%d)\n",minor_count);
-#ifdef MODULE
-		return -EINVAL;
-#else
-		minor_count = 8;
-#endif
-	}
-
 	if( (err = drbd_nl_init()) ) {
 		return err;
 	}
@@ -2436,13 +2532,8 @@
 	/*
 	 * allocate all necessary structs
 	 */
-	err = -ENOMEM;
-
-	init_waitqueue_head(&drbd_pp_wait);
-
+	err = -ENOMEM;	
 	drbd_proc = NULL; // play safe for drbd_cleanup
-	minor_table = kzalloc(sizeof(drbd_dev *)*minor_count,GFP_KERNEL);
-	if(!minor_table) goto Enomem;
 
 	if ((err = drbd_create_mempools()))
 		goto Enomem;
@@ -2469,7 +2560,6 @@
 	       API_VERSION,PRO_VERSION);
 	printk(KERN_INFO DEVICE_NAME ": %s\n", drbd_buildtag());
 	printk(KERN_INFO DEVICE_NAME": registered as block device major %d\n", MAJOR_NR);
-	printk(KERN_INFO DEVICE_NAME": minor_table @ 0x%p\n", minor_table);
 
 	return 0; // Success!
 
Index: trunk/drbd/drbd_req.c
===================================================================
--- trunk/drbd/drbd_req.c	(revision 2864)
+++ trunk/drbd/drbd_req.c	(working copy)
@@ -1110,7 +1110,8 @@
 		/* rather error out here than BUG in bio_split */
 		ERR("bio would need to, but cannot, be split: "
 		    "(vcnt=%u,idx=%u,size=%u,sector=%llu)\n",
-		    bio->bi_vcnt, bio->bi_idx, bio->bi_size, bio->bi_sector);
+		    bio->bi_vcnt, bio->bi_idx, bio->bi_size,
+		    (unsigned long long) bio->bi_sector);
 		bio_endio(bio, bio->bi_size, -EINVAL);
 		return 0;
 	} else {
Index: trunk/drbd/drbd_int.h
===================================================================
--- trunk/drbd/drbd_int.h	(revision 2864)
+++ trunk/drbd/drbd_int.h	(working copy)
@@ -40,7 +40,6 @@
 #include "lru_cache.h"
 
 // module parameter, defined in drbd_main.c
-extern int minor_count;
 extern int allow_oos;
 extern int major_nr;
 extern int use_nbd_major;
@@ -141,7 +140,7 @@
 //       Otherwise this is not portable from gcc-2.95 to gcc-3.3
 #define PRINTK(level,fmt,args...) \
 	printk(level DEVICE_NAME "%d: " fmt, \
-		mdev->minor , ##args)
+		mdev_to_minor(mdev) , ##args)
 
 #define ALERT(fmt,args...) PRINTK(KERN_ALERT, fmt , ##args)
 #define ERR(fmt,args...)  PRINTK(KERN_ERR, fmt , ##args)
@@ -263,7 +262,6 @@
 /* drbd_meta-data.c (still in drbd_main.c) */
 #define DRBD_MD_MAGIC (DRBD_MAGIC+4) // 4th incarnation of the disk layout.
 
-extern struct Drbd_Conf **minor_table;
 
 /***
  * on the wire
@@ -861,22 +859,23 @@
 	atomic_t packet_seq;
 	unsigned int peer_seq;
 	spinlock_t peer_seq_lock;
-	int minor;
 	unsigned long comm_bm_set; // communicated number of set bits.
+
+	struct list_head devs_list;
 };
 
+extern struct semaphore drbd_devs_mutex;
+extern struct list_head drbd_devs_list;
+extern drbd_dev *drbd_find_minor(int minor);
+
 static inline drbd_dev *minor_to_mdev(int minor)
 {
-	drbd_dev *mdev;
-
-	mdev = minor < minor_count ? minor_table[minor] : NULL;
-
-	return mdev;
+	return drbd_find_minor(minor);
 }
 
 static inline int mdev_to_minor(drbd_dev *mdev)
 {
-	return mdev->minor;
+	return mdev->vdisk->first_minor;
 }
 
 /* returns 1 if it was successfull,
@@ -1165,7 +1164,6 @@
  * because of kmem_cache_t weirdness */
 #include "drbd_compat_wrappers.h"
 
-extern int minor_count;
 extern drbd_kmem_cache_t *drbd_request_cache;
 extern drbd_kmem_cache_t *drbd_ee_cache;
 extern mempool_t *drbd_request_mempool;
@@ -1175,8 +1173,10 @@
 extern spinlock_t   drbd_pp_lock;
 extern int          drbd_pp_vacant;
 extern wait_queue_head_t drbd_pp_wait;
+extern unsigned int prealloc_segments;
 
-extern drbd_dev *drbd_new_device(int minor);
+extern int drbd_create_device(int minor);
+extern int drbd_remove_device(drbd_dev *mdev);
 
 // Dynamic tracing framework
 #ifdef ENABLE_DYNAMIC_TRACE

--Boundary-00=_oCcMGbJgD3CC11b
Content-Type: text/x-diff; charset="us-ascii";
	name="drbd-dynamic-devs-user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="drbd-dynamic-devs-user.patch"

Index: trunk/user/drbdadm_main.c
===================================================================
--- trunk/user/drbdadm_main.c	(revision 2864)
+++ trunk/user/drbdadm_main.c	(working copy)
@@ -85,6 +85,7 @@
 extern int yydebug;
 extern FILE* yyin;
 
+int adm_create(struct d_resource* ,const char* );
 int adm_attach(struct d_resource* ,const char* );
 int adm_connect(struct d_resource* ,const char* );
 int adm_generic_s(struct d_resource* ,const char* );
@@ -134,7 +135,7 @@
 int soi=0;
 volatile int alarm_raised;
 
-struct deferred_cmd *deferred_cmds[3] = { NULL, NULL, NULL };
+struct deferred_cmd *deferred_cmds[4] = { NULL, NULL, NULL, NULL };
 
 void schedule_dcmd( int (* function)(struct d_resource*,const char* ),
 		    struct d_resource* res,
@@ -180,7 +181,8 @@
 {
   return _run_dcmds(deferred_cmds[0]) ||
     _run_dcmds(deferred_cmds[1]) ||
-    _run_dcmds(deferred_cmds[2]);
+    _run_dcmds(deferred_cmds[2]) ||
+    _run_dcmds(deferred_cmds[3]);
 }
 
 struct option admopt[] = {
@@ -194,6 +196,8 @@
 
 struct adm_cmd cmds[] = {
 /*   name, function,                  show, needs res, verify_ips */
+  { "create",		 adm_create,    1,1,0 },
+  { "remove",		 adm_generic_s, 1,1,0 },
   { "attach",            adm_attach,    1,1,0 },
   { "detach",            adm_generic_s, 1,1,0 },
   { "connect",           adm_connect,   1,1,1 },
@@ -759,6 +763,19 @@
     OPT=OPT->next; \
   }
 
+int adm_create(struct d_resource* res,const char* unused __attribute((unused)))
+{
+  char* argv[MAX_ARGS];
+  int argc=0;
+
+  argv[NA(argc)]=drbdsetup;
+  argv[NA(argc)]=res->me->device;
+  argv[NA(argc)]="create";
+  argv[NA(argc)]=0;
+
+  return m_system(argv,SLEEPS_LONG);
+}
+
 int adm_attach(struct d_resource* res,const char* unused __attribute((unused)))
 {
   char* argv[MAX_ARGS];
@@ -995,9 +1012,10 @@
 
 static int adm_up(struct d_resource* res,const char* unused __attribute((unused)))
 {
-  schedule_dcmd(adm_attach,res,NULL,0);
-  schedule_dcmd(adm_syncer,res,NULL,1);
-  schedule_dcmd(adm_connect,res,NULL,2);
+  schedule_dcmd(adm_create,res,NULL,0);
+  schedule_dcmd(adm_attach,res,NULL,1);
+  schedule_dcmd(adm_syncer,res,NULL,2);
+  schedule_dcmd(adm_connect,res,NULL,3);
 
   return 0;
 }
Index: trunk/user/drbdsetup.c
===================================================================
--- trunk/user/drbdsetup.c	(revision 2864)
+++ trunk/user/drbdsetup.c	(working copy)
@@ -347,6 +347,8 @@
 		wait_cmds_options, w_connected_state } } },
 	{"wait-sync", 0, F_EVENTS_CMD, { .ep = {
 		wait_cmds_options, w_synced_state } } },
+	{"create", P_create, F_CONFIG_CMD, {{NULL, NULL}}},
+	{"remove", P_remove, F_CONFIG_CMD, {{NULL, NULL}}},
 };
 
 #define EM(C) [ C - RetCodeBase ]
@@ -393,7 +395,9 @@
 	EM(PauseFlagAlreadyClear) = "Sync-pause flag is already cleared",
 	EM(DiskLowerThanOutdated) = "Disk state is lower than outdated",
 	EM(HaveNoDiskConfig) = "Device does not have a disk-config",
-	EM(ProtocolCRequired) = "Protocol C required"
+	EM(ProtocolCRequired) = "Protocol C required",
+	EM(MinorInUse) = "Minor number in use.",
+	EM(MinorInvalid) = "Minor number invalid."
 };
 #define MAX_ERROR (sizeof(error_messages)/sizeof(*error_messages))
 const char * error_to_string(int err_no)
@@ -1170,11 +1174,17 @@
 	cm = find_cmd_by_name("secondary");
 	rv = cm->function(cm,minor,argc,argv);
 	if( rv ) return rv;
+
 	cm = find_cmd_by_name("disconnect");
-	cm->function(cm,minor,argc,argv);
+	rv = cm->function(cm,minor,argc,argv);	
+	if ( rv ) return rv;
+
 	cm = find_cmd_by_name("detach");
-	rv |= cm->function(cm,minor,argc,argv);
+	rv = cm->function(cm,minor,argc,argv);
+	if( rv ) return rv;
 
+	cm = find_cmd_by_name("remove");
+	rv = cm->function(cm,minor,argc,argv);
 	return rv;
 }
 

--Boundary-00=_oCcMGbJgD3CC11b--
