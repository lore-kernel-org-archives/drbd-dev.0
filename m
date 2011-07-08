Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7EA7F1056470
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:40:04 +0200 (CEST)
Resent-Message-ID: <20110708144002.GG15170@barkeeper1-xen.linbit>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 193831056470
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:17:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D82481B4262
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:17:22 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTevrZRN6Z7R for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jul 2011 16:17:19 +0200 (CEST)
Received: from [10.0.1.67] (85-127-83-88.dynamic.xdsl-line.inode.at
	[85.127.83.88])
	by zimbra.linbit.com (Postfix) with ESMTPSA id 088F91B4218
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:17:19 +0200 (CEST)
Message-ID: <4E17116D.4080305@linbit.com>
Date: Fri, 08 Jul 2011 16:17:17 +0200
From: Florian Haas <florian.haas@linbit.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
	<1310053461-15060-2-git-send-email-mrten+drbd@ii.nl>
In-Reply-To: <1310053461-15060-2-git-send-email-mrten+drbd@ii.nl>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3D013423934EF56E81C5AF0D"
Subject: Re: [Drbd-dev] [PATCH 2/2] expand section on throughput tuning to
 highlight prime usecase of external metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D013423934EF56E81C5AF0D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Maarten,

many thanks for the contribution. A few questions/comments on this one:

On 07/07/2011 05:44 PM, Mrten wrote:
> ---
>  users-guide/throughput.txt |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>=20
> diff --git a/users-guide/throughput.txt b/users-guide/throughput.txt
> index f033db5..584d0bf 100644
> --- a/users-guide/throughput.txt
> +++ b/users-guide/throughput.txt
> @@ -48,6 +48,7 @@ important to consider the following natural limitatio=
ns:
> =20
>  * DRBD throughput is limited by that of the raw I/O subsystem.
>  * DRBD throughput is limited by the available network bandwidth.
> +* DRBD throughput can be limited by head seeks with 'meta-disk interna=
l'
> =20
>  The _minimum_ between the two establishes the theoretical throughput
>  _maximum_ available to DRBD. DRBD then reduces that throughput maximum=


You're adding a third item to the enumeration; so it would be nice if
you could also rephrase the next paragraph which talks about "the
minimum between the two".

> @@ -64,6 +65,16 @@ less than 3 percent.
>  * By contrast, if the I/O subsystem is capable of only 100 MB/s for
>    sustained writes, then it constitutes the bottleneck, and you would
>    be able to expect only 97 MB/s maximum DRBD throughput.
> + =20
> +* In case of meta-disk internal without a hardware write cache (which =

> +  should be battery backupped!),

You're talking about a battery backup of a cache that is not there. Does
not compute. :)

 DRBD metadata updates necessary to guarantee
> +  data-completeness in case of failure can slow down=20
> +  write throughput significantly. If a raw device is normally capable =
of
> +  250 MB/s write throughput it is not an anomaly to see writes as slow=
 as=20
> +  70 MB/s with DRBD enabled (numbers are for rotational disks). This i=
s=20
> +  purely caused by head seeks; 4MB data updates have to be followed by=
 metadata updates
> +  and the data-writes can only continue after the metadata has been re=
ached the=20
> +  platters (caching and write reordering does not help).

I'm afraid you're missing some context here. DRBD performs the
synchronous meta data updates you are referring to only when an AL
extent goes hot or cold. It doesn't do so randomly or, as your paragraph
seems to imply to a casual reader, every time it has written 4M of data.

And it is definitely _not_ normal to see 250MB/s write bandwidth drop to
70 MB/s. 110 MB/s would be entirely normal if you are replicating over
Gigagit Ethernet, but that is determined by the bandwidth of the
replication link, it doesn't have much to do with AL updates.

And what you mean by "caching and write reordering does not help" I
don't understand at all, can you elaborate please?

> =20
>  [[s-throughput-tuning]]
>  =3D=3D=3D Tuning recommendations
> @@ -204,3 +215,25 @@ resource <resource> {
>    ...
>  }
>  ----------------------------
> +
> +[[s-tune-external-metadata]]
> +=3D=3D=3D=3D Moving meta-disk to external device
> +
> +WARNING: The recommended configuration is running with internal meta-d=
isk.=20
> +With external metadata, when underlying storage dies the metadata does=
 not=20
> +die with it, so special care should be taken. See <<s-external-meta-da=
ta,external meta data>>.
> +
> +With a software raid (md) of rotational media it is often faster to mo=
ve the metadata to a=20
> +dedicated set of platters.=20
> +
> +[source,drbd]
> +----------------------------
> +resource <resource> {
> +  disk {
> +    disk /dev/md3;
> +    flexible-meta-disk /dev/md4;
> +    ...
> +  }
> +  ...
> +}
> +----------------------------

This section would be ok, but it's still missing the steps to dump the
existing metadata and restore it onto the new metadata device. Can you
add that and repost the patch please?

Thanks,
Florian


--------------enig3D013423934EF56E81C5AF0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4XEW0ACgkQc0m4l7x1nPGHqACdGvmTBb743vo4Kb9vf1FvNYC5
9cQAoO9b952meSyWqo5n4ttGZxdqKuxY
=vIn0
-----END PGP SIGNATURE-----

--------------enig3D013423934EF56E81C5AF0D--
