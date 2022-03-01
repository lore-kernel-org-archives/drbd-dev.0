Return-Path: <gregkh@linuxfoundation.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A4C1442179E
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 18:48:02 +0100 (CET)
Date: Tue, 1 Mar 2022 18:37:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakob Koschel <jakobkoschel@gmail.com>
Message-ID: <Yh5ZzNQQQE8rIexy@kroah.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-3-jakobkoschel@gmail.com>
	<Yhyv42ONIxTj04mg@kroah.com>
	<79FCD5F4-0EBA-4E3F-8B3F-D450BBA10367@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79FCD5F4-0EBA-4E3F-8B3F-D450BBA10367@gmail.com>
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
	Dan Carpenter <dan.carpenter@oracle.com>,
	linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Arnd Bergman <arnd@arndb.de>, linux-pm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
	linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	tipc-discussion@lists.sourceforge.net,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [Drbd-dev] [PATCH 2/6] treewide: remove using list iterator
 after loop body as a ptr
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

On Mon, Feb 28, 2022 at 01:06:57PM +0100, Jakob Koschel wrote:
> 
> 
> > On 28. Feb 2022, at 12:20, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Mon, Feb 28, 2022 at 12:08:18PM +0100, Jakob Koschel wrote:
> >> If the list does not contain the expected element, the value of
> >> list_for_each_entry() iterator will not point to a valid structure.
> >> To avoid type confusion in such case, the list iterator
> >> scope will be limited to list_for_each_entry() loop.
> >> 
> >> In preparation to limiting scope of a list iterator to the list traversal
> >> loop, use a dedicated pointer to point to the found element.
> >> Determining if an element was found is then simply checking if
> >> the pointer is != NULL.
> >> 
> >> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> >> ---
> >> arch/x86/kernel/cpu/sgx/encl.c       |  6 +++--
> >> drivers/scsi/scsi_transport_sas.c    | 17 ++++++++-----
> >> drivers/thermal/thermal_core.c       | 38 ++++++++++++++++++----------
> >> drivers/usb/gadget/configfs.c        | 22 ++++++++++------
> >> drivers/usb/gadget/udc/max3420_udc.c | 11 +++++---
> >> drivers/usb/gadget/udc/tegra-xudc.c  | 11 +++++---
> >> drivers/usb/mtu3/mtu3_gadget.c       | 11 +++++---
> >> drivers/usb/musb/musb_gadget.c       | 11 +++++---
> >> drivers/vfio/mdev/mdev_core.c        | 11 +++++---
> >> 9 files changed, 88 insertions(+), 50 deletions(-)
> > 
> > The drivers/usb/ portion of this patch should be in patch 1/X, right?
> 
> I kept them separate since it's a slightly different case.
> Using 'ptr' instead of '&ptr->other_member'. Regardless, I'll split
> this commit up as you mentioned.
> 
> > 
> > Also, you will have to split these up per-subsystem so that the
> > different subsystem maintainers can take these in their trees.
> 
> Thanks for the feedback.
> To clarify I understand you correctly:
> I should do one patch set per-subsystem with every instance/(file?)
> fixed as a separate commit?

Yes, each file needs a different commit as they are usually all written
or maintained by different people.

As I said in my other response, if you need any help with this, just let
me know, I'm glad to help.

thanks,

greg k-h
