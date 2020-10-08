Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EB459420FED
	for <drbd-dev@lists.linbit.com>; Thu,  8 Oct 2020 22:17:46 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id r21so1919205pgj.5
	for <drbd-dev@lists.linbit.com>; Thu, 08 Oct 2020 13:17:46 -0700 (PDT)
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Christoph Hellwig
	<hch@lst.de>, dm-devel@redhat.com,
	open list <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>, drbd-dev@lists.linbit.com,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
	<linux-ide@vger.kernel.org>, linux-raid@vger.kernel.org,
	linux-mmc <linux-mmc@vger.kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	lkft-triage@lists.linaro.org
References: <CA+G9fYtwisRJtN4ht=ApeWc1jWssDok-7y2wee6Z0kzMP-atKg@mail.gmail.com>
	<CA+G9fYseTYRWoHUNZ=j4mjFs9dDJ-KOD8hDy+RnyDPx75HcVWw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <24c8ee4d-d5f7-e49f-cd0c-7cf50a5fd885@kernel.dk>
Date: Thu, 8 Oct 2020 14:17:41 -0600
MIME-Version: 1.0
In-Reply-To: <CA+G9fYseTYRWoHUNZ=j4mjFs9dDJ-KOD8hDy+RnyDPx75HcVWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Hannes Reinecke <hare@suse.de>, martin.petersen@oracle.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [Drbd-dev] [ Regressions ] linux next 20201008:
 blk_update_request: I/O error, dev sda,
 sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
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

On 10/8/20 2:05 PM, Naresh Kamboju wrote:
> On Thu, 8 Oct 2020 at 23:41, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> There are two major regressions noticed on linux next tag 20201008.
>> I will bisect this problem and get back to you.
> 
> Reverting scsi: patch set on  linux next tag 20201008 fixed reported problems.
> git revert --no-edit 653eb7c99d84..ed7fb2d018fd

Just for everyones edification, that would be these 9 patches from the
SCSI tree:

Christoph Hellwig (9):
      scsi: core: Don't export scsi_device_from_queue()
      scsi: core: Remove scsi_init_cmd_errh
      scsi: core: Move command size detection out of the fast path
      scsi: core: Use rq_dma_dir in scsi_setup_cmnd()
      scsi: core: Rename scsi_prep_state_check() to scsi_device_state_check()
      scsi: core: Rename scsi_mq_prep_fn() to scsi_prepare_cmd()
      scsi: core: Clean up allocation and freeing of sgtables
      scsi: core: Remove scsi_setup_cmnd() and scsi_setup_fs_cmnd()
      scsi: core: Only start the request just before dispatching

-- 
Jens Axboe

