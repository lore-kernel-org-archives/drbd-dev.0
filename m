Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C47B1101AC7C
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 14:56:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B5C8D301096
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 14:56:24 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dHhUjcXenl5q for <drbd-dev@lists.linbit.com>;
	Tue, 22 Apr 2014 14:56:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 97734301097
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 14:56:24 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id daRO9lpwtRVT for <drbd-dev@lists.linbit.com>;
	Tue, 22 Apr 2014 14:56:24 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 78A07301096
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 14:56:24 +0200 (CEST)
Date: Tue, 22 Apr 2014 14:56:24 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140422125624.GB2209@soda.linbit>
References: <535658E0.7060409@numerigraphe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <535658E0.7060409@numerigraphe.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] drbdsetup legacy utils can't fall back to version 8.3
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

On Tue, Apr 22, 2014 at 01:56:16PM +0200, Lionel Sausin wrote:
> Dear DRBD developers,
>=20
> Ubuntu 12.04 has several kernel users can choose from, some with
> DRBD 8.3 and others with 8.4.
> To address this, they have just deployed the drbd utils v8.4.3 with
> "--with-legacy_utils".
> This works fine for drbdadm but drbdsetup seems to not revert to the
> legacy version, even though drbdsetup is built and deployed to
> /lib/drbd/drbdsetup-83:
>     # /sbin/drbdsetup show 1
>     Could not connect to 'drbd' generic netlink family
>=20
>     # /lib/drbd/drbdsetup-83 show 1
>     disk {
>         size                0s _is_default; # bytes
>     ...
>     }
>=20
> From my (quick) reading of the source code, drbdadmin works because
> it adds /lib/drbd to the path using add_lib_drbd_to_path(), and
> drbdsetup seems not to.
> Is the correct fix to add a symlink from /lib/drbd/drbdsetup-83 to
> /sbin, or should drbdsetup be patched to search in /lib/drbd too?

"Correct" is whatever works for you.
As long as you know what version you are using, use the matching tools.

Note that using explicit path (anything with a '/' in it)
on drbdadm or drbdsetup causes them to expect the respective "legacy"
binary at that same path, beneath the current executable.
(on purpose).

So if you want to say /sbin/drbdsetup, and expect that to be able to
execvp drbdsetup-83, then yes, you have to make that accesible under
/sbin/drbdsetup-83, adding it to the PATH will not be good enough.

Also, as a heads up, we are in the process on splitting out the DRBD
userland, providing the "grand unified drbd utils", so this will all
change again within the next few weeks/month.


--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
