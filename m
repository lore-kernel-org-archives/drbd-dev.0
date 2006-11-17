Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Fencing and outdate-peer handler getting
	calledmultiple times
Date: Fri, 17 Nov 2006 09:18:17 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C838@EXNA.corp.stratus.com>
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
Aha! Thanks for the clarification. I will try again.

EM--

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Lars Ellenberg
Sent: Friday, November 17, 2006 9:13 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: Fencing and outdate-peer handler getting
calledmultiple times

/ 2006-11-16 08:10:56 -0500
\ Montrose, Ernest:
> Phil,
> My outdate-peer handler simply says "echo /deve/drbd0: Running handler
for outdate-peer >>/tmp/drbdio.log"
> And that log file is populated and created so I can only assume that
did indicate success.
> In this case success being an exit status of 0.

and exactly that assumption is wrong.

in your kernel log you should find messages like
"outdate-peer helper broken, returned 0"=20

>   If the disk state of the peer is unknown, drbd calls this=20
>   handler (yes a call to userspace from kernel space). The handler's
>   returncodes are:
>=20
>   3 -> peer is inconsistent=20
>   4 -> peer is outdated (this handler outdated it) [ resource fencing
]
>   5 -> peer was down / unreachable
>   6 -> peer is primary
>   7 -> peer got stonithed [ node fencing ]

these are the only valid return codes.

"success" being defined as=20
  "was able to outdate the peer" respective
  "peer need not to be outdated"

--=20
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
