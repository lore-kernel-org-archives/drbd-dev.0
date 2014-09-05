Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EBC3101E04D
	for <drbd-dev@lists.linbit.com>; Fri,  5 Sep 2014 08:58:10 +0200 (CEST)
Date: Fri, 5 Sep 2014 08:58:09 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Imre Palik <imrep.amz@gmail.com>
Message-ID: <20140905065808.GM23497@soda.linbit>
References: <1409860749-13458-1-git-send-email-imrep.amz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409860749-13458-1-git-send-email-imrep.amz@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Matt Wilson <msw@amazon.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: fix throttling on newly created DM
 backing devices
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

On Thu, Sep 04, 2014 at 09:59:09PM +0200, Imre Palik wrote:
> From: "Palik, Imre" <imrep@amazon.de>
> 
> If the drbd backing device is a new device mapper device (e.g., a
> dm-linear mapping of an existing block device that contains data), the
> counters are initially 0 even though the device contains useful
> data. This causes throttling until something accesses the drbd device
> or the backing device.
> 
> The patch disables throttling, as long as only resync is responsible
> for disk activity on a freshly created device.

That does not change a thing, actually it makes matters worse,
if for some reason "curr_events" becomes negative, which can easily
happen... wrap arounds and all ... 

> 
> +	device->rs_last_events = -1;

>  	if (atomic_read(&device->ap_actlog_cnt)
> -	    || !device->rs_last_events || curr_events - device->rs_last_events > 64) {
> +		|| device->rs_last_events < 0
> +		|| curr_events - device->rs_last_events > 64) {
>  		unsigned long rs_left;

No, what I meant is something more like this.
I still need to review if the ->ldev->backing_bdev-> ... deref
is always safe to do. But I think it is.

commit c90cac67d6c12dcf3945f67a28718c40b644cc32
Author: Lars Ellenberg <lars.ellenberg@linbit.com>
Date:   Thu Sep 4 13:15:45 2014 +0200

    drbd: fix resync throttling initialization
    
    If for some reason DRBD resync was the only activity on a backend
    device, drbd_rs_c_min_rate_throttle() would mistakenly decide that it is
    still initialization time, and keep throttling the resync.
    
    This patch explicitly initializes ->rs_last_events to the current
    backend event counters, and drops the rs_last_events == 0 from the
    throttle condition.
    
    Reported-by: Mikhail Sugakov <msugakov@amazon.de>

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 7376edd..6da9d25 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2867,7 +2867,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 		    - atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
-	|| !device->rs_last_events || curr_events - device->rs_last_events > 64) {
+	|| curr_events - device->rs_last_events > 64) {
 		unsigned long rs_left;
 		int i;
 
diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index bdad488..1df1a63 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -1078,7 +1078,6 @@ __drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 		set_ov_position(device, ns.conn);
 		device->rs_start = now;
-		device->rs_last_events = 0;
 		device->rs_last_sect_ev = 0;
 		device->ov_last_oos_size = 0;
 		device->ov_last_oos_start = 0;
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 0f11292..43dd841 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -1630,6 +1630,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	atomic_set(&device->rs_sect_in, 0);
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
+	device->rs_last_events = drbd_backing_bdev_events(device->ldev->backing_bdev->bd_contains->bd_disk);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
@@ -1776,7 +1777,6 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		device->rs_failed    = 0;
 		device->rs_paused    = 0;
 		device->rs_same_csum = 0;
-		device->rs_last_events = 0;
 		device->rs_last_sect_ev = 0;
 		device->rs_total     = tw;
 		device->rs_start     = now;
