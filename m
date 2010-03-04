Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ADA42108AD64
	for <drbd-dev@lists.linbit.com>; Thu,  4 Mar 2010 18:29:39 +0100 (CET)
Date: Thu, 4 Mar 2010 18:29:39 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100304172939.GC3670@soda.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C9809384@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C9809384@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] .filelist build target broken by commit
 d6bcfd29e249d40ebe01a573ab8573e74593422a
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 03, 2010 at 03:50:01PM -0500, Magina, Craig wrote:
> Changes were made to drbd/linux/drbd_config.h adding REL_VERSION
> preprocessor code.  However, the base Makefile uses a sed on that file
> looking for REL_VERSION to populate DIST_VERSION with, which the
> .filelist build target uses.  This sed was not updated to match these
> changes, so it gets populated with "#ifdef REL_VERSION" instead of
> "8.3.7".  I hit this while trying to build the tarball target in order
> to build an rpm from a freshly cloned drbd-8.3 repository.

Fixed.
	Thanks,
	

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
