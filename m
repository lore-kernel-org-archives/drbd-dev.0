Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id ED140162A8
	for <drbd-dev@lists.linbit.com>; Tue, 31 Jan 2006 19:00:14 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 31 Jan 2006 19:00:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200601311900.15806.philipp.reisner@linbit.com>
Subject: [Drbd-dev] internal vs external meta data [reminder]
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

internal vs external meta data

Theoretical it should be quicker in case you use external meta
data. Because AL-misses cause the disk-head to seek to the meta-
data area, write to the AL, and then seek back to the data location.
Real world measurement shows that the opposite is currently the case:

internal meta data

257 misses (outer sectors)
19.62 MB/sec (1077936128 B / 00:52.390089)
19.28 MB/sec (1077936128 B / 00:53.314101)
19.31 MB/sec (1077936128 B / 00:53.229198)

0 misses (outer sectors)
20.72 MB/sec (1077936128 B / 00:49.611017)
20.95 MB/sec (1077936128 B / 00:49.074782)
20.77 MB/sec (1077936128 B / 00:49.502596)

external meta data:

257 misses (outer sectors)
16.40 MB/sec (1077936128 B / 01:02.677786)
16.32 MB/sec (1077936128 B / 01:02.994084)
16.51 MB/sec (1077936128 B / 01:02.271167)

0 misses (outer sectors)
16.46 MB/sec (1077936128 B / 01:02.453234)
16.51 MB/sec (1077936128 B / 01:02.261244)
16.69 MB/sec (1077936128 B / 01:01.606018)

With the write to the meta-data the disk queue runs more frequent,
in case the meta-data is internal, this causes the higher performance
because in the same disk queue are also the blocks for the data
area.

Completely unclear is why the two test sets  with no misses completed
with different results. The only difference was the location of
the meta data, but there are now writes to the meta-data area,
if there are no misses.=20

=2Dphilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
