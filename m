Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] drbd0: [drbd0_receiver/5740] sock_sendmsg time expired,
	ko = 4294967294
Date: Tue, 12 Jun 2007 10:23:41 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F4792F@EXNA.corp.stratus.com>
In-Reply-To: 200706121614.42579.philipp.reisner@linbit.com
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
OK..So it's a feature..Not a bug..:)  Thanks for the clarification..

EM--

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Tuesday, June 12, 2007 10:15 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] drbd0: [drbd0_receiver/5740] sock_sendmsg time
expired,ko =3D 4294967294

On Monday 11 June 2007 03:39:47 Montrose, Ernest wrote:
> Hi all,
> It seems that the mdev->ko_count counter is going negative as
evidenced by
> the following message: drbd0: [drbd0_receiver/5740] sock_sendmsg time
> expired, ko =3D 4294967294
>

This is intended this way. If you configure ko_count to zero it becomes
that very large integer with the first expiration of the timeout. I.e.
no drop of connection.

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
