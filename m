Return-Path: <jinpu.wang@ionos.com>
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
	[209.85.208.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1ED834201E2
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jan 2022 09:46:34 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id f21so25441636eds.11
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jan 2022 00:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20220118071952.1243143-1-hch@lst.de>
	<20220118071952.1243143-11-hch@lst.de>
	<CAMGffEmFZB1PPE09bfxQjKw-tJhdprEkF-OWrVF4Kjsf1OwQ_g@mail.gmail.com>
	<20220120083746.GA5622@lst.de>
In-Reply-To: <20220120083746.GA5622@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 20 Jan 2022 09:46:23 +0100
Message-ID: <CAMGffE=+ENBdRfugG4k3yB_ca3rqwnaKFXC4+8=CZ=LGvggA6w@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
	dm-devel@redhat.com, "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/19] rnbd-srv: simplify bio mapping in
	process_rdma
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

On Thu, Jan 20, 2022 at 9:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 19, 2022 at 01:20:54AM +0100, Jinpu Wang wrote:
> > this changes lead to IO error all the time, because bio_add_page return len.
> > We need  if (bio_add_page(bio, virt_to_page(data), datalen,
> >                      offset_in_page(data)) < datalen)
>
> Does this version look good to you?
>
> http://git.infradead.org/users/hch/block.git/commitdiff/62adb08e765b889dd8db4227cad33a710e36d631

Yes, lgtm, thank you!
Reviewed-by: Jack Wang <jinpu.wang@ionons.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
