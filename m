Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 655A02CF8373
	for <drbd-dev@lists.linbit.com>; Fri, 15 Sep 2006 15:16:19 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: FOR REVIEW;
	proposed phase-I fixes to remove drbd_panic() calls
Date: Fri, 15 Sep 2006 15:16:51 +0200
References: <342BAC0A5467384983B586A6B0B37671038B07AB@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038B07AB@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609151516.51530.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 14. September 2006 22:48 schrieb Graham, Simon:
>  <<drbd-panic.patch>> I'm not done testing yet (because it's been hard
> to keep up with the changes recently ;-) but I think it's time to get
> some review of the first phase of panic removal I am proposing - in the
> end, the changes are actually fairly small for this phase and basically
> fall into the following areas:
>
> 1. In the case of meta-data failures, I took the approach of forcibly
> detaching
> >    the disk even if the on-error setting is PassOn AND I made sure that=
=20
> this is
>    done on ALL meta-data errors.
> 2. To do this, I added a new Boolean parameter to drbd_chk_io_error and
> drbd_io_error
>    that indicates if a detach should be forced - all meta-data cases
> pass TRUE
>    and all user data cases pass FALSE.
> 3. Apart from making sure that chk_io_error and io_error are called for
> all meta
>    data cases, I also removed the panic()s from these failure cases.
> 4. In order to test this, I introduced some fault insertion code -
> controlled by
>    a new config macro, DRBD_ENABLE_FAULTS, off by default. This adds a
> couple of
>    module parameters;
>    a. fault_rate - integer is the % of times the specified fault should
> be
>       inserted - the idea is that if you run enough tests with each
> fault enabled,
>       eventually all failure code paths will be tested...
>    b. enable_faults - bitmap of enabled faults - I broke it down into 6
> classes
>       so far - meta-data, resync and data reads and writes.
>    Every time an I/O is sent to the block layer, the code tests for the
> fault being
>    active and if so it completes the bio with an error instead of
> sending it down.
>
> Patch against trunk attached - all comments gratefully received...
> Simon

Whow, really very cool stuff. I applied the patch nearly as it is. While
skimming over it I found nothing that seemed incorrect to me.

> PS: There are also a few other minor fixes:
> 1. when reading the bitmap, I clear the BM_MD_IO_ERROR flag before
> starting - otherwise
>    if this fails once, it will fail every subsequent time.
> 2. some changes in tracing to help me debug - including fixing the
> packet dump trace
>    code - this fix got lost somehow and received frames were printed
> incorrectly.
> 3. At the end of drbd_nl_disk_conf, if a failure occurs AFTER the point
> of no return,
>    I think it's necessary to set the local nbc value to NULL and NOT
> free it - since
>    it has been put into the mdev->bc by this point, the error handling
> in
>    drbd_force_state() will free the bc object and we'd end up freeing it
> twice (I THINK!)

Yes, right.

> 4. drbd_al_to_on_disk_bm() - if inc_local_if_state() returns 0 pay
> attention!

Here you missed that we want to see an failed ASSERTION in case=20
in_local() fails. Added this.

=2DPhilipp

=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
