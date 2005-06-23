Return-Path: <lmb@suse.de>
Date: Thu, 23 Jun 2005 21:37:09 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@linbit.com
Message-ID: <20050623193709.GK29587@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] drbd crashes the SyncSource if a read error is
	encountered during sync
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is essentially drbd-0.7-latest - kernel message dump:

> Linux version 2.6.5-7.155-SLRS (geeko@buildhost) (gcc version 3.3.3 (SuSE Linux)) #1 Tue Mar 29 14:36:35 UTC 2005
> ...
> drbd: initialised. Version: 0.7.5 (api:77/proto:74)
> drbd: SVN Revision: 1735 build by root@g237, 2005-02-17 16:14:41
> drbd: hijacking NBD device major!
> drbd: registered as block device major 43
> drbd0: resync bitmap: bits=2588788 words=80900
> drbd0: size = 9 GB (10355152 KB)
> drbd0: 8224 MB marked out-of-sync by on disk bit-map.
> drbd0: Found 6 transactions (106 active extents) in activity log.
> drbd0: Marked additional 12 MB as out-of-sync based on AL.
> drbd0: drbdsetup [7700]: cstate Unconfigured --> StandAlone
> drbd0: drbdsetup [7713]: cstate StandAlone --> Unconnected
> drbd0: drbd0_receiver [7714]: cstate Unconnected --> WFConnection
> drbd0: drbd0_receiver [7714]: cstate WFConnection --> WFReportParams
> drbd0: Handshake successful: DRBD Network Protocol version 74
> drbd0: Connection established.
> drbd0: I am(S): 1:00000006:00000001:00000002:00000001:11
> drbd0: Peer(S): 0:00000006:00000001:00000003:00000001:01
> drbd0: drbd0_receiver [7714]: cstate WFReportParams --> WFBitMapS
> drbd0: Secondary/Unknown --> Secondary/Secondary
> drbd0: drbd0_receiver [7714]: cstate WFBitMapS --> SyncSource
> drbd0: Resync started as SyncSource (need to sync 8524240 KB [2131060 bits set]).
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068664
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068664
> drbd0: Local IO failed. Detaching...
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068672
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068672
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068680
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068680
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068688
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068688
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068696
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068696
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068704
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068704
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068712
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068712
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068720
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068720
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068728
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068728
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068736
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068736
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068744
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068744
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068752
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068752
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068760
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068760
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068772, sector=8068768
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068768
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068776, sector=8068776
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068776
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068784, sector=8068784
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068784
> drbd0: Can not satisfy peer's read request, no local data.
> drbd0: Can not satisfy peer's read request, no local data.
> drbd0: Can not satisfy peer's read request, no local data.
> drbd0: Can not satisfy peer's read request, no local data.
> drbd0: Can not satisfy peer's read request, no local data.
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8068792, sector=8068792
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 8068792
> drbd0: drbd0_receiver [7714]: cstate SyncSource --> Timeout
> drbd0: short sent NegDReply size=32 sent=24
> drbd0: 4114 messages suppressed in /usr/src/packages/BUILD/kernel-SLRS-2.6.5/modules-2.6.5/drbd/drbd_receiver.c:1160.
> drbd0: Can not satisfy peer's read request, no local data.
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> f8bf6cf8
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<f8bf6cf8>]    Tainted: G  U
> EFLAGS: 00010086   (2.6.5-7.155-SLRS SLES9_SP1_BRANCH-200503291436350000) 
> EIP is at receive_DataRequest+0x1b8/0x6f0 [drbd]
> eax: 00000000   ebx: 003ba238   ecx: f687b800   edx: f687bc74
> esi: 00000000   edi: f687bc74   ebp: 00000000   esp: f68d7fa8
> ds: 007b   es: 007b   ss: 0068
> Process drbd0_receiver (pid: 7714, threadinfo=f68d6000 task=f6a23360)
> Stack: 00004100 ffffff0a 00001000 f687b9d8 f687b800 f8bf6b40 f687b9d8 f687b800 
>        f687bbd8 f8bf63cc f687bbdc 00000000 f687bbd8 00000000 f8bfd624 f8bfd5c0 
>        00000000 00000000 c0106005 f687bbd8 00000000 00000000 
> Call Trace:
>  [<f8bf6b40>] receive_DataRequest+0x0/0x6f0 [drbd]
>  [<f8bf63cc>] drbdd_init+0xac/0x2a0 [drbd]
>  [<f8bfd624>] drbd_thread_setup+0x64/0xb0 [drbd]
>  [<f8bfd5c0>] drbd_thread_setup+0x0/0xb0 [drbd]
>  [<c0106005>] kernel_thread_helper+0x5/0x10
> 
> Code: 89 78 04 89 57 04 fb ff 81 b0 03 00 00 8b 81 bc 03 00 00 80 
>  Dumping to block device (3,1) on CPU 0 ...

While I agree the data on both nodes is toasted at this time, as we had
a second failure during a resync, I'm also thinking it shouldn't panic
(this is the SyncSource, not the primary).

I'd expect to fail the device locally, set the inconsistent flag, and in
fact, then the primary/SyncTarget ought to do the panic thing. (in
drbd_receiver.c)

But the secondary here might be hosting other services in a cross-over
configuration and shouldn't do that.

Comments?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

