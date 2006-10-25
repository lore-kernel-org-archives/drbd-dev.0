Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: pri-lost-after-sb handler not kicking in on
	Split-brain or so it seems
Date: Wed, 25 Oct 2006 15:40:18 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C811@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C811@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610251540.18997.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 25. Oktober 2006 00:06 schrieb Montrose, Ernest:
> Hi all,
> I set my configuration to allow two primaries and have those parameters
> set:
>
> allow-two-primaries;
> after-sb-0pri discard-least-changes;
> after-sb-2pri call-pri-lost-after-sb;
>
> I, of course, set a pri-lost-after-sb handler.    I then induced a split
> brain (Ifdown hbiface; ifup hbiface).
> I issue a drbdadm connect all on my primary.
>
> What happens is that:
> *	one of the nodes is forced to be secondary. (T original state
> was Primary/Primary before the split brain)
> *	My handler I never called.

The idea is:=20

1) run the "discard-least-changes" algorithm
2) try to make the looser secondary (and start resync)
3) If that failes call the user space helper

You might ask, why this is like that? ...

The root problem is that after a split brain, with both nodes in
primary state, we have to discard the data of one of the two nodes.

In case there is a a filesystem on top of DRBD, I do not see an other
option that to reboot the machine. There is not way a block devices
says to a file system: Sorry, I have to change my content, please
do not mind ;)

But if a device can be switched into secondary state, we know that
there is not file system on top of DRBD and therefore the reboot
can be avioded!


Actually we should avoid split brain situations in the first place,
see the "outdate-peer" hander!

>
> A quick look at drbd_receiver.c:drbd_asb_recover_2p() reveals that my
> handler would not be called because I successfully
> Setup the node to secondary.  Is this by design?  I would like for the
> handler to be called every time I attempt to recover from SB. Or at
> least,
> If in fact, the SB is "automatically solved" then my Sstate of
> Primary/Primary should return.  Any thoughts?

Ernest,=20
I see, that you want to have a handler that is called every time a
split-brain happens. I might consider this, but first I want to=20
understand what you want to do with that hander. What it could=20
be good for...=20

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
