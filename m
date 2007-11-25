Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C12B92E092D0
	for <drbd-dev@lists.linbit.com>; Sun, 25 Nov 2007 20:21:02 +0100 (CET)
Date: Sun, 25 Nov 2007 20:20:59 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Supporting barriers in DRBD, part 1
Message-ID: <20071125192059.GA10009@racke.local>
References: <342BAC0A5467384983B586A6B0B37671072830A7@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671072830A7@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 25, 2007 at 01:16:15PM -0500, Graham, Simon wrote:
> As part of the work to properly handle on-disk caches, I have enabled
> barrier support in DRBD for requests from above - the attached proposed
> patch includes the following changes (patch is against 8.0.6):

thank you very much, just integrated into current drbd-8.0 git.
will discuss with phil tomorrow, do some tests with and without
barrier support, and figure out the best way to map differing support on
both nodes.

since you say "part 1", what will the next part be?
defer "_req_is_done" until the corresponding barrier ack,
even for protocol C?

> 1.       Stop rejecting barrier requests in drbd_make_request_common()
> unless we know they are not supported (see point 1 in the 'things to do'
> below though).

I think this could be done by either
	offloading to the "trusted" admin
	via a configuration setting like use-bmbv

	and/or setting a flag in the "feature bits" area
	during handshake.

	or, preferably, we finally allocate local and remote error flag
	members in struct drbd_request, and properly deal with it :)
	
	meaning we could (at least for protocol C) notice, distinguish,
	and recover from both local and remote ENOTSUPP, for a barrier
	request.

> 2.       Fixed a few places where the code assumed
> BIO_RW_BARRIER/BIO_RW_SYNC were masks rather than bit numbers

oops.

> 3.       Added barriers to AL/MD writes, including detecting if the
> underlying device does not implement barriers and backing off in that
> case.

looks good.

> 4.       Forced a meta data write when a disk is attached so that we
> determine early on whether or not barriers are supported.

remains the problem of storage area device != meta data area device.

> 5.       Extended the tracing of BIO's to include internally generated
> BIOs as well as the ones from above

would you agree if we changed that to no longer use printk,
but to netlink-broadcast to userspace,
so you'd be able to see them with "drbdsetup events"?

I did that already for some other reasons,
so the code is basically there.

> 6.       I reformatted about_to_complete_local_write() - not necessary
> but I was trying to read the code...

I already noticed and fixed the two additional tabs :)

> Things to do (potentially):
> 
> 1.       RIght now, the code assumes that either both systems support
> barriers or neither do - should probably detect the mixed case and if
> either side does not support for any given device, reject barrier
> requests from above - I'm already setting the flag in the mdev when the
> disk is attached - we could pass this flag between the two systems and
> set the barrier-not-supported flag as the union of the two systems'
> values. Off hand, I can't see an easy place to add code to pass this
> capability between the systems.

during handshake, using one of the as yet unused reserved feature bits.

> 2.       Should complete bitmap writes be issued with a barrier? If so,
> then should this be just the first or last or all bitmap I/Os? I think
> the last but I'm not sure.

if the guarantee should be that the bitmap is on disk when we think it
is, I'd agree it has to be the last.

> 3.       I think we can remove the #ifdef BIO_RW_XXX - certainly they
> are not present everywhere these macros are referenced...

I'll have to check that. we still try to support even 2.6.5-something.

> I've tested this on a system that does support barriers (2.6.18 based
> with DRBD on top of LVM volumes) - it's a little hard for me to test in
> a case that does not support barriers - clearly that needs to be tested
> before this can be applied... I know that there are several flavours of
> md device that do not support barriers (linear, raid0, multipath for
> example), so that might be a somewhat easy way to setup a test - create
> a suitable md device and run drbd on top of it

will do.

thank you for that.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
