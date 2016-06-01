Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3309D1056446
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 213F14202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:15 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ClTeyt8j7fab for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F1978420305
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:14 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K7AmZVrbeeYR for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:14 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id CA46B4202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:14 +0200 (CEST)
Resent-Message-ID: <20160610114614.GP3235@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 919731056445
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2016 14:38:43 +0200 (CEST)
Received: from mail-yw0-f180.google.com ([209.85.161.180])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1b85Q2-0003h7-K5
	for drbd-dev@lists.linbit.com; Wed, 01 Jun 2016 12:38:42 +0000
Received: by mail-yw0-f180.google.com with SMTP id o16so16589524ywd.2
	for <drbd-dev@lists.linbit.com>; Wed, 01 Jun 2016 05:38:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160531155348.GA24840@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160531155348.GA24840@redhat.com>
Date: Wed, 1 Jun 2016 20:38:41 +0800
Message-ID: <CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-block@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
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

On Tue, May 31, 2016 at 11:53 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Mon, May 30 2016 at  9:34am -0400,
> Ming Lei <ming.lei@canonical.com> wrote:
>
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
>>
>> V6:
>>       - rebased on v4.7-rc1
>>       - add reviewed-by tag
>>       - mark BIO_MAX_SIZE as obsolete instead of removing because
>>       dm-tree adds one usage now
>
> Not sure what you're referring to here with "dm-tree" (since "dm-tree"
> doesn't exist).  But only direct user of "BIO_MAX_SIZE" in DM appears to

Looks it is from crypto tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6

> be dm-crypt.c.  Maybe you've identified some indirect use of
> BIO_MAX_SIZE?

I mean the recently introduced BIO_MAX_SIZE in -next tree:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/md/dm-crypt.c?id=4ed89c97b0706477b822ea2182827640c0cec486

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
