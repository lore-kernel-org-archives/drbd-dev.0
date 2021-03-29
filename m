Return-Path: <ming.li@easystack.cn>
Received: from m9785.mail.qiye.163.com (m9785.mail.qiye.163.com
	[220.181.97.85])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0018F420026
	for <drbd-dev@lists.linbit.com>; Mon, 29 Mar 2021 13:50:19 +0200 (CEST)
To: drbd-dev@lists.linbit.com
From: Ming Li <ming.li@easystack.cn>
Message-ID: <1ce2fa71-49d9-6070-9d9f-218a94975b32@easystack.cn>
Date: Mon, 29 Mar 2021 19:41:58 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: ming.li@easystack.cn
Subject: [Drbd-dev] IO cannot be completed
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

Hi everyone,

I got a problem about a  IO cannot be completed.

I used three nodes to compose a cluster, config is below:

resource drbd6 {
   device /dev/drbd6;
   meta-disk internal;

   options {
     quorum 2;
     on-no-quorum suspend-io;
     quorum-minimum-redundancy 2;
     auto-promote no;
     cpu-mask "fc0000";
   }

   disk {
     on-io-error detach;
     al-updates no;
   }

   on node-1 {
     node-id 0;
     address 192.168.170.2:7789;
     disk "/dev/disk/by-path/pci-0000:1b:00.0-nvme-1-part1";
   }
   on node-2 {
     node-id 1;
     address 192.168.170.3:7789;
     disk "/dev/disk/by-path/pci-0000:1b:00.0-nvme-1-part1";
   }
   on node-3 {
     node-id 2;
     address 192.168.170.4:7789;
     disk "/dev/disk/by-path/pci-0000:1b:00.0-nvme-1-part1";
   }
   on hotspare {
     node-id 3;
     address 192.168.170.2:17789;
     disk "/dev/disk/by-path/pci-0000:1b:00.0-nvme-1-part1";
   }
   connection {
     host node-1 port 7789;
     host node-2 port 7789;
     disk {
       c-max-rate 2048M;
       c-min-rate 0;
     }
     net {
       max-buffers 100000;
     }
   }
   connection {
     host node-1 port 7789;
     host node-3 port 7789;
     disk {
       c-max-rate 2048M;
       c-min-rate 0;
     }
     net {
       max-buffers 100000;
     }
   }
   connection {
     host node-2 port 7789;
     host node-3 port 7789;
     disk {
       c-max-rate 2048M;
       c-min-rate 0;
     }
     net {
       max-buffers 100000;
     }
   }
   connection {
     host node-1 port 7789;
     host hotspare port 17789;
     disk {
       c-max-rate 4G;
       c-min-rate 0;
     }
     net {
       max-buffers 100000;
     }
   }
   connection {
     host node-2 port 17789;
     host hotspare port 17789;
     disk {
       c-max-rate 4G;
       c-min-rate 0;
     }
     net {
       max-buffers 100000;
     }
   }
   connection {
     host node-3 port 17789;
     host hotspare port 17789;
     disk {
       c-max-rate 4G;
       c-min-rate 0;
     }
     net {
       max-buffers 100000;
     }
   }
}


drbd6 is primary in node-3, and I have systemd-udevd hang in node-3 some 
times.

like this:

[84157.492607] INFO: task systemd-udevd:16394 blocked for more than 120 
seconds.
[84157.493321]       Tainted: G           OE    --------- -  - 
4.18.0-147.5.1.el8_1.5es.14.x86_64 #1
[84157.494476] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[84157.495647] systemd-udevd   D    0 16394   1309 0x80000086
[84157.496302] Call Trace:
[84157.496932]  ? __schedule+0x253/0x830
[84157.497581]  schedule+0x28/0x70
[84157.498233]  io_schedule+0x12/0x40
[84157.498878]  __lock_page+0x141/0x240
[84157.499527]  ? find_get_entries+0x192/0x200
[84157.500180]  ? page_cache_tree_insert+0xe0/0xe0
[84157.500830]  truncate_inode_pages_range+0x432/0x8a0
[84157.501481]  ? find_get_pages_range_tag+0x192/0x270
[84157.502131]  ? pagevec_lookup_range_tag+0x24/0x30
[84157.502782]  ? __filemap_fdatawait_range+0x7a/0x140
[84157.503456]  ? cpumask_next_and+0x1a/0x20
[84157.517718]  ? smp_call_function_many+0x59/0x250
[84157.518354]  ? __brelse+0x20/0x20
[84157.518999]  ? on_each_cpu_mask+0x25/0x60
[84157.519651]  ? proc_ns_fget+0x40/0x40
[84157.520299]  ? on_each_cpu_cond+0xb4/0x140
[84157.520947]  __blkdev_put+0x79/0x1e0
[84157.521594]  blkdev_close+0x21/0x30
[84157.522248]  __fput+0xb7/0x230
[84157.522894]  task_work_run+0x8a/0xb0
[84157.523541]  do_exit+0x2da/0xb40
[84157.524192]  do_group_exit+0x3a/0xa0
[84157.524818]  get_signal+0x14b/0x850
[84157.525464]  do_signal+0x36/0x610
[84157.526109]  ? __audit_syscall_exit+0x228/0x290
[84157.526762]  exit_to_usermode_loop+0x89/0xf0
[84157.527413]  do_syscall_64+0x182/0x1b0


drbd6`s log is as below:

[82895.329346] drbd drbd6: Starting worker thread (from drbdsetup [50352])
[82895.331193] drbd drbd6 node-1: Starting sender thread (from drbdsetup 
[50356])
[82895.332421] drbd drbd6 node-2: Starting sender thread (from drbdsetup 
[50359])
[82895.333607] drbd drbd6 hotspare: Starting sender thread (from 
drbdsetup [50364])
[82895.391610] drbd drbd6/0 drbd6: meta-data IO uses: blk-bio
[82895.392850] drbd drbd6/0 drbd6: disk( Diskless -> Attaching )
[82895.393199] drbd drbd6/0 drbd6: Maximum number of peer devices = 4
[82895.393675] drbd drbd6: Method to ensure write ordering: flush
[82895.394007] drbd drbd6/0 drbd6: drbd_bm_resize called with capacity 
== 312437432
[82895.407125] drbd drbd6/0 drbd6: resync bitmap: bits=39054679 
words=2440920 pages=4768
[82895.407702] drbd drbd6/0 drbd6: size = 149 GB (156218716 KB)
[82895.456654] drbd drbd6/0 drbd6: recounting of set bits took 
additional 7ms
[82895.457004] drbd drbd6/0 drbd6: disk( Attaching -> Inconsistent )
[82895.457336] drbd drbd6/0 drbd6: attached to current UUID: 
0000000000000004
[82895.482294] drbd drbd6 node-1: conn( StandAlone -> Unconnected )
[82895.483237] drbd drbd6 node-2: conn( StandAlone -> Unconnected )
[82895.484130] drbd drbd6 hotspare: conn( StandAlone -> Unconnected )
[82895.506730] drbd drbd6 node-1: Starting receiver thread (from 
drbd_w_drbd6 [50353])
[82895.507404] drbd drbd6 node-1: conn( Unconnected -> Connecting )
[82895.507407] drbd drbd6 node-2: Starting receiver thread (from 
drbd_w_drbd6 [50353])
[82895.508391] drbd drbd6 hotspare: Starting receiver thread (from 
drbd_w_drbd6 [50353])
[82895.508395] drbd drbd6 node-2: conn( Unconnected -> Connecting )
[82895.509356] drbd drbd6 hotspare: conn( Unconnected -> Connecting )
[82896.804073] drbd drbd6 node-1: Handshake to peer 0 successful: Agreed 
network protocol version 116
[82896.805266] drbd drbd6 node-1: Feature flags enabled on protocol 
level: 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.
[82896.806502] drbd drbd6 node-1: Starting ack_recv thread (from 
drbd_r_drbd6 [50424])
[82896.946491] drbd drbd6 node-1: Preparing remote state change 1407406125
[82896.948175] drbd drbd6 node-1: Committing remote state change 
1407406125 (primary_nodes=0)
[82896.950013] drbd drbd6 node-1: conn( Connecting -> Connected ) peer( 
Unknown -> Secondary )
[82896.969061] drbd drbd6/0 drbd6 node-2: drbd_sync_handshake:
[82896.969735] drbd drbd6/0 drbd6 node-2: self 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:0 flags:24
[82896.971009] drbd drbd6/0 drbd6 node-2: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:0 flags:24
[82896.972178] drbd drbd6/0 drbd6 node-2: uuid_compare()=no-sync by rule 10
[82896.976105] drbd drbd6/0 drbd6 node-2: pdsk( DUnknown -> Inconsistent 
) repl( Off -> Established )
[82900.660110] drbd drbd6 node-2: Handshake to peer 1 successful: Agreed 
network protocol version 116
[82900.660727] drbd drbd6 node-2: Feature flags enabled on protocol 
level: 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.
[82900.661381] drbd drbd6 node-2: Starting ack_recv thread (from 
drbd_r_drbd6 [50426])
[82900.668493] drbd drbd6 node-1: Preparing remote state change 2853674044
[82900.673102] drbd drbd6 node-1: Committing remote state change 
2853674044 (primary_nodes=0)
[82900.777009] drbd drbd6 node-2: Preparing remote state change 4199642800
[82900.778671] drbd drbd6 node-2: Committing remote state change 
4199642800 (primary_nodes=0)
[82900.779626] drbd drbd6 node-2: conn( Connecting -> Connected ) peer( 
Unknown -> Secondary )
[82900.806092] drbd drbd6/0 drbd6 node-2: drbd_sync_handshake:
[82900.806435] drbd drbd6/0 drbd6 node-2: self 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:0 flags:24
[82900.807039] drbd drbd6/0 drbd6 node-2: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:0 flags:24
[82900.807655] drbd drbd6/0 drbd6 node-2: uuid_compare()=no-sync by rule 10
[82900.811180] drbd drbd6/0 drbd6 node-2: pdsk( DUnknown -> Inconsistent 
) repl( Off -> Established )
[82905.736502] drbd drbd6/0 drbd6: quorum( no -> yes )
[82905.739631] drbd drbd6: susp-io( user -> no)
[82905.742760] drbd drbd6: Preparing cluster-wide state change 
1609921248 (2->-1 7683/4609)
[82905.742893] drbd drbd6: State change 1609921248: primary_nodes=4, 
weak_nodes=FFFFFFFFFFFFFFF8
[82905.744054] drbd drbd6: Committing cluster-wide state change 
1609921248 (1ms)
[82905.744400] drbd drbd6: role( Secondary -> Primary )
[82905.744729] drbd drbd6/0 drbd6: disk( Inconsistent -> UpToDate )
[82905.745077] drbd drbd6/0 drbd6: size = 149 GB (156218716 KB)
[82905.893708] drbd drbd6: Forced to consider local data as UpToDate!
[82905.908612] drbd drbd6/0 drbd6: new current UUID: 959F6C5C1257B5F9 
weak: FFFFFFFFFFFFFFF8
[82906.301860] drbd drbd6/0 drbd6 node-2: drbd_sync_handshake:
[82906.302207] drbd drbd6/0 drbd6 node-2: self 
959F6C5C1257B5F9:ADECA711C521507D:0000000000000000:0000000000000000 
bits:0 flags:20
[82906.302813] drbd drbd6/0 drbd6 node-2: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:39054679 flags:4
[82906.303433] drbd drbd6/0 drbd6 node-2: 
uuid_compare()=source-set-bitmap by rule 30
[82906.304041] drbd drbd6/0 drbd6 node-2: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[82907.111693] drbd drbd6/0 drbd6 node-1: drbd_sync_handshake:
[82907.112040] drbd drbd6/0 drbd6 node-1: self 
959F6C5C1257B5F9:ADECA711C521507D:0000000000000000:0000000000000000 
bits:0 flags:20
[82907.112648] drbd drbd6/0 drbd6 node-1: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:39054679 flags:4
[82907.113269] drbd drbd6/0 drbd6 node-1: 
uuid_compare()=source-set-bitmap by rule 30
[82907.113885] drbd drbd6/0 drbd6 node-1: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[82907.114524] drbd drbd6/0 drbd6: drbd_r_drbd6[50424] going to 
'set_n_write from sync_handshake' but bitmap already locked for 
'set_n_write from sync_handshake' by drbd_r_drbd6[50426]
[82909.619044] drbd drbd6/0 drbd6: bitmap WRITE of 4768 pages took 3300 ms
[82909.646416] drbd drbd6/0 drbd6 node-2: repl( Established -> WFBitMapS )
[82910.918858] drbd drbd6/0 drbd6 node-1: resync-susp( no -> user )
[82912.457406] drbd drbd6/0 drbd6: bitmap WRITE of 4768 pages took 2787 ms
[82912.477458] drbd drbd6/0 drbd6 node-1: drbd_sync_handshake:
[82912.477801] drbd drbd6/0 drbd6 node-1: self 
959F6C5C1257B5F9:ADECA711C521507D:0000000000000000:0000000000000000 
bits:0 flags:20
[82912.478406] drbd drbd6/0 drbd6 node-1: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:39054679 flags:4
[82912.479054] drbd drbd6/0 drbd6 node-1: 
uuid_compare()=source-set-bitmap by rule 30
[82912.479648] drbd drbd6/0 drbd6 node-1: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[82912.480257] drbd drbd6/0 drbd6: drbd_r_drbd6[50424] going to 
'set_n_write from sync_handshake' but bitmap already locked for 
'send_bitmap (WFBitMapS)' by drbd_w_drbd6[50353]
[82912.482390] drbd drbd6/0 drbd6 node-2: send bitmap stats 
[Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
[82912.483822] drbd drbd6/0 drbd6 node-2: resync-susp( no -> user )
[82912.484782] drbd drbd6/0 drbd6 hotspare: resync-susp( no -> user )
[82912.730591] drbd drbd6/0 drbd6 node-1: repl( Established -> WFBitMapS )
[82912.733632] drbd drbd6/0 drbd6 node-2: receive bitmap stats 
[Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
[82912.734253] drbd drbd6/0 drbd6 node-2: helper command: /sbin/drbdadm 
before-resync-source
[82912.736384] drbd drbd6/0 drbd6 node-2: helper command: /sbin/drbdadm 
before-resync-source exit code 0 (0x0)
[82912.736993] drbd drbd6/0 drbd6 node-2: repl( WFBitMapS -> PausedSyncS )
[82912.737418] drbd drbd6/0 drbd6 node-2: Began resync as PausedSyncS 
(will sync 156218716 KB [39054679 bits set]).
[82934.663658] drbd drbd6/0 drbd6 node-1: resync-susp( user -> no )
[82934.664674] drbd drbd6/0 drbd6 node-2: repl( PausedSyncS -> 
SyncSource ) resync-susp( user -> no )
[82934.666910] drbd drbd6/0 drbd6 node-2: Syncer continues.
[82934.667851] drbd drbd6/0 drbd6 hotspare: resync-susp( user -> no )
[82934.682319] drbd drbd6/0 drbd6 node-1: send bitmap stats 
[Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
[82934.710854] drbd drbd6/0 drbd6 node-1: receive bitmap stats 
[Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
[82934.711485] drbd drbd6/0 drbd6 node-1: helper command: /sbin/drbdadm 
before-resync-source
[82934.713606] drbd drbd6/0 drbd6 node-1: helper command: /sbin/drbdadm 
before-resync-source exit code 0 (0x0)
[82934.714222] drbd drbd6/0 drbd6 node-1: repl( WFBitMapS -> SyncSource )
[82934.714651] drbd drbd6/0 drbd6 node-1: Began resync as SyncSource 
(will sync 156218716 KB [39054679 bits set]).
[82934.736660] drbd drbd6: susp-io( no -> user,quorum)
[82934.737003] drbd drbd6/0 drbd6: quorum( yes -> no )
[82934.775542] drbd drbd6/0 drbd6: helper command: /sbin/drbdadm 
quorum-lost
[82934.777362] drbd drbd6/0 drbd6: helper command: /sbin/drbdadm 
quorum-lost exit code 0 (0x0)
[82934.781031] drbd drbd6/0 drbd6 hotspare: ignore result of IO sector: 
312437416
[82938.246555] drbd drbd6/0 drbd6 node-2: updated UUIDs 
959F6C5C1257B5F9:0000000000000000:ADECA711C521507C:0000000000000000
[82938.284627] drbd drbd6/0 drbd6: bitmap page idx 8 changed during IO!
[82938.284993] drbd drbd6/0 drbd6: bitmap WRITE of 3 pages took 38 ms
[82938.318646] drbd drbd6/0 drbd6 node-2: Resync done (total 24 sec; 
paused 21 sec; 52072904 K/sec)
[82938.319247] drbd drbd6/0 drbd6 node-2: 0 % had equal checksums, 
eliminated: 9176K; transferred 156209540K total 156218716K
[82938.319862] drbd drbd6: susp-io( quorum -> no)
[82938.320200] drbd drbd6/0 drbd6: quorum( no -> yes )
[82938.320540] drbd drbd6/0 drbd6 node-2: pdsk( Inconsistent -> UpToDate 
) repl( SyncSource -> Established )
[82943.490962] drbd drbd6 node-8: Preparing remote state change 1267890931
[82943.527852] drbd drbd6 node-8: Committing remote state change 
1267890931 (primary_nodes=4)
[82943.528814] drbd drbd6/0 drbd6 node-2: repl( Established -> VerifyT )
[82943.529176] drbd drbd6/0 drbd6: Online Verify start sector: 0
[84086.817010] drbd drbd6/0 drbd6 node-1: updated UUIDs 
959F6C5C1257B5F9:0000000000000000:ADECA711C521507C:0000000000000000
[84086.817909] drbd drbd6/0 drbd6 node-1: Resync done (total 1152 sec; 
paused 0 sec; 135604 K/sec)
[84086.818508] drbd drbd6/0 drbd6 node-1: 99 % had equal checksums, 
eliminated: 156217972K; transferred 744K total 156218716K
[84086.819120] drbd drbd6/0 drbd6 node-1: pdsk( Inconsistent -> UpToDate 
) repl( SyncSource -> Established )
[84092.084394] drbd drbd6 node-2: Preparing remote state change 3770923910
[84092.120711] drbd drbd6 node-2: Committing remote state change 
3770923910 (primary_nodes=4)
[84092.121664] drbd drbd6/0 drbd6 node-1: repl( Established -> VerifyT )
[84092.122048] drbd drbd6/0 drbd6: Online Verify start sector: 0
[85594.442961] drbd drbd6/0 drbd6 node-2: Online verify done (total 2650 
sec; paused 0 sec; 58948 K/sec)
[85594.443573] drbd drbd6/0 drbd6 node-2: repl( VerifyT -> Established )
[85743.003811] drbd drbd6/0 drbd6 node-1: Online verify done (total 1650 
sec; paused 0 sec; 94676 K/sec)
[85743.004422] drbd drbd6/0 drbd6 node-1: repl( VerifyT -> Established )


and I found that drbd has in flight read request in node-3 through 
/sys/kernel/debug/drbd/resources/drbd6/volumes/0/oldest_requests

/sys/kernel/debug/drbd/resources/drbd6/volumes/0/oldest_requests:
v: 0

epoch   sector  size    rw      start   in AL   submit  sent acked   
done    state
0x4cd   312437416       8       R       235609292       - - -       
-       [3]235609292    0x00403000      master: pending local: suspended 
completed|ok   net[3]: done : - net[1]: - : - net[0]: - : -


I checked drbd codes, it seems if local IO or peer IO is completed after 
suspended state, it wouldn`t clean suspended state, so this IO will 
always pending.

I don`t have too much experience of drbd, and I don`t know where the 
problem is, so is it a bug? Can I clean suspended state when all peer IO 
and local IO are completed, like this:

diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index 7a39cf7e..a6ea737c 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -767,6 +767,10 @@ static void mod_rq_state(struct drbd_request *req, 
struct bio_and_error *m,
         if (req->i.waiting)
                 wake_up(&req->device->misc_wait);

+       if ((atomic_read(req->completion_ref) == (c_put + 1)) && 
req->local_rq_state & RQ_COMPLETION_SUSP) {
+               c_put++;
+               req->local_rq_state &= ~RQ_COMPLETION_SUSP;
+       }
         drbd_req_put_completion_ref(req, m, c_put);
         kref_put(&req->kref, drbd_req_destroy);
  }


May I know if this patch can solve this problem(or workaround this 
problem) and it will not bring some new problems?

Thanks.

