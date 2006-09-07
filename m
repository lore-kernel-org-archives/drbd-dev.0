Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 468CA2CF6713
	for <drbd-dev@lists.linbit.com>; Thu,  7 Sep 2006 11:28:50 +0200 (CEST)
Date: Thu, 7 Sep 2006 11:28:50 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - system hangs when NegDReply received
Message-ID: <20060907092850.GA13664@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671038AFA18@EXNA.corp.stratus.com>
	<20060906080931.GA30543@barkeeper1.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906080931.GA30543@barkeeper1.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-09-06 10:09:31 +0200
\ Lars Ellenberg:
> / 2006-09-05 21:41:36 -0400
> \ Graham, Simon:
> > I'd still like to understand why simply completing the original request
> > with an error similar to what is done in receive_DataReply leads to a
> > hang - all suggestions gratefully received - this is what the NegDReply
> > code looks like now:
> > 
> > STATIC int got_NegDReply(drbd_dev *mdev, Drbd_Header* h)
> > {
> > 	drbd_request_t *req;
> > 	Drbd_BlockAck_Packet *p = (Drbd_BlockAck_Packet*)h;
> > 	sector_t sector = be64_to_cpu(p->sector);
> > 
> > 	req = (drbd_request_t *)(unsigned long)p->block_id;
> > 	if(unlikely(!drbd_pr_verify(mdev,req,sector))) {
> > 		ERR("Got a corrupt block_id/sector pair(3).\n");
> > 		return FALSE;
> > 	}
> > 
> > 	ERR("Got NegDReply; Sector %llx, len %x; Fail original
> > request.\n",
> > 	    (unsigned long long)sector,be32_to_cpu(p->blksize));
> > 
> > 	spin_lock(&mdev->pr_lock);
> > 	hlist_del(&req->colision);
> > 	spin_unlock(&mdev->pr_lock);
> > 
> > 	/* Complete original request with error */
> > 	drbd_bio_endio(req->master_bio,0 /* failed */);
> 
> I am still working on a monster patch to consolidate all the
> request functionality in one place, so it is more obvious what should
> and should not happen.
> I may be wrong here, but you cannot simply end the master request and
> free the req because you get a NegDReply. the local part (submit_bio)
> may still be on the fly.
> you have to use drbd_end_req with appropriate flags...

nonsense. a NegDReply comes from a read request, there is no local
 request pending for that one...
 sorry, have been to deep in other areas of the code...

so this should just work as you coded it.

> 
> 
> > 
> > 	dec_ap_bio(mdev);
> > 	dec_ap_pending(mdev);
> > 
> > 	drbd_req_free(req);
> > 
> > 	drbd_khelper(mdev,"pri-on-incon-degr");

well, what is your pri-on-incon-degr handler?
if that happens to be "halt -f" it would pretty much explain the "hang"
right?

> > 
> > 	return TRUE;
> > }
> 

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
