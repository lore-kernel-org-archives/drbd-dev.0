Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Tue, 27 Jul 2004 10:15:53 +0200
References: <200405251206.11287.philipp.reisner@linbit.com> <20040526073608.GA21855@infradead.org>
In-Reply-To: <20040526073608.GA21855@infradead.org>
Cc: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407271015.53469.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: XFS on DRBD
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

On Wednesday 26 May 2004 09:36, you wrote:
> XFS does I/O on slab-allocated pages, which not a lot other code in
> the kernel does, and it seems drbd doesn't like that.  Do you have
> a pointer to the drbd code for Linux 2.6 so I can take a look?

Hi Christoph,

Drbd reached release status and finally everything works, but we have a
rather uggly workaround for XFS.

We usually use sendpage() to send the data blocks over the network.
But when XFS hands us its slab-allocated pages over, we may not
use sendpage. 

  If we call sendpage on such a page it will crash, since sendpage()
  calls put_page() after the job is done.

So currently we have this code in drbd:

	/* PARANOIA. if this ever triggers,
	 * something in the layers above us is really kaputt.
	 *one roundtrip later:
	 * doh. it triggered. so XFS _IS_ really kaputt ...
	 * oh well...
	 */
	if ( (page_count(page) < 1) || PageSlab(page) ) {
		/* e.g. XFS meta- & log-data is in slab pages, which have a
		 * page_count of 0 and/or have PageSlab() set...
		 * FIXME: This is a workaround.
		 */
		++fallback;
		sent =  _drbd_no_send_page(mdev, page, offset, size);
		if (likely(sent > 0)) len -= sent;
		goto out;
	}

Jul 27 09:58:32 mary kernel: drbd:sendpage fallback/total: 1/5381
Jul 27 09:59:32 mary kernel: drbd:sendpage fallback/total: 6/138083
Jul 27 10:00:32 mary kernel: drbd:sendpage fallback/total: 11/258761
Jul 27 10:01:32 mary kernel: drbd:sendpage fallback/total: 13/260085
Jul 27 10:02:32 mary kernel: drbd:sendpage fallback/total: 22/354874
Jul 27 10:03:32 mary kernel: drbd:sendpage fallback/total: 27/475558
Jul 27 10:04:37 mary kernel: drbd:sendpage fallback/total: 31/520124
Jul 27 10:05:37 mary kernel: drbd:sendpage fallback/total: 43/591427
Jul 27 10:06:37 mary kernel: drbd:sendpage fallback/total: 51/708371
Jul 27 10:07:42 mary kernel: drbd:sendpage fallback/total: 58/780179
Jul 27 10:08:42 mary kernel: drbd:sendpage fallback/total: 73/815288
Jul 27 10:09:42 mary kernel: drbd:sendpage fallback/total: 87/926600

Christoph,

IMHO XFS should only pass pages down the IO path which have a correct
page_count. 

Which is the right forum to discuss this issue ?

-Philipp

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
