Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[96.44.175.130])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 258E1421785
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 21:53:24 +0100 (CET)
Message-ID: <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Linus
	Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Feb 2022 15:42:53 -0500
In-Reply-To: <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-3-jakobkoschel@gmail.com>
	<2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
	<CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
	<282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
	alsa-devel@alsa-project.org, KVM list <kvm@vger.kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Cristiano Giuffrida <c.giuffrida@vu.nl>, "Bos,
	H.J." <h.j.bos@vu.nl>, linux1394-devel@lists.sourceforge.net,
	drbd-dev@lists.linbit.com, linux-arch <linux-arch@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	linux-rdma <linux-rdma@vger.kernel.org>, linux-staging@lists.linux.dev,
	amd-gfx list <amd-gfx@lists.freedesktop.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
	kgdb-bugreport@lists.sourceforge.net,
	bcm-kernel-feedback-list@broadcom.com,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Bergman <arnd@arndb.de>,
	Linux PM <linux-pm@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	v9fs-developer@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jakob Koschel <jakobkoschel@gmail.com>, Arnd,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-sgx@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, dma <dmaengine@vger.kernel.org>,
	linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	tipc-discussion@lists.sourceforge.net,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-mediatek@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Mike Rapoport <rppt@kernel.org>
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

On Mon, 2022-02-28 at 21:07 +0100, Christian König wrote:
> Am 28.02.22 um 20:56 schrieb Linus Torvalds:
> > On Mon, Feb 28, 2022 at 4:19 AM Christian König
> > <christian.koenig@amd.com> wrote:
> > > I don't think that using the extra variable makes the code in any
> > > way
> > > more reliable or easier to read.
> > So I think the next step is to do the attached patch (which
> > requires
> > that "-std=gnu11" that was discussed in the original thread).
> > 
> > That will guarantee that the 'pos' parameter of
> > list_for_each_entry()
> > is only updated INSIDE the for_each_list_entry() loop, and can
> > never
> > point to the (wrongly typed) head entry.
> > 
> > And I would actually hope that it should actually cause compiler
> > warnings about possibly uninitialized variables if people then use
> > the
> > 'pos' pointer outside the loop. Except
> > 
> >   (a) that code in sgx/encl.c currently initializes 'tmp' to NULL
> > for
> > inexplicable reasons - possibly because it already expected this
> > behavior
> > 
> >   (b) when I remove that NULL initializer, I still don't get a
> > warning,
> > because we've disabled -Wno-maybe-uninitialized since it results in
> > so
> > many false positives.
> > 
> > Oh well.
> > 
> > Anyway, give this patch a look, and at least if it's expanded to do
> > "(pos) = NULL" in the entry statement for the for-loop, it will
> > avoid the HEAD type confusion that Jakob is working on. And I think
> > in a cleaner way than the horrid games he plays.
> > 
> > (But it won't avoid possible CPU speculation of such type
> > confusion. That, in my opinion, is a completely different issue)
> 
> Yes, completely agree.
> 
> > I do wish we could actually poison the 'pos' value after the loop
> > somehow - but clearly the "might be uninitialized" I was hoping for
> > isn't the way to do it.
> > 
> > Anybody have any ideas?
> 
> I think we should look at the use cases why code is touching (pos)
> after the loop.
> 
> Just from skimming over the patches to change this and experience
> with the drivers/subsystems I help to maintain I think the primary
> pattern looks something like this:
> 
> list_for_each_entry(entry, head, member) {
>      if (some_condition_checking(entry))
>          break;
> }
> do_something_with(entry);


Actually, we usually have a check to see if the loop found anything,
but in that case it should something like

if (list_entry_is_head(entry, head, member)) {
    return with error;
}
do_somethin_with(entry);

Suffice?  The list_entry_is_head() macro is designed to cope with the
bogus entry on head problem.

James


