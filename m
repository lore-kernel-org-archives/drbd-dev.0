Return-Path: <Christian.Koenig@amd.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
	(mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4879B421790
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 00:30:21 +0100 (CET)
Message-ID: <0b65541a-3da7-dc35-690a-0ada75b0adae@amd.com>
Date: Mon, 28 Feb 2022 21:56:40 +0100
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-3-jakobkoschel@gmail.com>
	<2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
	<CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
	<282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
	<b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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
	Kees Cook <keescook@chromium.org>, Arnd Bergman <arnd@arndb.de>,
	Linux PM <linux-pm@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, dma <dmaengine@vger.kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jakob Koschel <jakobkoschel@gmail.com>,
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



Am 28.02.22 um 21:42 schrieb James Bottomley:
> On Mon, 2022-02-28 at 21:07 +0100, Christian König wrote:
>> Am 28.02.22 um 20:56 schrieb Linus Torvalds:
>>> On Mon, Feb 28, 2022 at 4:19 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>> [SNIP]
>>> Anybody have any ideas?
>> I think we should look at the use cases why code is touching (pos)
>> after the loop.
>>
>> Just from skimming over the patches to change this and experience
>> with the drivers/subsystems I help to maintain I think the primary
>> pattern looks something like this:
>>
>> list_for_each_entry(entry, head, member) {
>>       if (some_condition_checking(entry))
>>           break;
>> }
>> do_something_with(entry);
>
> Actually, we usually have a check to see if the loop found anything,
> but in that case it should something like
>
> if (list_entry_is_head(entry, head, member)) {
>      return with error;
> }
> do_somethin_with(entry);
>
> Suffice?  The list_entry_is_head() macro is designed to cope with the
> bogus entry on head problem.

That will work and is also what people already do.

The key problem is that we let people do the same thing over and over 
again with slightly different implementations.

Out in the wild I've seen at least using a separate variable, using a 
bool to indicate that something was found and just assuming that the 
list has an entry.

The last case is bogus and basically what can break badly.

If we would have an unified macro which search for an entry combined 
with automated reporting on patches to use that macro I think the 
potential to introduce such issues will already go down massively 
without auditing tons of existing code.

Regards,
Christian.

>
> James
>
>

