Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an
	ioerrorduring resync.
Date: Fri, 16 Feb 2007 15:52:43 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C903@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars,
It appears that this patch will work around the panic.

Thanks!

EM--=20

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Lars Ellenberg
Sent: Friday, February 16, 2007 12:32 PM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an
ioerrorduring resync.

/ 2007-02-16 09:55:12 -0500
\ Montrose, Ernest:
> Phil,
> Thanks!
>=20
> I think all these panics on I/O errors are all related to the same
bug.
>=20
> Your comments make me look at a different angle... Looking at the logs

> around the failure Shows a problem on repeated I/O errors...the state=20
> machine is somewhat confused..It essentially Goes from=20
> Uptodate->Failed which is fine...then from
> Failed->Diskless...fine...then we go and
> Wait for mdev->local_cnt to be false like you explained...
> Then we get more I/O errors...and our problem starts...
> We go from Diskless->failed..again.(This does not seem correct since=20
> we just went from this state)

even though I dislike our overall state engine design, it may be enough
to do

--- drbd/drbd_main.c    (revision 2754)
+++ drbd/drbd_main.c    (working copy)
@@ -604,6 +604,11 @@
                dec_local(mdev);
        }

+       /* If we are Diskless, we can only go to Attaching. */
+       if ( (os.disk =3D=3D Diskless) && (ns.disk !=3D Attaching) ) {
+               ns.disk =3D Diskless;
+       }
+
        /* Early state sanitising. Dissalow the invalidate ioctl to
 * connect  */
        if( (ns.conn =3D=3D StartingSyncS || ns.conn =3D=3D =
StartingSyncT) &&
                os.conn < Connected ) {


> Then faile->diskless again
> We get more I/O errors...(not good)
> Mdev->bc is set to null eventually
> We went and wait again for mdev->local_cnt to be False..(not good) Now

> we die an awful ungodly death..:)
>=20
> Here is the full log around the failure:
> Feb 15 16:01:57 captain kernel: end_request: I/O error, dev sda,=20
> sector
> 17554615
> Feb 15 16:01:57 captain kernel: drbd0: disk( UpToDate -> Failed ) Feb=20
> 15 16:01:57 captain kernel: drbd0: Local IO failed. Detaching...
> Feb 15 16:01:57 captain kernel: drbd_io_error: EM--****** Handling an=20
> IO error***mdev->bc is valid*********************** Feb 15 16:01:57=20
> captain kernel: drbd0: disk( Failed -> Diskless ) Feb 15 16:01:57=20
> captain kernel: drbd0: Notified peer that my disk is broken.
> Feb 15 16:01:57 captain kernel: after_state_ch: EM-- *******Waiting=20
> for
> mdev->local_cnt to be FALSE ******
> Feb 15 16:01:57 captain kernel: end_request: I/O error, dev sda,=20
> sector
> 17554623
> Feb 15 16:01:57 captain kernel: drbd0: disk( Diskless -> Failed )

right. this is not allowed.

but this also means that our reference counting of in-flight local
requests is not ok, since once local_cnt is zero, there should be no
more in-flight requests to the local disk that might trigger the end_io
handler.

--=20
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
