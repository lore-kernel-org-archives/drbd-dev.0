Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
	[209.85.128.172])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D594F105647D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 11:33:15 +0200 (CEST)
Received: by mail-wr0-f172.google.com with SMTP id k6so46127335wre.2
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 02:33:15 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	w130sm2504568wmg.0.2017.03.30.02.33.14
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 Mar 2017 02:33:14 -0700 (PDT)
Resent-Message-ID: <20170330093314.GE5939@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E2E121057FBA
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2017 16:57:44 +0200 (CEST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>,
	Alasdair G Kergon <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	Jens Axboe <axboe@fb.com>, "shli@kernel.org" <shli@kernel.org>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
	<1490719722.2573.8.camel@sandisk.com>
Message-ID: <dab09af5-521a-99da-9852-2d18cc28ca4f@redhat.com>
Date: Wed, 29 Mar 2017 16:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <1490719722.2573.8.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	dm <dm-devel@redhat.com>, Linux SCSI List <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 12/23] sd: handle REQ_UNMAP
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



On 28/03/2017 18:48, Bart Van Assche wrote:
>> +	if (rq->cmd_flags & REQ_UNMAP) {
>> +		switch (sdkp->provisioning_mode) {
>> +		case SD_LBP_WS16:
>> +			return sd_setup_write_same16_cmnd(cmd, true);
>> +		case SD_LBP_WS10:
>> +			return sd_setup_write_same10_cmnd(cmd, true);
>> +		}
>> +	}
>> +
>>  	if (sdp->no_write_same)
>>  		return BLKPREP_INVALID;
>>  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
> Users can change the provisioning mode from user space from SD_LBP_WS16 into
> SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
> 0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.

Yeah, if REQ_UNMAP is set you should probably check sdkp->provisioning_mode
instead of sdkp->ws16, but apart from this it should still go through the
checks below.

Plus, if the provisioning mode is not ws10 or ws16, should
sd_setup_write_zeroes_cmnd:

1) do a WRITE SAME without UNMAP (what Christoph's code does)

2) return BLKPREP_INVALID

3) ignore provisioning mode and do a WRITE SAME with UNMAP

4) do a WRITE SAME without UNMAP for SD_LBP_{ZERO,FULL,DISABLE},
do a WRITE SAME with UNMAP for SD_LBP_{WS10,WS16,UNMAP}.

I'm in favor of (4).  The distinction between SD_LBP_UNMAP, SD_LBP_WS10
and SD_LBP_WS16 is as problematic as discard_zeroes_data in my opinion.

Thanks,

Paolo

