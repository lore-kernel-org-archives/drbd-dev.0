Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 734E22D9CFCA
	for <drbd-dev@lists.linbit.com>; Mon, 20 Nov 2006 13:39:01 +0100 (CET)
Date: Mon, 20 Nov 2006 13:39:01 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
Message-ID: <20061120123901.GC1561@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671040347F7@EXNA.corp.stratus.com>
	<5e77099e0611180419s77b9e3f5u172d853634174bd8@mail.gmail.com>
	<5e77099e0611180420p6c400880j19a22a0dcb7fd62e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e77099e0611180420p6c400880j19a22a0dcb7fd62e@mail.gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-11-18 12:20:56 +0000
\ Sudhakar Mekathotti:
> On 11/16/06, Graham, Simon <Simon.Graham@stratus.com> wrote:
> >
> >Not sure I agree that the current behavior is protecting users from
> >themselves -- it only causes the split-brain if you lose the n/w and during
> >'normal' operation and there is nothing that protects against mounting a
> >1-node fs on both nodes of a primary-primary DRBD cluster.
> >
> >Running primary-secondary doesn't work if you are in a situation where it
> >is not possible to switch primaryness when failing over; a good example of
> >that is if you want to run a Xen virtual machine on top of a DRBD partition
> >and support live migration of the VM (the problem is that Xen doesn't
> >provide the means to execute a script to change primaryness at the required
> >point in the migration). Of course you could argue that this is a Xen bug
> >_but_ pragmatically, the proposed patch to delay updating the UUID until an
> >actual write occurs preserves (I believe) correctness in DRBD and works
> >without introducing new features into Xen.
> >
> >Recovering from split-brain automatically is of course something that is
> >incredibly valuable but I think it can be treated orthogonally to the
> >proposed fix.
> 
> 
> I think from a technical perspective, automatically recovering from
> split-brain is nice to have. But from a user perspective, I would in almost
> all cases refrain from using that feature as I would like to make double
> sure my data is consistent and makes 'business sense' before electing which
> disk to be primary.

and that is the reason why all the "recovery strategies" are configurable.
different deployments, different requirements, different settings.

one possible (and default) strategy is "disconnect",
i.e. refuse to talk to each other until operator intervenes.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
