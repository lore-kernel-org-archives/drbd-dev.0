Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BAB6E421783
	for <drbd-dev@lists.linbit.com>; Tue, 22 Feb 2022 08:38:36 +0100 (CET)
Date: Tue, 22 Feb 2022 08:38:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20220222073833.GA4979@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-8-hch@lst.de>
	<yq135kefh5j.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq135kefh5j.fsf@ca-mkp.ca.oracle.com>
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, ukrishn@linux.ibm.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	jinpu.wang@ionos.com, Christoph Hellwig <hch@lst.de>, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] [PATCH 7/7] block: remove REQ_OP_WRITE_SAME support
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Feb 19, 2022 at 08:44:18PM -0500, Martin K. Petersen wrote:
> > -static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
> > -{
> > -	return sprintf(page, "%llu\n",
> > -		(unsigned long long)q->limits.max_write_same_sectors << 9);
> > -}
> > -
> 
> This tripped one of my test scripts. We should probably return 0 here
> like we did for discard_zeroes_data and leave the sysfs entry in place.

The maybe fold this in?

---
From eae8e9b8cff5ee8522b00430a4aabd01ebc7c55a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 Feb 2022 08:35:59 +0100
Subject: block: restore the write_same_max sysfs attribute

Some userspace breaks if this attribute is gone.  Restore it and always
return 0.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4a5bb47bee3ce..431fdd036f65a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -212,6 +212,11 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
 	return queue_var_show(0, page);
 }
 
+static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", 0ULL);
+}
+
 static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 {
 	return sprintf(page, "%llu\n",
@@ -581,6 +586,7 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
@@ -636,6 +642,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
-- 
2.30.2

