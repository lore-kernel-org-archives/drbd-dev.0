Return-Path: <lee.jones@linaro.org>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1594C420F79
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 11:55:46 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id g20so3530573wmk.3
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 02:55:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Date: Fri, 12 Mar 2021 10:55:30 +0000
Message-Id: <20210312105530.2219008-12-lee.jones@linaro.org>
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/11] block: drbd: drbd_nl: Demote half-complete
	kernel-doc headers
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

Fixes the following W=1 kernel build warning(s):

 from drivers/block/drbd/drbd_nl.c:24:
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_attach’:
 drivers/block/drbd/drbd_nl.c:1968:10: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c:930: warning: Function parameter or member 'flags' not described in 'drbd_determine_dev_size'
 drivers/block/drbd/drbd_nl.c:930: warning: Function parameter or member 'rs' not described in 'drbd_determine_dev_size'
 drivers/block/drbd/drbd_nl.c:1148: warning: Function parameter or member 'dc' not described in 'drbd_check_al_size'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_nl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 31902304ddac7..e7d0e637e6321 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -918,7 +918,7 @@ void drbd_resume_io(struct drbd_device *device)
 		wake_up(&device->misc_wait);
 }
 
-/**
+/*
  * drbd_determine_dev_size() -  Sets the right device size obeying all constraints
  * @device:	DRBD device.
  *
@@ -1136,7 +1136,7 @@ drbd_new_dev_size(struct drbd_device *device, struct drbd_backing_dev *bdev,
 	return size;
 }
 
-/**
+/*
  * drbd_check_al_size() - Ensures that the AL is of the right size
  * @device:	DRBD device.
  *
-- 
2.27.0

