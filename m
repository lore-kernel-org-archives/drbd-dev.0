Return-Path: <lmb@suse.de>
Date: Tue, 19 Oct 2004 11:13:07 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20041019091307.GD9603@marowsky-bree.de>
References: <20041019073224.518E93BE6D@garcon.linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041019073224.518E93BE6D@garcon.linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] r1598 - trunk/user
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-10-19T09:32:24, svn@svn.drbd.org wrote:

> Author: phil
> Date: 2004-10-19 09:32:21 +0200 (Tue, 19 Oct 2004)
> New Revision: 1598
> 
> Modified:
>    trunk/user/Makefile
>    trunk/user/drbdmeta.c
> Log:
> [patch by LGE] 
>  * removed the dependency on glib, and use the kernel's
>    includes instead. 

Do not do that. Please. Including kernel-headers from user-space is an
absolute nightmare, it keeps breaking sporadically and in particular on
non-i386 archs. The kernel headers just aren't meant to be used in
user-space (and are documented to not be supported for this), and all
the build issues I've had with OCFS, Lustre, ... have been caused by
this.

In particular these headers

> +#include <asm/byteorder.h>	/* for the __cpu_to_le64 etc. functions  */
> +#include <linux/bitops.h>	/* for the hweight functions  */
> +#include <linux/types.h>	/* for the __u32/64 type defs */

_are known to break_ on ia64/ppc64/s390x. I'd be very grateful if you
could avoid this.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

