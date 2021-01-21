Return-Path: <julian.calaby@gmail.com>
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
	[209.85.218.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E5F6342063D
	for <drbd-dev@lists.linbit.com>; Thu, 21 Jan 2021 04:01:50 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id gx5so558549ejb.7
	for <drbd-dev@lists.linbit.com>; Wed, 20 Jan 2021 19:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 21 Jan 2021 14:00:38 +1100
Message-ID: <CAGRGNgWLspr6M1COgX9cuDDgYdiXvQQjWQb7XYLsmFpfMYt0sA@mail.gmail.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, snitzer@redhat.com,
	gustavo@embeddedor.com, linux-nvme@lists.infradead.org,
	philipp.reisner@linbit.com, song@kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, adilger.kernel@dilger.ca,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com,
	drbd-dev@lists.linbit.com, naohiro.aota@wdc.com,
	sagi@grimberg.me, Linux SCSI List <linux-scsi@vger.kernel.org>,
	darrick.wong@oracle.com, osandov@fb.com,
	cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
	kent.overstreet@gmail.com, josef@toxicpanda.com,
	Denis Efremov <efremov@linux.com>, colyli@suse.de,
	linux-raid@vger.kernel.org, rpeterso@redhat.com,
	linux-bcache@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	dsterba@suse.com, bvanassche@acm.org, agruenba@redhat.com,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	damien.lemoal@wdc.com, tytso@mit.edu,
	"Martin K. Petersen" <martin.petersen@oracle.com>, clm@fb.com,
	LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
	jefflexu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, lars.ellenberg@linbit.com,
	jth@kernel.org, asml.silence@gmail.com, linux-btrfs@vger.kernel.org
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

Hi Chaitanya,

On Tue, Jan 19, 2021 at 5:01 PM Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
>
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
>  38 files changed, 124 insertions(+), 236 deletions(-)

On a more abstract note, I don't think this diffstat is actually
illustrating the benefits of this as much as you think it is.

Yeah, we've reduced the code by 112 lines, but that's barely half the
curn here. It looks, from the diffstat, that you've effectively
reduced 2 lines into 1. That isn't much of a saving.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
