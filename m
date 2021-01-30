Return-Path: <willy@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 100EE420341
	for <drbd-dev@lists.linbit.com>; Sat, 30 Jan 2021 04:57:04 +0100 (CET)
Date: Sat, 30 Jan 2021 03:56:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20210130035646.GH308988@casper.infradead.org>
References: <20210126145247.1964410-1-hch@lst.de>
	<20210126145247.1964410-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126145247.1964410-5-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
	dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-nilfs@vger.kernel.org,
	Chao Yu <chao@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 04/17] block: split bio_kmalloc from
	bio_alloc_bioset
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

On Tue, Jan 26, 2021 at 03:52:34PM +0100, Christoph Hellwig wrote:
> bio_kmalloc shares almost no logic with the bio_set based fast path
> in bio_alloc_bioset.  Split it into an entirely separate implementation.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 167 ++++++++++++++++++++++----------------------
>  include/linux/bio.h |   6 +-
>  2 files changed, 86 insertions(+), 87 deletions(-)

This patch causes current linux-next to OOM for me when running xfstests
after about ten minutes.  Haven't looked into why yet, this is just the
results of a git bisect.

The qemu command line is:

qemu-system-x86_64 -nodefaults -nographic -cpu host -machine accel=3Dkvm,nv=
dimm -m 2G,slots=3D8,maxmem=3D1T -smp 6 -kernel /home/willy/kernel/folio/.b=
uild_test_kernel-x86_64/kpgk/vmlinuz -append console=3Dhvc0 root=3D/dev/sda=
 rw log_buf_len=3D8M ktest.dir=3D/home/willy/kernel/ktest ktest.env=3D/tmp/=
build-test-kernel-nJO6QgxOmo/env quiet systemd.show_status=3D0 systemd.log-=
target=3Djournal crashkernel=3D128M no_console_suspend -device virtio-seria=
l -chardev stdio,id=3Dconsole -device virtconsole,chardev=3Dconsole -serial=
 unix:/tmp/build-test-kernel-nJO6QgxOmo/vm-kgdb,server,nowait -monitor unix=
:/tmp/build-test-kernel-nJO6QgxOmo/vm-mon,server,nowait -gdb unix:/tmp/buil=
d-test-kernel-nJO6QgxOmo/vm-gdb,server,nowait -device virtio-rng-pci -virtf=
s local,path=3D/,mount_tag=3Dhost,security_model=3Dnone -device virtio-scsi=
-pci,id=3Dhba -nic user,model=3Dvirtio,hostfwd=3Dtcp:127.0.0.1:24674-:22 -d=
rive if=3Dnone,format=3Draw,id=3Ddisk0,file=3D/var/lib/ktest/root.amd64,sna=
pshot=3Don -device scsi-hd,bus=3Dhba.0,drive=3Ddisk0 -drive if=3Dnone,forma=
t=3Draw,id=3Ddisk1,file=3D/tmp/build-test-kernel-nJO6QgxOmo/dev-1,cache=3Du=
nsafe -device scsi-hd,bus=3Dhba.0,drive=3Ddisk1 -drive if=3Dnone,format=3Dr=
aw,id=3Ddisk2,file=3D/tmp/build-test-kernel-nJO6QgxOmo/dev-2,cache=3Dunsafe=
 -device scsi-hd,bus=3Dhba.0,drive=3Ddisk2 -drive if=3Dnone,format=3Draw,id=
=3Ddisk3,file=3D/tmp/build-test-kernel-nJO6QgxOmo/dev-3,cache=3Dunsafe -dev=
ice scsi-hd,bus=3Dhba.0,drive=3Ddisk3

