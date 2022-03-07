Return-Path: <david.laight@aculab.com>
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3374242036B
	for <drbd-dev@lists.linbit.com>; Mon,  7 Mar 2022 16:26:53 +0100 (CET)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@oracle.com>, Jakob Koschel
	<jakobkoschel@gmail.com>
Date: Mon, 7 Mar 2022 15:26:48 +0000
Message-ID: <f7ffd78aa68340e1ade6af15fa2f06d8@AcuMS.aculab.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220307150037.GD3293@kadam>
In-Reply-To: <20220307150037.GD3293@kadam>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Gustavo A.
	R. Silva" <gustavo@embeddedor.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Cristiano Giuffrida <c.giuffrida@vu.nl>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"linux1394-devel@lists.sourceforge.net"
	<linux1394-devel@lists.sourceforge.net>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"Bos, H.J." <h.j.bos@vu.nl>, Jason Gunthorpe <jgg@ziepe.ca>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Arnd Bergman <arnd@arndb.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"v9fs-developer@lists.sourceforge.net"
	<v9fs-developer@lists.sourceforge.net>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Andy
	Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, Linus
	Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [Drbd-dev] [PATCH 0/6] Remove usage of list iterator past the
	loop body
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

From: Dan Carpenter
> Sent: 07 March 2022 15:01
>=20
> Updating this API is risky because some places rely on the old behavior
> and not all of them have been updated.  Here are some additional places
> you might want to change.

I really can't help thinking that trying to merge this patch is
actually impossible.
It affects far too many different parts of the tree.

Since (I believe) this is a doubly linked list with forwards and
backwards pointers that point to a 'node' (not that there is a
nice comment to that effect in the header - and there are lots of
ways to do linked lists) the 'head' pretty much has to be a 'node'.

I'd write the following new defines (but I might be using
the old names here):

list_first(head, field) First item, NULL if empty.
list_last(head, field) Last item NULL if empty.
list_next(head, item, field) Item after 'item', NULL if last.
list_prev(head, item. field) Item before 'item', NULL if first.

You get (something like):
#define list_first(head, field) \
=09head->next =3D=3D &head ? NULL : list_item(head->next, field)
(probably needs typeof(item) from somewhere).

The iterator loop is then just:
#define loop_iterate(item, head, field) \
=09for (item =3D list_first(head, field); item; \
=09=09item =3D list_next(head, item, field)

I'm not sure, but making the 'head' be a structure that contains
a single member that is a 'node' might help type checking.

Then all the code that uses the current defines can slowly be
moved over (probably a couple of releases) before the existing
defines are deleted.

That should simplify all the open-coded search loops that are
just as likely to be buggy (possibly more so).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

