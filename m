Return-Path: <Lars.Ellenberg@linbit.com>
Date: Fri, 24 Sep 2004 14:37:18 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@linbit.com
Message-ID: <P3J8pVXQZJMx4eU9q8DUNEQ=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: 
Subject: [Drbd-dev] inter-arch PAGE_SIZE problem
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


int drbd_make_request_26(request_queue_t *q, struct bio *bio)
{
...
  /*
   * what we "blindly" assume:
   */
  D_ASSERT(bio->bi_size > 0);
  D_ASSERT( (bio->bi_size & 0x1ff) == 0);
  D_ASSERT(bio->bi_size <= PAGE_SIZE);
  D_ASSERT(bio->bi_vcnt == 1);
  D_ASSERT(bio->bi_idx == 0);

oopsie.
we are going to send PAGE_SIZE requests over the wire,
but the other side may have a different PAGE_SIZE...

// mirrored write
int receive_Data(drbd_dev *mdev,Drbd_Header* h)
{               
...
        /* I expect a block to be a multiple of 512 byte, and
         * no more than 4K (PAGE_SIZE). is this too restrictive?
         */
        ERR_IF(data_size == 0) return FALSE;
        ERR_IF(data_size &  0x1ff) return FALSE;
        ERR_IF(data_size >  PAGE_SIZE) return FALSE;


we need to agree to use fixed 4K, I guess.  optionally negotiate a
higher "drbd_page_size" during the initial connection handshake.

however we are required to accept a single bio with a data payload
of PAGE_SIZE in the request function.

this is all relevant only on ARCHs with PAGE_SIZE > 4K.

so we need to split it up at least during send (would need to
attach more than one "private_bio" to our req object, or at least
some atomic counter for the expected ACK packets), or even before
that and split requests > 4K up into several requests before we
actually send/submit them. the latter probably is a huge
performance impact.

we may ignore this for now, but we should at least include a
current page size negotiation in the handshake, and refuse to
connect if it differs.

my prefered solution would be to attach some atomic "expected
acks" counter to the request, and do multiple sendpage() with
varying offset and size <= 4K, then wait for the acks to come...
and show in the request header some number (1/8; 2/8; 3/8; ...)
that can be ignored, but can be used on the receiving side to
optimize and merge into a single bio.

for the time being I'd like to continue to accept only single page
bios, i.e. bios with a "scalar" io-vector. but once we implemented
that loop, we probably could easily adjust that for multiple page
bios, too.

does that all make sense?

	lge
