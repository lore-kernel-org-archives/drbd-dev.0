Return-Path: <Christian.Koenig@amd.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 53A28420171
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 15:51:45 +0100 (CET)
Message-ID: <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
Date: Mon, 28 Feb 2022 13:19:17 +0100
Content-Language: en-US
To: Jakob Koschel <jakobkoschel@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
	<20220228110822.491923-3-jakobkoschel@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220228110822.491923-3-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: linux-wireless@vger.kernel.org, alsa-devel@alsa-project.org,
	kvm@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	amd-gfx@lists.freedesktop.org,
	linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
	linux-arch <linux-arch@vger.kernel.org>,
	linux-cifs@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
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
	Nathan Chancellor <nathan@kernel.org>, dmaengine@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
	linux-block@vger.kernel.org, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	tipc-discussion@lists.sourceforge.net,
	linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
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

Am 28.02.22 um 12:08 schrieb Jakob Koschel:
> If the list does not contain the expected element, the value of
> list_for_each_entry() iterator will not point to a valid structure.
> To avoid type confusion in such case, the list iterator
> scope will be limited to list_for_each_entry() loop.

We explicitly have the list_entry_is_head() macro to test after a loop 
if the element pointer points to the head of the list instead of a valid 
list entry.

So at least from my side I absolutely don't think that this is a good idea.

> In preparation to limiting scope of a list iterator to the list traversal
> loop, use a dedicated pointer to point to the found element.
> Determining if an element was found is then simply checking if
> the pointer is != NULL.

Since when do we actually want to do this?

Take this code here as an example:
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 48afe96ae0f0..6c916416decc 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -450,7 +450,8 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>   				     struct mm_struct *mm)
>   {
>   	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
> -	struct sgx_encl_mm *tmp = NULL;
> +	struct sgx_encl_mm *found_encl_mm = NULL;
> +	struct sgx_encl_mm *tmp;
>
>   	/*
>   	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
> @@ -460,12 +461,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>   	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
>   		if (tmp == encl_mm) {
>   			list_del_rcu(&encl_mm->list);
> +			found_encl_mm = tmp;
>   			break;
>   		}
>   	}
>   	spin_unlock(&encl_mm->encl->mm_lock);
>
> -	if (tmp == encl_mm) {
> +	if (found_encl_mm) {
>   		synchronize_srcu(&encl_mm->encl->srcu);
>   		mmu_notifier_put(mn);
>   	}

I don't think that using the extra variable makes the code in any way 
more reliable or easier to read.

Regards,
Christian.
