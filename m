Return-Path: <philipp.reisner@linbit.com>
Received: from amd.localdomain (chello080108092198.22.11.tuwien.teleweb.at
	[80.108.92.198])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2667E2DF6558
	for <drbd-dev@lists.linbit.com>; Tue, 12 Sep 2006 09:36:55 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 12 Sep 2006 09:36:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609120936.57920.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Crash in _req_may_be_done()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Lars,

First, do not read e-mails while on vacation. 

Ok, I just document here my findings, in case Simon works on the same,
I do not want that we hunt the same bugs ...

Currently I run drbd in my UML setup and hit a crash in. _req_may_be_done()

		/* remove the request from the conflict detection
		 * respective block_id verification hash */
		hlist_del(&req->colision);           <<<<<<<=====<<<<<<==== HERE!

		/* FIXME not yet implemented...
		 * in case we got "suspended" (on_disconnect: freeze io)
		 * we may not yet complete the request...

To understand how this came I added that VERBOSE_REQUEST_CODE

[42950452.520000] drbd0: _req_mod(a101c744,to_be_submitted)
[42950452.520000] drbd0: _req_mod(a101c744,completed_ok)
[42950452.520000] drbd0: _req_may_be_done(a101c744 L-coN-----)
           *******   without modifications it would crash here **********
[42950452.540000] drbd0: _req_mod(a101c744,to_be_send)
[42950452.540000] drbd0: _req_mod(a101c744,to_be_submitted)
[42950452.540000] drbd0: _req_mod(a101c744,queue_for_net_write)
[42950452.540000] drbd0: _req_mod(a101c744,handed_over_to_network)
[42950452.540000] drbd0: _req_may_be_done(a101c744 Lp--Np-s--)
[42950452.540000] drbd0: _req_mod(a101c744,completed_ok)
[42950452.540000] drbd0: _req_may_be_done(a101c744 L-coNp-s--)
[42950452.540000] drbd0: _req_mod(a101c744,recv_acked_by_peer)
[42950452.540000] drbd0: _req_may_be_done(a101c744 L-coN--s-o)

What we see here is, that UML's block layer finishes the write of the
block before we even mark the request that it should be sent. 
Strange, since the code in drbd_make_request_common() is:

	if (remote) _req_mod(req, to_be_send);
	if (local)  _req_mod(req, to_be_submitted);
[...]
	if (local) {
		BUG_ON(req->private_bio->bi_bdev == NULL);
		generic_make_request(req->private_bio);
	}

The code reads, set the RQ_NET_PENDING first, then the RQ_LOCAL_PENDING
and after that issue the local request (= call generic_make_request())

What happens here ? Agressive reordering of the compiler ? I can not
believe this.

-Philipp
