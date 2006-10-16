Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Date: Mon, 16 Oct 2006 13:53:29 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610161353.29732.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Regarding rs_failed...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Simon,

When you introduced the rs_failed memers of the resync requests, there
happened some minor glitches I think:

 *) Missed to initialize it in drbd_rs_begin_io() actually _bme_get()
 *) Missed to initialize it in case we overwrite an element in the=20
    resynch LRU cache in drbd_try_clear_on_disk_bm().

Additionally I renamed the "cleared" variable to "count" with the=20
2534 commit.

Did I missed something ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=C3=B6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
