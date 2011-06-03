Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5B00E1056F4B
	for <drbd-dev@lists.linbit.com>; Fri,  3 Jun 2011 13:38:46 +0200 (CEST)
Resent-Message-ID: <20110603113846.GI9498@barkeeper1-xen.linbit>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E525A105695E
	for <drbd-dev@lists.linbit.com>; Fri,  3 Jun 2011 11:29:15 +0200 (CEST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>, drbd-dev@lists.linbit.com,
	dri-devel@lists.freedesktop.org
Date: Fri,  3 Jun 2011 02:28:45 -0700
Message-Id: <cover.1307092588.git.joe@perches.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [Drbd-dev] [Trivial PATCH 0/5] treewide: Use angle brackets for
	system includes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Just neatening.

Joe Perches (5):
  drbd: Use angle brackets for system includes
  drm: Use angle brackets for system includes
  aix94xx: Use angle brackets for system includes
  ALSA: asihpi: Use angle brackets for system includes
  staging: msm: Use angle brackets for system includes

 drivers/block/drbd/drbd_int.h                 |    2 +-
 drivers/block/drbd/drbd_nl.c                  |    4 ++--
 drivers/gpu/drm/drm_ioctl.c                   |    2 +-
 drivers/gpu/drm/i915/i915_gem_tiling.c        |    4 ++--
 drivers/gpu/drm/nouveau/nouveau_drv.h         |   10 +++++-----
 drivers/gpu/drm/ttm/ttm_agp_backend.c         |    6 +++---
 drivers/gpu/drm/ttm/ttm_bo.c                  |    6 +++---
 drivers/gpu/drm/ttm/ttm_bo_manager.c          |    6 +++---
 drivers/gpu/drm/ttm/ttm_bo_util.c             |    4 ++--
 drivers/gpu/drm/ttm/ttm_execbuf_util.c        |    6 +++---
 drivers/gpu/drm/ttm/ttm_lock.c                |    4 ++--
 drivers/gpu/drm/ttm/ttm_memory.c              |    6 +++---
 drivers/gpu/drm/ttm/ttm_module.c              |    2 +-
 drivers/gpu/drm/ttm/ttm_object.c              |    4 ++--
 drivers/gpu/drm/ttm/ttm_page_alloc.c          |    4 ++--
 drivers/gpu/drm/ttm/ttm_tt.c                  |    8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c        |    4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |    8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |   12 ++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c       |    4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c          |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c           |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    6 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c       |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      |    4 ++--
 drivers/scsi/aic94xx/aic94xx_dump.c           |    2 +-
 drivers/staging/msm/ebi2_l2f.c                |    2 +-
 drivers/staging/msm/ebi2_tmd20.c              |    2 +-
 drivers/staging/msm/mddihost.h                |    2 +-
 drivers/staging/msm/mdp_ppp.c                 |    2 +-
 drivers/staging/msm/mdp_ppp_v20.c             |    2 +-
 drivers/staging/msm/mdp_ppp_v31.c             |    2 +-
 drivers/staging/msm/msm_fb.h                  |    2 +-
 include/drm/ttm/ttm_bo_driver.h               |   12 ++++++------
 include/drm/ttm/ttm_execbuf_util.h            |    2 +-
 include/drm/ttm/ttm_lock.h                    |    2 +-
 include/linux/drbd_tag_magic.h                |    2 +-
 sound/pci/asihpi/hpidspcd.c                   |    2 +-
 39 files changed, 80 insertions(+), 80 deletions(-)

-- 
1.7.5.rc3.dirty

