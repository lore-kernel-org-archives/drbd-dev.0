Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Aug 2006 14:17:39 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624F66@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 crash in drbd_rd_begin_io if connection is
	terminated at the wrong time...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I haven't been able to figure this one out yet, but when the syncsource
machine disconnects the n/w connection at the wrong time, I get the
attached panic.

What I cant figure out at the moment is exactly which source line
corresponds to the faulting address - the assembler is:

   15647:	8b 4d 08             	mov    0x8(%ebp),%ecx
   1564a:	31 ff                	xor    %edi,%edi
   1564c:	8b 81 f0 02 00 00    	mov    0x2f0(%ecx),%eax
   15652:	8b 50 1c             	mov    0x1c(%eax),%edx

The fault occurs on the last line and eax is zero, so it's a double
dereference where the 1st pointer is at offset 2f0 in the struct pointed
to by ecx and is NULL -- I'm assuming that something got zeroed as a
result of losing the connection and the rs_begin_io processing is not
smart enough to check... (the disassembled output from objdump -S does
not show any source lines around this, so it's pretty hard to figure out
the actual line of code here).

I'm hoping someone who knows this code better (i.e. Philipp or Lars ;-)
will immediately know what the problem is!
Simon

--------panic info ----------

drbd15: short read expecting header on sock: r=3D-512
drbd15: tl_clear()
Aug 11 09:40:45 ellwood kernel: drbd15: peer( Secondary -> Unknown )
conn( SyncSource -> StandAlone )=20
drbd0: short read expecting header on sock: r=3D-512
Unable to handle kernel NULL pointer dereference at virtual address
0000001c
 printing eip:
f128d652
*pde =3D ma 00000000 pa fffff000
Oops: 0000 [#1]
Modules linked in: drbd ipmi_devintf ipmi_si ipmi_msghandler video
thermal processor fan button battery ac
CPU:    0
EIP:    0061:[<f128d652>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16.13-xen0 #2)=20
EIP is at drbd_rs_begin_io+0x2f2/0x5b0 [drbd]
eax: 00000000   ebx: 00000000   ecx: e6588000   edx: fbfa9000
esi: e658836c   edi: 00000000   ebp: e6325f40   esp: e6325ecc
ds: 007b   es: 007b   ss: 0069
Process drbd0_worker (pid: 13898, threadinfo=3De6324000 task=3De5811030)
Stack: <0>00004100 e6325ef8 f129154b e6588000 e7b3dc80 00000009 e6325f14
00000020=20
       00000000 ffffffff 00000000 e5811030 c012d570 e6325f20 e6325f20
eaf32440=20
       e6588000 e6325f40 00000000 e5811030 c012d570 e658836c e658836c
ffffffff=20
Call Trace:
 [<c010513a>] show_stack_log_lvl+0xaa/0xe0
 [<c010534e>] show_registers+0x18e/0x210
 [<c0105549>] die+0xd9/0x180
 [<c0112b7c>] do_page_fault+0x3cc/0x640
 [<c0104d5f>] error_code+0x2b/0x30
 [<f127fc7e>] w_make_resync_request+0xfe/0x310 [drbd]
 [<f1281b16>] drbd_worker+0x186/0x4f7 [drbd]
 [<f1290f8d>] drbd_thread_setup+0x7d/0xe0 [drbd]
 [<c0102d85>] kernel_thread_helper+0x5/0x10
Code: 6c 03 00 00 89 45 d4 89 4d d8 c7 45 dc 70 d5 12 c0 b9 01 00 00 00
8d 55 d4 89 f0 e8 b9 fd e9 ce 8b 4d 08 31 ff 8b 81 f0 02 00 00 <8b> 50
1c 8b 81 f4 02 00 00 31 c9 83 ea 03 39 d0 0f 86 8f 00 00=20
 <0>Fatal exception: panic in 5 seconds
