Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 061D01019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:29:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id E91581B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:29:54 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kz-6Tf8UlBuB for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:29:54 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id C42001B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:29:54 +0200 (CEST)
Resent-Message-ID: <20120525202954.GA1903@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B2331019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 18:49:26 +0200 (CEST)
Date: Fri, 25 May 2012 12:49:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120525164914.GE3855@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-10-git-send-email-koverstreet@google.com>
	<4FBE687E.1030605@panasas.com> <20120524213158.GB22664@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524213158.GB22664@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	Boaz Harrosh <bharrosh@panasas.com>,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 09/14] block: Add an explicit bio flag for
 bios that own their bvec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 02:31:58PM -0700, Kent Overstreet wrote:
> On Thu, May 24, 2012 at 07:57:34PM +0300, Boaz Harrosh wrote:
> > How do you insure that the original bio which owns the
> > bvec is not freed before the split-out bio.
> > 
> > Perhaps calling code needs to make sure by taking an extra
> > ref on the original bio, or something. If so a big fat comment
> > at bio_split is do.
> 
> Yeah, just added that.
> 
> > 
> > And I understand you did not like my suggestion of negating
> > the meaning of the flag, so the default is zero?
> > Please say why?
> 
> I liked it at first, but I think I prefer having the flag be set
> if bio_free() must take some action; i.e. you set the flag when you
> allocate bi_io_vec. Also, I think bio_alloc_bioset() getting
> reimplemented is less likely than people open coding bio splitting or
> something that shares bi_io_vec in the future, so it's slightlry less
> likely to be used wrong this way.

Even if you keep it as it is, I thought BIO_OWNS_BVEC probably communicates
the idea better than BIO_HAS_BVEC.

Thanks
Vivek
