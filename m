Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
	[209.85.128.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 394B81057FF0
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2017 11:09:07 +0200 (CEST)
Received: by mail-wr0-f180.google.com with SMTP id b65so37781464wrd.0
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2017 02:09:07 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	y203sm2789608wmc.27.2017.08.17.02.09.05
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 17 Aug 2017 02:09:05 -0700 (PDT)
Resent-Message-ID: <20170817090902.GC3587@soda.linbit>
Received: from rl01-a.atservers.net (rl01-a.atservers.net [31.193.195.40])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7501C1057FFC
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2017 04:05:03 +0200 (CEST)
From: Artem Pogartsev <artem.pogartsev@activecloud.com>
To: <drbd-dev@lists.linbit.com>
Message-ID: <a1c1b596-8259-a2cf-3b1b-6461761bbca4@activecloud.com>
Date: Thu, 17 Aug 2017 04:57:12 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------BA2B08336A1153102A7F85F3"
Content-Language: ru
Subject: [Drbd-dev] [PATCH] drbdmeta: Fix drbdmeta to support old kernels
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

--------------BA2B08336A1153102A7F85F3
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

RedHat 6.9
kernel-2.6.32-431.11.2
drbd-utils-9.0.0
drbd-8.4.10

Problem:

drbdmeta 0 v08 /dev/sda internal create-md
initializing activity log
initializing bitmap (30524 KB) to all zero
ioctl(/dev/sda) failed: Invalid argument

Reason:

Wrong check of the return error code into zeroout_bitmap function 
(user/shared/drbdmeta.c):

err = ioctl(cfg->md_fd, BLKZEROOUT, &range);
if (!err)
         return;
if (errno == ENOTTY) {
         do pwrite stuff;
}

We must check if errno == EINVAL (request code or argp is not valid). We 
will get ENOTTY if the block device doesnt has ioctl into fops structure 
(look at the __blkdev_driver_ioctl into block/ioctl.c) - not out case. 
And we will get EINVAL if the request code is wrong for this type of the 
device (old kernels doesnt have BLKZEROOUT) - our case.

Possible patch is attached.

But maybe better change logic and make ioctl with BLKZEROOUT only if 
BLKZEROOUT was defined in kernel headers (if we dont have BLKZEROOUT 
macro in kernel tree then 100% ioctl with _IO(0x12,127) will fail).


--------------BA2B08336A1153102A7F85F3
Content-Type: text/plain; charset="UTF-8";
	name="drbd-utils-9.0.0-blkzeroout.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="drbd-utils-9.0.0-blkzeroout.patch"

ZGlmZiAtTnJ1IGEvdXNlci9zaGFyZWQvZHJiZG1ldGEuYyBiL3VzZXIvc2hhcmVkL2RyYmRt
ZXRhLmMKLS0tIGEvdXNlci9zaGFyZWQvZHJiZG1ldGEuYwkyMDE3LTA0LTIwIDEwOjM1OjAy
LjAwMDAwMDAwMCArMDMwMAorKysgYi91c2VyL3NoYXJlZC9kcmJkbWV0YS5jCTIwMTctMDgt
MTcgMDQ6MjY6MzUuNTA5MDAwNzg0ICswMzAwCkBAIC0xNzE2LDcgKzE3MTYsNyBAQAogCWlm
ICghZXJyKQogCQlyZXR1cm47CiAKLQlpZiAoZXJybm8gPT0gRU5PVFRZKSB7CisJaWYgKGVy
cm5vID09IEVJTlZBTCkgewogCQkvKiBuZWVkIHRvIHNlY3Rvci1hbGlnbiB0aGlzIGZvciBP
X0RJUkVDVC4KIAkJICogInNlY3RvciIgaGVyZSBtZWFucyBoYXJkLXNlY3Qgc2l6ZSwgd2hp
Y2ggbWF5IGJlICE9IDUxMi4KIAkJICogTm90ZSB0aGF0IGV2ZW4gdGhvdWdoIEFMSUdOIGRv
ZXMgcm91bmQgdXAsIGZvciBzZWN0b3Igc2l6ZXMK
--------------BA2B08336A1153102A7F85F3--
