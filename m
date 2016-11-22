Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E984B105645E
	for <drbd-dev@lists.linbit.com>; Fri, 25 Nov 2016 17:20:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A3A0D465B9A
	for <drbd-dev@lists.linbit.com>; Fri, 25 Nov 2016 17:20:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OvZ9BsRjp3Vo for <drbd-dev@lists.linbit.com>;
	Fri, 25 Nov 2016 17:20:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1ED5F4659B5
	for <drbd-dev@lists.linbit.com>; Fri, 25 Nov 2016 17:20:03 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 56u8XC1xMFwG for <drbd-dev@lists.linbit.com>;
	Fri, 25 Nov 2016 17:20:02 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A8368465929
	for <drbd-dev@lists.linbit.com>; Fri, 25 Nov 2016 17:20:02 +0100 (CET)
Resent-Message-ID: <20161125162002.GI22026@soda.linbit>
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
	[67.231.153.30]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 203621051881
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2016 17:29:12 +0100 (CET)
To: Ming Lei <tom.leiming@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <167c2511-349f-a8e6-17d1-f7ce438b2f14@fb.com>
Date: Tue, 22 Nov 2016 08:53:00 -0700
MIME-Version: 1.0
In-Reply-To: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "open
	list:NVM EXPRESS TARGET DRIVER" <linux-nvme@lists.infradead.org>,
	Keith Busch <keith.busch@intel.com>, "open
	list:DEVICE-MAPPER \(LVM\)" <dm-devel@redhat.com>, "open
	list:TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	Hannes Reinecke <hare@suse.com>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Guoqing, Christoph Hellwig <hch@infradead.org>,
	Mike Christie <mchristi@redhat.com>, Jiang <gqjiang@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Coly Li <colyli@suse.de>, "open
	list:SOFTWARE RAID \(Multiple Disks\) SUPPORT"
	<linux-raid@vger.kernel.org>, "open
	list:BCACHE \(BLOCK LAYER CACHE\)" <linux-bcache@vger.kernel.org>,
	linux-block@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"open list:LogFS" <logfs@logfs.org>,
	Zheng Liu <wenqing.lz@taobao.com>, linux-fsdevel@vger.kernel.org,
	Eric Wheeler <git@linux.ewheeler.net>
Subject: Re: [Drbd-dev] [PATCH 00/12] block: cleanup direct access to bvec
	table
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

On 11/11/2016 05:05 AM, Ming Lei wrote:
> Hi,
>
> This patchset cleans up direct access to bvec table.
>
> The 1st patch passes bvec table to bio_init(), so that
> direct access to bvec table in bio initialization is avoided.
>
> For other patches, most of them uses bio_add_page()
> to replace hardcode style of adding page to bvec,
> and others avoids to access bio->bi_vcnt.
>
> The most special one is to use bvec iterator helpers
> to implement .get_page/.next_page for dm-io.c
>
> One big motivation is to prepare for supporting multipage
> bvec, but this patchset is one good cleanup too even not
> for that purpose.

I've added the series, except 6-8, the dm parts. I updated some of the
descriptions/subjects to read a little better.

-- 
Jens Axboe

