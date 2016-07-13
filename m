Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5F0581056468
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:16:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4BAF34215C1
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:16:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rgfJKOhCGoU6 for <drbd-dev@lists.linbit.com>;
	Wed, 13 Jul 2016 12:16:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2EBC442AA45
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:16:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YS9R7ceZ0yGE for <drbd-dev@lists.linbit.com>;
	Wed, 13 Jul 2016 12:16:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 04AFD4215C1
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 12:16:48 +0200 (CEST)
Date: Wed, 13 Jul 2016 12:16:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160713101648.GE29779@soda.linbit>
References: <CALLFrTQTyBH8oy4+17-REd=WG7r7ZAmzwVTbwfyrtby-wA1vJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTQTyBH8oy4+17-REd=WG7r7ZAmzwVTbwfyrtby-wA1vJg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] How to handle repl_state is L_OFF in
 get_max_agreeable_size()
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

On Wed, Jul 13, 2016 at 03:56:55PM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> I think get_max_agreeable_size() function return a agreeable size but f=
irst
> connected repl_state
>=20
> So, then will not call bm_resize through the agreeable size.

I don't understand what you are saying here.

> How's your opinion replacing in the get_max_agreeable_size()
> if (peer_device->repl_state[NOW] >=3D L_ESTABLISHED) {
> to
> if (peer_device->repl_state[NOW] >=3D L_OFF) {

There is no repl_state less than L_OFF.

	Lars

