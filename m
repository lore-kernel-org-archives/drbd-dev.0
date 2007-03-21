Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9FD6F2E08FC1
	for <drbd-dev@lists.linbit.com>; Wed, 21 Mar 2007 17:43:16 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 21 Mar 2007 17:43:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703211743.16391.philipp.reisner@linbit.com>
Subject: [Drbd-dev] OOPS...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I just want to archive this OOPS (it is attached to the end of that mail),
on an 2.6.16.21-0.15-bigsmp SLES10 kernel.


void submit_bio(int rw, struct bio *bio)
{
        int count = bio_sectors(bio);

        BIO_BUG_ON(!bio->bi_size);
        BIO_BUG_ON(!bio->bi_io_vec); // this is line 3077 of block/ll_rw_blk.c
        bio->bi_rw |= rw;
        if (rw & WRITE)
                mod_page_state(pgpgout, count);
        else
                mod_page_state(pgpgin, count);
[...]

I have read drbd_al_to_on_disk_bm() and  atodb_prepare_unless_covered()
several times, and can not think of a way how a bio could get passed 
to submit_bio with its bi_io_vec set to NULL.

The bios are allocated with "bio = bio_alloc(GFP_KERNEL, 1);", so there
has to be a singe bio_vec in bio->bi_io_vec in place.

My conclusion for now is that something strange happened. (Machine corrupting
its memory ?) 

Here is the actual OOPS:
========================
kernel BUG at block/ll_rw_blk.c:3077!
CPU:    2
EIP:    0060:[<c01b27e5>]    Tainted: P     U VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246   (2.6.16.21-0.15-bigsmp #1)
eax: 80000004   ebx: c166ca60   ecx: 00000001   edx: 00400000
esi: ed65f18c   edi: 00000063   ebp: ed65f000   esp: f7d77e18
ds: 007b   es: 007b   ss: 0068
Stack: <0>01000001 f7d77e40 c011bb81 00000000 00000000 00000003 00200292 f5f62000
       ed65f000 f5f62000 ed65f18c 00000063 f93efd8b f93f7776 00000000 ebf6800c
       0000d082 00000002 00000003 0000d081 f5f62310 00000063 00000000 00000001
Call Trace:
 [<c011bb81>] __wake_up+0x2a/0x3d
 [<f93efd8b>] drbd_al_to_on_disk_bm+0x205/0x36d [drbd]
 [<f93f7776>] _drbd_request_state+0x2b7/0x2c2 [drbd]
 [<c011bb81>] __wake_up+0x2a/0x3d
 [<f93f9d00>] drbd_set_role+0x36d/0x402 [drbd]
 [<c0295212>] schedule+0xbee/0xc9a
 [<f93f9da4>] drbd_nl_secondary+0xf/0x16 [drbd]
 [<f93fa13d>] drbd_connector_callback+0xc4/0x173 [drbd]
 [<c0213d96>] cn_queue_wrapper+0x9/0x1e
 [<c012ee96>] run_workqueue+0x7f/0xba
 [<c0213d8d>] cn_queue_wrapper+0x0/0x1e
 [<c012f866>] worker_thread+0xed/0x11e
 [<c011ad69>] default_wake_function+0x0/0xc
 [<c013209a>] kthread+0xca/0xf7
 [<c012f779>] worker_thread+0x0/0x11e
 [<c0131fd0>] kthread+0x0/0xf7
 [<c0102005>] kernel_thread_helper+0x5/0xb
Code: c4 34 5b 5e 5f 5d c3 57 89 c1 56 53 89 d3 83 ec 24 8b 42 20 89 c2 c1 ea 09 85 c0 75 08 0f 0b 04 0c 7e b7 2c c0 83 7b 30 00 75 08 0b 05 0c 7e b7 2c c0 88 c8 09 4b 14 24 01 88 44 24 03 74 07


>>EIP; c01b27e5 <submit_bio+24/ad>   <=====

>>eax; 80000004 <phys_startup_32+7ff00004/c0000000>
>>ebx; c166ca60 <pg0+1266a60/3fbf8400>
>>edx; 00400000 <phys_startup_32+300000/c0000000>
>>esi; ed65f18c <pg0+2d25918c/3fbf8400>
>>ebp; ed65f000 <pg0+2d259000/3fbf8400>
>>esp; f7d77e18 <pg0+37971e18/3fbf8400>

Trace; c011bb81 <__wake_up+2a/3d>
Trace; f93efd8b <pg0+38fe9d8b/3fbf8400>
Trace; f93f7776 <pg0+38ff1776/3fbf8400>
Trace; c011bb81 <__wake_up+2a/3d>
Trace; f93f9d00 <pg0+38ff3d00/3fbf8400>
Trace; c0295212 <schedule+bee/c9a>
Trace; f93f9da4 <pg0+38ff3da4/3fbf8400>
Trace; f93fa13d <pg0+38ff413d/3fbf8400>
Trace; c0213d96 <cn_queue_wrapper+9/1e>
Trace; c012ee96 <run_workqueue+7f/ba>
Trace; c0213d8d <cn_queue_wrapper+0/1e>
Trace; c012f866 <worker_thread+ed/11e>
Trace; c011ad69 <default_wake_function+0/c>
Trace; c013209a <kthread+ca/f7>
Trace; c012f779 <worker_thread+0/11e>
Trace; c0131fd0 <kthread+0/f7>
Trace; c0102005 <kernel_thread_helper+5/b>

Code;  c01b27e5 <submit_bio+24/ad>
00000000 <_EIP>:
Code;  c01b27e5 <submit_bio+24/ad>   <=====
   0:   c4 34 5b                  les    (%ebx,%ebx,2),%esi   <=====
Code;  c01b27e8 <submit_bio+27/ad>
   3:   5e                        pop    %esi
Code;  c01b27e9 <submit_bio+28/ad>
   4:   5f                        pop    %edi
Code;  c01b27ea <submit_bio+29/ad>
   5:   5d                        pop    %ebp
Code;  c01b27eb <submit_bio+2a/ad>
   6:   c3                        ret
Code;  c01b27ec <submit_bio+2b/ad>
   7:   57                        push   %edi
Code;  c01b27ed <submit_bio+2c/ad>
   8:   89 c1                     mov    %eax,%ecx
Code;  c01b27ef <submit_bio+2e/ad>
   a:   56                        push   %esi
Code;  c01b27f0 <submit_bio+2f/ad>
   b:   53                        push   %ebx
Code;  c01b27f1 <submit_bio+30/ad>
   c:   89 d3                     mov    %edx,%ebx
Code;  c01b27f3 <submit_bio+32/ad>
   e:   83 ec 24                  sub    $0x24,%esp
Code;  c01b27f6 <submit_bio+35/ad>
  11:   8b 42 20                  mov    0x20(%edx),%eax
Code;  c01b27f9 <submit_bio+38/ad>
  14:   89 c2                     mov    %eax,%edx
Code;  c01b27fb <submit_bio+3a/ad>
  16:   c1 ea 09                  shr    $0x9,%edx
Code;  c01b27fe <submit_bio+3d/ad>
  19:   85 c0                     test   %eax,%eax
Code;  c01b2800 <submit_bio+3f/ad>
  1b:   75 08                     jne    25 <_EIP+0x25>
Code;  c01b2802 <submit_bio+41/ad>
  1d:   0f 0b                     ud2a
Code;  c01b2804 <submit_bio+43/ad>
  1f:   04 0c                     add    $0xc,%al
Code;  c01b2806 <submit_bio+45/ad>
  21:   7e b7                     jle    ffffffda <_EIP+0xffffffda>
Code;  c01b2808 <submit_bio+47/ad>
  23:   2c c0                     sub    $0xc0,%al
Code;  c01b280a <submit_bio+49/ad>
  25:   83 7b 30 00               cmpl   $0x0,0x30(%ebx)
Code;  c01b280e <submit_bio+4d/ad>
  29:   75 08                     jne    33 <_EIP+0x33>
Code;  c01b2810 <submit_bio+4f/ad>
  2b:   0b 05 0c 7e b7 2c         or     0x2cb77e0c,%eax
Code;  c01b2816 <submit_bio+55/ad>
  31:   c0 88 c8 09 4b 14 24      rorb   $0x24,0x144b09c8(%eax)
Code;  c01b281d <submit_bio+5c/ad>
  38:   01 88 44 24 03 74         add    %ecx,0x74032444(%eax)
Code;  c01b2823 <submit_bio+62/ad>
  3e:   07                        pop    %es

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
