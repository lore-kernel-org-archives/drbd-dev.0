Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 652C4101AC77
	for <drbd-dev@lists.linbit.com>; Wed, 26 Feb 2014 17:24:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2896B32174F
	for <drbd-dev@lists.linbit.com>; Wed, 26 Feb 2014 17:24:06 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yEKsQaZFVStE for <drbd-dev@lists.linbit.com>;
	Wed, 26 Feb 2014 17:24:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DE2CC321753
	for <drbd-dev@lists.linbit.com>; Wed, 26 Feb 2014 17:24:05 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sQieXkvjOiUa for <drbd-dev@lists.linbit.com>;
	Wed, 26 Feb 2014 17:24:05 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8A83E32174F
	for <drbd-dev@lists.linbit.com>; Wed, 26 Feb 2014 17:24:05 +0100 (CET)
Resent-Message-ID: <20140226162405.GD3154@soda.linbit>
Message-ID: <530E05DA.6070500@citrix.com>
Date: Wed, 26 Feb 2014 16:18:50 +0100
From: =?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
MIME-Version: 1.0
To: <drbd-dev@lists.linbit.com>
References: <1392911976-37506-1-git-send-email-roger.pau@citrix.com>
In-Reply-To: <1392911976-37506-1-git-send-email-roger.pau@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: xen-devel@lists.xenproject.org, drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block-drbd: type is "phy" for drbd backends
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


I've realized I haven't Cc'ed the drbd developers lists, so adding it now=
.

On 20/02/14 16:59, Roger Pau Monne wrote:
> The type written to xenstore by libxl when attaching a drbd backend is
> "phy", not "drbd", so handle this case also.
>=20
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---
>  scripts/block-drbd |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/block-drbd b/scripts/block-drbd
> index 5563ccb..975802b 100755
> --- a/scripts/block-drbd
> +++ b/scripts/block-drbd
> @@ -250,7 +250,7 @@ case "$command" in
>      fi
> =20
>      case $t in=20
> -      drbd)
> +      drbd|phy)
>          drbd_resource=3D$p
>          drbd_role=3D"$(drbdadm role $drbd_resource)"
>          drbd_lrole=3D"${drbd_role%%/*}"
> @@ -278,7 +278,7 @@ case "$command" in
> =20
>    remove)
>      case $t in=20
> -      drbd)
> +      drbd|phy)
>          p=3D$(xenstore_read "$XENBUS_PATH/params")
>          drbd_resource=3D$p
>          drbd_role=3D"$(drbdadm role $drbd_resource)"
>=20

