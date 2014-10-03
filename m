Return-Path: <igor@novg.net>
Received: from mail.novg.net (mail.novg.net [194.190.107.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 80F46101E048
	for <drbd-dev@lists.linbit.com>; Fri,  3 Oct 2014 21:42:10 +0200 (CEST)
Received: from [192.168.22.101] (128-72-215-40.broadband.corbina.ru
	[128.72.215.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.novg.net (Postfix) with ESMTPSA id 8601B780E8B
	for <drbd-dev@lists.linbit.com>; Fri,  3 Oct 2014 23:33:34 +0400 (MSK)
Message-ID: <542EFA18.9060705@novg.net>
Date: Fri, 03 Oct 2014 23:33:44 +0400
From: Igor Novgorodov <igor@novg.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Bug in latest 8.4-git
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

Hello!

Just checked out latest rev of git tree and built it against latest LTS 
vanilla kernel - 3.14.19

And the problem is that it won't connect to the peer server (it's drbd 
8.4.3 and kernel 3.4.42) at all
with "listen failed, err = -515" error. Replication link is 4x1G 
balance-rr bond which worked fine
for years, if that's relevant. IPv6 is disabled in kernel completely.

I've fallen back to 8.4.5 stable release and it all worked fine again.
The thing is that last time i've checked out git version around July 
2014 - it worked fine too,
something broke later.

Kernel log of the connection follows, glad to get any help or answer any 
questions:

[  987.195779] drbd: failed to initialize debugfs -- will not be available
[  987.195875] drbd: initialized. Version: 8.4.5 (api:1/proto:86-101)
[  987.195946] drbd: GIT-hash: ca3a67af3823b85614621a4cf95e191c5820c0eb 
build by root@debian-service, 2014-10-03 21:23:28
[  987.196039] drbd: registered as block device major 147
[  987.243928] drbd VM_STORAGE2_1: Starting worker thread (from 
drbdsetup-84 [7574])
[  987.244564] block drbd0: disk( Diskless -> Attaching )
[  987.245006] drbd VM_STORAGE2_1: Method to ensure write ordering: drain
[  987.245080] block drbd0: max BIO size = 286720
[  987.245151] block drbd0: Adjusting my ra_pages to backing device's 
(32 -> 70)
[  987.245227] block drbd0: drbd_bm_resize called with capacity == 
23436772800
[  987.309127] block drbd0: resync bitmap: bits=2929596600 
words=45774947 pages=89405
[  987.309223] block drbd0: size = 11 TB (11718386400 KB)
[  988.983804] block drbd0: recounting of set bits took additional 8 jiffies
[  988.983884] block drbd0: 0 KB (0 bits) marked out-of-sync by on disk 
bit-map.
[  988.983964] block drbd0: disk( Attaching -> UpToDate )
[  988.984048] block drbd0: attached to UUIDs 
6BCB7D550A1E86DE:0000000000000000:22A0154CECB25AF2:229F154CECB25AF3
[  989.016875] drbd VM_STORAGE2_2: Starting worker thread (from 
drbdsetup-84 [7580])
[  989.017381] block drbd1: disk( Diskless -> Attaching )
[  989.017842] drbd VM_STORAGE2_2: Method to ensure write ordering: drain
[  989.017919] block drbd1: max BIO size = 286720
[  989.017990] block drbd1: Adjusting my ra_pages to backing device's 
(32 -> 70)
[  989.018066] block drbd1: drbd_bm_resize called with capacity == 
17577578552
[  989.065815] block drbd1: resync bitmap: bits=2197197319 
words=34331209 pages=67054
[  989.065908] block drbd1: size = 8382 GB (8788789276 KB)
[  990.280610] block drbd1: recounting of set bits took additional 5 jiffies
[  990.280690] block drbd1: 0 KB (0 bits) marked out-of-sync by on disk 
bit-map.
[  990.280771] block drbd1: disk( Attaching -> UpToDate )
[  990.280855] block drbd1: attached to UUIDs 
7869022EE30A1DDC:0000000000000000:BEFCB1DA3C794170:BEFBB1DA3C794171
[  990.282283] drbd VM_STORAGE2_1: conn( StandAlone -> Unconnected )
[  990.282382] drbd VM_STORAGE2_1: Starting receiver thread (from 
drbd_w_VM_STORA [7575])
[  990.282590] drbd VM_STORAGE2_1: receiver (re)started
[  990.282698] drbd VM_STORAGE2_1: conn( Unconnected -> WFConnection )
[  990.282788] drbd VM_STORAGE2_1: listen failed, err = -515
[  990.282888] drbd VM_STORAGE2_1: conn( WFConnection -> Disconnecting )
[  990.283287] drbd VM_STORAGE2_1: Connection closed
[  990.283307] drbd VM_STORAGE2_2: conn( StandAlone -> Unconnected )
[  990.283349] drbd VM_STORAGE2_2: Starting receiver thread (from 
drbd_w_VM_STORA [7581])
[  990.283461] drbd VM_STORAGE2_2: receiver (re)started
[  990.283500] drbd VM_STORAGE2_2: conn( Unconnected -> WFConnection )
[  990.283515] drbd VM_STORAGE2_2: listen failed, err = -515
[  990.283542] drbd VM_STORAGE2_2: conn( WFConnection -> Disconnecting )
[  990.283580] drbd VM_STORAGE2_2: Connection closed
[  990.283611] drbd VM_STORAGE2_2: conn( Disconnecting -> StandAlone )
[  990.283975] drbd VM_STORAGE2_1: conn( Disconnecting -> StandAlone )
[  991.282537] drbd VM_STORAGE2_1: State change failed: Need a 
connection to start verify or resync
[  991.282540] drbd VM_STORAGE2_2: State change failed: Need a 
connection to start verify or resync
[  991.282541] drbd VM_STORAGE2_2:  mask = 0x1f0 val = 0x80
[  991.282544] drbd VM_STORAGE2_2:  old_conn:StandAlone 
wanted_conn:WFConnection
[  991.282545] drbd VM_STORAGE2_2: receiver terminated
[  991.282546] drbd VM_STORAGE2_2: Terminating drbd_r_VM_STORA
[  991.283005] drbd VM_STORAGE2_1:  mask = 0x1f0 val = 0x80
[  991.283076] drbd VM_STORAGE2_1:  old_conn:StandAlone 
wanted_conn:WFConnection
[  991.283149] drbd VM_STORAGE2_1: receiver terminated
[  991.283220] drbd VM_STORAGE2_1: Terminating drbd_r_VM_STORA

