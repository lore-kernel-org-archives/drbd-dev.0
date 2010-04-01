Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 36F50105B1A2
	for <drbd-dev@lists.linbit.com>; Thu,  1 Apr 2010 18:35:01 +0200 (CEST)
Resent-Message-ID: <20100401163459.GE32597@soda.linbit>
Received: from mail-pw0-f54.google.com (mail-pw0-f54.google.com
	[209.85.160.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 65177105B0D9
	for <drbd-dev@lists.linbit.com>; Thu,  1 Apr 2010 18:03:42 +0200 (CEST)
Received: by pwi9 with SMTP id 9so1120402pwi.27
	for <drbd-dev@lists.linbit.com>; Thu, 01 Apr 2010 09:03:41 -0700 (PDT)
Date: Thu, 1 Apr 2010 19:03:30 +0300
From: Dan Carpenter <error27@gmail.com>
To: akpm@linux-foundation.org
Message-ID: <20100401160330.GG5265@bicker>
References: <201003312250.o2VMoweK013539@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201003312250.o2VMoweK013539@imap1.linux-foundation.org>
Cc: jens.axboe@oracle.com, mm-commits@vger.kernel.org,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] + drbd-potential-null-dereference.patch added to -mm
	tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 31, 2010 at 03:50:58PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      drbd: fix potential null dereference
> has been added to the -mm tree.  Its filename is
>      drbd-potential-null-dereference.patch


Hi Andrew,

Could you drop this patch?  It turns out that "drbd" can never be NULL
there.  Philip Reisner has a patch that removes the check.

regards,
dan carpenter

> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: drbd: fix potential null dereference
> From: Dan Carpenter <error27@gmail.com>
> 
> If "e" is NULL then "bm_ext" would be NULL too.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
> Cc: Jens Axboe <jens.axboe@oracle.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/block/drbd/drbd_actlog.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/block/drbd/drbd_actlog.c~drbd-potential-null-dereference drivers/block/drbd/drbd_actlog.c
> --- a/drivers/block/drbd/drbd_actlog.c~drbd-potential-null-dereference
> +++ a/drivers/block/drbd/drbd_actlog.c
> @@ -1337,7 +1337,7 @@ int drbd_rs_del_all(struct drbd_conf *md
>  		for (i = 0; i < mdev->resync->nr_elements; i++) {
>  			e = lc_element_by_index(mdev->resync, i);
>  			bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
> -			if (bm_ext->lce.lc_number == LC_FREE)
> +			if (!bm_ext || bm_ext->lce.lc_number == LC_FREE)
>  				continue;
>  			if (bm_ext->lce.lc_number == mdev->resync_wenr) {
>  				dev_info(DEV, "dropping %u in drbd_rs_del_all, apparently"
> _
> 
> Patches currently in -mm which might be from error27@gmail.com are
> 
> linux-next.patch
> power_meter-acpi_device_class-power_meter_resource-too-long.patch
> dpt_i20-several-use-after-free-issues.patch
> sbshc-acpi_device_class-smbus_host_controller-too-long.patch
> acpi_pad-processor_aggregator-name-too-long.patch
> backlight-backlight_device_register-return-err_ptr.patch
> scsi-remove-superfluous-null-pointer-check-from-scsi_kill_request.patch
> iscsi-change-to.patch
> drbd-potential-null-dereference.patch
> musb-potential-use-after-free.patch
> dynamic_debug-small-cleanup-in-ddebug_proc_write.patch
> sis-strcpy-=-strlcpy.patch
> proc-cleanup-remove-unused-assignments.patch
