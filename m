Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9476A103B4DF
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 18:02:01 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id h9-v6so2241673wro.3
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 09:02:01 -0700 (PDT)
Date: Thu, 26 Jul 2018 18:01:59 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Digimer <lists@alteeve.ca>
Message-ID: <20180726160159.GJ25507@soda.linbit>
References: <cb6d86c4-acbb-f299-00fe-e83f6c4e69ba@alteeve.ca>
	<58525792-e53d-55a6-379e-5afe963cbae7@alteeve.ca>
	<26442f3d-0a5c-cea3-3d8b-e4d888ebffd3@alteeve.ca>
	<437fd238-e310-80a1-22af-04d3a8783981@alteeve.ca>
	<a48cbd5f-1030-4449-3603-9716ae38cb3b@prgmr.com>
	<3bbddc4f-6337-594b-9fcc-eec9b6e5de4d@alteeve.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bbddc4f-6337-594b-9fcc-eec9b6e5de4d@alteeve.ca>
Cc: drbd-dev@lists.linbit.com, Nick Bebout <nb@prgmr.com>
Subject: Re: [Drbd-dev] DRBD 9 on Fedora 28
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

On Tue, Jul 24, 2018 at 02:52:25PM -0400, Digimer wrote:
> On 2018-07-24 02:01 PM, Sarah Newman wrote:
> > On 07/24/2018 08:55 AM, Digimer wrote:
> >> On 2018-07-24 11:31 AM, Digimer wrote:
> >>> On 2018-07-24 11:23 AM, Digimer wrote:
> >>>> On 2018-07-24 12:40 AM, Digimer wrote:

"making progress" ;-)

> >>>>> Hi all,
> >>>>>
> >>>>>   I'm trying to get DRBD 9 on Fedora 28 (which I'm using as a dev
> >>>>> platform ahead of RHEL 8 beta). The DRBD that ships with the kernel is
> >>>>> 8.4.10.
> >>>>>
> >>>>>   I've been struggling to build the 9.0.15rc1 RPM without luck. I've
> >>>>> made a few progressions (ie: added kernel-rpm-macros, kernel-devel and
> >>>>> elfutils-devel to BuildRequires).
> >>>>>
> >>>>>   Has anyone managed to build DRBD9 on Fedora 27+? If so, would you mind
> >>>>> sharing the src.rpm or .spec?
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>> digimer
> >>>>
> >>>> Following up with additional info;
> >>>>
> >>>> The problem is in this loop;
> >>>>
> >>>> https://github.com/LINBIT/drbd-9.0/blob/master/drbd-kernel.spec#L84
> >>>>
> >>>> It causes the arch to be appended twice;

The "kernel_source" macro is the offender here,
and is defined by the "%kernel_module_package" macro.
The "flavors_to_build" macro may play a role as well,
also defined by that same macro, likely just a line before.

the kernel_source macro on rhel used to expect a "default" flavor,
and would "filter that out", but append a .$flavor for any other flavor.

possibly the "verrel" subcommand of the kmodtool script is an other
place to apply a fix, to strip out the first .x86_64 there,
maybe by adding it to the "known variants" list.

or maybe you could just tell rpmbuild or the top level spec
that the kernel source directory is /usr/src/kernels/4.17.7-200.fc28
and have the macro append the .x86_64 just that once.

that would be, or at least used to be in rhel,
usr/lib/rpm/redhat/macros and usr/lib/rpm/redhat/kmodtool

if you really want to dig into it, you could compare
the kernel_module_package macro and kmodtool scripts
between rhel (where it apprently still works?) and current fedora
(where it does not/no longer work).

I had a lot of "fun" in the past fighting those magic scripts and macros
to get them to actually do what they where supposed to do in the first
place, on various occasions, more than I can recount the details on,
but I remember that rhel5, 6, 7, suse, and some other rpm based distros
have all been broken differently at one time or the other
in kernel_module_package and/or kmodtool.

> >>>> ====
> >>>> + for flavor in default
> >>>> ++ '[' default = default ']'
> >>>> + make -C /usr/src/kernels/4.17.7-200.fc28.x86_64.x86_64 modules_install
> >>>> M=/home/digimer/rpmbuild/BUILD/drbd-9.0.15rc1/obj/default
> >>>> make: *** /usr/src/kernels/4.17.7-200.fc28.x86_64.x86_64: No such file
> >>>> or directory.  Stop.
> >>>> ====
> >>>>
> >>>> I've been trying to figure out how to fix it, but it seems my ignorance
> >>>> of RPM .spec is getting the better of me...
> >>>
> >>> I should mention; This same src.rpm builds fine on RHEL 7.5. So it seems
> >>> to be specifically a Fedora issue (tried on 27 and 28).
> > 
> > Digimer, you might be better off asking the Fedora folks rather than
> > the DRBD folks, since they may have had to fix similar issues in
> > other packages.
> > 
> > Nick, since you're a Fedora ambassador do you have any suggestions
> > on where or who to ask? I don't know if
> > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/
> > is appropriate unless Digimer is planning on submitting his work to

her.
just saying ;-)

> > Fedora.
> > 
> > Thanks, Sarah
> 
> Thanks Sarah!
> 
>   I asked on the #fedora IRC channel and a few folks did help (that's
> how I narrows it down to that loop), the general feeling was to talk to
> LINBIT folks. Personally, I am happy working with either, though I want
> to admit straight up that I am fairly new to RPM packaging.
> 
>   If Nick has advice, I'll be happy to follow it, too. :)
> 
> digimer

Cheers,

    Lars

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
