Return-Path: <florian.haas@hastexo.com>
MIME-Version: 1.0
In-Reply-To: <4ECCA837.2030109@hastexo.com>
References: <4ECCA837.2030109@hastexo.com>
Date: Mon, 28 Nov 2011 15:18:23 +0100
Message-ID: <CAPUexz-HfNofZE4Fe5WK-uTroXV4Y6Ufbmv-NZuaUmT3JO4JUw@mail.gmail.com>
From: Florian Haas <florian@hastexo.com>
To: drbd-user <drbd-user@lists.linbit.com>, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [GIT PULL] User's Guide fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Message quoted below didn't make it to the lists because I used the
wrong sender address. Sorry about that; resending with the right one
now.

Cheers,
Florian

On Wed, Nov 23, 2011 at 9:00 AM, Florian Haas <florian.haas@hastexo.com> wr=
ote:
> Morning,
>
> Wonder if there are any takers on the User's Guide fixes I posted 1-2
> weeks back.
>
> At any rate, the following changes since commit
> 5c4c8eb62387f64ab1ce503323cea55011159c82:
>
> =C2=A0User's Guide: Added proper op monitor intervals for both Master and
> Slave roles. (2011-11-14 11:03:52 +0100)
>
> are available in the git repository at:
> =C2=A0git://github.com/fghaas/drbd-documentation master
>
> Florian Haas (7):
> =C2=A0 =C2=A0 =C2=A0Fix incorrect configuration syntax for c-plan-ahead a=
nd friends
> =C2=A0 =C2=A0 =C2=A0User's Guide: add joint copyright notice for hastexo
> =C2=A0 =C2=A0 =C2=A0User's Guide: update blog links in "more info" sectio=
n
> =C2=A0 =C2=A0 =C2=A0User's Guide: add section on DRBD over InfiniBand
> =C2=A0 =C2=A0 =C2=A0User's Guide: add section about Dolphin SuperSockets =
replication
> =C2=A0 =C2=A0 =C2=A0User's Guide: add chapter on high-performance replica=
tion
> =C2=A0 =C2=A0 =C2=A0User's Guide: add note about IPoIB MTU
>
> =C2=A0users-guide/administration.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A02 +-
> =C2=A0users-guide/drbd-users-guide-docinfo.xml | =C2=A0 =C2=A04 +
> =C2=A0users-guide/drbd-users-guide.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A01 +
> =C2=A0users-guide/hp-transports.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0140
> ++++++++++++++++++++++++++++++
> =C2=A0users-guide/latency.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0users-guide/more-info.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A07 +-
> =C2=A0users-guide/recent-changes.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A02 +-
> =C2=A07 files changed, 151 insertions(+), 6 deletions(-)
> =C2=A0create mode 100644 users-guide/hp-transports.txt
>
> Tree has been rebased against current upstream on git.drbd.org now that
> that tree has had a few changes pushed to it.
>
> If it's more convenient to everyone, we can of course always designate
> the GitHub repo as the primary location. Or, if I get FTP or rsync
> access to git.drbd.org, I could even build and push UG releases there
> myself (mentioned this to Lars on IRC the other day).
>
> Cheers,
> Florian
>
>
