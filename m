Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 90DF22D9E384
	for <drbd-dev@lists.linbit.com>; Fri, 17 Nov 2006 15:04:00 +0100 (CET)
Date: Fri, 17 Nov 2006 15:04:00 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
Message-ID: <20061117140400.GF16440@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671040347F7@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671040347F7@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-11-16 07:52:14 -0500
\ Graham, Simon:
> Not sure I agree that the current behavior is protecting users from
> themselves -- it only causes the split-brain if you lose the n/w and
> during 'normal' operation and there is nothing that protects against
> mounting a 1-node fs on both nodes of a primary-primary DRBD cluster.
> 
> Running primary-secondary doesn't work if you are in a situation where
> it is not possible to switch primaryness when failing over; a good
> example of that is if you want to run a Xen virtual machine on top of
> a DRBD partition and support live migration of the VM (the problem is
> that Xen doesn't provide the means to execute a script to change
> primaryness at the required point in the migration). Of course you
> could argue that this is a Xen bug _but_ pragmatically, the proposed
> patch to delay updating the UUID until an actual write occurs
> preserves (I believe) correctness in DRBD and works without
> introducing new features into Xen.
> 
> Recovering from split-brain automatically is of course something that
> is incredibly valuable but I think it can be treated orthogonally to
> the proposed fix.

I agree here.
But see below why I still think Philipp is "right", too :)

  But I think the provided patch (doing it only in al_begin_io) is wrong.
  actually it needs to be done as soon as the bitmap is touched,
  so it needs be done in "set_out_of_sync", which may be called in the
  cleanup code after connection loss, too, and will be, typically, on the
  actually active node.

  when there is a journalled file system mounted, even if it had been
  idle, there are periodic updates for the journal/superblock, so it would
  be deferred only a few seconds on the actually active node.

  on the "Primary" but inactive node, it would indeed defer this uuid update,
  thus preventing the "split brain"...

one alternative would be to update the uuids where it is done now,
  but only if we have been opened RW (we have that information anyways
  somewhere), and do it again (unless already done) as soon as we are
  opened rw. that would be correct, I think, and easy.

Why we could leave the code as is, anyways:

  we can leave it like it is right now, because the "after split brain
  recovery" strategy "discard least changes" would do the same thing:
  your assumtion was that the "inactive" node does no changes.
  zero is less than anything else...

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
