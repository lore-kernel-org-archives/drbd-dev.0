Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Jacobson" <mengxx@ict.ac.cn>
Date: Thu, 2 Nov 2006 09:57:05 +0100
References: <200610241508.49069.philipp.reisner@linbit.com>
	<004101c6fca1$1593f4b0$04710a0a@jacobson>
In-Reply-To: <004101c6fca1$1593f4b0$04710a0a@jacobson>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611020957.06404.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: question about drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 31. Oktober 2006 05:00 schrieb Jacobson:
> Dear philipp:
>     I am now studying drbd code. I can not get why, in function
> _drbd_send_page(),  the page send method can not be used in case of
> PageSlab(page) =3D=3D 1? I am looking forword to your response:). Many th=
anks.
> one of drbd fan

If I remeber correctly, pages that are controlled by slab have only a
use count of one (Slab holds that single reference) [maybe it was zero,
because slab does not use the reference counting on pages].
When zero copy send is done, the network code simply decreases the
reference count to that page by one.=20

I think it was the slab code that does not like it if someone=20
modifies the reference counts of the pages with are owned by=20
slab.

PS: As noted in the code, the only FS at that time, was XFS, which=20
    was using such pages...

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
