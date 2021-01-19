Return-Path: <msnitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [216.205.24.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 42D4B42006E
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 15:20:47 +0100 (CET)
Date: Tue, 19 Jan 2021 09:14:22 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Message-ID: <20210119141422.GA23758@redhat.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
	gustavo@embeddedor.com, linux-nvme@lists.infradead.org,
	philipp.reisner@linbit.com, song@kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, adilger.kernel@dilger.ca,
	hch@lst.de, agk@redhat.com, drbd-dev@lists.linbit.com,
	naohiro.aota@wdc.com, sagi@grimberg.me,
	linux-scsi@vger.kernel.org, darrick.wong@oracle.com,
	osandov@fb.com, cluster-devel@redhat.com,
	linux-ext4@vger.kernel.org, kent.overstreet@gmail.com,
	josef@toxicpanda.com, efremov@linux.com, colyli@suse.de,
	linux-raid@vger.kernel.org, rpeterso@redhat.com,
	linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk,
	dsterba@suse.com, bvanassche@acm.org, agruenba@redhat.com,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	damien.lemoal@wdc.com, tytso@mit.edu, martin.petersen@oracle.com,
	clm@fb.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, jefflexu@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org, tj@kernel.org,
	lars.ellenberg@linbit.com, jth@kernel.org,
	asml.silence@gmail.com, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [RFC PATCH 00/37] block: introduce bio_init_fields()
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

On Tue, Jan 19 2021 at 12:05am -0500,
Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> wrote:

> Hi,
> 
> This is a *compile only RFC* which adds a generic helper to initialize
> the various fields of the bio that is repeated all the places in
> file-systems, block layer, and drivers.
> 
> The new helper allows callers to initialize various members such as
> bdev, sector, private, end io callback, io priority, and write hints.
> 
> The objective of this RFC is to only start a discussion, this it not 
> completely tested at all.                                                                                                            
> Following diff shows code level benefits of this helper :-
>  38 files changed, 124 insertions(+), 236 deletions(-)


Please no... this is just obfuscation.

Adding yet another field to set would create a cascade of churn
throughout kernel (and invariably many callers won't need the new field
initialized, so you keep passing 0 for more and more fields).

Nacked-by: Mike Snitzer <snitzer@redhat.com>

