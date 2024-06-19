Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
	[209.85.215.178])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9B8E64202C2
	for <drbd-dev@lists.linbit.com>; Wed, 19 Jun 2024 16:18:44 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
	41be03b00d2f7-6f86dcadb14so170632a12.1
	for <drbd-dev@lists.linbit.com>; Wed, 19 Jun 2024 07:18:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240617060532.127975-1-hch@lst.de>
References: <20240617060532.127975-1-hch@lst.de>
Subject: Re: move features flags into queue_limits v2
Message-Id: <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Date: Wed, 19 Jun 2024 08:18:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
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


On Mon, 17 Jun 2024 08:04:27 +0200, Christoph Hellwig wrote:
> this is the third and last major series to convert settings to
> queue_limits for this merge window.  After a bunch of prep patches to
> get various drivers in shape, it moves all the queue_flags that specify
> driver controlled features into the queue limits so that they can be
> set atomically and are separated from the blk-mq internal flags.
> 
> Note that I've only Cc'ed the maintainers for drivers with non-mechanical
> changes as the Cc list is already huge.
> 
> [...]

Applied, thanks!

[01/26] xen-blkfront: don't disable cache flushes when they fail
        commit: dd9300e9eaeeb212f77ffeb72d1d8756107f1f1f
[02/26] sd: remove sd_is_zoned
        commit: be60e7700e6df1e16a2f60f45bece08e6140a46d
[03/26] sd: move zone limits setup out of sd_read_block_characteristics
        commit: 308ad58af49d6c4c3b7a36b98972cc9db4d7b36a
[04/26] loop: stop using loop_reconfigure_limits in __loop_clr_fd
        commit: c9055b44abe60da69aa4ee4fdcb78ee7fe733335
[05/26] loop: always update discard settings in loop_reconfigure_limits
        commit: ae0d40ff49642651f969883ef9fc79d69c1632d7
[06/26] loop: regularize upgrading the block size for direct I/O
        commit: a17ece76bcfe7b86327b19cae1652d7c62068a30
[07/26] loop: also use the default block size from an underlying block device
        commit: 4ce37fe0938b02b7b947029c40b72d76a22a3882
[08/26] loop: fold loop_update_rotational into loop_reconfigure_limits
        commit: 97dd4a43d69b74a114be466d6887e257971adfe9
[09/26] virtio_blk: remove virtblk_update_cache_mode
        commit: bbe5c84122b35c37f2706872fe34da66f0854b56
[10/26] nbd: move setting the cache control flags to __nbd_set_size
        commit: 6b377787a306253111404325aee98005b361e59a
[11/26] block: freeze the queue in queue_attr_store
        commit: af2814149883e2c1851866ea2afcd8eadc040f79
[12/26] block: remove blk_flush_policy
        commit: 70905f8706b62113ae32c8df721384ff6ffb6c6a
[13/26] block: move cache control settings out of queue->flags
        commit: 1122c0c1cc71f740fa4d5f14f239194e06a1d5e7
[14/26] block: move the nonrot flag to queue_limits
        commit: bd4a633b6f7c3c6b6ebc1a07317643270e751a94
[15/26] block: move the add_random flag to queue_limits
        commit: 39a9f1c334f9f27b3b3e6d0005c10ed667268346
[16/26] block: move the io_stat flag setting to queue_limits
        commit: cdb2497918cc2929691408bac87b58433b45b6d3
[17/26] block: move the stable_writes flag to queue_limits
        commit: 1a02f3a73f8c670eddeb44bf52a75ae7f67cfc11
[18/26] block: move the synchronous flag to queue_limits
        commit: aadd5c59c910427c0464c217d5ed588ff14e2502
[19/26] block: move the nowait flag to queue_limits
        commit: f76af42f8bf13d2620084f305f01691de9238fc7
[20/26] block: move the dax flag to queue_limits
        commit: f467fee48da4500786e145489787b37adae317c3
[21/26] block: move the poll flag to queue_limits
        commit: 8023e144f9d6e35f8786937e2f0c2fea0aba6dbc
[22/26] block: move the zoned flag into the features field
        commit: b1fc937a55f5735b98d9dceae5bb6ba262501f56
[23/26] block: move the zone_resetall flag to queue_limits
        commit: a52758a39768f441e468a41da6c15a59d6d6011a
[24/26] block: move the pci_p2pdma flag to queue_limits
        commit: 9c1e42e3c876c66796eda23e79836a4d92613a61
[25/26] block: move the skip_tagset_quiesce flag to queue_limits
        commit: 8c8f5c85b20d0a7dc0ab9b2a17318130d69ceb5a
[26/26] block: move the bounce flag into the features field
        commit: 339d3948c07b4aa2940aeb874294a7d6782cec16

Best regards,
-- 
Jens Axboe



