Return-Path: <rgoldwyn@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A75A610003ED
	for <drbd-dev@lists.linbit.com>; Mon, 23 Feb 2015 18:21:02 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id AAE4EAC9B
	for <drbd-dev@lists.linbit.com>; Mon, 23 Feb 2015 17:21:01 +0000 (UTC)
Message-ID: <54EB60E7.10304@suse.de>
Date: Mon, 23 Feb 2015 11:18:31 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <54E6C8BA.9090201@suse.de>
	<20150220074152.GC12926@cacao.linbit>	<54E6FA84.2070306@suse.de>
	<20150220141845.GZ20897@soda.linbit>
In-Reply-To: <20150220141845.GZ20897@soda.linbit>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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



On 02/20/2015 08:18 AM, Lars Ellenberg wrote:
> On Fri, Feb 20, 2015 at 03:12:36AM -0600, Goldwyn Rodrigues wrote:
>> Hi Philipp,
>>
>>
>> On 02/20/2015 01:41 AM, Philipp Marek wrote:
>>> Hi Goldwyn,
>>>
>>>> I compiled drbd-9.0 against Opensuse Tumbleweed and installed it [1].
>>>> I applied Linux kernel commit f730c848affc05fb7262574b06e0cd7e1fa96096 to
>>>> get it to compile against the latest (factory) kernels and should be the
>>>> same for the tumbleweed kernel (3.18.3 based) I am using to test.
>>>>
>>>> I am getting the following receiver errors in the kernel log when I try to
>>>> start the drbd service:
>>> ...
>>>> Please let me know if you need any more information to debug this or if I am
>>>> doing something wrong.
>>> how many nodes did you connect, which DRBD versions were they running?
>>
>> Two nodes, traditional way with one local device and no other
>> clustering software.
>>
>>> Can you show the configuration, and some more log lines - from all nodes,
>>> and starting quite a bit earlier?
>>
>> Here is the one which errs:
>>
>> [  175.644532] drbd: initialized. Version: 9.0.0rc1 (api:1/proto:86-110)
>> [  175.644535] drbd: GIT-hash:
>> 9804ed9b1eedab65cb137380f8066518a9521c12 build by abuild@cloud109,
>> 2015-02-20 08:39:07
>> [  175.644536] drbd: registered as block device major 147
>> [  175.657174] drbd r0: Starting worker thread (from drbdsetup [1162])
>> [  175.797012]  sda: unknown partition table
>> [  175.798367] block drbd0: disk( Diskless -> Attaching )
>> [  175.798404] block drbd0: Maximum number of peer devices = 1
>> [  175.798634] drbd r0: Method to ensure write ordering: flush
>> [  175.798644] block drbd0: drbd_bm_resize called with capacity == 62912568
>> [  175.799879] block drbd0: resync bitmap: bits=7864071 words=122877
>> pages=240
>
>
>> [  176.429715] block drbd0: tumbleweed1: bitmap overflow (e:8388342) while decoding bm RLE packet
>> [  176.429739] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP, e: -5 l: 7!
>
>
> If you can reproduce this (with RLE enabled),
> can you please down drbd on both nodes,
> then "dump-md"?
>
> I'm interested in how exactly your bitmaps look like,
> so I could "unit test" the bitmap compression/decompression for it.
>

The problem occurs when the devices are of unequal sizes. I am unable to 
get the dump-md _after_ the error, because of the following:

tumbleweed3:~ # drbdadm dump-md r0
Found meta data is "unclean", please apply-al first
Command 'drbdmeta 0 v09 /dev/sda internal dump-md' terminated with exit 
code 255


I am able to recreate the problem everytime. Here is the dump before 
starting the service:

tumbleweed1:~ # drbdadm dump-md r0
# DRBD meta data dump
# 2015-02-23 10:31:50 -0600 [1424709110]
# tumbleweed1> drbdmeta 0 v09 /dev/sda internal dump-md
#

version "v09";

max-peers 1;
# md_size_sect 2120
# md_offset 34359734272
# al_offset 34359701504
# bm_offset 34358652928

node-id -1;
current-uuid 0x0000000000000004;
flags 0x00000080;
peer[0] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[1] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[2] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[3] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[4] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[5] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[6] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[7] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[8] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[9] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[10] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[11] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[12] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[13] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[14] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[15] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[16] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[17] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[18] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[19] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[20] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[21] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[22] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[23] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[24] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[25] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[26] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[27] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[28] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[29] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[30] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[31] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
history-uuids {
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
}
# al-extents 257;
la-size-sect 0;
bm-byte-per-bit 4096;
device-uuid 0xA4C9657C56B6D358;
la-peer-max-bio-size 0;
al-stripes 1;
al-stripe-size-4k 8;
# bm-bytes 0;
bitmap[0] {
}
# bits-set 0;



tumbleweed3:~ # drbdadm dump-md r0
# DRBD meta data dump
# 2015-02-23 10:32:12 -0600 [1424709132]
# tumbleweed3> drbdmeta 0 v09 /dev/sda internal dump-md
#

version "v09";

max-peers 1;
# md_size_sect 1992
# md_offset 32212250624
# al_offset 32212217856
# bm_offset 32211234816

node-id -1;
current-uuid 0x0000000000000004;
flags 0x00000080;
peer[0] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[1] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[2] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[3] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[4] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[5] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[6] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[7] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[8] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[9] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[10] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[11] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[12] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[13] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[14] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[15] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[16] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[17] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[18] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[19] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[20] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[21] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[22] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[23] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[24] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[25] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[26] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[27] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[28] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[29] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[30] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
peer[31] {
     bitmap-index -1;
     bitmap-uuid 0x0000000000000000;
     bitmap-dagtag 0x0000000000000000;
     flags 0x00000000;
}
history-uuids {
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
         0x0000000000000000; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
}
# al-extents 257;
la-size-sect 0;
bm-byte-per-bit 4096;
device-uuid 0xC789EF231ECD0071;
la-peer-max-bio-size 0;
al-stripes 1;
al-stripe-size-4k 8;
# bm-bytes 0;
bitmap[0] {
}
# bits-set 0;


This happens when I try to assign tumbleweed1 (bigger device) the 
primary using the command:

# drbdadm -- --overwrite-data-of-peer primary r0


-- 
Goldwyn
