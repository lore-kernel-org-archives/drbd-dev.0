Return-Path: <ldenel@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.194])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 67558143C9
	for <drbd-dev@lists.linbit.com>; Tue, 28 Mar 2006 18:33:42 +0200 (CEST)
Received: by xproxy.gmail.com with SMTP id s6so1114634wxc
	for <drbd-dev@lists.linbit.com>; Tue, 28 Mar 2006 08:33:41 -0800 (PST)
Message-ID: <6ed4c8790603280833s4f7478b3r661d9dfc2ad073b0@mail.gmail.com>
Date: Tue, 28 Mar 2006 18:33:40 +0200
From: "Laurent Denel" <ldenel@gmail.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] freeze under postmark io bench
In-Reply-To: <6ed4c8790603230008t155b855djc4c77b5366357526@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
	<20060311163505.GC3816@soda.linbit>
	<6ed4c8790603221046w6fedd871p8786bc427eafd8b@mail.gmail.com>
	<20060322223502.GB6223@barkeeper1.linbit>
	<6ed4c8790603230008t155b855djc4c77b5366357526@mail.gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Finally, I've been able to capture some traces when the host hangs,
iLO remote access has been set up today. Hope this helps.

Cheers
LD

Unable to handle kernel paging request at virtual address 98393c38
  printing eip:
c01124ae
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: drbd bcm5700
CPU:    134217728
EIP:    0060:[<c01124ae>]    Not tainted VLI
EFLAGS: 00010206   (2.6.16-AWL-messagerie #1)
EIP is at do_page_fault+0x96/0x51f
eax: f7c21000   ebx: f7c22078   ecx: 0000007b   edx: 98393bc0
esi: 98393bc0   edi: c0112418   ebp: 98393c38   esp: f7c210a0
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
c
  printing eip:
c01990db
*pde =3D 37ee3001
BUG: soft lockup detected on CPU#0!

Pid: 2565, comm:                  sar
EIP: 0060:[<c031c840>] CPU: 0
EIP is at _spin_lock+0x3f/0x59
  EFLAGS: 00000202    Not tainted  (2.6.16-AWL-messagerie #1)
EAX: 00000000 EBX: c0370a18 ECX: 00000001 EDX: 00000001
ESI: 00000001 EDI: 00000032 EBP: c2383740 DS: 007b ES: 007b
CR0: 8005003b CR2: bf8decec CR3: 37f81880 CR4: 000006f0
 [<c010d215>] smp_call_function+0x13/0x104
 [<c0141f47>] set_page_address+0x114/0x159
 [<c010d1ac>] flush_tlb_all+0x1a/0x43
 [<c010d13b>] do_flush_tlb_all+0x0/0x57
 [<c0141767>] kmap_high+0x51/0x19b
 [<c013c5b4>] get_page_from_freelist+0x70/0x88
 [<c013c612>] __alloc_pages+0x46/0x25f
 [<c015db5a>] pipe_writev+0x1ef/0x380
 [<c015dd10>] pipe_write+0x25/0x29
 [<c0152ed8>] vfs_write+0x87/0x11b
 [<c015300a>] sys_write+0x3b/0x63
 [<c01027ef>] sysenter_past_esp+0x54/0x75
