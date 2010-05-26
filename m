Return-Path: <btimby@gmail.com>
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com
	[209.85.161.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 66B6710871C1
	for <drbd-dev@lists.linbit.com>; Wed, 26 May 2010 18:27:42 +0200 (CEST)
Received: by fxm17 with SMTP id 17so1806732fxm.27
	for <drbd-dev@lists.linbit.com>; Wed, 26 May 2010 09:27:42 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 26 May 2010 12:21:27 -0400
Message-ID: <AANLkTim66dldWydThtZraIL6dqzVn0lxB1Q_chcOkkaa@mail.gmail.com>
From: Ben Timby <btimby@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Drbd-dev] DRBD + DM = EIO.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I posted a couple times to drbd-user, but I think this list is
actually the correct forum for what I am experiencing. I will
reiterate all the information have at this time below.

I have two matched machines. They have 15 SATA hard drives in a raid 5
array. I am using LVM to split this array into two volumes. I am then
using DRBD to replicate these two volumes. On top of DRBD, I have two
more LVM volumes, on which I can create (replicated) snapshots. These
volumes each contain a single file system which is ext4, the size is
10.84TB per volume.

The OS is CentOS 5.4, I am running DRBD 8.3.7, I built an RPM using
the instructions provided in the DRBD users guide. I am using the
2.6.18-164.15.1.el5 kernel on an x86_64 processor.

I am intermittently receiving the following error in /var/log/messages:

-
May 10 00:05:11 ragoon6 kernel: block drbd1: p read: error=-5
-

I tracked this down to the function drbd_endio_pri, after this error
occurs, DRBD goes into diskless mode, shovelling reads/writes to it's
peer. Once in diskless mode, I no longer receive this error, but I
can't run this way.

I removed DRBD from the mix, thus I have RAID -> LVM -> LVM -> EXT4,
and I get no EIO errors.

I found that I can immediately trigger this error by starting a raid
rebuild on the underlying array (while DRBD is in the stack). I do
this by executing the weekly cron job that is part of the mdadm
package on CentOS:

# /etc/cron.weekly/99-raid-check

I rebuilt the RPM and added a call to dump_stack() in the
drbd_endio_pri function. Below is the stack trace.

--
May 26 10:58:36 ragoon6 kernel: block drbd0: p read: error=-5
May 26 10:58:36 ragoon6 kernel:
May 26 10:58:36 ragoon6 kernel: Call Trace:
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886398f2>]
:drbd:drbd_endio_pri+0x66/0x129
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8811b34a>]
:dm_mod:dec_pending+0x134/0x18e
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8811c15b>]
:dm_mod:__split_bio+0x398/0x3b0
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8811c94d>]
:dm_mod:dm_request+0x115/0x124
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8001c040>]
generic_make_request+0x211/0x228
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8001a893>] bio_alloc_bioset+0x89/0xd9
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886471c7>]
:drbd:drbd_make_request_common+0xc00/0xc2b
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8002e31f>] __wake_up+0x38/0x4f
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886478b3>]
:drbd:drbd_make_request_26+0x6c1/0x702
May 26 10:58:36 ragoon6 kernel:  [<ffffffff800a0307>]
autoremove_wake_function+0x0/0x2e
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8001c040>]
generic_make_request+0x211/0x228
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8811b3f2>]
:dm_mod:__map_bio+0x4e/0x125
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8811bf39>]
:dm_mod:__split_bio+0x176/0x3b0
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8811c94d>]
:dm_mod:dm_request+0x115/0x124
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8001c040>]
generic_make_request+0x211/0x228
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80023013>] mempool_alloc+0x31/0xe7
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80010ceb>]
__find_get_block_slow+0xeb/0xf7
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80033488>] submit_bio+0xe4/0xeb
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8001a78a>] submit_bh+0xf1/0x111
May 26 10:58:36 ragoon6 kernel:  [<ffffffff800173ac>] ll_rw_block+0x8c/0xab
May 26 10:58:36 ragoon6 kernel:  [<ffffffff800e0f0c>] __breadahead+0x27/0x3b
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886ac0b4>]
:ext4:__ext4_get_inode_loc+0x2e3/0x370
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886b0abc>] :ext4:ext4_iget+0x52/0x4db
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886b456c>]
:ext4:ext4_lookup+0x82/0xc3
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80036e16>] __lookup_hash+0x10b/0x12f
May 26 10:58:36 ragoon6 kernel:  [<ffffffff800e7140>] lookup_one_len+0x53/0x61
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885f9d0a>]
:nfsd:compose_entry_fh+0xcd/0x121
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885f9f62>]
:nfsd:encode_entry+0x204/0x53c
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80062ff8>] thread_return+0x62/0xfe
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8006e189>] do_gettimeofday+0x40/0x90
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8005aa51>] getnstimeofday+0x10/0x28
May 26 10:58:36 ragoon6 kernel:  [<ffffffff800a22cc>] ktime_get_ts+0x1a/0x4e
May 26 10:58:36 ragoon6 kernel:  [<ffffffff800bd3f3>] delayacct_end+0x5d/0x86
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80063a36>] __wait_on_bit+0x60/0x6e
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885fa29a>]
:nfsd:nfs3svc_encode_entry_plus+0x0/0x10
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885fa2a5>]
:nfsd:nfs3svc_encode_entry_plus+0xb/0x10
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886a90a0>]
:ext4:call_filldir+0x7f/0x99
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885fa29a>]
:nfsd:nfs3svc_encode_entry_plus+0x0/0x10
May 26 10:58:36 ragoon6 kernel:  [<ffffffff886a9363>]
:ext4:ext4_readdir+0x1bd/0x536
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885fa29a>]
:nfsd:nfs3svc_encode_entry_plus+0x0/0x10
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80022ef2>] file_move+0x36/0x44
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885fa29a>]
:nfsd:nfs3svc_encode_entry_plus+0x0/0x10
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80035292>] vfs_readdir+0x77/0xa9
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885fa29a>]
:nfsd:nfs3svc_encode_entry_plus+0x0/0x10
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885f1ea0>]
:nfsd:nfsd_readdir+0x6d/0xc5
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885f9122>]
:nfsd:nfsd3_proc_readdirplus+0xf8/0x220
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885ee1db>]
:nfsd:nfsd_dispatch+0xd8/0x1d6
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8857f529>]
:sunrpc:svc_process+0x454/0x71b
May 26 10:58:36 ragoon6 kernel:  [<ffffffff80064644>] __down_read+0x12/0x92
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885ee5a1>] :nfsd:nfsd+0x0/0x2cb
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885ee746>] :nfsd:nfsd+0x1a5/0x2cb
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8005dfb1>] child_rip+0xa/0x11
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885ee5a1>] :nfsd:nfsd+0x0/0x2cb
May 26 10:58:36 ragoon6 kernel:  [<ffffffff885ee5a1>] :nfsd:nfsd+0x0/0x2cb
May 26 10:58:36 ragoon6 kernel:  [<ffffffff8005dfa7>] child_rip+0x0/0x11
May 26 10:58:36 ragoon6 kernel:
May 26 10:58:36 ragoon6 kernel: block drbd0: Local READ failed
sec=92278400s size=4096
May 26 10:58:36 ragoon6 kernel: block drbd0: disk( UpToDate -> Failed )
May 26 10:58:36 ragoon6 kernel: block drbd0: Local IO failed in
__req_mod.Detaching...
May 26 10:58:36 ragoon6 kernel: block drbd0: helper command:
/sbin/drbdadm pri-on-incon-degr minor-0
May 26 10:58:36 ragoon6 kernel: block drbd0: Sorry, I have no access
to good data anymore.
--

I just started walking the stack trace in my kernel sources to try to
locate the issue. However, I am hopeful that a DRBD developer can help
me to find the (I am assuming) bug in interaction between
device-mapper and DRBD.

Thanks.
