Return-Path: <BATV+6cc4c2ca6091f98ba507+4601+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8B12A105643D
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 09:29:39 +0200 (CEST)
Date: Tue, 29 Mar 2016 00:29:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160329072933.GF18920@infradead.org>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
	<1458627149-12988-6-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458627149-12988-6-git-send-email-ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 5/8] fs: xfs: replace BIO_MAX_SECTORS with
	BIO_MAX_PAGES
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> +	nr_pages = BIO_MAX_PAGES;
>  	if (nr_pages > total_nr_pages)
>  		nr_pages = total_nr_pages;

Looks reasonable, but the whole thing could simply become:

	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
