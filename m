Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2007 15:50:19 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671046146E6@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 - handling data write errors
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

A few months ago, I added support to handle write errors for the
meta-data portions of the disk (by forcibly detaching the disk when this
occurs).

Now I'm looking at handling write errors in the data portion and
wondering what the best approach would be - the current behavior is
definitely wrong because we end up with the two plexes having
inconsistent data with no record of the fact in the bitmap or other disk
state. This is true no matter what flavor of error handling is used.

I'm not really sure how to fix this at the moment, but I'm considering
the following:

1. The side that gets the error marks the block as out of sync AND marks
the local disk as inconsistent.
2. Receipt of a NegAck causes the block to be marked as out of sync AND
the peer disk is made inconsistent=20
   (not sure if I need this step since step 1 should cause this fact to
be broadcast but it seems safer).

I'm not sure if I need to bump the UUID info as well here to ensure
resync happens correctly in the future?

I also considered forcibly detaching the disk in this case but rejected
that as it makes the rest of the disk unavailable when the error might
only be in one block.

One last problem to be considered is when we get write errors in
different blocks on both disks -- they cant both be inconsistent (how
would we know which way to resync?); I'm not sure what the right answer
is here - anyone have any suggestions?

Thanks,
Simon
