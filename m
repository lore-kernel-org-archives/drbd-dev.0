Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 860321018D73
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 10:13:38 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so1562341wmb.4
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 01:13:38 -0700 (PDT)
Date: Tue, 24 Jul 2018 10:08:07 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20180724080806.nbfo3akwtxdx5qsi@rck.sh>
References: <225e8fd1-fc2e-287a-63cb-00ce31fa79b5@alteeve.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225e8fd1-fc2e-287a-63cb-00ce31fa79b5@alteeve.ca>
Subject: Re: [Drbd-dev] BuildRequires for drbd-utils
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

On Mon, Jul 23, 2018 at 07:19:38PM -0400, Digimer wrote:
> Hi all,
> 
>   I'm working on RPMs for Fedora, and noticed two missing build
> dependencies in drbd-utils-9.5.0;
> 
> BuildRequires: automake
> BuildRequires: libxslt

Hi Digimer,

I will look into it (and if RHEL/SLES name them differently and what
not).

Same for the kernel part you mentioned in the other thread. Others might
be faster, currently can't promise anything, a bit too busy at the
moment.

In general I think that is more appropriate for drbd-user, drbd-dev is
basically "kernel patch coordination only", drbd-user is "everything
else".

Thanks, rck
