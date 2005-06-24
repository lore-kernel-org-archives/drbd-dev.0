Return-Path: <philipp.reisner@linbit.com>
Received: from [10.9.9.50] (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C2FC514435
	for <drbd-dev@lists.linbit.com>; Fri, 24 Jun 2005 13:38:55 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd crashes the SyncSource if a read error is
	encountered during sync
Date: Fri, 24 Jun 2005 13:41:05 +0200
References: <20050623193709.GK29587@marowsky-bree.de>
In-Reply-To: <20050623193709.GK29587@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200506241341.05585.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000004 printing eip:
> > f8bf6cf8
> > *pde =3D 00000000
> > Oops: 0002 [#1]
> > CPU:    0
> > EIP:    0060:[<f8bf6cf8>]    Tainted: G  U
> > EFLAGS: 00010086   (2.6.5-7.155-SLRS SLES9_SP1_BRANCH-20050329143635000=
0)
> > EIP is at receive_DataRequest+0x1b8/0x6f0 [drbd]
> > eax: 00000000   ebx: 003ba238   ecx: f687b800   edx: f687bc74
> > esi: 00000000   edi: f687bc74   ebp: 00000000   esp: f68d7fa8
> > ds: 007b   es: 007b   ss: 0068
> > Process drbd0_receiver (pid: 7714, threadinfo=3Df68d6000 task=3Df6a2336=
0)
> > Stack: 00004100 ffffff0a 00001000 f687b9d8 f687b800 f8bf6b40 f687b9d8
> > f687b800 f687bbd8 f8bf63cc f687bbdc 00000000 f687bbd8 00000000 f8bfd624
> > f8bfd5c0 00000000 00000000 c0106005 f687bbd8 00000000 00000000
> > Call Trace:
> >  [<f8bf6b40>] receive_DataRequest+0x0/0x6f0 [drbd]
> >  [<f8bf63cc>] drbdd_init+0xac/0x2a0 [drbd]
> >  [<f8bfd624>] drbd_thread_setup+0x64/0xb0 [drbd]
> >  [<f8bfd5c0>] drbd_thread_setup+0x0/0xb0 [drbd]
> >  [<c0106005>] kernel_thread_helper+0x5/0x10
> >
> > Code: 89 78 04 89 57 04 fb ff 81 b0 03 00 00 8b 81 bc 03 00 00 80
> >  Dumping to block device (3,1) on CPU 0 ...
[...]

N.b. I case it is urgent, it would help a lot if you could do an
ksymoops on the machine (for decoding of the Code line), as
well as a=20

gcc -Sg of that drbd_receiver.c with that compiler on that kernel=20
with the right other gcc options :)

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
