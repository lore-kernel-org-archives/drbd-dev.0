Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
	[209.85.128.172])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 87CAA105633D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 11:32:52 +0200 (CEST)
Received: by mail-wr0-f172.google.com with SMTP id k6so46110975wre.2
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 02:32:51 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	l41sm2036060wre.23.2017.03.30.02.32.50
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 Mar 2017 02:32:51 -0700 (PDT)
Resent-Message-ID: <20170330093245.GD5939@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D3970105633D
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2017 16:57:37 +0200 (CEST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Alasdair G Kergon <agk@redhat.com>,
	"shli@kernel.org" <shli@kernel.org>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	dm <dm-devel@redhat.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323155410.GD1138@soda.linbit> <20170323170221.GA20854@redhat.com>
	<20170323225256.GK1138@soda.linbit>
Message-ID: <0d2950ea-a1ab-7939-3c8e-d14038839761@redhat.com>
Date: Wed, 29 Mar 2017 16:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170323225256.GK1138@soda.linbit>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing
	offload
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



On 23/03/2017 23:53, Lars Ellenberg wrote:
> Thin does not claim to zero data on discard.  which is ok, and correct,
> because it only punches holes on full chunks (or whatever you call
> them), and leaves the rest in the mapping tree as is.
> 
> And that behaviour would prevent DRBD from exposing discards if
> configured on top of thin. (see above)
> 
> But thin *could* easily guarantee zeroing, by simply punching holes
> where it can, and zeroing out the not fully-aligned partial start and
> end of the range.

That's the difference between REQ_OP_DISCARD (only punches holes on full
chunks) and REQ_OP_WRITE_ZEROES with the REQ_UNMAP flag (punches holes +
zeroes incomplete chunks).

dm-thinp's REQ_OP_DISCARD should not do anything for unaligned parts.
Instead, layers above should use REQ_OP_WRITE_ZEROES (with or without
REQ_UNMAP, as required) if they need zeroes.  dm-thinp would have to
split off the partial chunks, and zero them in the lower-level device
with REQ_OP_WRITE_ZEROES.

Paolo

