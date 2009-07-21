Return-Path: <lars.ellenberg@linbit.com>
Received: from johann (chello212017090083.12.15.vie.surfer.at [212.17.90.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 71D191011C09
	for <drbd-dev@lists.linbit.com>; Tue, 21 Jul 2009 12:38:25 +0200 (CEST)
Resent-Message-ID: <20090721103825.GD7556@johann>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D3E141013803
	for <drbd-dev@lists.linbit.com>; Tue, 21 Jul 2009 07:50:26 +0200 (CEST)
Date: Mon, 20 Jul 2009 22:49:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-Id: <20090720224957.a8a36701.akpm@linux-foundation.org>
In-Reply-To: <1246894775-10855-5-git-send-email-philipp.reisner@linbit.com>
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-2-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-3-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-4-git-send-email-philipp.reisner@linbit.com>
	<1246894775-10855-5-git-send-email-philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>, Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>, Greg,
	Lars Marowsky-Bree <lmb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
	Dave Jones <davej@redhat.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Sam Ravnborg <sam@ravnborg.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 04/16] drbd: dirty bitmap
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon,  6 Jul 2009 17:39:23 +0200 Philipp Reisner <philipp.reisner@linbit.com> wrote:

> DRBD maintains a dirty bitmap in case it has to run without peer node or
> without local disk. Writes to the on disk dirty bitmap are minimized by the
> activity log (=AL). Each time an extent is evicted from the AL the part of
> the bitmap no longer covered by the AL is written to disk.
> 
> ...
>
> +static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
> +{
> +	struct page **old_pages = b->bm_pages;
> +	struct page **new_pages, *page;
> +	unsigned int i, bytes, vmalloced = 0;
> +	unsigned long have = b->bm_number_of_pages;
> +
> +	BUG_ON(have == 0 && old_pages != NULL);
> +	BUG_ON(have != 0 && old_pages == NULL);
> +
> +	if (have == want)
> +		return old_pages;
> +
> +	/* Trying kmalloc first, falling back to vmalloc.
> +	 * GFP_KERNEL is ok, as this is done when a lower level disk is
> +	 * "attached" to the drbd.  Context is receiver thread or cqueue
> +	 * thread.  As we have no disk yet, we are not in the IO path,
> +	 * not even the IO path of the peer. */
> +	bytes = sizeof(struct page *)*want;
> +	new_pages = kmalloc(bytes, GFP_KERNEL);
> +	if (!new_pages) {
> +		new_pages = vmalloc(bytes);
> +		if (!new_pages)
> +			return NULL;
> +		vmalloced = 1;
> +	}
> +
> +	memset(new_pages, 0, bytes);
> +	if (want >= have) {
> +		for (i = 0; i < have; i++)
> +			new_pages[i] = old_pages[i];
> +		for (; i < want; i++) {
> +			page = alloc_page(GFP_HIGHUSER);
> +			if (!page) {
> +				bm_free_pages(new_pages + have, i - have);
> +				bm_vk_free(new_pages, vmalloced);
> +				return NULL;
> +			}
> +			new_pages[i] = page;
> +		}
> +	} else {
> +		for (i = 0; i < want; i++)
> +			new_pages[i] = old_pages[i];
> +		/* NOT HERE, we are outside the spinlock!
> +		bm_free_pages(old_pages + want, have - want);
> +		*/
> +	}
> +
> +	if (vmalloced)
> +		set_bit(BM_P_VMALLOCED, &b->bm_flags);
> +	else
> +		clear_bit(BM_P_VMALLOCED, &b->bm_flags);
> +
> +	return new_pages;
> +}

The vmalloc is always troublesome.

It's a pretty commonly-occurring pattern and I've been suggesting that
we implement a generic dynamic-array facility so that those callsites
which wish to do huge contiguous allocations need no longer do that.

Please take a look at this thread: http://lkml.org/lkml/2009/7/2/464
and let's see if there's any useful commonality here.  I think there
is...

