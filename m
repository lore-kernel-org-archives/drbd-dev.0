Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 97EE1101AC77
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 00:40:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 844392B816E
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 00:40:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UELhdd7EsOLf for <drbd-dev@lists.linbit.com>;
	Wed, 28 May 2014 00:40:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 641023961C2
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 00:40:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c7ba6gGysjWb for <drbd-dev@lists.linbit.com>;
	Wed, 28 May 2014 00:40:53 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 273612B816E
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 00:40:53 +0200 (CEST)
Date: Wed, 28 May 2014 00:40:53 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140527224053.GD17111@soda.linbit>
References: <065690d908f4c5aaeba8d8763c41a764@ugr.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <065690d908f4c5aaeba8d8763c41a764@ugr.es>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Protocol C
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

On Tue, May 27, 2014 at 05:33:53PM +0200, raulhp wrote:
> Hi all,
>=20
> Can someone explain me how the Protocol C operate?, if the receiver
> send an ACK for every block or how ACK works.

It basically goes like this:

local:
  submit to disk
+ send the data,
			remote: receive the data
disk completion			submit to disk
				disk completion
				send ack back
receive ack

complete to upper layers,
once both local disk completion
and remote ack have been seen.

With some more housekeeping to be able to detect failures,
and recover from them as gracefully as possible.

> which exactly is the source code?

exactly "most of it" ;-) sorry.
there is a lot going on, and all those various stages cannot be covered
with "look there, these six lines of code do it".

What are you trying to do?

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
