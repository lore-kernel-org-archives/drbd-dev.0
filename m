Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4DB431028A6F
	for <drbd-dev@lists.linbit.com>; Tue,  4 Jun 2019 11:49:23 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id u16so8760095wmc.5
	for <drbd-dev@lists.linbit.com>; Tue, 04 Jun 2019 02:49:23 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	f2sm18510923wme.12.2019.06.04.02.49.21
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 02:49:21 -0700 (PDT)
Date: Tue, 4 Jun 2019 11:49:19 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190604094919.GL5803@soda.linbit>
References: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
	<cf05cd9c-687f-6264-0bc3-aefa90c91b3a@gmail.com>
	<CANr6vz8kxacCYSb38G464Y2c1xw1ZqZAddN45LTwEcnE_Y2dsA@mail.gmail.com>
	<7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
	<20190604094158.GK5803@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190604094158.GK5803@soda.linbit>
Subject: Re: [Drbd-dev] drbd_nl.c:drbd_adm_prepare() indexes drbd_genl_ops[]
 by cmd number
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

On Tue, Jun 04, 2019 at 11:41:58AM +0200, Lars Ellenberg wrote:
> On Tue, Jun 04, 2019 at 02:18:02AM -0600, David Butterfield wrote:
> > On 6/3/19 11:43 PM, Lars Ellenberg wrote:
> > > Think again: how is family->ops inexed?
> > 
> > If you mean the genl_family, its ops are kept on a list, which is searched using genl_get_cmd().
> > Constructed as a list, it doesn't even (necessarily) have an an underlying array one might be tempted to index.
> > 
> > > How is drbd_genl_ops indexed?
> > 
> > It is an array, but it isn't indexed by command number,
> 
> Why, yes it it.
> Because it is constructed that way.
> Uhm. Wait. It used to at some point.
> But ... not so anymore.
> I can swear it used to be
> [op_name] = {
> }
> 
> in that "magic" header...

> Okay.
> 
> Either we fix it in the magic header to construct an array
> that has holes in it, but can then be indexed by [cmd],
> as I think it was meant to be, and used to be
> (though I may be misremembering).

That won't work (anymore),
because that would be rejected,
we would not be able to register that 

So we are back to this:

> Or we add an additional iteration to find the correct flags.

Or our own "bit field" to flag "privileged" operations.

Or we decide that "CAP_NET_ADMIN"
is sufficient to (re)configure DRBD.
But I don't think so.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
