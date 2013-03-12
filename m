Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6596E1055F5A
	for <drbd-dev@lists.linbit.com>; Wed, 13 Mar 2013 10:12:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 5CCED1B4368
	for <drbd-dev@lists.linbit.com>; Wed, 13 Mar 2013 10:12:42 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7EYSPT9CfMHr for <drbd-dev@lists.linbit.com>;
	Wed, 13 Mar 2013 10:12:42 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id EA0F21B4361
	for <drbd-dev@lists.linbit.com>; Wed, 13 Mar 2013 10:12:41 +0100 (CET)
Resent-Message-ID: <20130313091241.GC19508@soda.linbit>
Received: from condef001-v.nifty.com (condef001-v.nifty.com [210.131.4.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5C87F1017081
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 08:45:38 +0100 (CET)
Received: from nfmsa303g.nifmail.jp ([10.22.241.47])by condef001-v.nifty.com
	with ESMTP id r2C7b0x2008756
	for <drbd-dev@lists.linbit.com>; Tue, 12 Mar 2013 16:37:00 +0900
Message-ID: <14929986.1066301363073806770.herumi@nifty.com>
Date: Tue, 12 Mar 2013 16:36:46 +0900 (JST)
From: MITSUNARI Shigeo <herumi@nifty.com>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [request][patch] adding sysfs entry for backing_dev info
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

Hi, all.

We are using drbdsetup directly without drbdadm and configuration files
in order to configure DRBD resources dynamically.  Most operations can
be done without configuration files except one.

Currently, the kernel does not provide information about the attached
backing devices.
Without the information, we cannot implement such dynamic configurations
in a state-less manner.

The attached patch exposes the backing device information via sysfs entry.

For instance, the backing device of /dev/drbd0 can be obtained by:

    $ cat /sys/block/drbd0/drbd/backing_dev
    7:2 /dev/loop2

The format is "<major>:<minor> <backing device name>".

This patch is for drbd-8.3.13 with ubuntu 12.04.2 LTS kernel 3.2.37 #10.
I'm sorry that it is not for the latest version of drbd because it is quite
different from 8.3.13.

Could you review and merge or support the function?

Sincerely yours,
 Shigeo

-----------
diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 2065c0e..768d4ba 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -41,6 +41,54 @@
 #include <linux/drbd_limits.h>
 #include <linux/compiler.h>
 #include <linux/kthread.h>
+#include <linux/sysfs.h>
+
+static ssize_t drbd_attr_show(struct device *dev, char *page,
+			      ssize_t (*callback)(struct drbd_conf*, char *))
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct drbd_conf *mdev = disk->private_data;
+
+	return callback(mdev, page);
+}
+
+static ssize_t drbd_attr_backing_file_show(struct drbd_conf *mdev, char *buf)
+{
+	if (mdev && mdev->ldev && mdev->ldev->backing_bdev) {
+		dev_t d = mdev->ldev->backing_bdev->bd_dev;
+		return sprintf(buf, "%d:%d %s\n", MAJOR(d), MINOR(d), mdev->ldev->dc.backin
g_dev);
+	}
+	return 0;
+}
+
+static ssize_t drbd_attr_do_show_backing_file(struct device *d,
+	struct device_attribute *attr, char *b)
+{
+	return drbd_attr_show(d, b, drbd_attr_backing_file_show);
+}
+static struct device_attribute drbd_attr_backing_file =
+	__ATTR(backing_file, S_IRUGO, drbd_attr_do_show_backing_file, NULL);
+
+static struct attribute *drbd_attrs[] = {
+	&drbd_attr_backing_file.attr,
+	NULL,
+};
+
+static struct attribute_group drbd_attribute_group = {
+	.name = "drbd",
+	.attrs= drbd_attrs,
+};
+
+static int drbd_sysfs_init(struct drbd_conf *mdev)
+{
+	return sysfs_create_group(&disk_to_dev(mdev->vdisk)->kobj,
+				  &drbd_attribute_group);
+}
+
+static void drbd_sysfs_exit(struct drbd_conf *mdev)
+{
+	sysfs_remove_group(&disk_to_dev(mdev->vdisk)->kobj, &drbd_attribute_group);
+}
 
 static unsigned short *tl_add_blob(unsigned short *, enum drbd_tags, const vo
id *, int);
 static unsigned short *tl_add_str(unsigned short *, enum drbd_tags, const cha
r *);
@@ -1309,6 +1357,10 @@ STATIC int drbd_nl_disk_conf(struct drbd_conf *mdev, st
ruct drbd_nl_cfg_req *nlp
 	put_ldev(mdev);
 	reply->ret_code = retcode;
 	drbd_reconfig_done(mdev);
+	if (drbd_sysfs_init(mdev)) {
+		retcode = ERR_SYSFS_CREATE_GROUP;
+		goto fail;
+	}
 	return 0;
 
  force_diskless_dec:
@@ -1345,6 +1397,8 @@ STATIC int drbd_nl_detach(struct drbd_conf *mdev, struct
 drbd_nl_cfg_req *nlp,
 	int ret;
 	struct detach dt = {};
 
+	drbd_sysfs_exit(mdev);
+
 	if (!detach_from_tags(mdev, nlp->tag_list, &dt)) {
 		reply->ret_code = ERR_MANDATORY_TAG;
 		goto out;
diff --git a/drbd/linux/drbd.h b/drbd/linux/drbd.h
index e899aaa..84e7e09 100644
--- a/drbd/linux/drbd.h
+++ b/drbd/linux/drbd.h
@@ -149,6 +149,7 @@ enum drbd_ret_code {
 	ERR_CONG_NOT_PROTO_A	= 155,
 	ERR_PIC_AFTER_DEP	= 156,
 	ERR_PIC_PEER_DEP	= 157,
+	ERR_SYSFS_CREATE_GROUP = 158,
 
 	/* insert new ones above this line */
 	AFTER_LAST_ERR_CODE

-----------

