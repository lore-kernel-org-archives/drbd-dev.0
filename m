Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DE4511056469
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D52B54202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Guydzb8FtJ8N for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B56FB420305
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ed_4oiYjkvAb for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:17 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8ADE14202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:17 +0200 (CEST)
Resent-Message-ID: <20160610114617.GR3235@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C495F1056445
	for <drbd-dev@lists.linbit.com>; Thu,  2 Jun 2016 04:13:20 +0200 (CEST)
Received: from mail-yw0-f171.google.com ([209.85.161.171])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1b8I8N-0005Be-8x
	for drbd-dev@lists.linbit.com; Thu, 02 Jun 2016 02:13:19 +0000
Received: by mail-yw0-f171.google.com with SMTP id o16so36833889ywd.2
	for <drbd-dev@lists.linbit.com>; Wed, 01 Jun 2016 19:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160601135150.GA30759@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160531155348.GA24840@redhat.com>
	<CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
	<20160601134427.GA15888@infradead.org>
	<20160601135150.GA30759@redhat.com>
Date: Thu, 2 Jun 2016 10:13:18 +0800
Message-ID: <CACVXFVNFH7zYOG+RsCNEXuxLE+ybq1qbLk6h=keN19LWsKT2mw@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <axboe@fb.com>, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sagi Grimberg <sagig@mellanox.com>, NeilBrown <neilb@suse.com>,
	Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <ejt@redhat.com>, linux-block@vger.kernel.org,
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

On Wed, Jun 1, 2016 at 9:51 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Wed, Jun 01 2016 at  9:44am -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
>
>> On Wed, Jun 01, 2016 at 08:38:41PM +0800, Ming Lei wrote:
>> > > be dm-crypt.c.  Maybe you've identified some indirect use of
>> > > BIO_MAX_SIZE?
>> >
>> > I mean the recently introduced BIO_MAX_SIZE in -next tree:
>> >
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/md/dm-crypt.c?id=4ed89c97b0706477b822ea2182827640c0cec486
>>
>> The crazy bcache bios striking back once again.  I really think it's
>> harmful having a _MAX value and then having a minor driver
>> reinterpreting it and sending larger ones.  Until we can lift the
>> maximum limit in general nad have common code exercise it we really need
>> to stop bcache from sending these instead of littering the tree with
>> workarounds.
>
> So should I not push this type of fix to Linus now?  I was going to send
> the above commit and this one to him this week:
> https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.7&id=57b3001b240629ecc5266d28c845e23ca5f11719

I don't suggest this kind of fix.

That fix should be in bcache or blk-core instead of other places.
Last time, I sent out the following fix([PATCH v1] block: make sure big bio is
splitted into at most 256 bvecs):

     https://lkml.org/lkml/2016/4/5/1046

But forget to clear the flag of REQ_NOMERGE for this case.

If Jens doesn't mind doing such thing in block-core, I can post v2
for this issue.

>
> Instead, should bcache be made to not do what it is doing?

It depends on if bcache is the only user of this kind of usage.
In theory, any driver can use external bvec table.

Thanks,
Ming
