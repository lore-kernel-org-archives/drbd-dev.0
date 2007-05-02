Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Panic in _drbd_send_page() again.
Date: Wed, 2 May 2007 11:22:56 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C994@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C994@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705021122.56681.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 26. April 2007 23:58 schrieb Montrose, Ernest:
> Hi all,
> I think we have seen this panic before.  I am not sure if there was a
> fix then a regression of sort.
> I am looking for a clue to help narrow this down. It seems a
> bvec->bv_page is freed and is being used later.  Here is the panic
> message:
>

Hi Ernest,

Could you run this through ksymoops, to get the code line
disassembled ? -- This does not look like a well-known distri kernel,
or is it ?

-Phil

05:05:53 chogs kernel: CPU:    0
05:05:53 chogs kernel: EIP:    0061:[<ee2853c1>]    Tainted: GF VLI
05:05:53 chogs kernel: EFLAGS: 00010296  (2.6.16.38-xen #1)
05:05:53 chogs kernel: EIP is at _drbd_send_page+0x21/0x120 [drbd]
05:05:53 chogs kernel: eax: ffffffff  ebx: c05958fc  ecx: eb024000  edx: 6b6b6b6b
05:05:53 chogs kernel: esi: 6b6b6b6b  edi: a56b6b6b  ebp: eb025eec  esp: eb025ebc
05:05:53 chogs kernel: ds: 007b  es: 007b  ss: 0069
05:05:53 chogs kernel: Process drbd3_worker (pid: 5739, threadinfo=eb024000 task=ed440570)
05:05:53 chogs kernel: Stack: <0>00001000 00004000 00000000 eb024000 00000020 ec64b26c ffffffff 6b6b6b6b
05:05:53 chogs kernel:        ec64b26c c05958fc 00000003 c7a5c6d0 eb025f08 ee2854f3 6b6b6b6b ec64b26c
05:05:54 chogs kernel:        eb025f30 00000000 ec64b26c eb025f5c ee285643 00000020 00008000 00000000
05:05:54 chogs kernel: Call Trace:
05:05:54 chogs kernel:  [<c0105a01>] show_stack_log_lvl+0xa1/0xe0
05:05:54 chogs kernel:  [<c0105bf1>] show_registers+0x181/0x200
05:05:54 chogs kernel:  [<c0105e10>] die+0x100/0x1b0
05:05:54 chogs kernel:  [<c01168f6>] do_page_fault+0x3c6/0x8c1
05:05:54 chogs kernel:  [<c010565f>] error_code+0x2b/0x30
05:05:54 chogs kernel:  [<ee2854f3>] _drbd_send_zc_bio+0x33/0x50 [drbd]
05:05:55 chogs kernel:  [<ee285643>] drbd_send_dblock+0x133/0x1f0 [drbd]
05:05:55 chogs kernel:  [<ee2703da>] w_send_dblock+0x1a/0xe0 [drbd]
05:05:55 chogs kernel:  [<ee270e5e>] drbd_worker+0x2de/0x4b5 [drbd]
05:05:55 chogs kernel:  [<ee283f8c>] drbd_thread_setup+0x8c/0x100 [drbd]
05:05:55 chogs kernel:  [<c0103485>] kernel_thread_helper+0x5/0x10
05:05:55 chogs kernel: Code: 5d f4 8b 7d fc 89 ec 5d c3 90 55 89 e5 57 89 cf b9 00 e0 ff ff 56 53 83 ec 24 8b 75 08 89 45 f0 89 55 ec 21 e1 8b 41 18 89 45 e8 <8b> 02 f6 c4 40 74 03 8b 52 0c 8b 42 04 40 85 c0 7e 09 8b 55 ec
05:05:55 chogs kernel:  <0>Fatal exception: panic in 5 seconds

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
