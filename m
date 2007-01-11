Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - handling data write errors
Date: Wed, 10 Jan 2007 23:00:53 -0500
Message-ID: <342BAC0A5467384983B586A6B0B376710461476B@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> I'm not really sure how to fix this at the moment, but I'm considering
> the following:
>=20
> 1. The side that gets the error marks the block as out of sync AND
> marks
> the local disk as inconsistent.
> 2. Receipt of a NegAck causes the block to be marked as out of sync
AND
> the peer disk is made inconsistent
>    (not sure if I need this step since step 1 should cause this fact
to
> be broadcast but it seems safer).
>=20

So - I've found there is some existing code in place already - for
example, set_out_of_sync
is done in req_may_be_done if either local or remote fails, however,
this is not sufficient
for a couple of reasons:

1. Need to get the failing disk set Inconsistent so that following reads
do not attempt
   to use the local block.

2. It seems to me that the current code doesn't really handle
set_out_of_sync being set
   whilst resync is in progress (i.e. if a write error occurs on an
application write
   during resync).

I've also coded something that sends the Inconsistent state to the other
side, which will trigger resync immediately - perhaps I shouldn't do
this??? Not really going to be able to fix this problem (although it
might be worth trying if the error was transient)...

I wonder if we shouldn't instead simply always detach on error (i.e.
stop using PassOn at all) to get the best behavior... this would
certainly make things simpler (and we could remove the forcible detach
on meta-data error that I added earlier -- if you want to be able to
handle errors then never use PassOn!

Simon
