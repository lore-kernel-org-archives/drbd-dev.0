Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Proposed update to packet dumping code
Date: Wed, 9 Aug 2006 20:43:05 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624D5F@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> I'd like to even be able to "echo $mask > sysfs", to select which
> packets to dump. this could be done by reserving the lower values
> (using the first few bits) for generic switching, and if you see a
> higher number with all lower bits cleared, you'd shift it and
interpret
> it as a bitmask.  whether thats useful, I don't know...
>=20

I think something like this would be useful too -- the way I'd like to
approach it though is more general - rather than using bits to control
which packet types are printed, I would suggest migrating over time to a
scheme where ALL of the DRBD tracing is controlled by a couple of sysfs
variables -- perhaps using the following:

1. A variable that controls the type of tracing -- packet dumps would be
one type, examples of others might be resync, bitmap,
   activity log, bio's etc -- this variable would be a bitmap

2. A variable to control the verbosity - this would be a value and the
higher the number, the more output is produced.

Having done that, replace the existing trace macros & printk calls with
macros are passed type/level params and which check the values of the
variables inline and then call printk if the trace should be output. Of
course it's important to have a type/level combination that is always
output since there is some output that must always be printed...

This, I think, is orthogonal to the code I sent with this patch though
-- it would have to change a little but it would be straightforward to
make the change in this code (but a fair amount of work to change all
the other trace calls).=20

Can I suggest that we (ok, you ;-) add the enhanced packet dumping code
now and maybe later on move to a more dynamic and configurable tracing
scheme? I'm certainly willing to make changes and repost this patch if
there is something specific you'd like me to change...

Simon

PS: Some might argue that the levels already exist by means of the
various printk levels; there are, however, a couple of major issues with
this, including:

1. It's not possible to control the level of output on a per-driver
level
2. The mechanism for getting different levels of printk output to the
console and messages file is confusing and difficult and
   I for one have never managed to grok the /proc/sys/kernel/printk
file...
3. There's no concept of debug types in printk.

