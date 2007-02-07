Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8:Panics in lc_find due to null
	lcafterScsiMEDIUM_ERROR I.O error.
Date: Wed, 7 Feb 2007 08:08:33 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8E3@EXNA.corp.stratus.com>
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

Hi Phil,
Thanks...That is just fine.  I will retest with the new patch and let
you know soon.

Thanks.
EM--=20

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Wednesday, February 07, 2007 8:00 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8:Panics in lc_find due to null
lcafterScsiMEDIUM_ERROR I.O error.

Am Samstag, 3. Februar 2007 00:27 schrieb Montrose, Ernest:
>  Phil,
> The one spot that was missed is in this patch.  I looked around for=20
> other places but I am Still not that everything is covered.

Hi Ernest,

I decided for a different patch:
http://lists.linbit.com/pipermail/drbd-cvs/2007-February/001460.html

Clearing the bit in the bitmap is valid in this case, we only must not
call drbd_try_clear_on_disk_bm(), since that function in turn uses
mdev->resync.=20

The second reason is that there are more calls to the drbd_set_in_sync()
function than to the drbd_try_clear_on_disk_bm(). We would need to
protect each and every call to drbd_set_in_sync()...

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
