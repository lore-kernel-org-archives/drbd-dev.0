Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 79D561056444
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 14:41:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6A1E940FC25
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 14:41:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id M_EcSWuIoxrM for <drbd-dev@lists.linbit.com>;
	Tue, 10 May 2016 14:41:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4799E40FC26
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 14:41:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N_ahAVGTwZ4D for <drbd-dev@lists.linbit.com>;
	Tue, 10 May 2016 14:41:51 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EBD9A40FC25
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 14:41:50 +0200 (CEST)
Resent-Message-ID: <20160510124149.GD16459@soda.linbit>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C48D41051881
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 12:06:42 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id a17so18152193wme.0
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 03:06:42 -0700 (PDT)
References: <20160503100644.GE16459@soda.linbit>
	<1462786820-15519-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160509131547.GX16459@soda.linbit> <5731A561.6090509@6wind.com>
	<20160510094023.GC16459@soda.linbit>
To: davem@davemloft.net, netdev@vger.kernel.org, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <5731B2B0.3000400@6wind.com>
Date: Tue, 10 May 2016 12:06:40 +0200
MIME-Version: 1.0
In-Reply-To: <20160510094023.GC16459@soda.linbit>
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

Le 10/05/2016 11:40, Lars Ellenberg a =E9crit :
> On Tue, May 10, 2016 at 11:09:53AM +0200, Nicolas Dichtel wrote:
>> Le 09/05/2016 15:15, Lars Ellenberg a =E9crit :
>>> On Mon, May 09, 2016 at 11:40:20AM +0200, Nicolas Dichtel wrote:
>> [snip]
>>>> Maybe prefixing genl_magic_func.h and genl_magic_struct.h by 'drbd_'
>>>> could be interesting so that new module won't use it. What is your
>>>> opinion?
>>>
>>> This was supposed to not be DRBD specific.  But it might even still
>>> need some massaging before it was truly generic. And obviously,
>>> it does not meet the taste of genetlink folks, to say the least :(
>> Yes, this file is not generic and netlink APIs are never defined like =
this.
>> These tons of macro complexifies the code too much. It's overengineeri=
ng for
>> what purpose?
>=20
> If we introduce a new config option,
> we have to add it to the config scanner (one line),
> define min, max, default and scale (four short defines),
> and add it to the netlink definition here (one line).
> Done, rest of the code is generated,
> both on the kernel side,
> and on the drbd-utils side used to talk to the kernel.
> We found that to be very convenient.
Ok.

>=20
>> Small examples:
>>  - the drbd netlink API is not exported via uapi (I wonder how apps us=
ing this
>>    API get it)
>=20
> There used to be a time where there was no "uapi".
> (I wonder how apps ever worked back then).
At that time, include/linux/ was exported ;-)

>=20
>>  - v2 of the patch is nacked because adding a new attribute may break =
existing
>=20
> No.
>=20
> But because the "new" attributes you chose have not been new,
> but already used (though not yet merged back into mainline yet).
> (Which you did not realize, and had no obvious way of knowing.
>  Could have been fixed.).
Ok.

>=20
> And because your patch introduced useless new members to the structs.
> (Could also have been fixed).
>=20
> And because I did not see any use defining that many new "padding attri=
butes"
> for no reason, where the obvious (to me) choice was to use 0, and you
> did not even try to explain why that would have been a bad choice.
Because some nl APIs were wrongly use 0 as a valid attribute we make the =
choice
of always adding a new attribute for padding to be sure to not break exis=
ting API.
And yes, in drdb it does not seem to be the case.

> Is this going somewhere?
I'm just trying to understand things.


Regards,
Nicolas
