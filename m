Return-Path: <konishi.ryusuke@gmail.com>
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
	[209.85.167.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 677E54201F8
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 22:38:18 +0100 (CET)
Received: by mail-lf1-f51.google.com with SMTP id x11so7947277lfa.2
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20220124091107.642561-1-hch@lst.de>
	<20220124091107.642561-3-hch@lst.de>
In-Reply-To: <20220124091107.642561-3-hch@lst.de>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 28 Jan 2022 06:38:05 +0900
Message-ID: <CAKFNMomoLqbbOwg5d6aBHCyGT5v+NF=N2Rm3QwYk8NDXsoJHtA@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-nilfs <linux-nilfs@vger.kernel.org>,
	Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
	device-mapper development <dm-devel@redhat.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev,
	Jack Wang <jinpu.wang@ionos.com>, Pavel Begunkov <asml.silence@gmail.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 02/19] nilfs2: remove nilfs_alloc_seg_bio
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

On Mon, Jan 24, 2022 at 6:11 PM Christoph Hellwig <hch@lst.de> wrote:
>
> bio_alloc will never fail when it can sleep.  Remove the now simple
> nilfs_alloc_seg_bio helper and open code it in the only caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nilfs2/segbuf.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks!

Ryusuke Konishi
