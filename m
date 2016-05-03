Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 99A481051881
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 886F23743BD
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:09 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id j4sp1Pfic-Hj for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 14:34:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 650DD3743BF
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:09 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I2zgbg4ZgpB7 for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 14:34:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 13C923743BD
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:09 +0200 (CEST)
Resent-Message-ID: <20160504123408.GL16459@soda.linbit>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 604371051881
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 14:07:06 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id g17so35044802wme.1
	for <drbd-dev@lists.linbit.com>; Tue, 03 May 2016 05:07:06 -0700 (PDT)
References: <57286F49.8050107@6wind.com>
	<1462268358-19044-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160503100644.GE16459@soda.linbit>
To: netdev@vger.kernel.org, davem@davemloft.net, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <57289468.5090401@6wind.com>
Date: Tue, 3 May 2016 14:07:04 +0200
MIME-Version: 1.0
In-Reply-To: <20160503100644.GE16459@soda.linbit>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH net-next v2] block/drbd: use
	nla_put_u64_64bit()
Reply-To: nicolas.dichtel@6wind.com
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

Le 03/05/2016 12:06, Lars Ellenberg a =E9crit :
> On Tue, May 03, 2016 at 11:39:18AM +0200, Nicolas Dichtel wrote:
>> Two new handlers have been defined in genl_magic_ headers:
>>  - __field2: the corresponding nla_put() function (nla_put_flag()) tak=
es
>>              only two args
>>  - __field4: the corresponding nla_put() function (nla_put_u64_64bit()=
)
>>              takes four args
>>
>> __field2 allows us to define __unspec_field for padding attribute.
>> __field4 allows us to update the definition of __u64_field: the pad
>> attribute should now be specified.
>=20
> Please just NOT use an additional "field",
> but always use 0 to pad.
>=20
> Patch is much shorter as well, see below.
I don't think that the goal is to make the shortest patch...
But frankly, I don't care. The goal was to use the new interface in a pro=
per
way, like every other subsystem.

>=20
> Attribute type "0" is not used,
> and will never be of semantic value,
> but always be ignored in the DRBD netlink family.
>=20
> Whereas using some arbitrary value will be wrong,
> and will needlessly break userland.
An application should always ignore unknown attribute, this is a golden r=
ule.
Now if you know that this patch will break applications (which one exactl=
y?), we
can use your proposal.


Regards,
Nicolas
