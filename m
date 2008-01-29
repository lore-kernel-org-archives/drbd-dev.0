Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] [PATCH] DRBD 8.0;
	Make sure barrier is sent after last data block in epoch
Date: Tue, 29 Jan 2008 14:40:10 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671080C8E4B@EXNA.corp.stratus.com>
In-Reply-To: 200801291437.06285.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B3767107E8A3F8@EXNA.corp.stratus.com>
	200801291437.06285.philipp.reisner@linbit.com
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> BTW, I did white space changes to them.

Sorry - I do try to remember to use the right conventions when editing
these files, but it's different from our internal standard and I
sometimes forget!

> From the other patch bomb I still intend to merge
> 0010-Ensure-that-state-updates-cannot-be-done-out-of-orde.patch
>=20
> Regarding the other patches from patch bomb #1, I wanted to
> write an summay, which patches where accepted, which are not
> yet applied for what reasons. ... But then I went to the
> "Open Source Meets Business" Conference and now I can not
> remember...
>=20
> Simon, from your point of view, what patches to we missed from
> patch bomb #1 ?

"Patch bomb #1" -- I like it! Here's the set that I think have not been
applied yet (with the git SHA1 ids of the commits in my git repo - I
think these come in the .patch files, right?), including the one you
mentioned above:

. One more place where stop-sync flag is not explicitely cleared when
starting resync (16896a5)
. Ensure that state updated cannot be done out of order whilst running
receive_state (914435c)
. Revert "Fixing "drbdadm pause-sync r0; drbdadm resume-sync r0""
(93144f7)
. Revert "make resync more robust, don't reset find bit offset too
early." (cab2179)

(note on these last two -- the changes you committed actually cause the
sync to stall if paused and resumed quickly. I suspect that some part of
these is probably desired, but you mixed in the changes to the way
resync is restarted which cause the stall so I just backed them out in
toto).

Simon
