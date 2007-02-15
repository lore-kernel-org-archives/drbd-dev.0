Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io
	errorduring resync.
Date: Thu, 15 Feb 2007 10:44:54 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8FC@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
I will try all these but I think I have some clues for you that may lead
you to a fix.
I instrumented the driver and caused the crash. Essentially what I
understand to be happening=20
Is that after_state_ch() is setting mdev->bc to NULL and then
drbd_io_error() is using it
after in: drbd_io_error(){.......
  If(inc_local_if_state(mdev,Failed )){
	eh =3D mdev->bc->dc.on_io_error; <-----we die here I
think.mdev->bc is NULL
...
}
Mdev->bc was set to Null earlier in after_state_ch(){.....
If(os.disk >Diskless && ns.disk =3D=3D Diskless){
....mdev->bc =3D NULL;
..
}

This is some sort of a race condition as this does not happen all the
times.  Below
Is the result of my instrumentation.  You can see that we behaved nicely
at first after
An I/O error..but latter when the same I/O error occurs...we die.:
Some more very telling data:

=3D=3D=3D=3D=3D=3D=3DStart debug messages=3D=3D=3D=3D=3D=3D=3D
Feb 15 08:50:16 captain kernel: sd 1:0:28:0: SCSI error: return code =3D
0x8000002
Feb 15 08:50:16 captain kernel: sda: Current: sense key: Medium Error
Feb 15 08:50:16 captain kernel:    Additional sense: Recovered data with
retries and/or circ applied
Feb 15 08:50:16 captain kernel: end_request: I/O error, dev sda, sector
19071159
Feb 15 08:50:16 captain kernel: drbd0: disk( Diskless -> Failed )
Feb 15 08:50:16 captain kernel: drbd0: Local IO failed. Detaching...
Feb 15 08:50:16 captain kernel: drbd_io_error: EM--****** Handling an IO
error****************************************
Feb 15 08:50:16 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev is valid***********************
Feb 15 08:50:16 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev->bc is valid***********************
Feb 15 08:50:16 captain kernel: drbd0: disk( Failed -> Diskless )
Feb 15 08:50:16 captain kernel: drbd0: Notified peer that my disk is
broken.
Feb 15 08:50:16 captain kernel: sd 1:0:28:0: SCSI error: return code =3D
0x8000002
Feb 15 08:50:16 captain kernel: sda: Current: sense key: Medium Error
Feb 15 08:50:16 captain kernel:    Additional sense: Recovered data with
retries and/or circ applied
Feb 15 08:50:16 captain kernel: end_request: I/O error, dev sda, sector
19071167
Feb 15 08:50:16 captain kernel: drbd0: disk( Diskless -> Failed )
Feb 15 08:50:16 captain kernel: drbd0: Local IO failed. Detaching...
Feb 15 08:50:16 captain kernel: after_state_ch: EM-- *******Setting
mdev->bc to NULL after freeing it ******
Feb 15 08:50:16 captain last message repeated 2 times
Feb 15 08:50:16 captain kernel: drbd_io_error: EM--****** Handling an IO
error****************************************
Feb 15 08:50:16 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev is valid***********************
Feb 15 08:50:16 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev->bc is NOT valid***********************
Feb 15 08:50:16 captain kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000ac

=3D=3D=3D=3D=3D=3DEnd debug messages=3D=3D=3D=3D=3D=3D=3D


I will prepare the other stuff and send them to later....Thanks!!!
EM--




-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Thursday, February 15, 2007 10:28 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io
errorduring resync.

Am Mittwoch, 14. Februar 2007 19:03 schrieb Montrose, Ernest:
> Hi all,
> We are overwelmed with panic's after io errors. Seem mdev->bc is null=20
> due to some race condition.  Here is one instance:
>
> Two node cluster, node A and Node B. Syncsource is node A. While=20
> syncing Reads are issued on Node B.  I/O errosrs start to occur on=20
> node A,  Node A panics :
>
[...OOPS... ]

Hi Ernest,

I was not able to understand the cause of the oops on the first glance.

Could you provide the output of ksymoops when you feed this OOPS to it ?
( I am interested in the disassebled code)

AND=20

I do this debugging by comparing it to the assembler output of the
compiler.
Please provide the .s files from the machine where you build your drbd
(with your compiler, kernel config and kernel source).

Remke DRBD with "make V=3D1"

The create the .s file:
Replaceing the "-c" option with "-gstabs+ -S" and the -o "foo.o" to -o
"foo.s" in the call of the compiler

Something like this:
(cd $KDIR ; gcc ... /some/path/foo.c )

Thanks,
Philipp
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
