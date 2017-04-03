Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
	[209.85.128.176])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5EF7C1056320
	for <drbd-dev@lists.linbit.com>; Mon,  3 Apr 2017 14:39:35 +0200 (CEST)
Received: by mail-wr0-f176.google.com with SMTP id w43so167337871wrb.0
	for <drbd-dev@lists.linbit.com>; Mon, 03 Apr 2017 05:39:35 -0700 (PDT)
Received: from soda.linbit ([217.196.73.213]) by smtp.gmail.com with ESMTPSA id
	s27sm13303371wra.69.2017.04.03.05.39.34
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Apr 2017 05:39:34 -0700 (PDT)
Resent-Message-ID: <20170403123934.GL5939@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A7E31056320
	for <drbd-dev@lists.linbit.com>; Mon,  3 Apr 2017 08:23:48 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com,
	shli@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com
References: <20170331163313.31821-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <83c79b9c-362a-c12c-8a75-7e42947a77da@suse.de>
Date: Mon, 3 Apr 2017 08:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170331163313.31821-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] always use REQ_OP_WRITE_ZEROES for zeroing offload
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

On 03/31/2017 06:32 PM, Christoph Hellwig wrote:
> This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> supported by the block layer, and switches existing implementations
> of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> removes incorrect discard_zeroes_data, and also switches WRITE SAME
> based zeroing in SCSI to this new method.
> 
> The series is against the block for-next tree.
> 
> A git tree is also avaiable at:
> 
>     git://git.infradead.org/users/hch/block.git discard-rework
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/discard-rework
Thank you for doing this.

For this series:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
