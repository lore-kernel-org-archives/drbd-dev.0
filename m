Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5D1791005415
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 57A501B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:59 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9fC4WN2LX6K for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:03:59 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 2185D1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:59 +0200 (CEST)
Resent-Message-ID: <20120525070359.GI12726@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7F6DB1017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 21:55:54 +0200 (CEST)
Received: by dadv36 with SMTP id v36so269116dad.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 12:55:53 -0700 (PDT)
Date: Thu, 24 May 2012 12:55:49 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20120524195549.GA18624@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-8-git-send-email-koverstreet@google.com>
	<20120524194252.GF27550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524194252.GF27550@redhat.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 07/14] pktcdvd: Switch to bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 03:42:52PM -0400, Vivek Goyal wrote:
> On Wed, May 23, 2012 at 05:02:44PM -0700, Kent Overstreet wrote:
> 
> [..]
> > @@ -567,10 +569,13 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
> >  		goto no_pkt;
> >  
> >  	pkt->frames = frames;
> > -	pkt->w_bio = pkt_bio_alloc(frames);
> > +	pkt->w_bio = bio_kmalloc(GFP_KERNEL, frames);
> 
> So previously bios allocated were being kfreed by pkt_bio_destructor().
> Now where are we doing kfree() on bio being allocated by bio_kmalloc()?

bio_kmalloc() sets up bi_destructor, so there's no need to kfree() the
bio - bio_put() frees it just like normal.
