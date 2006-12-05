Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: rr-conflict violently breaks sync states.
Date: Tue, 5 Dec 2006 08:53:13 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C85C@EXNA.corp.stratus.com>
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
This issue is resolved!!!It was a problem in the way we install and the
fact
That the drbd user tools have changed. Sorry about the false alarm :)

EM--
-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Monday, December 04, 2006 5:29 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: rr-conflict violently breaks sync states.

Am Freitag, 1. Dezember 2006 23:10 schrieb Montrose, Ernest:
> If "rr-conflict vilently;" is present in /etc/drbd.conf then the drbd
> volumes will not sync completely. Some of them ends up in :
> cs: Connected:St: secondary/Secondary:ds: Inconsistent/Inconsistent
>
> These states are on both nodes.
>
> It seems like this rr-conflict violently is not fully implemented.


Hi Ernest,

Actually it is. Could you grep in the kernel-logfile for all messages of
the devices that ended up in that state. Preferrable from both nodes.

Thanks!

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
