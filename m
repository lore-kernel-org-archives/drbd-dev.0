Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 344E2101AC75
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:33:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5B8362A0150
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:33:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T7q9WVSoCw3m for <drbd-dev@lists.linbit.com>;
	Mon,  7 Apr 2014 16:33:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3CAA52A20AD
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:33:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MY7R245MxtqX for <drbd-dev@lists.linbit.com>;
	Mon,  7 Apr 2014 16:33:20 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1F7CF2A0150
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:33:20 +0200 (CEST)
Date: Mon, 7 Apr 2014 16:33:20 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140407143320.GH2209@soda.linbit>
References: <bd4dca3f93ea0361c978541eb47ff5c1@ugr.es>
	<5302c0939964d7f19bec260413f4c90c@ugr.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5302c0939964d7f19bec260413f4c90c@ugr.es>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] obtain addr
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

On Thu, Apr 03, 2014 at 12:35:36PM +0200, raulhp wrote:
> Sorry, I accidentally sent email, then...
>=20
>=20
>  Where is the seccion in source code that obtain the IP address from
> drbd.conf file?

What is it you are trying to do?

>  The follow code in drbd_int.h -> struct drbd_connection
>=20
>  struct sockaddr_storage my_addr;
>  int my_addr_len;
>  struct sockaddr_storage peer_addr;
>  int peer_addr_len;
>=20
>=20
> Best Regards,
> Ra

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
