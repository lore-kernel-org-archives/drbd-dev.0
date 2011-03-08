Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 05D05108D61B
	for <drbd-dev@lists.linbit.com>; Tue,  8 Mar 2011 20:39:21 +0100 (CET)
Resent-Message-ID: <20110308193922.GD9823@barkeeper1-xen.linbit>
Received: from stinky.trash.net (stinky.trash.net [213.144.137.162])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 29B6510571DA
	for <drbd-dev@lists.linbit.com>; Tue,  8 Mar 2011 19:54:37 +0100 (CET)
Message-ID: <4D767B69.2030603@trash.net>
Date: Tue, 08 Mar 2011 19:54:33 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
To: Evgeniy Polyakov <zbr@ioremap.net>
References: <4D6F6180.5030903@trash.net>
	<20110303173230.GP4988@sequoia.sous-sol.org>
	<20110303.105655.189705829.davem@davemloft.net>
	<20110303201522.GT4988@sequoia.sous-sol.org>
	<20110303223746.GI25069@barkeeper1-xen.linbit>
	<20110304012956.GA13573@ioremap.net> <4D764247.9080509@trash.net>
	<20110308183246.GA17412@ioremap.net>
In-Reply-To: <20110308183246.GA17412@ioremap.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Chris Wright <chrisw@sous-sol.org>, dm-devel@redhat.com,
	David Miller <davem@davemloft.net>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2 v2] netlink: kill eff_cap from struct
	netlink_skb_parms
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am 08.03.2011 19:32, schrieb Evgeniy Polyakov:
> Hi Patrick.
> 
> On Tue, Mar 08, 2011 at 03:50:47PM +0100, Patrick McHardy (kaber@trash.net) wrote:
>>> Yup, connector is very async at that place, but I wonder why the hell I
>>> ever made that decision. I believe we can replace it with pure sync call
>>> of the registered connector callback, since netlink is synchronous and
>>> no one has any problem with it.
>>
>> Are you going to do this or do you want me to take care of it?
> 
> I will return back at the end of the week and will take care of this
> problem. I will not mind if you complete it first though :)

Thanks Evgeniy, I'll give it a shot.
