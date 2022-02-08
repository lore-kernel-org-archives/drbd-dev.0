Return-Path: <baijiaju1990@gmail.com>
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
	[209.85.210.182])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5DD874201E1
	for <drbd-dev@lists.linbit.com>; Tue,  8 Feb 2022 11:55:42 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id p43so637820pfw.1
	for <drbd-dev@lists.linbit.com>; Tue, 08 Feb 2022 02:55:42 -0800 (PST)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk
Message-ID: <3b992e3b-bf1a-426a-5e76-a822f5bf6e6a@gmail.com>
Date: Tue, 8 Feb 2022 18:55:20 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [BUG] block: drbd: possible deadlocks involving waiting
 and locking operations
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

Hello,

My static analysis tool reports three possible deadlocks in the drbd 
driver in Linux 5.16:

#BUG 1
drbd_adm_attach()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1810 (Lock A)
   wait_event(device->misc_wait, ...); --> Line 1824 (Wait X)

drbd_adm_disk_opts()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1582 (Lock A)
   get_ldev()
     get_ldev_if_state()
       _get_ldev_if_state()
         put_ldev()
           wake_up(&device->misc_wait); --> Line 2108 (Wake X)

#BUG 2
drbd_adm_invalidate()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 3024 (Lock A)
   wait_event(device->misc_wait, ...); --> Line 3030 (Wait X)

drbd_adm_disk_opts()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1582 (Lock A)
   get_ldev()
     get_ldev_if_state()
       _get_ldev_if_state()
         put_ldev()
           wake_up(&device->misc_wait); --> Line 2108 (Wake X)

#BUG 3
drbd_adm_invalidate_peer()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 3101 (Lock A)
   wait_event(device->misc_wait, ...); --> Line 3107 (Wait X)

drbd_adm_disk_opts()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1582 (Lock A)
   get_ldev()
     get_ldev_if_state()
       _get_ldev_if_state()
         put_ldev()
           wake_up(&device->misc_wait); --> Line 2108 (Wake X)

When drbd_adm_attach()/drbd_adm_invalidate()/drbd_adm_invalidate_peer() 
is executed, "Wait X" is performed by holding "Lock A". If 
drbd_adm_disk_opts() is executed at this time, because "Lock A" has been 
already held, "Wake X" cannot be performed to wake up "Wait X", causing 
possible deadlocks.

I am not quite sure whether these possible problems are real.
Any feedback would be appreciated, thanks :)

Best wishes,
Jia-Ju Bai

