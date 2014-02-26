Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4CC7D101AC79
	for <drbd-dev@lists.linbit.com>; Thu, 27 Feb 2014 14:43:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 452232A2107
	for <drbd-dev@lists.linbit.com>; Thu, 27 Feb 2014 14:43:10 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id f8agGncKKIyE for <drbd-dev@lists.linbit.com>;
	Thu, 27 Feb 2014 14:43:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 207DF2A5176
	for <drbd-dev@lists.linbit.com>; Thu, 27 Feb 2014 14:43:10 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cqiVXbVb7xjC for <drbd-dev@lists.linbit.com>;
	Thu, 27 Feb 2014 14:43:10 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7AF082A2107
	for <drbd-dev@lists.linbit.com>; Thu, 27 Feb 2014 14:43:09 +0100 (CET)
Resent-Message-ID: <20140227134306.GH3154@soda.linbit>
Message-ID: <530E1E07.4090007@citrix.com>
Date: Wed, 26 Feb 2014 18:01:59 +0100
From: =?ISO-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
MIME-Version: 1.0
To: <drbd-dev@lists.linbit.com>, <xen-devel@lists.xenproject.org>,
	<drbd-user@lists.linbit.com>
References: <1392911976-37506-1-git-send-email-roger.pau@citrix.com>	<530E05DA.6070500@citrix.com>
	<20140226163036.GE3154@soda.linbit>
In-Reply-To: <20140226163036.GE3154@soda.linbit>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [Xen-devel] [PATCH] block-drbd: type is "phy" for
 drbd backends
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

On 26/02/14 17:30, Lars Ellenberg wrote:
> On Wed, Feb 26, 2014 at 04:18:50PM +0100, Roger Pau Monn=E9 wrote:
>>
>> I've realized I haven't Cc'ed the drbd developers lists, so adding it =
now.
>=20
> We do read the user's list just as well.
> Our -dev is actually mainly intended for "coordination".
>=20
>> On 20/02/14 16:59, Roger Pau Monne wrote:
>>> The type written to xenstore by libxl when attaching a drbd backend i=
s
>>> "phy", not "drbd", so handle this case also.
>=20
> If you say so; you should know ;-)
> Did this change at some point?

I'm sure libxl (the new Xen toolstack) uses "phy" and not "drbd" as
type. Probably the old xend toolstack was setting type to "drbd", and
that's why the script checked for drbd.

IMHO, setting the type to phy is the right thing to do, since drbd ends
up presenting a block device which is handled by blkback.

> I personally have not used this script in a long while...
>=20
> Do you ("citrix") have this in some
> regression/integration testing yourself?

Not in Xen OSS Test suite [0], although I have no idea if other products
based on Xen perform any kind of tests with drbd.

[0] http://xenbits.xen.org/gitweb/?p=3Dosstest.git;a=3Dsummary
