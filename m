Return-Path: <lmb@suse.de>
Date: Mon, 14 Aug 2006 21:47:08 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 0.7 with recent kernels?
Message-ID: <20060814194708.GJ15779@marowsky-bree.de>
References: <20060814131554.GC15779@marowsky-bree.de>
	<20060814163536.GF7226@soda.linbit>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060814163536.GF7226@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2006-08-14T18:35:36, Lars Ellenberg <Lars.Ellenberg@linbit.com> wrote:

> / 2006-08-14 15:15:54 +0200
> \ Lars Marowsky-Bree:
> > Hi,
> > 
> > did anyone already rip out the devfs support from drbd 0.7 to make it
> > compile with the latest kernels from upstream again, so I can avoid
> > doing it myself? ;-)
> 
> "latest kernels" ...
> well, we still compile against 2.6.17 as is.

I was referring to the upcoming 2.6.18.

I've attached the patch needed to compile it with that. Simple enough
indeed ;-)


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"


--9amGYk9869ThD9tj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="drbd-2.6.18.diff"

Index: drbd/drbd_main.c
===================================================================
--- drbd/drbd_main.c	(revision 2372)
+++ drbd/drbd_main.c	(working copy)
@@ -49,7 +49,9 @@
 #include <linux/mm_inline.h>
 #endif
 #include <linux/slab.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 #include <linux/devfs_fs_kernel.h>
+#endif
 
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
@@ -144,10 +146,11 @@
 #endif
 int disable_bd_claim = 0;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 // devfs name
 char* drbd_devfs_name = "drbd";
+#endif
 
-
 // global panic flag
 volatile int drbd_did_panic = 0;
 
@@ -1695,8 +1698,10 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	devfs_unregister(devfs_handle);
 #else
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 	devfs_remove(drbd_devfs_name);
 #endif
+#endif
 
 	if (unregister_blkdev(MAJOR_NR, DEVICE_NAME) != 0)
 		printk(KERN_ERR DEVICE_NAME": unregister of device failed\n");
@@ -1769,7 +1774,9 @@
 		return err;
 	}
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 	drbd_devfs_name = (major_nr == NBD_MAJOR) ? "nbd" : "drbd";
+#endif
 
 	/*
 	 * allocate all necessary structs
@@ -1791,7 +1798,9 @@
 	if (unlikely(!drbd_blocksizes)) goto Enomem;
 #else
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 	devfs_mk_dir(drbd_devfs_name);
+#endif
 
 	for (i = 0; i < minor_count; i++) {
 		drbd_dev    *mdev = drbd_conf + i;
@@ -1814,7 +1823,9 @@
 		disk->first_minor = i;
 		disk->fops = &drbd_ops;
 		sprintf(disk->disk_name, DEVICE_NAME "%d", i);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 		sprintf(disk->devfs_name, "%s/%d", drbd_devfs_name, i);
+#endif
 		disk->private_data = mdev;
 		add_disk(disk);
 
Index: drbd/drbd_int.h
===================================================================
--- drbd/drbd_int.h	(revision 2372)
+++ drbd/drbd_int.h	(working copy)
@@ -73,8 +73,10 @@
 extern int major_nr;
 extern int use_nbd_major;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 // use_nbd_major ? "nbd" : "drbd";
 extern char* drbd_devfs_name;
+#endif
 
 #include <linux/major.h>
 #ifdef DRBD_MAJOR

--9amGYk9869ThD9tj--
