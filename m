Return-Path: <glass.su@suse.com>
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
	[209.85.208.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6CFF9420319
	for <drbd-dev@lists.linbit.com>; Thu,  7 Mar 2024 03:54:43 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id
	38308e7fff4ca-2d228a132acso4833761fa.0
	for <drbd-dev@lists.linbit.com>; Wed, 06 Mar 2024 18:54:43 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 2/2] crm-fence-peer.9.sh: use join of node_state to judge
	whether node is banned
From: Su Yue <glass.su@suse.com>
In-Reply-To: <20240303091259.5045-2-l@damenly.org>
Date: Thu, 7 Mar 2024 10:54:29 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2F581E6-5D15-49E7-B944-B79B3C08F252@suse.com>
References: <20240303091259.5045-1-l@damenly.org>
	<20240303091259.5045-2-l@damenly.org>
To: drbd-dev@lists.linbit.com
Cc: lars.ellenberg@linbit.com
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

Hi, dear drbd folks
  Would you help review the patches for drbd-utils? Many thanks!

=E2=80=94=20
Su

> On Mar 3, 2024, at 17:12, Su Yue <glass.su@suse.com> wrote:
>=20
> From: Su Yue <glass.su@suse.com>
>=20
> crmd in node_state can't be "banned". join should be used instead
> of crmd.
>=20
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
> scripts/crm-fence-peer.9.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/crm-fence-peer.9.sh b/scripts/crm-fence-peer.9.sh
> index a3353a7354a6..b326a1656c15 100755
> --- a/scripts/crm-fence-peer.9.sh
> +++ b/scripts/crm-fence-peer.9.sh
> @@ -934,7 +934,7 @@ guess_if_pacemaker_will_fence()
>=20
> # for further inspiration, see pacemaker:lib/pengine/unpack.c, =
determine_online_status_fencing()
> [[ -z $in_ccm ]] && will_fence=3Dtrue
> - [[ $crmd =3D "banned" ]] && will_fence=3Dtrue
> + [[ $join =3D "banned" ]] && will_fence=3Dtrue
> if [[ ${expected-down} =3D "down" && $in_ccm =3D "false"  && $crmd !=3D =
"online" ]]; then
> : "pacemaker considers this as clean down"
> elif [[ $in_ccm =3D false ]] || [[ $crmd !=3D "online" ]]; then
> --=20
> 2.44.0
>=20

