Return-Path: <dan.carpenter@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3865C420171
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 14:19:59 +0100 (CET)
Date: Mon, 28 Feb 2022 16:18:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jakob Koschel <jakobkoschel@gmail.com>
Message-ID: <20220228131844.GD2812@kadam>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-2-jakobkoschel@gmail.com>
	<20220228112413.GA2812@kadam>
	<E31E215E-C409-40B8-8452-57E70C91484C@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E31E215E-C409-40B8-8452-57E70C91484C@gmail.com>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	amd-gfx@lists.freedesktop.org, samba-technical@lists.samba.org,
	linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
	linux-arch <linux-arch@vger.kernel.org>,
	linux-cifs@vger.kernel.org, kvm@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
	Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
	kgdb-bugreport@lists.sourceforge.net,
	bcm-kernel-feedback-list@broadcom.com,
	linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Arnd Bergman <arnd@arndb.de>, linux-pm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	tipc-discussion@lists.sourceforge.net,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [Drbd-dev] [PATCH 1/6] drivers: usb: remove usage of list
 iterator past the loop body
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Feb 28, 2022 at 01:03:36PM +0100, Jakob Koschel wrote:
> >> @@ -954,7 +957,6 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
> >> 		dev_dbg(ep->dev->dev, "unlink (%s) pio\n", _ep->name);
> >> 		net2272_done(ep, req, -ECONNRESET);
> >> 	}
> >> -	req = NULL;
> > 
> > Another unrelated change.  These are all good changes but send them as
> > separate patches.
> 
> You are referring to the req = NULL, right?

Yes.

> 
> I've changed the use of 'req' in the same function and assumed that I can
> just remove the unnecessary statement. But if it's better to do separately
> I'll do that.
> 

These are all changes which made me pause during my review to figure out
why they were necessary.  The line between what is a related part of a
patch is a bit vague and some maintainers will ask you to add or subtract
from a patch depending on their individual tastes.  I don't really have
an exact answer, but I felt like this patch needs to be subtracted from.

Especially if there is a whole chunk of the patch which can be removed,
then to me, that obviously should be in a different patch.

regards,
dan carpenter

