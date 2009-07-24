Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 24 Jul 2009 17:20:21 +0200
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
	<20090721185156.GA10126@johann>
	<20090722145917.055eddc1.sfr@canb.auug.org.au>
In-Reply-To: <20090722145917.055eddc1.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907241720.22771.philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/16] drbd: a block device for HA clusters
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 22 July 2009 06:59:17 Stephen Rothwell wrote:
> Hi Lars,
>
> On Tue, 21 Jul 2009 20:51:56 +0200 Lars Ellenberg 
<lars.ellenberg@linbit.com> wrote:
> > Stephen: expect an explicit linux-next merge request
> > within the next few days.
>
> OK, just to be clear your tree should be based on Linus' tree (or some
> other *stable*, non rebasing, tree - *not* linux-next).
>

Hi Stephen,

Please add git://git.drbd.org/linux-2.6-drbd.git to linux-next.

The tree was initially based on v2.6.30-rc1. Later 2.6.31-rc1 was
merged in. 
I verified that it still merges with 2.6.31-rc4 without conflicts.

Thanks!

-Philipp
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

