Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 941381433811
	for <drbd-dev@lists.linbit.com>; Tue,  8 Mar 2011 20:39:45 +0100 (CET)
Resent-Message-ID: <20110308193945.GE9823@barkeeper1-xen.linbit>
Received: from tservice.net.ru (unknown [195.178.208.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DD3701057498
	for <drbd-dev@lists.linbit.com>; Tue,  8 Mar 2011 19:32:47 +0100 (CET)
Date: Tue, 8 Mar 2011 21:32:46 +0300
From: Evgeniy Polyakov <zbr@ioremap.net>
To: Patrick McHardy <kaber@trash.net>
Message-ID: <20110308183246.GA17412@ioremap.net>
References: <4D6F6180.5030903@trash.net>
	<20110303173230.GP4988@sequoia.sous-sol.org>
	<20110303.105655.189705829.davem@davemloft.net>
	<20110303201522.GT4988@sequoia.sous-sol.org>
	<20110303223746.GI25069@barkeeper1-xen.linbit>
	<20110304012956.GA13573@ioremap.net> <4D764247.9080509@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D764247.9080509@trash.net>
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

Hi Patrick.

On Tue, Mar 08, 2011 at 03:50:47PM +0100, Patrick McHardy (kaber@trash.net) wrote:
> > Yup, connector is very async at that place, but I wonder why the hell I
> > ever made that decision. I believe we can replace it with pure sync call
> > of the registered connector callback, since netlink is synchronous and
> > no one has any problem with it.
> 
> Are you going to do this or do you want me to take care of it?

I will return back at the end of the week and will take care of this
problem. I will not mind if you complete it first though :)

-- 
	Evgeniy Polyakov
