Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT
Date: Thu, 5 Apr 2007 16:45:41 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C954@EXNA.corp.stratus.com>
In-reply-to: 200704052241.22962.philipp.reisner@linbit.com
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
Thanks for the patch! I will try this and let you know.

EM--

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Thursday, April 05, 2007 4:41 PM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT

Hi Ernest,

I think with this patch it is no longer possible to end up
in the both nodes WFBitMapT situation.

http://lists.linbit.com/pipermail/drbd-cvs/2007-April/001501.html

-Phil
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
