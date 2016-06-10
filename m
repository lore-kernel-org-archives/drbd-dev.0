Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A982B1056446
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:45:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9C8584202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:45:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id G1yMLcmvFMvF for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:45:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7ADFF420301
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:45:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CvicJFi6sdCm for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:45:46 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 4FFE74202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:45:46 +0200 (CEST)
Resent-Message-ID: <20160610114545.GO3235@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 834291056445
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 04:44:37 +0200 (CEST)
Received: from mail-yw0-f170.google.com ([209.85.161.170])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1bBCR2-00075G-97
	for drbd-dev@lists.linbit.com; Fri, 10 Jun 2016 02:44:36 +0000
Received: by mail-yw0-f170.google.com with SMTP id z186so36952794ywd.2
	for <drbd-dev@lists.linbit.com>; Thu, 09 Jun 2016 19:44:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <575993EA.3010005@kernel.dk>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<575993EA.3010005@kernel.dk>
From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 10 Jun 2016 10:44:34 +0800
Message-ID: <CACVXFVMbvqyEeX4NsuZLANCCQyxwr2_cjLrLT8tR9LUZkwejdg@mail.gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Cc: linux-block@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sagi Grimberg <sagig@mellanox.com>, NeilBrown <neilb@suse.com>,
	Jens Axboe <axboe@fb.com>, Joe Thornber <ejt@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Shaohua Li <shli@fb.com>,
	Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v6 0/8] block: prepare for multipage bvecs
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

On Fri, Jun 10, 2016 at 12:06 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 05/30/2016 07:34 AM, Ming Lei wrote:
>>
>> Hi,
>>
>> Interests[1] have been shown in multipage bvecs, so this patchset
>> try to prepare for the support and do two things:
>>
>> 1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
>> then we can drop the non-standard way for iterating bvec, which
>> can be thought as a good cleanup for lib/iov_iter.c
>>
>> 2) remove BIO_MAX_SECTORS and makre BIO_MAX_SIZE as obsolete, and
>> now there is only one user for each. Once multipage bvecs is introduced,
>> one bio may hold lots of sectors, and we should always use sort of
>> BIO_MAX_VECS which should be introduced in future and is similiar
>> with current BIO_MAX_PAGES.
>>
>> The only functional change is iterate_bvec():lib/iov_iter.c
>>
>> xfstests(-a auto) over loop aio is run for ext4/xfs to verify
>> the change and no regression found with this patchset.
>
>
> Added patches 1-7, still waiting for an answer on my reply to #8.

Thanks for adding patches 1-7, and now I just found the added
BIO_MAX_SIZE usage in dm-crypt.c is droped from next, so it is
safe to kill it now.

I will send a new patch #8 against for-4.8/core.

Thanks,
Ming

>
> --
> Jens Axboe
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
