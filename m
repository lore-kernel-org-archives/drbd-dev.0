Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8DED014311
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jan 2005 13:00:22 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 Jan 2005 13:01:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200501171301.39032.philipp.reisner@linbit.com>
Subject: [Drbd-dev] drbd-0.7.8 Release will happen today...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


0.7.8 (api:77/proto:74)
=2D----
 * Fixed a bug that caused the syncer to starve on devices=20
   bigger than 2 TB on 32bit systems (=3DCONFIG_LBA).
 * Made online resizing actually work. Now it makes a lot
   more sense to put DRBD on top of LVM.
 * Made the user dialog to work on RedHat based distributions.
 * A small optimization that improves the performance of the=20
   syncer when woking with IBM's ServRaid Controllers (ips).
   May have a positive effect with other Controllers as well.
 * Made epoch_size atomic. This removes a SMP race condition that
   could lead on some Xeon CPUs to an ASSERT printk, but did no other
   harm than printing messages to the syslog
 * Fixed write_gc.pl to work with the perl version delivered
   with RHAS3.
 * Made the initscript to abort if one of the setup commands fails.

I will send the usual announcement to the announcements list, when
it is done...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
