Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Crash in lru_cache.c
Date: Sat, 12 Jan 2008 18:37:47 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5B0C0@EXNA.corp.stratus.com>
In-Reply-To: 20080112170446.GA26053@debian-etc-mailname
References: <342BAC0A5467384983B586A6B0B3767107C5B0B7@EXNA.corp.stratus.com>
	20080112170446.GA26053@debian-etc-mailname
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> sure I can have requests there, but they are not yet completed to
upper
> layers.  if they are, their correponding barrier will have been send
> out
> already.
>=20
> for attach, we would then do
>   block new incomming request
>   wait for ap count to reach zero
>   [in current code, send out a barrier now;
>    with the idea outline above, there is no need for that]
>   wait for the lates barrier ack
>       (tl now empty)
>   attach
>   unblock
>=20
> am I still missing something?

I think that works.=20

What's the appropriate mechanism for blocking new requests? There are
existing mechanisms based on locking the AL cache entry, but since there
is no AL at this time, we cant use that...

Thanks for the ideas!
Simon
