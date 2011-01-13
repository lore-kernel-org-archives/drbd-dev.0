Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7DF581057AA9
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jan 2011 16:57:35 +0100 (CET)
Resent-Message-ID: <20110113155731.GG25975@barkeeper1-xen.linbit>
Received: from Exil2010.voltaire.com (fwil.voltaire.com [193.47.165.2])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E70BF1057ABD
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jan 2011 16:46:14 +0100 (CET)
Message-ID: <4D2F1E43.3050400@voltaire.com>
Date: Thu, 13 Jan 2011 17:46:11 +0200
From: Or Gerlitz <ogerlitz@voltaire.com>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
	<201101131604.58153.philipp.reisner@linbit.com>
In-Reply-To: <201101131604.58153.philipp.reisner@linbit.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <jaxboe@fusionio.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Philipp Reisner wrote:
> Yes, I send my pull requests to Jens, and CC them to LKML 
> If it would help you I can start to CC them to drbd-dev@lists.linbit.com 
> as well. It is a really low traffic mailing list

yep, please do that, it will help, so I'll subscribe to that list

> [...] the next pull request to Jens. (That will be for the 2.6.39 merge window)
> FYI, We are missing the (current) 2.6.38 merge window, with drbd-8.3.10
 

The drbd version in 2.6.37 is 8.3.9, looking on the git shortlog in the drbd-8.3 tree
between 8.3.9 to 8.3.10rc2 I see many many changes with most of them being kernel ones.

Does this means that currently you push upstream only whole drbd releases, and such 
a push can contain tens or even hundred patches?

Or.


Andreas Gruenbacher (32):
      drbd: Move compatibility headers into their own directory
      drbd: Get the include file order right
      drbd: Use standard make variable where we can
      drbd: No longer build and package drbd_trace.ko
      build: Add drbd-kernel.spec.in kernel module spec file template
      rpm system macro fixes for sles10, sles11, sles11-sp1, rhel5
      Update the .gitignore file
      build: Fix the use of %kernel_module_package_moddir
      man-pages: Minor grammar glitch
      compat: The min_not_zero() macro is now defined upstream
      Make sure that drbd_send() has sent the right number of bytes
      Remove left-over prototype
      drbd: Rename drbd_make_request_26 to drbd_make_request
      drbd: Get rid of unnecessary macros (1)
      drbd: Get rid of unnecessary macros (2)
      drbd: Rename enum drbd_ret_codes to enum drbd_ret_code
      drbd: Rename enum drbd_state_ret_codes to enum drbd_state_rv
      drbd: Be more explicit about functions that return an enum drbd_state_rv
      drbd: Another small enum drbd_state_rv cleanup
      drbd: This code is dead now
      drbd: Use the standard bool, true, and false keywords
      drbd: Document how struct drbd_nl_cfg_req->ret_code is used
      drbd: drbd_nl_disk_conf: Avoid a compiler warning
      drbd: receive_bitmap: Fix the wrong return value
      drbd: receive_bitmap: Avoid casting enum drbd_state_rv to int
      drbd: receive_bitmap: Missing free_page() on error path
      drbd: send_bitmap_rle_or_plain: Get rid of ugly and useless enum
      drbd: receive_bitmap_plain: Get rid of ugly and useless enum
      drbd: Fix: drbd_bitmap_io does not return an enum determine_dev_size
      drbd: Rename __inc_ap_bio_cond to may_inc_ap_bio
      drbd: With 2.6.37, I/O barriers have become plain old flushes
      drbd: Remove useless / wrong comments

Christoph Hellwig (1):
      block: remove BLKDEV_IFL_WAIT

Lars Ellenberg (67):
      drbd: fix compatibility bi_rw flag to dp_flag conversion
      drbd: add UNPLUG to any SYNC request on the receiving side
      drbd: don't recvmsg with zero length
      drbd: only reset online-verify start sector if verify completed
      drbd: improve online-verify progress tracking
      drbd: initialize online-verify progress tracking on verify target
      drbd: factor out advancement of resync marks for progress reporting
      drbd: advance progress step marks for online-verify
      drbd: show progress bar and ETA for online-verify
      drbd: factor out drbd_rs_controller_reset
      drbd: factor out drbd_rs_number_requests
      drbd: use the resync controller for online-verify requests as well
      drbd: disable drbd_tracing for >= 2.6.35
      drbd: fix potential wrap of 32bit oos:%lu display in /proc/drbd
      drbd: further converge progress display of resync and online-verify
      rhcs script: there is no OCF_RUNNING, replace with OCF_SUCCESS
      drbd: use irqsave in bio endio callback
      drbd: detect modification of in-flight buffers
      drbd: debug: limit nelink-broadcast of request on digest mismatch to 32k
      doc: improve notes about false positives when using data-integrity
      drbd: properly use max_hw_sectors to limit the our bio size
      drbd: restore compatibility with 32bit kernels
      build: debian: adjust build-depends
      build: allow build inside a git checkout to succeed without git installed
      build: make install disables all drbd.ko found in /lib/modules/$KVER/
      drbd: better fix for spin_lock_irqsave in endio callback
      fix compatibility with kernel versions < 2.6.9 (sles9)
      drbd: revert wrong hotfix, restore drbd barriers implemented with bio_rw_barrier
      drbd: increase module count on /proc/drbd access
      drbd: remove /proc/drbd before unregistering from netlink
      drbd: use kzalloc and memset(,0,) to start with clean buffers in drbd_nl
      drbd: add packet_type 27 (return_code_only) to netlink api
      drbdsetup: don't ignore error replies in events based commands
      drbdsetup events: improve message filtering
      build: our userland needs to find the drbd/compat includes as well
      build: compile fix: rhel5 and other do not support LINUXINCLUDES the way we now use it
      build: hint to --enable-spec in autogen.sh as well
      build: autofoo: don't warn about a variable before it is assigned
      build: when disabling existing drbd.ko, rename them with a timestamp
      build: add kmp-rpm target to our toplevel Makefile.in
      compat: regression fix: max bio size limitation enforcement on 2.6.31 to 2.6.33
      drbd: fix regression, we need to close drbd epochs during normal operation
      build: configure should not tough KVER/KDIR veriables
      build: for kmp, don't override %kernel_version with uname -r
      build: don't leave XSLTPROC empty
      build: pass KDIR and KVER to submake for "make modules" in toplevel dir
      build: compile fix: add an other compat define for RHEL6
      fix incomplete error message
      drbd: bitmap: don't count unused bits (fix non-terminating resync)
      drbd: store in-core bitmap little endian, regardless of architecture
      compatibility for generic_*_le_bit
      drbd: bitmap keep track of changes vs on-disk bitmap
      drbd: allow petabyte storage on 64bit arch
      drbd: get rid of unused debug code
      drbd: get rid of more unused debug code
      drbd: move bitmap write from resync_finished to after_state_change
      drbd: fix potential dereference of NULL pointer
      drbd: add debugging assert to make sure the protocol is clean
      drbd: serialize sending of resync uuid with pending w_send_oos
      compat: add enum for bool true and false
      drbd: add missing include of dynamic_debug.h
      drbd: be less noisy with some log messages
      drbd: spelling fix in log message
      drbd: improve on bitmap write out timing
      drbd: fix potential access of on-stack wait_queue_head_t after return
      compat: define COMPLETION_INITIALIZER_ONSTACK if missing
      drbd: ratelimit io error messages

Nicolas Kaiser (1):
      drivers/block/drbd/drbd_main.c: fix error path

Philipp Marek (18):
      Fix the filelist generation for the new kernel-module-spec file.
      drbdadm: Extend the dump_option(_xml) functions to embed data within the section.
      drbdadm: do_proxy(): Only join the connection name once.
      drbdadm: Use the proxy_plugin values for output and drbd_proxy_ctl calling.
      drbdadm: On "drbdadm adjust" load current proxy settings for verification.
      drbdadm: Adjust memlimit of the proxy, if necessary. Plugins to come.
      drbdadm: Don't use a hardcoded number, use sizeof().
      drbdadm: Terminate the plugin list with END, to avoid any assumptions about the plugin list length in the proxy.
      drbdadm: Split do_proxy() into a validation and two worker functions.
      drbdadm: The memory limit cannot be changed without destroying and re-creating the connection.
      drbdadm: Cut do_proxy_conn_plugins() from do_proxy_conn_up(), and use it in "adjust".
      drbdadm: Try to find a minimal set of commands to update the proxies' plugin settings.
      drbdadm: Fix segfault on "drbdadm adjust" if no proxy configuration for this machine exists.
      drbdadm: Fix proxy plugin configuration for "drbdadm proxy-up".
      drbdadm: Fix "drbdadm adjust" parsing of drbd proxy version 1 output; it doesn't have the "show as-resources" command.
      drbdadm: Fix segfault in "drbdadm adjust all", for resources where the defined/running configurations disagree about proxy usage.
      drbdadm: If we detect a drbd proxy version 1, don't try to adjust its settings - it has no "show as-resources" command.
      drbdadm: Fix "drbdadm adjust" for drbd proxy version 3; got broken by the opt->value to opt->name switch.

Philipp Reisner (37):
      man-pages: Fixed the documentation of c-min-rate on drbd.conf's man page
      drbd: Track the numbers of sectors in flight
      drbd: New configuration parameters for dealing with network congestion
      drbd: Implemented two new connection states Ahead/Behind
      drbd: New packet for Ahead/Behind mode: P_OUT_OF_SYNC
      drbd: When proxy's buffer drained off go into regular resync mode
      drbd: Do not cleanup resync LRU for the Ahead/Behind SyncSource/SyncTarget transitions
      man-pages: Documentation for the network congestion poliy paraemters
      io-latency-test: Display how long IO was frozen
      drbd: Implemented priority inheritance for resync requests
      drbd: Make some functions static
      drbd: Implemented side-stepping in drbd_res_begin_io()
      drbd: Begin to account BIO processing time before inc_ap_bio()
      drbd: use test_and_set_bit() to decide if bm_io_work should be queued
      drbd: Fixed inc_ap_bio()
      drbd: Fixed race condition in drbd_queue_bitmap_io
      drbd: Improvements in sanitize_state()
      drbd: Starting with protocol 96 we can allow app-IO while receiving the bitmap
      drbd: Becoming sync target may not happen out of < C_WF_REPORT_PARAMS
      drbd: Removed 20 seconds upper bound for side-stepping
      compat: Updated backwards compatibility code for blkdev_issue_flush()
      drbd: --force option for disconnect
      drbd: Implemented the before-resync-source handler
      drbd: Fixed disk state transitions when getting connected
      drbd: Documenting drbd_should_do_remote() and drbd_should_send_oos()
      drbd: There might be a resync after unfreezing IO due to no disk [Bugz 332]
      drbdadm: Parse proxy/plugin section into a d_option list
      Preparing 8.3.10rc1
      drbdadm: Flush flex's buffers after aborting scanning
      drbd: Fixed an issue with AHEAD -> SYNC_SOURCE transitions
      drbd: No longer answer P_RS_DATA_REQUEST packets when in C_AHEAD mode
      drbd: Be more careful with SyncSource -> Ahead transitions
      drbd: Cleaned up the resync timer logic
      drbd: Corrected off-by-one error in DRBD_MINOR_COUNT_MAX
      drbdadm: Do not clutter the output of the init script
      drbd: Do not full sync if a P_SYNC_UUID packet gets lost
      Preparing 8.3.10rc2

