Return-Path: <lmb@suse.de>
Date: Mon, 21 Feb 2005 18:11:10 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20050221171110.GN7016@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] [patch] avoid long long division in _hash_fn
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

sector_t might be 64 bit, but long long divisions aren't supported in
kernel space in i386. This patch adds a straightforward cast to avoid an
unresolved symbol for __umoddi3.

Index: drbd/drbd_main.c
===================================================================
--- drbd/drbd_main.c    (revision 1763)
+++ drbd/drbd_main.c    (working copy)
@@ -164,7 +164,7 @@
 
 STATIC unsigned int tl_hash_fn(drbd_dev *mdev, sector_t sector)
 {
-       return (sector>>HT_SHIFT) % mdev->tl_hash_s;
+       return (unsigned int)(sector>>HT_SHIFT) % mdev->tl_hash_s;
 }
 
 
@@ -367,7 +367,7 @@
 
 STATIC unsigned int ee_hash_fn(drbd_dev *mdev, sector_t sector)
 {
-       return (sector>>HT_SHIFT) % mdev->ee_hash_s;
+       return (unsigned int)(sector>>HT_SHIFT) % mdev->ee_hash_s;
 }
 
 STATIC int overlaps(sector_t s1, int l1, sector_t s2, int l2)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

