Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@suse.de>
Date: Tue, 15 Mar 2005 21:15:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503152115.58219.philipp.reisner@linbit.com>
Cc: drbd-dev@linbit.com
Subject: [Drbd-dev] bio_split()...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

bio_split only works for bios with a single page...

[ from bio.c: ]
/*
 * split a bio - only worry about a bio with a single page
 * in it's iovec
 */
struct bio_pair *bio_split(struct bio *bi, mempool_t *pool, int first_sectors)
{
 struct bio_pair *bp = mempool_alloc(pool, GFP_NOIO);

 if (!bp)
  return bp;

 BUG_ON(bi->bi_vcnt != 1);
[...]

In DRBD-0.8 I want to split BIO's that cross a 16 MB boundary. 
In DRBD-0.8 I accept BIOs with more than one page (currently up to
32 kB in a single BIO), I thought that bio_split is here
to handle such situations....

Is there an other way to go ?
Would you accept a patch that would make bio_split to work with bigger
BIOs ?

Currently my code hits that BUG_ON statement....

-Philipp

