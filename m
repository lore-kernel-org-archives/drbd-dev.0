Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@linbit.com
Date: Mon, 9 May 2005 10:30:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200505091030.00455.philipp.reisner@linbit.com>
Cc: Paul Clements <paul.clements@steeleye.com>
Subject: [Drbd-dev] 0.7.11 soon
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

The last DRBD release happened on the 31st Jan of 2005, this=20
is more than 3 month by now. I guess we need to give our
users the feeling that DRBD is still alive :)

0.7.11 (api:77/proto:74)
=2D----
 * The upper limit of the runtime tuning parameter max_buffers=20
   was ways too low for today's IBM storage controllers.=20
   Was 32 - 10000 ; Now it is 32 - 131072 ( Now one could=20
   allow DRBD to allocate up to half a gigabyte of memory as=20
   receive buffers)
 * A fix to the Makefiles to make building of RPMs work on RAHS4.
 * A workaround to have DBRD running on PPC64 with Linux-2.4.x kernels,
   on Linux-2.6.x everything was fine already.
 * Removal of dead code (busy_blocks).

I will tag, create the tar-ball and announce it on wednesday,=20
as long as nobody objects.

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
