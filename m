Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DD15F42177B
	for <drbd-dev@lists.linbit.com>; Thu, 17 Feb 2022 04:08:00 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
	h14-20020a17090a130e00b001b88991a305so8202266pja.3
	for <drbd-dev@lists.linbit.com>; Wed, 16 Feb 2022 19:08:00 -0800 (PST)
Message-ID: <2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
Date: Wed, 16 Feb 2022 20:07:56 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
References: <20220209082828.2629273-1-hch@lst.de>
	<yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com> <20220210055151.GA3491@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220210055151.GA3491@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: ukrishn@linux.ibm.com, target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	manoj@linux.ibm.com, haris.iqbal@ionos.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	jinpu.wang@ionos.com, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] remove REQ_OP_WRITE_SAME v2
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2/9/22 10:51 PM, Christoph Hellwig wrote:
> On Wed, Feb 09, 2022 at 01:00:26PM -0500, Martin K. Petersen wrote:
>>
>> Christoph,
>>
>>> Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
>>> kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
>>> have two callers left, and both just export optional protocol features
>>> to remote systems: DRBD and the target code.
>>
>> No particular objections from me. I had a half-baked series to do the
>> same thing.
>>
>> One thing I would like is to either pull this series through SCSI or do
>> the block pieces in a post merge branch because I'm about to post my
>> discard/zeroing rework and that's going to clash with your changes.
> 
> I'd be fine with taking this through the SCSI tree.  Or we can wait
> another merge window to make your life easier.

Let's just use the SCSI tree - I didn't check if it throws any conflicts
right now, so probably something to check upfront...

If things pan out, you can add my Acked-by to the series.

-- 
Jens Axboe

