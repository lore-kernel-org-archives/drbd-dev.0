Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 582AB101AC75
	for <drbd-dev@lists.linbit.com>; Mon, 17 Feb 2014 17:23:53 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 17 Feb 2014 17:23:52 +0100
Message-ID: <1426530.nXFczoq90f@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT pull] DRBD code reorganization
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

Hi Jens,

I have here a number of patches, that do not change any functionality.
All patches from Rashika Kheria clean up compiler warnings, like making=

functions static etc... . All patches from Andreas Gr=FCnbacher restruc=
ture
code for further improvements. A single bugfix is hidden in there, that=

was committed by me.

Rashika patches where posted for review on LKML on December 19, 2013.
The other patches where posted for review on LKML on December 20 and 23=
.

This is of course for your tree that is intended for the 3.15 merge win=
dow.
Since you have not created a for-3.15/drivers branch as of today, I bas=
ed
this on Linus' 2.14-rc3.



The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f=
3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.drbd.org/linux-drbd.git for-3.15-p2

for you to fetch changes up to 2457b6d5ee1a9ff8a3c15ea8eaa5bc195a47d326=
:

  drbd: Add drbd_thread->resource and make drbd_thread->connection opti=
onal (2014-02-17 16:50:48 +0100)

----------------------------------------------------------------
Andreas Gruenbacher (52):
      idr: Add new function idr_is_empty()
      drbd: Describe the future high-level structure of DRBD
      drbd: Split off on-the-wire protocol definitions
      drbd: Rename struct drbd_conf -> struct drbd_device
      drbd: Rename "mdev" to "device"
      drbd: Rename drbd_tconn -> drbd_connection
      drbd: Introduce "peer_device" object between "device" and "connec=
tion"
      drbd: Improve some function and variable naming
      drbd: Add struct drbd_resource
      drbd: drbd_adm_down(): Move valid resource name check to drbd_adm=
_prepare()
      drbd: Add struct drbd_device->resource
      drbd: Minor cleanup in conn_new_minor()
      drbd: Add struct drbd_resource->devices
      drbd: Replace conn_get_by_name() with drbd_find_resource()
      drbd: conn_try_disconnect(): Use parameter instead of the global =
variable
      drbd: Move resource options from connection to resource
      drbd: Turn connection->volumes into connection->peer_devices
      drbd: Remove the terrible DEV hack
      drbd: Turn drbd_printk() into a polymorphic macro
      drbd: Replace and remove the obsolete conn_() macros
      drbd: Add explicit device parameter to D_ASSERT
      drbd: Rename drbd_{create,delete}_minor -> drbd_{create,delete}_d=
evice
      drbd: get_one_status(): Iterate over resource->devices instead of=
 connection->peer_devices
      drbd: drbd_adm_new_resource(): Check if resource exists, not if i=
t has any connections
      drbd: drbd_create_device(): Take a resource instead of a connecti=
on argument
      drbd: Rename net_conf variables old_conf -> old_net_conf and new_=
conf -> new_net_conf
      drbd: Iterate over all connections
      drbd: drbd_adm_prepare(): Only set adm_ctx.connection when a conn=
ection is requested
      drbd: Move conf_mutex from connection to resource
      drbd: Move susp, susp_nod, susp_fen from connection to resource
      drbd: Define the size of res_opts->cpu_mask in a single place
      drbd: Move cpu_mask from connection to resource
      drbd: Rename drbdd_init() -> drbd_receiver()
      drbd: Function prototype cleanups
      drbd: drbd_csum_bio(), drbd_csum_ee(): Remove unused device argum=
ent
      drbd: Replace vnr_to_mdev() with conn_peer_device()
      drbd: Pass a peer device to a number of fuctions
      drbd: Kill drbd_task_to_thread_name()
      drbd: Remove useless assertion
      drbd: Move string function prototypes from linux/drbd.h to drbd_s=
tring.h
      drbd: Rename w_prev_work_done -> w_complete
      drbd: Create a dedicated struct drbd_device_work
      drbd: Turn conn_flush_workqueue() into drbd_flush_workqueue()
      drbd: struct after_conn_state_chg_work: Use drbd_work instead of =
drbd_device_work
      drbd: struct drbd_peer_request: Use drbd_work instead of drbd_dev=
ice_work
      drbd: Make w_make_resync_request() static
      drbd: Turn w_make_ov_request and make_resync_request into "normal=
" functions
      drbd: In the worker thread, process drbd_work instead of drbd_dev=
ice_work items
      drbd: Get rid of first_peer_device() in handle_write_conflicts()
      drbd: Remove unused parameter of wire_flags_to_bio()
      drbd: Use the right peer device
      drbd: Add drbd_thread->resource and make drbd_thread->connection =
optional

Philipp Reisner (1):
      drbd: Add missing error goto

Rashika Kheria (10):
      drivers: block: Mark functions as static in drbd_main.c
      drivers: block: Mark functions as static in drbd_nl.c
      drivers: block: Mark function as static in drbd_actlog.c
      drivers: block: Move prototype declaration of function tl_abort_d=
isk_io() to appropriate header file from drbd_state.c
      drivers: block: Mark functions as static in drbd_req.c
      drivers: block: Mark functions as static in drbd_receiver.c
      drivers: block: Move prototype declaration to appropriate header =
file from drbd_main.c
      drivers: block: Mark the function as static in drbd_worker.c
      drivers: block: Mark function seq_printf_with_thousands_grouping(=
) as static in drbd_proc.c
      drivers: block: Remove unused function drbd_bm_write_lazy() in dr=
bd_bitmap.c

 Documentation/blockdev/drbd/data-structure-v9.txt |   38 +
 drivers/block/drbd/drbd_actlog.c                  |  629 ++---
 drivers/block/drbd/drbd_bitmap.c                  |  368 ++-
 drivers/block/drbd/drbd_int.h                     | 1130 ++++-----
 drivers/block/drbd/drbd_main.c                    | 2009 ++++++++-----=
---
 drivers/block/drbd/drbd_nl.c                      | 1653 +++++++------=
-
 drivers/block/drbd/drbd_proc.c                    |  140 +-
 drivers/block/drbd/drbd_protocol.h                |  295 +++
 drivers/block/drbd/drbd_receiver.c                | 2532 +++++++++++--=
--------
 drivers/block/drbd/drbd_req.c                     |  464 ++--
 drivers/block/drbd/drbd_req.h                     |   20 +-
 drivers/block/drbd/drbd_state.c                   |  859 +++----
 drivers/block/drbd/drbd_state.h                   |   40 +-
 drivers/block/drbd/drbd_strings.c                 |    1 +
 drivers/block/drbd/drbd_strings.h                 |    9 +
 drivers/block/drbd/drbd_worker.c                  |  944 ++++----
 drivers/block/drbd/drbd_wrappers.h                |   14 +-
 include/linux/drbd.h                              |    8 +-
 include/linux/drbd_genl.h                         |    6 +-
 include/linux/idr.h                               |    1 +
 lib/idr.c                                         |   10 +
 21 files changed, 5814 insertions(+), 5356 deletions(-)
 create mode 100644 Documentation/blockdev/drbd/data-structure-v9.txt
 create mode 100644 drivers/block/drbd/drbd_protocol.h
 create mode 100644 drivers/block/drbd/drbd_strings.h

