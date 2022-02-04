Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B541D4201F8
	for <drbd-dev@lists.linbit.com>; Fri,  4 Feb 2022 15:43:39 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
	g15-20020a17090a67cf00b001b7d5b6bedaso6299669pjm.4
	for <drbd-dev@lists.linbit.com>; Fri, 04 Feb 2022 06:43:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
Message-Id: <164398581785.446137.16953674702943074856.b4-ty@kernel.dk>
Date: Fri, 04 Feb 2022 07:43:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] improve the bio cloning interface v2
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

On Wed, 2 Feb 2022 17:00:56 +0100, Christoph Hellwig wrote:
> this series changes the bio cloning interface to match the rest changes
> to the bio allocation interface and passes the block_device and operation
> to the cloning helpers.  In addition it renames the cloning helpers to
> be more descriptive.
> 
> To get there it requires a bit of refactoring in the device mapper code.
> 
> [...]

Applied, thanks!

[01/13] drbd: set ->bi_bdev in drbd_req_new
        commit: c347a787e34cba0e5a80a04082dacaf259105605
[02/13] dm: add a clone_to_tio helper
        commit: 6c23f0bd7f16d88c774db37b30c5da82811c41be
[03/13] dm: fold clone_bio into __clone_and_map_data_bio
        commit: b1bee79237ce0ab43ef7fe66aa6e5c4783165012
[04/13] dm: fold __send_duplicate_bios into __clone_and_map_simple_bio
        commit: 8eabf5d0a7bd9226d6cc25402dde67f372aae838
[05/13] dm: move cloning the bio into alloc_tio
        commit: dc8e2021da71f6b2d5971f98ee3e528cf30c409c
[06/13] dm: pass the bio instead of tio to __map_bio
        commit: 1561b396106d759fdf5f9a71b412e068f74d2cc9
[07/13] dm: retun the clone bio from alloc_tio
        commit: 1d1068cecff70cb8e48c7cb0ba27cc3fd906eb31
[08/13] dm: simplify the single bio fast path in __send_duplicate_bios
        commit: 891fced644a7529bfd4b1436b2341527ce8f68ad
[09/13] dm-cache: remove __remap_to_origin_clear_discard
        commit: 3c4b455ef8acdacd0e5ecd33428d4f32f861637a
[10/13] block: clone crypto and integrity data in __bio_clone_fast
        commit: 56b4b5abcdab6daf71c5536fca2772f178590e06
[11/13] dm: use bio_clone_fast in alloc_io/alloc_tio
        commit: 92986f6b4c8a2c24d3a36b80140624f80fd93de4
[12/13] block: initialize the target bio in __bio_clone_fast
        commit: a0e8de798dd6710a69d69ec57b246a0e34c4a695
[13/13] block: pass a block_device to bio_clone_fast
        commit: abfc426d1b2fb2176df59851a64223b58ddae7e7

Best regards,
-- 
Jens Axboe


