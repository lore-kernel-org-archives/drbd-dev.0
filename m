Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A039C1028A6F
	for <drbd-dev@lists.linbit.com>; Tue,  4 Jun 2019 11:42:01 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id e16so6809685wrn.1
	for <drbd-dev@lists.linbit.com>; Tue, 04 Jun 2019 02:42:01 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	p2sm13617400wmp.40.2019.06.04.02.41.59
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 02:41:59 -0700 (PDT)
Date: Tue, 4 Jun 2019 11:41:58 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190604094158.GK5803@soda.linbit>
References: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
	<cf05cd9c-687f-6264-0bc3-aefa90c91b3a@gmail.com>
	<CANr6vz8kxacCYSb38G464Y2c1xw1ZqZAddN45LTwEcnE_Y2dsA@mail.gmail.com>
	<7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b015341-f9f7-e207-84d7-61ab8f0d5a7b@gmail.com>
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

On Tue, Jun 04, 2019 at 02:18:02AM -0600, David Butterfield wrote:
> On 6/3/19 11:43 PM, Lars Ellenberg wrote:
> > Think again: how is family->ops inexed?
> 
> If you mean the genl_family, its ops are kept on a list, which is searched using genl_get_cmd().
> Constructed as a list, it doesn't even (necessarily) have an an underlying array one might be tempted to index.
> 
> > How is drbd_genl_ops indexed?
> 
> It is an array, but it isn't indexed by command number,

Why, yes it it.
Because it is constructed that way.
Uhm. Wait. It used to at some point.
But ... not so anymore.
I can swear it used to be
[op_name] = {
}

in that "magic" header...

> except in this one place in drbd_adm_prepare().

Okay.
So we check against flags we don't meant to check,
even check with out-of-bounds array access (undefined content).
And potentially someone that already has CAP_NET_ADMIN
could do stuff we meant to require CAP_SYS_ADMIN for.

That's bad :-(

-_- :: accidentally correct
!!! :: allows NET_ADMIN to do stuff we meant to require SYS_ADMIN for
OOB :: access beyond end of array, unknown, possibly bad.

leaving off the -_- entries, I find:

OOB  [5]   =  {  .cmd  =  44,  .flags  =  0x1,  .doit  =  drbd_adm_new_peer          [drbd],  .dumpit  =                           (null)  }
OOB  [6]   =  {  .cmd  =  45,  .flags  =  0x1,  .doit  =  drbd_adm_new_path          [drbd],  .dumpit  =                           (null)  }
OOB  [7]   =  {  .cmd  =  46,  .flags  =  0x1,  .doit  =  drbd_adm_del_peer          [drbd],  .dumpit  =                           (null)  }
OOB  [8]   =  {  .cmd  =  47,  .flags  =  0x1,  .doit  =  drbd_adm_del_path          [drbd],  .dumpit  =                           (null)  }
!!!  [10]  =  {  .cmd  =  29,  .flags  =  0x1,  .doit  =  drbd_adm_net_opts          [drbd],  .dumpit  =                           (null)  }
OOB  [33]  =  {  .cmd  =  38,  .flags  =  0x0,  .doit  =  (null),                    .dumpit  =        drbd_adm_get_initial_state  [drbd]  }
OOB  [34]  =  {  .cmd  =  42,  .flags  =  0x1,  .doit  =  drbd_adm_forget_peer       [drbd],  .dumpit  =                           (null)  }
OOB  [35]  =  {  .cmd  =  43,  .flags  =  0x1,  .doit  =  drbd_adm_peer_device_opts  [drbd],  .dumpit  =                           (null)  }

Someone with NET_ADMIN (but without SYS_ADMIN) could
 - change net options
potentially (OOB access, may or may not have the bit set)
 - create and delete peers and paths
   (but not connect them, or disconnect them,
   which would be required to do anything useful with a new path, or to delete an active path)
 - forget a peer (but not disconnect it, which would be required to have success)
 - be disallowed from getting the initial state, even though that should be an unpriviledged operation

Luckily, "mostly harmless".

Okay.

Either we fix it in the magic header to construct an array
that has holes in it, but can then be indexed by [cmd],
as I think it was meant to be, and used to be
(though I may be misremembering).

Or we add an additional iteration to find the correct flags.

Thank you for point this out.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
