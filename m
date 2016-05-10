Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D3DDC1056443
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 11:12:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 71B4440FBB3
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 11:12:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6l_vDVcnEcBg for <drbd-dev@lists.linbit.com>;
	Tue, 10 May 2016 11:12:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4B2E240FBB4
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 11:12:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UsUTr3_mdd9O for <drbd-dev@lists.linbit.com>;
	Tue, 10 May 2016 11:12:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1A19B40FBB2
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 11:12:43 +0200 (CEST)
Resent-Message-ID: <20160510091243.GB16459@soda.linbit>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D92761056443
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 11:09:56 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id a17so15419993wme.0
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 02:09:56 -0700 (PDT)
References: <20160503100644.GE16459@soda.linbit>
	<1462786820-15519-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160509131547.GX16459@soda.linbit>
To: davem@davemloft.net, netdev@vger.kernel.org, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <5731A561.6090509@6wind.com>
Date: Tue, 10 May 2016 11:09:53 +0200
MIME-Version: 1.0
In-Reply-To: <20160509131547.GX16459@soda.linbit>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH net-next v3] block/drbd: align properly u64
	in nl messages
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

Le 09/05/2016 15:15, Lars Ellenberg a =E9crit :
> On Mon, May 09, 2016 at 11:40:20AM +0200, Nicolas Dichtel wrote:
[snip]
>> Maybe prefixing genl_magic_func.h and genl_magic_struct.h by 'drbd_'
>> could be interesting so that new module won't use it. What is your
>> opinion?
>=20
> This was supposed to not be DRBD specific.  But it might even still
> need some massaging before it was truly generic. And obviously,
> it does not meet the taste of genetlink folks, to say the least :(
Yes, this file is not generic and netlink APIs are never defined like thi=
s.
These tons of macro complexifies the code too much. It's overengineering =
for
what purpose?
Small examples:
 - the drbd netlink API is not exported via uapi (I wonder how apps using=
 this
   API get it)
 - v2 of the patch is nacked because adding a new attribute may break exi=
sting
   apps (in networking code, a lot of new attributes are added in each ve=
rsion)
 - it's not possible to grep to show the definition of an attribute ('git=
 grep
   -w T_bits_total' returns only 1 line)


Regards,
Nicolas
