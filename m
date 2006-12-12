Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B28952D9D69F
	for <drbd-dev@lists.linbit.com>; Tue, 12 Dec 2006 19:56:10 +0100 (CET)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:34586)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1GuCnR-0006Jk-Cv
	for drbd-dev@lists.linbit.com; Tue, 12 Dec 2006 18:56:09 +0000
Message-ID: <457EFB5D.2080500@dcs.gla.ac.uk>
Date: Tue, 12 Dec 2006 18:56:29 +0000
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] modprobe error
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


I just tried drbd8.0pre6 with the 2.6.16.29 xen kernel.
Compilation goes without errors: make clean all, make tools, make 
install ...
However, I am getting this oops when doing "modprobe drbd":
Can you please tell help me find out why is this happening?

Thank you.


[  188.728070] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[  188.728253]  printing eip:
[  188.728323] d126a47b
[  188.728394] *pde = ma 00000000 pa fffff000
[  188.728467] Oops: 0002 [#1]
[  188.728537] Modules linked in: drbd intel_agp agpgart
[  188.728842] CPU:    0
[  188.728843] EIP:    0061:[<d126a47b>]    Not tainted VLI
[  188.728844] EFLAGS: 00010286   (2.6.16.29-xen0 #5)
[  188.729072] EIP is at cn_queue_add_callback+0x3b/0xf0 [drbd]
[  188.729146] eax: fffffff4   ebx: d127b524   ecx: d1274c03   edx: 00000000
[  188.729222] esi: 0806f9d0   edi: ced77200   ebp: c869bf2c   esp: c869bf10
[  188.729296] ds: 007b   es: 007b   ss: 0069
[  188.729368] Process modprobe (pid: 3882, threadinfo=c869a000 
task=c9a8a070)
[  188.729434] Stack: <0>d1274a82 d127b524 d12695d0 00000000 d127b524 
0806f9d0 4014d340 c869bf48
[  188.730160]        d1269ffb 00000000 d1274a82 d127b524 d12695d0 
d127b600 c869bf60 d127d207
[  188.730820]        d127b524 d1274a82 d12695d0 d127b600 c869bf98 
d127d028 00000000 00000000
[  188.731480] Call Trace:
[  188.731607]  [<c010526a>] show_stack_log_lvl+0xaa/0xe0
[  188.731857]  [<c010548e>] show_registers+0x18e/0x1f0
[  188.732103]  [<c0105679>] die+0xd9/0x180
[  188.732347]  [<c0112dd1>] do_page_fault+0x301/0x6cb
[  188.732595]  [<c0104e6b>] error_code+0x2b/0x30
[  188.732840]  [<d1269ffb>] cn_add_callback+0x2b/0x50 [drbd]
[  188.733094]  [<d127d207>] drbd_nl_init+0x27/0x50 [drbd]
[  188.733346]  [<d127d028>] init_module+0x28/0x1e0 [drbd]
[  188.733598]  [<c01346d5>] sys_init_module+0x135/0x1b0
[  188.733845]  [<c0104cf5>] syscall_call+0x7/0xb
[  188.734090] Code: 00 00 00 89 44 24 08 8b 45 10 89 44 24 04 8b 45 0c 
89 04 24 e8 b7 fe ff ff 89 c7 85 ff b8 f4 ff ff ff 0f 84 88 00 00 00 8b 
55 08 <ff> 02 89 57 3c b8 00 e0 ff ff 21 e0 81 40 14 00 01 00 00 8b 5a
[  188.737941]


Thank you

Cristian
