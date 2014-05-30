Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0FEF6101AC77
	for <drbd-dev@lists.linbit.com>; Fri, 30 May 2014 15:17:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 03D303052D0
	for <drbd-dev@lists.linbit.com>; Fri, 30 May 2014 15:17:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9p85JvC9TLdn for <drbd-dev@lists.linbit.com>;
	Fri, 30 May 2014 15:17:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C41943052FD
	for <drbd-dev@lists.linbit.com>; Fri, 30 May 2014 15:17:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3f9WByGG8JZj for <drbd-dev@lists.linbit.com>;
	Fri, 30 May 2014 15:17:52 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 35F733052D0
	for <drbd-dev@lists.linbit.com>; Fri, 30 May 2014 15:17:52 +0200 (CEST)
Date: Fri, 30 May 2014 15:17:52 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140530131752.GC12754@soda.linbit>
References: <20140527224053.GD17111@soda.linbit>
	<85bebd869def7c9ebf198ee72baef5ba@ugr.es>
	<20140528115654.GH17111@soda.linbit>
	<41bcdaf0897e6ebd1d919e7675c7f385@ugr.es>
	<20140528124957.GI17111@soda.linbit>
	<fb84d1d109a3575156acc44b4e6d1d00@ugr.es>
	<20140528183616.GJ17111@soda.linbit>
	<9eb0a7ed7c21820d13febc89c63dc340@ugr.es>
	<20140529212917.GC6434@soda.linbit>
	<94c262ac1c1dd4603894b6594b03208a@ugr.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <94c262ac1c1dd4603894b6594b03208a@ugr.es>
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

On Fri, May 30, 2014 at 12:28:19PM +0200, raulhp wrote:
> >>>Am I misunderstanding your question?
> >>You understand my question :-) only y want to understand how to use
> >>existing code of ACK for multicast
> >
> >I don't think it works that way.
>=20
> Now, What do you think?

I think, amoung other things, we have some a nice language barrier here.

I think, as I tried to explain,
that you need to distinguish between what happens
on the DRBD protocol level, and what happens
on the communication transport level.
The latter is what you are working on.
You can do almost whatever you want there.

But it should be obvious that you cannot re-use the
DRBD protocol level "my-disk-has-failed-I-am-so-sorry" message
to mean, on the transport layer,
"please-resend-all-requests-I-did-miss", just because both
concepts use the term "nack" somewhere in the description.

Different things.
Both needed.
Not directly related.


--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
