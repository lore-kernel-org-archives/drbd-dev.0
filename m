Return-Path: <stf_xl@wp.pl>
Received: from ip-83-238-22-2.netia.com.pl (HELO lapsg1.open-e.pl)
	(stf_xl@wp.pl@[83.238.22.2]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES128-SHA encrypted SMTP
	for <drbd-dev@lists.linbit.com>; 1 Feb 2008 15:39:53 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: drbd-dev@lists.linbit.com
Date: Fri, 1 Feb 2008 15:49:50 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OGzoHG3i5XprxST"
Message-Id: <200802011549.50898.stf_xl@wp.pl>
Subject: [Drbd-dev] [PATCH] DRBD 8.0 return error when vmalloc fail
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_OGzoHG3i5XprxST
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Bitmap allocation failure is not visible for users. First reason is drbradm
not return status of executed commands  Second determin_dev_size() function
return enum value which badly become non negative at function output from
negative error code (at least for gcc3) . Attached patch is fix for these issues.

Stanislaw Gruszka

--Boundary-00=_OGzoHG3i5XprxST
Content-Type: text/x-diff; charset="us-ascii";
	name="return-error-when-vmalloc-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="return-error-when-vmalloc-fail.patch"

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 72796f2..1847844 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1300,7 +1300,7 @@ extern int is_valid_ar_handle(drbd_request_t *, sector_t);
 // drbd_nl.c
 extern char* ppsize(char* buf, unsigned long long size);
 extern sector_t drbd_new_dev_size(struct Drbd_Conf*, struct drbd_backing_dev*);
-enum determin_dev_size_enum { unchanged = 0, shrunk = 1, grew = 2 };
+enum determin_dev_size_enum { dev_size_error = -1, unchanged = 0, shrunk = 1, grew = 2 };
 extern enum determin_dev_size_enum drbd_determin_dev_size(drbd_dev*);
 extern void resync_after_online_grow(drbd_dev *mdev);
 extern void drbd_setup_queue_param(drbd_dev *mdev, unsigned int);
diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 1dd1aed..683d1f3 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -461,7 +461,7 @@ enum determin_dev_size_enum drbd_determin_dev_size(drbd_dev* mdev)
 	char ppb[10];
 
 	int md_moved, la_size_changed;
-	int rv=unchanged;
+	enum determin_dev_size_enum rv=unchanged;
 
 	wait_event(mdev->al_wait, lc_try_lock(mdev->act_log));
 
@@ -490,7 +490,7 @@ enum determin_dev_size_enum drbd_determin_dev_size(drbd_dev* mdev)
 				    "Leaving size unchanged at size = %lu KB\n",
 				    (unsigned long)size);
 			}
-			rv = err;
+			rv = dev_size_error;
 		}
 		// racy, see comments above.
 		drbd_set_my_capacity(mdev,size);
@@ -498,7 +498,7 @@ enum determin_dev_size_enum drbd_determin_dev_size(drbd_dev* mdev)
 		INFO("size = %s (%llu KB)\n",ppsize(ppb,size>>1),
 		     (unsigned long long)size>>1);
 	}
-	if (rv < 0) goto out;
+	if (rv == dev_size_error) goto out;
 
 	la_size_changed = (la_size != mdev->bc->md.la_size_sect);
 
@@ -931,7 +931,7 @@ STATIC int drbd_nl_disk_conf(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
 	}
 
 	drbd_bm_lock(mdev); // racy...
-	if (drbd_determin_dev_size(mdev) < 0) {
+	if (drbd_determin_dev_size(mdev) == dev_size_error) {
 		retcode = VMallocFailed;
 		goto unlock_bm;
 	}
@@ -1309,7 +1309,7 @@ STATIC int drbd_nl_resize(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
 	struct resize rs;
 	int retcode=NoError;
 	int ldsc = 0; /* local disk size changed */
-	int dd;
+	enum determin_dev_size_enum dd;
 
 	memset(&rs, 0, sizeof(struct resize));
 	if (!resize_from_tags(mdev,nlp->tag_list,&rs)) {
@@ -1344,7 +1344,7 @@ STATIC int drbd_nl_resize(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
 	drbd_md_sync(mdev);
 	drbd_bm_unlock(mdev);
 	dec_local(mdev);
-	if (dd < 0) {
+	if (dd == dev_size_error) {
 		retcode = VMallocFailed;
 		goto fail;
 	}
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 50197b0..6642927 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2238,7 +2238,6 @@ STATIC int receive_sizes(drbd_dev *mdev, Drbd_Header *h)
 	sector_t p_size, p_usize, my_usize;
 	int ldsc = 0; /* local disk size changed */
 	drbd_conns_t nconn;
-	int dd;
 
 	ERR_IF(h->length != (sizeof(*p)-sizeof(*h))) return FALSE;
 	if (drbd_recv(mdev, h->payload, h->length) != h->length)
@@ -2293,11 +2292,12 @@ STATIC int receive_sizes(drbd_dev *mdev, Drbd_Header *h)
 
 	mdev->p_size=p_size;
 	if(inc_local(mdev)) {
+		enum determin_dev_size_enum dd;
 		drbd_bm_lock(mdev); // {
 		dd = drbd_determin_dev_size(mdev);
 		drbd_bm_unlock(mdev); // }
 		dec_local(mdev);
-		if (dd < 0) return FALSE;
+		if (dd == dev_size_error) return FALSE;
 		if (dd == grew && mdev->state.conn == Connected &&
 		    mdev->state.pdsk >= Inconsistent &&
 		    mdev->state.disk >= Inconsistent) {
diff --git a/user/drbdadm_main.c b/user/drbdadm_main.c
index b3445a2..6ed17ec 100644
--- a/user/drbdadm_main.c
+++ b/user/drbdadm_main.c
@@ -1938,7 +1938,7 @@ int main(int argc, char** argv)
       }
     }
 
-  run_dcmds();
+  rv = run_dcmds();
 
   free_config(config);
 

--Boundary-00=_OGzoHG3i5XprxST--
