Return-Path: <rgoldwyn@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 86DCE100EBF0
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 06:54:02 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2A0BAAC27
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 05:42:32 +0000 (UTC)
Message-ID: <54E6C8BA.9090201@suse.de>
Date: Thu, 19 Feb 2015 23:40:10 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [bug] drbd 9: Receiver error
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

Hi,

I compiled drbd-9.0 against Opensuse Tumbleweed and installed it [1].
I applied Linux kernel commit f730c848affc05fb7262574b06e0cd7e1fa96096 
to get it to compile against the latest (factory) kernels and should be 
the same for the tumbleweed kernel (3.18.3 based) I am using to test.

I am getting the following receiver errors in the kernel log when I try 
to start the drbd service:

[  862.129755] drbd r0 tumbleweed1: conn( Connected -> ProtocolError ) 
peer( Secondary -> Unknown )
[  862.129760] block drbd0: tumbleweed1: pdsk( UpToDate -> DUnknown ) 
repl( WFBitMapT -> Off )
[  862.129797] drbd r0 tumbleweed1: asender terminated
[  862.129800] drbd r0 tumbleweed1: Terminating asender thread
[  862.156233] drbd r0 tumbleweed1: Connection closed
[  862.156254] drbd r0 tumbleweed1: conn( ProtocolError -> Unconnected )
[  862.156276] drbd r0 tumbleweed1: Restarting receiver thread
[  862.156294] drbd r0 tumbleweed1: conn( Unconnected -> Connecting )
[  862.656286] drbd r0 tumbleweed1: Handshake successful: Agreed network 
protocol version 110
[  862.656290] drbd r0 tumbleweed1: Agreed to support TRIM on protocol level
[  862.656304] drbd r0 tumbleweed1: Starting asender thread (from 
drbd_r_r0 [13897])
[  862.732281] drbd r0 tumbleweed1: Preparing remote state change 
528121841 (primary_nodes=0, weak_nodes=0)
[  862.732990] drbd r0 tumbleweed1: Committing remote state change 528121841
[  862.733010] drbd r0 tumbleweed1: conn( Connecting -> Connected ) 
peer( Unknown -> Secondary )
[  862.736117] block drbd0: tumbleweed1: drbd_sync_handshake:
[  862.736127] block drbd0: tumbleweed1: self 
0000000000000004:0000000000000000:0000000000000000:0000000000000000 
bits:7864071 flags:0
[  862.736131] block drbd0: tumbleweed1: peer 
2077E6DCE2ED8D5E:0000000000000000:0000000000000000:0000000000000000 
bits:8388343 flags:20
[  862.736135] block drbd0: tumbleweed1: uuid_compare()=-2 by rule 20
[  862.736138] block drbd0: tumbleweed1: Writing the whole bitmap, full 
sync required after drbd_sync_handshake.
[  862.766801] block drbd0: tumbleweed1: pdsk( DUnknown -> UpToDate ) 
repl( Off -> WFBitMapT )
[  862.775107] block drbd0: tumbleweed1: bitmap overflow (e:8388342) 
while decoding bm RLE packet
[  862.775127] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP, 
e: -5 l: 7!

[1] Opensuse Packages builds: 
https://build.opensuse.org/package/show/home:goldwynr:branches:network:ha-clustering:Factory/drbd9

Please let me know if you need any more information to debug this or if 
I am doing something wrong.

-- 
Goldwyn
