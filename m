Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
	[209.85.218.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2EE81160917
	for <drbd-dev@lists.linbit.com>; Thu,  8 May 2025 10:39:59 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id
	a640c23a62f3a-ac339f53df9so120682966b.1
	for <drbd-dev@lists.linbit.com>; Thu, 08 May 2025 01:39:59 -0700 (PDT)
Date: Thu, 8 May 2025 10:39:56 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: transferring bvecs over the network in drbd
Message-ID: <aBxt3NsJcofxhV5P@grappa.linbit>
References: <aBxTHl8UIwr9Ehuv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBxTHl8UIwr9Ehuv@infradead.org>
Cc: linux-block@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
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

On Wed, May 07, 2025 at 11:45:50PM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> I recently went over code that directly access the bio_vec bv_page/
> bv_offset members and the code in _drbd_send_bio/_drbd_send_zc_bio
> came to my attention.
> 
> It iterates the bio to kmap all segments, and then either does a
> sock_sendmsg on a newly created kvec iter, or one one a new bvec iter
> for each segment.  The former can't work on highmem systems and both
> versions are rather inefficient.
> 
> What is preventing drbd from doing a single sock_sendmsg with the
> bvec payload?  nvme-tcp (nvme_tcp_init_iter0 is a good example for
> doing that, or the sunrpc svcsock code using it's local bvec list
> (svc_tcp_sendmsg).

For async replication, we want to actually copy data into send buffer,
we cannot have the network stack hold a reference to a page for which
we signalled io completion already.

For sync replication we want to avoid additional data copy if possible,
so try to use "zero copy sendpage".

That's why we have two variants of what looks to be the same thing.

Why we do it that way: probably when we wrote that part,
a better infrastructure was not available, or we were not aware of it.
Thanks for the pointers, we'll look into it.
Using more efficient ways to do stuff sounds good.

    Lars

