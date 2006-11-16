Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
Date: Thu, 16 Nov 2006 07:52:14 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671040347F7@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Not sure I agree that the current behavior is protecting users from =
themselves -- it only causes the split-brain if you lose the n/w and =
during 'normal' operation and there is nothing that protects against =
mounting a 1-node fs on both nodes of a primary-primary DRBD cluster.

Running primary-secondary doesn't work if you are in a situation where =
it is not possible to switch primaryness when failing over; a good =
example of that is if you want to run a Xen virtual machine on top of a =
DRBD partition and support live migration of the VM (the problem is that =
Xen doesn't provide the means to execute a script to change primaryness =
at the required point in the migration). Of course you could argue that =
this is a Xen bug _but_ pragmatically, the proposed patch to delay =
updating the UUID until an actual write occurs preserves (I believe) =
correctness in DRBD and works without introducing new features into Xen.

Recovering from split-brain automatically is of course something that is =
incredibly valuable but I think it can be treated orthogonally to the =
proposed fix.

Simon

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Thursday, November 16, 2006 4:10 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest; Graham, Simon
Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on =
Primary/primary potential patch

Am Dienstag, 7. November 2006 00:47 schrieb Montrose, Ernest:
> When running Primary/Primary if the Heartbeat connection goes down =
when
> we recover we always split brain.  Simon had an idea which I have
> implemented. He is on vacation  so this may not reflect his exact =
idea.
>
> Essentially with this change, we do not create a new current UUID on =
the
> node unless I/O is seen. This prevent Split-Brain mitigation when both
> nodes are primary but only one node is originating I/O and never the
> other.  He is only stand-by in that case.
>
> Take a look and let me know.

Hi Ernest,

I understand your reasoning, I see the patch, which I guess does=20
what you expect of it.

I do not want to do it that way for the following reasons:

 * It is only applicable in case you are using a 1-node filesystem
   on a primary-primary DRBD cluster.

   * I do not want users to do this. Because with this setup it is
     easily possible to mount the FS on both nodes concurrently.
     I want to protect the from themselfs ;)

   * Users using a 1-node filesystem should use DRBD withe=20
     primary and secondary role.

 * I rather want to fix DRBD's split brain recovery methods to deal
   with a cluster crash of a primary-primary cluster (actually this
   is item 41 in the ROADMAP file)

I have a few hours time today, I will work on this today...=20

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
