Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BFE051056445
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:33:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B06D040C553
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:33:39 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id L7v3NsjR9tk5 for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 10:33:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8FE7140C556
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:33:39 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EIxNtvjlSxMT for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 10:33:39 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 0C9CD40C553
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 10:33:39 +0200 (CEST)
Resent-Message-ID: <20160421083338.GM3078@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C81081056442
	for <drbd-dev@lists.linbit.com>; Fri, 15 Apr 2016 00:22:35 +0200 (CEST)
Received: from mail-yw0-f174.google.com ([209.85.161.174])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1aqpek-0005IT-0W
	for drbd-dev@lists.linbit.com; Thu, 14 Apr 2016 22:22:34 +0000
Received: by mail-yw0-f174.google.com with SMTP id i84so119137512ywc.2
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 15:22:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <570FA4F7.6020301@kernel.dk>
References: <1460634438-26530-1-git-send-email-ming.lei@canonical.com>
	<570FA4F7.6020301@kernel.dk>
Date: Fri, 15 Apr 2016 06:22:33 +0800
Message-ID: <CACVXFVN5ifhRiyW8ovugYrwVE_p8DOsLXW_fZ95WV0+54w0mGw@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	Jens Axboe <axboe@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v4 0/8] block: prepare for multipage bvecs
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

On Thu, Apr 14, 2016 at 10:11 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 04/14/2016 05:46 AM, Ming Lei wrote:
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
>> 2) remove BIO_MAX_SECTORS & BIO_MAX_SIZE, and now there is only
>> one user for each. Once multipage bvecs is introduced, one bio
>> may hold lots of sectors, and we should always use sort of BIO_MAX_VECS
>> which should be introduced in future and is similiar with current
>> BIO_MAX_PAGES.
>>
>> xfstests(-a auto) have been run over ext4/xfs and no regression found
>> by this patchset.
>
>
> We've had too many disasters in the block layer the last few series, I'm
> making the 4.7 round a nice and small one. I don't mind taking prep patches
> for the multipage bvecs, if they are simple and clean, but that's about the
> extent of it.
>
> Just a heads up.

Jens, thanks for your response, and understood your concerns.

Please hold on this patchset, and I will check it further and make it
better.

Thanks,
