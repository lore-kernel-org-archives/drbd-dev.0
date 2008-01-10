Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Thu, 10 Jan 2008 14:00:06 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5AE45@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Crash in lru_cache.c
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I've been seeing an occasional crash (using DRBD8.0) recently in the
lru_cache.c file that looks like this:

Dec  5 05:57:09 ------------[ cut here ]------------
Dec  5 05:57:09 kernel BUG at
/test_logs/builds/SuperNova/trunk/20071205-r21536/src/platform/drbd/src/
drbd/lru_cache.c:312!
Dec  5 05:57:09 invalid opcode: 0000 [#1]
Dec  5 05:57:09 SMP=20
Dec  5 05:57:09 Modules linked in: tun drbd cn ipmi_devintf ipmi_si
ipmi_msghandler bridge ipv6 binfmt_misc dm_mirror dm_multipath dm_mod
video thermal sbs processor i2c_ec i2c_core fan container button battery
asus_acpi ac parport_pc lp parport nvram ide_cd cdrom evdev intel_rng
pcspkr sg bnx2 shpchp piix zlib_inflate pci_hotplug serio_raw
serial_core rtc mptspi scsi_transport_spi ide_disk mptsas mptscsih
mptbase scsi_transport_sas sd_mod scsi_mod raid1 ehci_hcd ohci_hcd
uhci_hcd usbcore
Dec  5 05:57:09 CPU:    1
Dec  5 05:57:09 EIP:    0061:[<ee297564>]    Tainted: GF    VLI
Dec  5 05:57:09 EFLAGS: 00010046  (2.6.18-xen #1)=20
Dec  5 05:57:09 EIP is at lc_put+0x84/0xc0 [drbd]
Dec  5 05:57:10 eax: 00000000  ebx: ee24e000  ecx: ed3a4000  edx:
ee24fc50
Dec  5 05:57:10 esi: ee24fc50  edi: ed3a4000  ebp: deb55e30  esp:
deb55e28
Dec  5 05:57:10 ds: 007b  es: 007b  ss: 0069
Dec  5 05:57:10 Process drbd5_asender (pid: 12691, ti=3Ddeb54000
task=3De6d960f0 task.ti=3Ddeb54000)
Dec  5 05:57:10 Stack: ed3a43b0 00000001 deb55e70 ee29480e 00000000
00000000 00004100 deb55e48=20
Dec  5 05:57:10        00000000 c031e320 00000000 00000000 deb55f38
ed3a4000 00000000 000000e6=20
Dec  5 05:57:10        c8d32288 ed3a4000 deb55ee8 ee29149e 00000001
ffffffff 00000000 00000000=20
Dec  5 05:57:10 Call Trace:
Dec  5 05:57:10  [<c0105dc1>] show_stack_log_lvl+0xb1/0xe0
Dec  5 05:57:10  [<c0105ffa>] show_registers+0x1aa/0x230
Dec  5 05:57:10  [<c01061b6>] die+0x136/0x300
Dec  5 05:57:10  [<c01063ff>] do_trap+0x7f/0xb0
Dec  5 05:57:10  [<c0106be7>] do_invalid_op+0x97/0xb0
Dec  5 05:57:10  [<c01058f3>] error_code+0x2b/0x30
Dec  5 05:57:10  [<ee29480e>] drbd_al_complete_io+0x6e/0x130 [drbd]
Dec  5 05:57:10  [<ee29149e>] _req_may_be_done+0x5ee/0x780 [drbd]
Dec  5 05:57:10  [<ee291993>] _req_mod+0x363/0xab0 [drbd]
Dec  5 05:57:10  [<ee29e7c1>] tl_release+0x51/0x1f0 [drbd]
Dec  5 05:57:10  [<ee28c576>] got_BarrierAck+0x16/0xb0 [drbd]
Dec  5 05:57:10  [<ee28d7b9>] drbd_asender+0x2e9/0x5a0 [drbd]
Dec  5 05:57:10  [<ee29ea0f>] drbd_thread_setup+0xaf/0xf0 [drbd]
Dec  5 05:57:10  [<c0103005>] kernel_thread_helper+0x5/0x10

The failing line of code is asserting in lc_put that the current ref
count is greater than zero. Now, I think this bug has been there for a
while if you are using protocol A or B and has now been exposed when
using protocol C because of the recent change to maintain the transfer
log for all protocols (i.e. it's my fault it got exposed!)

My theory is that the following occurred:

1. We were running normally; this means that the TL has at least one
entry most of the=20
   time - this entry is a request that includes a reference to the AL
cache for that
   write operation.

2. The local disk is detached for some reason (failure, or 'drbdsetup
detach') - this
   causes the AL cache to be discarded

3. The local disk is reattached - the creates a brand spanking new AL
with no hot entries

4. We process a second write for the same AL area as the one above -
this will create a
   new hot entry in the cache, but the refcount will only be one even
though there are
   two I/O's outstanding for the AL area covered by the entry

5. Now we get a barrier ack that allows us to clear both entries from
the TL when we
   attempt to lc_put for the second one we crash because the ref count
is already zero.

So, first of all, does this seem a reaonsable explanation, or did I miss
something?

Secondly, assuming I'm right, I see a couple of possible solutions:

1. Remember in the req structure if this request has a reference to the
AL cache entry.
   When clearing the AL because of a detach, go through the TL list at
that time and
   clear the flag - thus when we eventually remove the entry, we wont
even try the
   lc_put.

2. When attached a disk, run through the current TL and allocate AL
entries for each
   request currently in the list. The problem with this is that the AL
cache size=20
   might have changed in a way that doesn't allow sufficient hot entries
(i.e. the
   cache size is less than the number of unique entries required by the
current
   TL list.

Thoughts? I'm about to start on fixing this, so would welcome ideas...

Thanks,
Simon
  =20
