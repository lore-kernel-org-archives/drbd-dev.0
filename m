Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8:Panics in lc_find due to null lc after
	ScsiMEDIUM_ERROR I.O error.
Date: Wed, 31 Jan 2007 12:32:37 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8DA@EXNA.corp.stratus.com>
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
Thank you very much.That was fast!!..This should be quick to verify!!
Just have to run it
On my machine with the broken disk.  Sweet!! I'll let you know.

EM--=20

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Wednesday, January 31, 2007 12:26 PM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8:Panics in lc_find due to null lc after
ScsiMEDIUM_ERROR I.O error.

Am Mittwoch, 31. Januar 2007 14:58 schrieb Montrose, Ernest:

Just for the records, this triggered this commit:
http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001458.html

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
