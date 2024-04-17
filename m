Return-Path: <glass.su@suse.com>
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
	[209.85.208.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 66B9442019F
	for <drbd-dev@lists.linbit.com>; Wed, 17 Apr 2024 12:48:09 +0200 (CEST)
Received: by mail-lj1-f180.google.com with SMTP id
	38308e7fff4ca-2d715638540so64673511fa.3
	for <drbd-dev@lists.linbit.com>; Wed, 17 Apr 2024 03:48:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 2/2] crm-fence-peer.9.sh: use join of node_state to judge
	whether node is banned
From: Glass Su <glass.su@suse.com>
In-Reply-To: <Zh+dFQrPLM6an2lk@grappa.linbit>
Date: Wed, 17 Apr 2024 18:47:50 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <D49E0E18-C4CC-49EF-8BB6-47C2A89BD6BC@suse.com>
References: <20240303091259.5045-1-l@damenly.org>
	<20240303091259.5045-2-l@damenly.org>
	<C2F581E6-5D15-49E7-B944-B79B3C08F252@suse.com>
	<48A9DD72-39A4-4866-B858-E50A33299CEB@suse.com>
	<Zh+dFQrPLM6an2lk@grappa.linbit>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>



> On Apr 17, 2024, at 17:57, Lars Ellenberg <lars.ellenberg@linbit.com> =
wrote:
>=20
> On Thu, Mar 14, 2024 at 11:18:22AM +0800, Su Yue wrote:
>>=20
>>=20
>>> On Mar 7, 2024, at 10:54, Su Yue <glass.su@suse.com> wrote:
>>>=20
>>> Hi, dear drbd folks
>>> Would you help review the patches for drbd-utils? Many thanks!
>>>=20
>> Gentle ping.
>=20
> So you apparently have some kind of test suite
> excercising this fencing handler?
>=20

Yes. SUSE does have internal tests for drbd in HA environment.
The issue of patch1 was exposed with pacemaker-2.1.7 in SLES-15SP6. =20
Patch2 was filed during debug process of the above issue. It looks like =
a=20
small mistake when the judgement was introduced.

And the patches survived in our test scenarios.

Thanks,
Su
> Thank you for making us aware, and for your patience.
> Looks plausible.
>=20
> Lars
>=20

