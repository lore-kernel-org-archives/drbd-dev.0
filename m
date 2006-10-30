Return-Path: <lmb@suse.de>
Date: Mon, 30 Oct 2006 23:29:35 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] svn commit by lars - r2551 - in
	branches/drbd-0.7: . drbd drbd/linux scripts - fix some odities
	in the paranoia checks of our build sy
Message-ID: <20061030222935.GC3927@marowsky-bree.de>
References: <20061019145600.78C0B2DF6539@mail.linbit.com>
	<20061024144835.GH20631@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061024144835.GH20631@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2006-10-24T16:48:35, Lars Marowsky-Bree <lmb@suse.de> wrote:

This seems to have gotten lost. Can I interest you in the patch again?

> On 2006-10-19T16:56:00, drbd-cvs@lists.linbit.com wrote:
> 
> > Author: lars
> > Date: 2006-10-19 16:55:58 +0200 (Thu, 19 Oct 2006)
> > New Revision: 2551
> > 
> > Added:
> >    branches/drbd-0.7/scripts/get_uts_release.sh
> > Modified:
> >    branches/drbd-0.7/Makefile
> >    branches/drbd-0.7/drbd.spec.in
> >    branches/drbd-0.7/drbd/Makefile
> >    branches/drbd-0.7/drbd/drbd_worker.c
> >    branches/drbd-0.7/drbd/linux/drbd_config.h
> >    branches/drbd-0.7/scripts/adjust_drbd_config_h.sh
> > Log:
> > fix some odities in the paranoia checks of our build system,
> > should build agains 2.6.18 now out of the box.
> 
> That actually introduced a bug: building the tgz now requires the
> kernel source to be installed, which is in fact only required when the
> kernel modules are built (and which could happen on another system).
> 
> How about the rather simple patch attached instead?
> 
> 
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
> "Ignorance more frequently begets confidence than does knowledge"
> 

> Index: Makefile
> ===================================================================
> --- Makefile	(revision 2564)
> +++ Makefile	(working copy)
> @@ -160,9 +160,6 @@
>  
>  KDIR := $(shell echo /lib/modules/`uname -r`/build)
>  KVER := $(shell KDIR=$(KDIR) O=$(O) scripts/get_uts_release.sh)
> -ifeq ($(KVER),)
> -$(error "could not determine uts_release")
> -endif
>  
>  kernel-patch: drbd/drbd_buildtag.c
>  	set -o errexit; \
> @@ -173,6 +170,10 @@
>  
>  # maybe even dist/RPMS/$(ARCH) ?
>  rpm: tgz
> +	@if [ -z "$(KVER)" ]; then \
> +		echo "Could not determine uts_release" ; \
> +		false ; \
> +	fi
>  	mkdir -p dist/BUILD \
>  	         dist/RPMS  \
>  	         dist/SPECS \

> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

Sincerely,
Mit freundlichen Grüßen,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

