Return-Path: <BATV+4d4f7abe5776451c4d8a+8263+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A649E160876
	for <drbd-dev@lists.linbit.com>; Wed,  8 Apr 2026 07:42:56 +0200 (CEST)
Date: Tue, 7 Apr 2026 22:42:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 06/20] drbd: add RDMA transport implementation
Message-ID: <adXq36pbGLXMZc2r@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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

You really need to add the RDMA mailing list before adding new RDMA
code.  I'll try to review the bits I still remember, but you also
need a maintainer ACK.

> +#ifndef SENDER_COMPACTS_BVECS
> +/* My benchmarking shows a limit of 30 MB/s
> + * with the current implementation of this idea.
> + * cpu bound, perf top shows mainly get_page/put_page.
> + * Without this, using the plain send_page,
> + * I achieve > 400 MB/s on the same system.
> + * => disable for now, improve later.
> + */
> +#define SENDER_COMPACTS_BVECS 0
> +#endif

Nothing explains what "this idea" is.  And we do not add dead code as
a rule of thumb anyway.

> +/* Nearly all data transfer uses the send/receive semantics. No need to

Please use the normal kernel command style:

/*
 * Blah, blah, blah.
 */

> +int allocation_size;
> +/* module_param(allocation_size, int, 0664);
> +   MODULE_PARM_DESC(allocation_size, "Allocation size for receive buffers (page size of peer)");
> +
> +   That needs to be implemented in dtr_create_rx_desc() and in dtr_recv() and dtr_recv_pages() */
> +
> +/* If no recvbuf_size or sendbuf_size is configured use 1M plus two pages for the DATA_STREAM */
> +/* Actually it is not a buffer, but the number of tx_descs or rx_descs we allow,
> +   very comparable to the socket sendbuf and recvbuf sizes */

Please don't add random unused code.

Also while the kernel coding style has an exception for overly long
lines for selected lines where the improve readability, that by
definition can't apply to block comments.

> +/* Assuming that a singe 4k write should be at the highest scatterd over 8
> +   pages. I.e. has no parts smaller than 512 bytes.
> +   Arbitrary assumption. It seems that Mellanox hardware can do up to 29
> +   ppc64 page size might be 64k */
> +#if (PAGE_SIZE / 512) > 28
> +# define DTR_MAX_TX_SGES 28
> +#else
> +# define DTR_MAX_TX_SGES (PAGE_SIZE / 512)
> +#endif

All this looks complete bollocks.  We had multi-page bvecs for years,
aso the page size should not apply for the I/O path.

> +union dtr_immediate {
> +	struct {
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +		unsigned int sequence:SEQUENCE_BITS;
> +		unsigned int stream:2;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +		unsigned int stream:2;
> +		unsigned int sequence:SEQUENCE_BITS;
> +#else
> +# error "this endianness is not supported"
> +#endif
> +	};
> +	unsigned int i;
> +};

Bitfields for on-the-write structures are an anti-pattern,  Please
use proper masking and shifting like just about everyone else in modern
code.

> +static int dtr_init(struct drbd_transport *transport);
> +static void dtr_free(struct drbd_transport *transport, enum drbd_tr_free_op);
> +static int dtr_prepare_connect(struct drbd_transport *transport);
> +static int dtr_connect(struct drbd_transport *transport);
> +static void dtr_finish_connect(struct drbd_transport *transport);

The code structure here is totally messed up if you need all these
dozens of forward declarations.  Please reshuffled it that you only
need those actually required,

> +static struct drbd_transport_class rdma_transport_class = {
> +	.name = "rdma",
> +	.instance_size = sizeof(struct dtr_transport),
> +	.path_instance_size = sizeof(struct dtr_path),
> +	.listener_instance_size = sizeof(struct dtr_listener),
> +	.ops = (struct drbd_transport_ops) {

nested struct initializers don't need casts.

> +static bool atomic_inc_if_below(atomic_t *v, int limit)
> +{
> +	int old, cur;
> +
> +	cur = atomic_read(v);
> +	do {
> +		old = cur;
> +		if (old >= limit)
> +			return false;
> +
> +		cur = atomic_cmpxchg(v, old, old + 1);
> +	} while (cur != old);
> +
> +	return true;
> +}

Don't add you own atomics, please talk to the atomics maintainers
instead of adding hacks like this.

> +	err = -ENOMEM;
> +	tx_desc = kzalloc(sizeof(*tx_desc) + sizeof(struct ib_sge), gfp_mask);
> +	if (!tx_desc)
> +		goto out_put;

This is supposed to use the new flex kmalloc family of functions
(as much as I hate them).

> +	send_buffer = kmalloc(size, gfp_mask);
> +	if (!send_buffer) {
> +		kfree(tx_desc);
> +		goto out_put;
> +	}
> +	memcpy(send_buffer, buf, size);

and this is a kmemdup.

> +	if (err) {
> +		kfree(tx_desc);
> +		kfree(send_buffer);
> +		goto out_put;
> +	}

And please use proper gotos to unwind.

> +static int dtr_recv(struct drbd_transport *transport, enum drbd_stream stream, void **buf, size_t size, int flags)
> +{
> +	struct dtr_transport *rdma_transport;
> +	int err;
> +
> +	if (!transport)
> +		return -ECONNRESET;

How can this be NULL?

> +static int dtr_path_prepare(struct dtr_path *path, struct dtr_cm *cm, bool active)
> +{
> +	struct dtr_cm *cm2;
> +	int i, err;
> +
> +	cm2 = cmpxchg(&path->cm, NULL, cm); // RCU xchg

Wht's that comment supposed to mean?  If it is a rcu_replace_pointer,
use that.  If not the comment looks really odd.

> +	err = dtr_cm_alloc_rdma_res(cm);
> +
> +	return err;

You can return the value directly here.

Giving up for now.  I think this needs a sweep for basic sanity an
a review from the RDMA maintainers before we can go into more details.

