Return-Path: <jakobkoschel@gmail.com>
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
	[209.85.218.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9932D420368
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 18:41:07 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id p15so32989623ejc.7
	for <drbd-dev@lists.linbit.com>; Tue, 01 Mar 2022 09:41:07 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
From: Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <Yh5ZmwiH5AxtQ69K@kroah.com>
Date: Tue, 1 Mar 2022 18:40:04 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B1AFAD9-C1B3-499C-945A-C259361ABA8C@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-3-jakobkoschel@gmail.com>
	<2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
	<CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
	<CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
	<CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
	<FC710A1A-524E-481B-A668-FC258F529A2E@gmail.com>
	<CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
	<CEDAD0D9-56EE-4105-9107-72C2EAD940B0@gmail.com>
	<Yh5ZmwiH5AxtQ69K@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
	alsa-devel@alsa-project.org, KVM list <kvm@vger.kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Cristiano Giuffrida <c.giuffrida@vu.nl>,
	amd-gfx list <amd-gfx@lists.freedesktop.org>,
	linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
	linux-arch <linux-arch@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
	Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
	kgdb-bugreport@lists.sourceforge.net,
	bcm-kernel-feedback-list@broadcom.com,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Arnd Bergman <arnd@arndb.de>,
	Linux PM <linux-pm@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, dma <dmaengine@vger.kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	v9fs-developer@lists.sourceforge.net,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-sgx@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	tipc-discussion@lists.sourceforge.net,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-mediatek@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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



> On 1. Mar 2022, at 18:36, Greg KH <greg@kroah.com> wrote:
>=20
> On Tue, Mar 01, 2022 at 12:28:15PM +0100, Jakob Koschel wrote:
>>=20
>>=20
>>> On 1. Mar 2022, at 01:41, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>>=20
>>> On Mon, Feb 28, 2022 at 1:47 PM Jakob Koschel =
<jakobkoschel@gmail.com> wrote:
>>>>=20
>>>> The goal of this is to get compiler warnings right? This would =
indeed be great.
>>>=20
>>> Yes, so I don't mind having a one-time patch that has been gathered
>>> using some automated checker tool, but I don't think that works from =
a
>>> long-term maintenance perspective.
>>>=20
>>> So if we have the basic rule being "don't use the loop iterator =
after
>>> the loop has finished, because it can cause all kinds of subtle
>>> issues", then in _addition_ to fixing the existing code paths that
>>> have this issue, I really would want to (a) get a compiler warning =
for
>>> future cases and (b) make it not actually _work_ for future cases.
>>>=20
>>> Because otherwise it will just happen again.
>>>=20
>>>> Changing the list_for_each_entry() macro first will break all of =
those cases
>>>> (e.g. the ones using 'list_entry_is_head()).
>>>=20
>>> So I have no problems with breaking cases that we basically already
>>> have a patch for due to  your automated tool. There were certainly
>>> more than a handful, but it didn't look _too_ bad to just make the
>>> rule be "don't use the iterator after the loop".
>>>=20
>>> Of course, that's just based on that patch of yours. Maybe there are =
a
>>> ton of other cases that your patch didn't change, because they =
didn't
>>> match your trigger case, so I may just be overly optimistic here.
>>=20
>> Based on the coccinelle script there are ~480 cases that need fixing
>> in total. I'll now finish all of them and then split them by
>> submodules as Greg suggested and repost a patch set per submodule.
>> Sounds good?
>=20
> Sounds good to me!
>=20
> If you need help carving these up and maintaining them over time as
> different subsystem maintainers accept/ignore them, just let me know.
> Doing large patchsets like this can be tough without a lot of
> experience.

Very much appreciated!

There will probably be some cases that do not match one of the pattern
we already discussed and need separate attention.

I was planning to start with one subsystem and adjust the coming ones
according to the feedback gather there instead of posting all of them
in one go.

>=20
> thanks,
>=20
> greg k-h

- Jakob=
