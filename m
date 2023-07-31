Return-Path: <dan.carpenter@linaro.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E1985420202
	for <drbd-dev@lists.linbit.com>; Mon, 31 Jul 2023 16:04:14 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
	5b1f17b1804b1-3fc0aecf15bso50908095e9.1
	for <drbd-dev@lists.linbit.com>; Mon, 31 Jul 2023 07:04:14 -0700 (PDT)
Date: Mon, 31 Jul 2023 11:15:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bobo.shaobowang@huawei.com
Message-ID: <ca0093ef-ccb0-4e2e-b845-7b8930579783@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [bug report] drbd: destroy workqueue when drbd device
	was freed
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

Hello Wang ShaoBo,

The patch 8692814b77ca: "drbd: destroy workqueue when drbd device was
freed" from Nov 24, 2022 (linux-next), leads to the following Smatch
static checker warning:

	drivers/block/drbd/drbd_main.c:2233 drbd_destroy_device()
	warn: sleeping in atomic context

drivers/block/drbd/drbd_main.c
    2193 void drbd_destroy_device(struct kref *kref)
    2194 {
    2195         struct drbd_device *device = container_of(kref, struct drbd_device, kref);
    2196         struct drbd_resource *resource = device->resource;
    2197         struct drbd_peer_device *peer_device, *tmp_peer_device;
    2198 
    2199         timer_shutdown_sync(&device->request_timer);
    2200 
    2201         /* paranoia asserts */
    2202         D_ASSERT(device, device->open_cnt == 0);
    2203         /* end paranoia asserts */
    2204 
    2205         /* cleanup stuff that may have been allocated during
    2206          * device (re-)configuration or state changes */
    2207 
    2208         drbd_backing_dev_free(device, device->ldev);
    2209         device->ldev = NULL;
    2210 
    2211         drbd_release_all_peer_reqs(device);
    2212 
    2213         lc_destroy(device->act_log);
    2214         lc_destroy(device->resync);
    2215 
    2216         kfree(device->p_uuid);
    2217         /* device->p_uuid = NULL; */
    2218 
    2219         if (device->bitmap) /* should no longer be there. */
    2220                 drbd_bm_cleanup(device);
    2221         __free_page(device->md_io.page);
    2222         put_disk(device->vdisk);
    2223         kfree(device->rs_plan_s);
    2224 
    2225         /* not for_each_connection(connection, resource):
    2226          * those may have been cleaned up and disassociated already.
    2227          */
    2228         for_each_peer_device_safe(peer_device, tmp_peer_device, device) {
    2229                 kref_put(&peer_device->connection->kref, drbd_destroy_connection);
    2230                 kfree(peer_device);
    2231         }
    2232         if (device->submit.wq)
--> 2233                 destroy_workqueue(device->submit.wq);
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The patch introduces this call to destroy_workqueue() which is a
sleeping function (mutex_lock etc).

    2234         kfree(device);
    2235         kref_put(&resource->kref, drbd_destroy_resource);

It's the drbd_endio_write_sec_final() function which calls
drbd_destroy_device() with preempt disabled.

drbd_endio_write_sec_final() <- disables preempt
-> drbd_destroy_device()

regards,
dan carpenter
