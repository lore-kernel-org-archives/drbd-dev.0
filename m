Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 57BB91056443
	for <drbd-dev@lists.linbit.com>; Tue, 10 May 2016 11:40:24 +0200 (CEST)
Date: Tue, 10 May 2016 11:40:23 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <20160510094023.GC16459@soda.linbit>
References: <20160503100644.GE16459@soda.linbit>
	<1462786820-15519-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160509131547.GX16459@soda.linbit> <5731A561.6090509@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5731A561.6090509@6wind.com>
Content-Transfer-Encoding: quoted-printable
Cc: netdev@vger.kernel.org, drbd-dev@lists.linbit.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v3] block/drbd: align properly u64
 in nl messages
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

On Tue, May 10, 2016 at 11:09:53AM +0200, Nicolas Dichtel wrote:
> Le 09/05/2016 15:15, Lars Ellenberg a =E9crit :
> > On Mon, May 09, 2016 at 11:40:20AM +0200, Nicolas Dichtel wrote:
> [snip]
> >> Maybe prefixing genl_magic_func.h and genl_magic_struct.h by 'drbd_'
> >> could be interesting so that new module won't use it. What is your
> >> opinion?
> >=20
> > This was supposed to not be DRBD specific.  But it might even still
> > need some massaging before it was truly generic. And obviously,
> > it does not meet the taste of genetlink folks, to say the least :(
> Yes, this file is not generic and netlink APIs are never defined like t=
his.
> These tons of macro complexifies the code too much. It's overengineerin=
g for
> what purpose?

If we introduce a new config option,
we have to add it to the config scanner (one line),
define min, max, default and scale (four short defines),
and add it to the netlink definition here (one line).
Done, rest of the code is generated,
both on the kernel side,
and on the drbd-utils side used to talk to the kernel.
We found that to be very convenient.

> Small examples:
>  - the drbd netlink API is not exported via uapi (I wonder how apps usi=
ng this
>    API get it)

There used to be a time where there was no "uapi".
(I wonder how apps ever worked back then).

>  - v2 of the patch is nacked because adding a new attribute may break e=
xisting

No.

But because the "new" attributes you chose have not been new,
but already used (though not yet merged back into mainline yet).
(Which you did not realize, and had no obvious way of knowing.
 Could have been fixed.).

And because your patch introduced useless new members to the structs.
(Could also have been fixed).

And because I did not see any use defining that many new "padding attribu=
tes"
for no reason, where the obvious (to me) choice was to use 0, and you
did not even try to explain why that would have been a bad choice.

>    apps (in networking code, a lot of new attributes are added in each =
version)


>  - it's not possible to grep to show the definition of an attribute ('g=
it grep
>    -w T_bits_total' returns only 1 line)

Opencoded, it would return 2.

 ;-)

Is this going somewhere?

Cheers,

    Lars

