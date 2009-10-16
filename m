Return-Path: <lmb@suse.de>
Received: from mx.in-addr.de (gate.in-addr.de [212.8.193.158])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0A52410620AB
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2009 13:43:16 +0200 (CEST)
Date: Fri, 16 Oct 2009 13:43:02 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20091016114302.GC26808@suse.de>
References: <20091016103845.GA15975@suse.de>
	<20091016112001.GB8041@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20091016112001.GB8041@barkeeper1-xen.linbit>
Subject: Re: [Drbd-dev] SCTP support for drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2009-10-16T13:20:01, Lars Ellenberg <lars.ellenberg@linbit.com> wrote:

> > The other service is drbd, which also uses TCP-only right now. It'd be
> > nice if it also supported SCTP; it can't be that hard, since the
> > in-kernel dlm also supports TCP and SCTP.
> Is somewhere on our todo list,
> but may have to wait for DRBD 9.
> Feature sponsoring accepted ;)

How much sponsoring do you need? Florian said it looked trivial enough.
;-)

> > As a further consideration, I'd like to point out how cool it'd be if
> > drbd could also, like the DLM, default to gathering its network
> > information from the OpenAIS/corosync layer (perhaps via a
> > drbd_controld); the peers could auto-detect each other based on the
> > UUID/label of the drbd instance being activated.  It'd reduce the need
> > to duplicate information between configuration files for the most common
> > scenarios.
> >
> > (This would also be an extremely convenient and even neater way for
> > floating peers.)
> -EPONIES

It may be something you could put on said todo list as well. It'd be
beneficial for drbd users, would it not?

> proof of concept implementations may be reviewed, though ;)

Well, before heading down that path it may be worthwhile to get feedback
as to whether you think this is a useful feature or not. Even if we
don't implement it, maybe one day there'll be a student looking for a
thesis topic ;-)



Regards,
    Lars

-- 
Architect Storage/HA, OPS Engineering, Novell, Inc.
SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

