Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 824C010561A9
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7D5112A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HziLxd7oW1Pn for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 622B42ADE0A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sEvtZilj_H-V for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3D7262A910D
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:26 +0100 (CET)
Resent-Message-ID: <20151130193025.GZ22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0A7A110561A9
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:30:02 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:29:33 +0100
Message-Id: <1448659775-13596-9-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659775-13596-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
	<1448659775-13596-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 18/21] drbd: remove redundant declarations
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

both drbd_conn_str() and drbd_role_str() were already declared
extern in drbd_strings.h included in drbd_int.h

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_int.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 34bc84e..c898947 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1635,8 +1635,6 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 /* drbd_proc.c */
 extern struct proc_dir_entry *drbd_proc;
 extern const struct file_operations drbd_proc_fops;
-extern const char *drbd_conn_str(enum drbd_conns s);
-extern const char *drbd_role_str(enum drbd_role s);
 
 /* drbd_actlog.c */
 extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i);
-- 
2.1.4

