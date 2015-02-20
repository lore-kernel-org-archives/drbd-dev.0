Return-Path: <rgoldwyn@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2E0C91019A36
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 10:14:59 +0100 (CET)
Message-ID: <54E6FA84.2070306@suse.de>
Date: Fri, 20 Feb 2015 03:12:36 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
MIME-Version: 1.0
To: Philipp Marek <philipp.marek@linbit.com>
References: <54E6C8BA.9090201@suse.de> <20150220074152.GC12926@cacao.linbit>
In-Reply-To: <20150220074152.GC12926@cacao.linbit>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [bug] drbd 9: Receiver error
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

Hi Philipp,


On 02/20/2015 01:41 AM, Philipp Marek wrote:
> Hi Goldwyn,
>
>> I compiled drbd-9.0 against Opensuse Tumbleweed and installed it [1].
>> I applied Linux kernel commit f730c848affc05fb7262574b06e0cd7e1fa96096 to
>> get it to compile against the latest (factory) kernels and should be the
>> same for the tumbleweed kernel (3.18.3 based) I am using to test.
>>
>> I am getting the following receiver errors in the kernel log when I try to
>> start the drbd service:
> ...
>> Please let me know if you need any more information to debug this or if I am
>> doing something wrong.
> how many nodes did you connect, which DRBD versions were they running?

Two nodes, traditional way with one local device and no other clustering 
software.

> Can you show the configuration, and some more log lines - from all nodes,
> and starting quite a bit earlier?

Here is the one which errs:

[  175.644532] drbd: initialized. Version: 9.0.0rc1 (api:1/proto:86-110)
[  175.644535] drbd: GIT-hash: 9804ed9b1eedab65cb137380f8066518a9521c12 
build by abuild@cloud109, 2015-02-20 08:39:07
[  175.644536] drbd: registered as block device major 147
[  175.657174] drbd r0: Starting worker thread (from drbdsetup [1162])
[  175.797012]  sda: unknown partition table
[  175.798367] block drbd0: disk( Diskless -> Attaching )
[  175.798404] block drbd0: Maximum number of peer devices = 1
[  175.798634] drbd r0: Method to ensure write ordering: flush
[  175.798644] block drbd0: drbd_bm_resize called with capacity == 62912568
[  175.799879] block drbd0: resync bitmap: bits=7864071 words=122877 
pages=240
[  175.799886] block drbd0: size = 30 GB (31456284 KB)
[  175.830618] block drbd0: recounting of set bits took additional 0ms
[  175.830633] block drbd0: Suspended AL updates
[  175.830642] block drbd0: disk( Attaching -> Inconsistent )
[  175.830645] block drbd0: attached to current UUID: 0000000000000004
[  175.843022] drbd r0 tumbleweed1: conn( StandAlone -> Unconnected )
[  175.843069] drbd r0 tumbleweed1: Starting sender thread (from 
drbdsetup [1175])
[  175.880303] drbd r0 tumbleweed1: Starting receiver thread (from 
drbd_w_r0 [1163])
[  175.880486] drbd r0 tumbleweed1: conn( Unconnected -> Connecting )
[  176.380200] drbd r0 tumbleweed1: Handshake successful: Agreed network 
protocol version 110
[  176.380205] drbd r0 tumbleweed1: Agreed to support TRIM on protocol level
[  176.380218] drbd r0 tumbleweed1: Starting asender thread (from 
drbd_r_r0 [1183])
[  176.392180] drbd r0 tumbleweed1: Preparing remote state change 
1900523070 (primary_nodes=0, weak_nodes=0)
[  176.392697] drbd r0 tumbleweed1: Committing remote state change 
1900523070
[  176.392718] drbd r0 tumbleweed1: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )
[  176.400177] block drbd0: tumbleweed1: drbd_sync_handshake:
[  176.400183] block drbd0: tumbleweed1: self 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:7864071 flags:0
[  176.400188] block drbd0: tumbleweed1: peer 
2077E6DCE2ED8D5E:0000000000000000:0000000000000000:0000000000000000 
bits:8388343 flags:20
[  176.400191] block drbd0: tumbleweed1: uuid_compare()=-2 by rule 20
[  176.400195] block drbd0: tumbleweed1: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[  176.421355] block drbd0: tumbleweed1: pdsk( DUnknown -> UpToDate ) 
repl( Off -> WFBitMapT )
[  176.421366] block drbd0: Resumed AL updates
[  176.429715] block drbd0: tumbleweed1: bitmap overflow (e:8388342) 
while decoding bm RLE packet
[  176.429739] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP, 
e: -5 l: 7!
[  176.429763] drbd r0 tumbleweed1: conn( Connected -> ProtocolError ) 
peer( Secondary -> Unknown )
[  176.429768] block drbd0: tumbleweed1: pdsk( UpToDate -> DUnknown ) 
repl( WFBitMapT -> Off )
[  176.429805] drbd r0 tumbleweed1: asender terminated
[  176.429807] drbd r0 tumbleweed1: Terminating asender thread
[  176.456361] drbd r0 tumbleweed1: Connection closed
[  176.456382] drbd r0 tumbleweed1: conn( ProtocolError -> Unconnected )
[  176.456404] drbd r0 tumbleweed1: Restarting receiver thread
[  176.456413] drbd r0 tumbleweed1: conn( Unconnected -> Connecting )
[  176.972179] drbd r0 tumbleweed1: Handshake successful: Agreed network 
protocol version 110
[  176.972185] drbd r0 tumbleweed1: Agreed to support TRIM on protocol level
[  176.972205] drbd r0 tumbleweed1: Starting asender thread (from 
drbd_r_r0 [1183])
[  176.984192] drbd r0 tumbleweed1: Preparing remote state change 
2872485783 (primary_nodes=0, weak_nodes=0)
[  176.984540] drbd r0 tumbleweed1: Committing remote state change 
2872485783
[  176.984560] drbd r0 tumbleweed1: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )
[  176.992109] block drbd0: tumbleweed1: drbd_sync_handshake:
[  176.992115] block drbd0: tumbleweed1: self 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:7864071 flags:0
[  176.992120] block drbd0: tumbleweed1: peer 
2077E6DCE2ED8D5E:0000000000000000:0000000000000000:0000000000000000 
bits:8388343 flags:20
[  176.992124] block drbd0: tumbleweed1: uuid_compare()=-2 by rule 20
[  176.992127] block drbd0: tumbleweed1: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[  177.003945] block drbd0: tumbleweed1: pdsk( DUnknown -> UpToDate ) 
repl( Off -> WFBitMapT )
[  177.012276] block drbd0: tumbleweed1: bitmap overflow (e:8388342) 
while decoding bm RLE packet
[  177.012300] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP, 
e: -5 l: 7!
[  177.012324] drbd r0 tumbleweed1: conn( Connected -> ProtocolError ) 
peer( Secondary -> Unknown )
[  177.012328] block drbd0: tumbleweed1: pdsk( UpToDate -> DUnknown ) 
repl( WFBitMapT -> Off )
[  177.012365] drbd r0 tumbleweed1: asender terminated
[  177.012369] drbd r0 tumbleweed1: Terminating asender thread
[  177.036176] drbd r0 tumbleweed1: Connection closed
[  177.036197] drbd r0 tumbleweed1: conn( ProtocolError -> Unconnected )
[  177.036219] drbd r0 tumbleweed1: Restarting receiver thread
[  177.036237] drbd r0 tumbleweed1: conn( Unconnected -> Connecting )
[  177.536161] drbd r0 tumbleweed1: Handshake successful: Agreed network 
protocol version 110
[  177.536165] drbd r0 tumbleweed1: Agreed to support TRIM on protocol level
[  177.536177] drbd r0 tumbleweed1: Starting asender thread (from 
drbd_r_r0 [1183])
[  177.544168] drbd r0 tumbleweed1: Preparing remote state change 
1844200584 (primary_nodes=0, weak_nodes=0)
[  177.544569] drbd r0 tumbleweed1: Committing remote state change 
1844200584
[  177.544588] drbd r0 tumbleweed1: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )
[  177.548098] block drbd0: tumbleweed1: drbd_sync_handshake:
[  177.548106] block drbd0: tumbleweed1: self 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:7864071 flags:0
[  177.548113] block drbd0: tumbleweed1: peer 
2077E6DCE2ED8D5E:0000000000000000:0000000000000000:0000000000000000 
bits:8388343 flags:20
[  177.548118] block drbd0: tumbleweed1: uuid_compare()=-2 by rule 20
[  177.548122] block drbd0: tumbleweed1: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[  177.561761] block drbd0: tumbleweed1: pdsk( DUnknown -> UpToDate ) 
repl( Off -> WFBitMapT )
[  177.570088] block drbd0: tumbleweed1: bitmap overflow (e:8388342) 
while decoding bm RLE packet
[  177.570109] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP, 
e: -5 l: 7!

[the last messages start looping]

And the one which attempts to be primary
[  148.615292] drbd: initialized. Version: 9.0.0rc1 (api:1/proto:86-110)
[  148.615297] drbd: GIT-hash: 9804ed9b1eedab65cb137380f8066518a9521c12 
build by abuild@cloud109, 2015-02-20 08:39:07
[  148.615299] drbd: registered as block device major 147
[  148.629013] drbd r0: Starting worker thread (from drbdsetup [1138])
[  148.746514]  sda: unknown partition table
[  148.747150] block drbd0: disk( Diskless -> Attaching )
[  148.747161] block drbd0: Maximum number of peer devices = 1
[  148.747251] drbd r0: Method to ensure write ordering: flush
[  148.747255] block drbd0: drbd_bm_resize called with capacity == 67106744
[  148.748075] block drbd0: resync bitmap: bits=8388343 words=131068 
pages=256
[  148.748078] block drbd0: size = 32 GB (33553372 KB)
[  148.774226] block drbd0: recounting of set bits took additional 0ms
[  148.774247] block drbd0: Suspended AL updates
[  148.774262] block drbd0: disk( Attaching -> UpToDate )
[  148.774270] block drbd0: attached to current UUID: 2077E6DCE2ED8D5E
[  148.826678] drbd r0 tumbleweed3: conn( StandAlone -> Unconnected )
[  148.826719] drbd r0 tumbleweed3: Starting sender thread (from 
drbdsetup [1151])
[  148.880835] drbd r0 tumbleweed3: Starting receiver thread (from 
drbd_w_r0 [1139])
[  148.881016] drbd r0 tumbleweed3: conn( Unconnected -> Connecting )
[  156.921255] drbd r0 tumbleweed3: Handshake successful: Agreed network 
protocol version 110
[  156.921260] drbd r0 tumbleweed3: Agreed to support TRIM on protocol level
[  156.921275] drbd r0 tumbleweed3: Starting asender thread (from 
drbd_r_r0 [1159])
[  156.928136] drbd r0: Preparing cluster-wide state change 1900523070 
(0->1 499/146)
[  156.933242] drbd r0: State change 1900523070: primary_nodes=0, 
weak_nodes=0
[  156.933246] drbd r0: Committing cluster-wide state change 1900523070 
(4ms)
[  156.933263] drbd r0 tumbleweed3: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )
[  156.936119] block drbd0: tumbleweed3: drbd_sync_handshake:
[  156.936125] block drbd0: tumbleweed3: self 
2077E6DCE2ED8D5E:0000000000000000:0000000000000000:0000000000000000 
bits:8388343 flags:0
[  156.936130] block drbd0: tumbleweed3: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:7864071 flags:24
[  156.936133] block drbd0: tumbleweed3: uuid_compare()=2 by rule 30
[  156.936136] block drbd0: tumbleweed3: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[  156.963632] block drbd0: tumbleweed3: pdsk( DUnknown -> Inconsistent 
) repl( Off -> WFBitMapS )
[  156.963644] block drbd0: Resumed AL updates
[  156.966625] block drbd0: tumbleweed3: send bitmap stats 
[Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
[  156.985166] drbd r0 tumbleweed3: sock was shut down by peer
[  156.985186] drbd r0 tumbleweed3: conn( Connected -> BrokenPipe ) 
peer( Secondary -> Unknown )
[  156.985191] block drbd0: tumbleweed3: repl( WFBitMapS -> Off )
[  156.985215] drbd r0 tumbleweed3: short read (expected size 16)
[  156.985238] drbd r0 tumbleweed3: asender terminated
[  156.985241] drbd r0 tumbleweed3: Terminating asender thread
[  157.012359] drbd r0 tumbleweed3: Connection closed
[  157.012380] drbd r0 tumbleweed3: conn( BrokenPipe -> Unconnected )
[  157.012402] drbd r0 tumbleweed3: Restarting receiver thread
[  157.012420] drbd r0 tumbleweed3: conn( Unconnected -> Connecting )
[  157.513134] drbd r0 tumbleweed3: Handshake successful: Agreed network 
protocol version 110
[  157.513138] drbd r0 tumbleweed3: Agreed to support TRIM on protocol level
[  157.513153] drbd r0 tumbleweed3: Starting asender thread (from 
drbd_r_r0 [1159])
[  157.520104] drbd r0: Preparing cluster-wide state change 2872485783 
(0->1 499/146)
[  157.525159] drbd r0: State change 2872485783: primary_nodes=0, 
weak_nodes=0
[  157.525162] drbd r0: Committing cluster-wide state change 2872485783 
(4ms)
[  157.525179] drbd r0 tumbleweed3: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )
[  157.528106] block drbd0: tumbleweed3: drbd_sync_handshake:
[  157.528111] block drbd0: tumbleweed3: self 
2077E6DCE2ED8D5E:0000000000000000:0000000000000000:0000000000000000 
bits:8388343 flags:0
[  157.528115] block drbd0: tumbleweed3: peer 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:7864071 flags:24
[  157.528118] block drbd0: tumbleweed3: uuid_compare()=2 by rule 30
[  157.528121] block drbd0: tumbleweed3: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[  157.546946] block drbd0: tumbleweed3: repl( Off -> WFBitMapS )
[  157.548668] block drbd0: tumbleweed3: send bitmap stats 
[Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.0%
[  157.561288] drbd r0 tumbleweed3: sock was shut down by peer
[  157.561306] drbd r0 tumbleweed3: conn( Connected -> BrokenPipe ) 
peer( Secondary -> Unknown )
[  157.561311] block drbd0: tumbleweed3: repl( WFBitMapS -> Off )
[  157.561335] drbd r0 tumbleweed3: short read (expected size 16)
[  157.561358] drbd r0 tumbleweed3: asender terminated
[  157.561360] drbd r0 tumbleweed3: Terminating asender thread
[  157.576230] drbd r0 tumbleweed3: Connection closed
[  157.576251] drbd r0 tumbleweed3: conn( BrokenPipe -> Unconnected )
[  157.576273] drbd r0 tumbleweed3: Restarting receiver thread
[  157.576290] drbd r0 tumbleweed3: conn( Unconnected -> Connecting )
[  158.077114] drbd r0 tumbleweed3: Handshake successful: Agreed network 
protocol version 110
[  158.077119] drbd r0 tumbleweed3: Agreed to support TRIM on protocol level
[  158.077152] drbd r0 tumbleweed3: Starting asender thread (from 
drbd_r_r0 [1159])
[  158.084157] drbd r0: Preparing cluster-wide state change 1844200584 
(0->1 499/146)
[  158.085191] drbd r0: State change 1844200584: primary_nodes=0, 
weak_nodes=0
[  158.085196] drbd r0: Committing cluster-wide state change 1844200584 
(0ms)
[  158.085214] drbd r0 tumbleweed3: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )


And the configs:

tumbleweed1:~ # cat /etc/drbd.conf
# You can find an example in  /usr/share/doc/drbd.../drbd.conf.example

include "drbd.d/global_common.conf";
include "drbd.d/*.res";


I haven't turned on any optins in global_common.conf

tumbleweed1:~ # cat /etc/drbd.d/r0.res
resource r0 {
   device /dev/drbd_r0 minor 0;
   disk /dev/sda;
   meta-disk internal;
   on tumbleweed1 {
     address  192.168.1.111:7788;
   }
   on tumbleweed3 {
     address 192.168.1.113:7788;
   }
   syncer {
     rate  7M;
   }
}


> And then the DRBD 9 git HEAD has already moved again...
>

Yes, I rebuilt against the latest one and the error still occurs.

BTW, the latest git still needs to fix the f_dentry in 
drbd/drbd_debugfs.c not covered in 7b00306c929c389bf030463466cb62e65bc415ec

IOW, there is still reference to f_dentry is drbd/drbd_debugfs.c



-- 
Goldwyn
