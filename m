Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7019D1056F9D
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jan 2018 06:03:00 +0100 (CET)
Message-Id: <5A6F1B3402000070000DBB3A@prv-mh.provo.novell.com>
Date: Sun, 28 Jan 2018 22:01:40 -0700
From: "Nick Wang" <nwang@suse.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
References: <20180125062729.4142-1-nwang@suse.com>
	<1621611.JSGMFM0nhf@fat-tyre>
In-Reply-To: <1621611.JSGMFM0nhf@fat-tyre>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Drbd-dev] [PATCH] drbdadm: Fix does not allocate bitmap for
 stacked res
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

Hi Philipp,

Your fix working perfectly in my test scenario.

Best regards,
Nick

>>> On 1/26/2018 at 11:26 下午, in message <1621611.JSGMFM0nhf@fat-tyre>, Philipp
Reisner <philipp.reisner@linbit.com> wrote:
> Hi Nick,
> 
> regarding you proposed patch, instead of special casing
> the code we should rather fix the data structure.
> 
> I will give it a bit more testing before I push it to the master.
> Please let me know if that works for your test-cases.
> 
> best regards,
>  Phil
> 
> From b5eab810ded459792c24a4bc5db5ce272ea1ee15 Mon Sep 17 00:00:00 2001
> From: Philipp Reisner <philipp.reisner@linbit.com>
> Date: Fri, 26 Jan 2018 16:09:01 +0100
> Subject: [PATCH] v9,drbdadm,stacking: Fix setting the disk in stacked host
>  sections
> 
> This got broken on the long way from drbd-8.4 to 9.
> ---
>  user/v9/drbdadm_postparse.c | 73 ++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/user/v9/drbdadm_postparse.c b/user/v9/drbdadm_postparse.c
> index dde0a5e..f223dbe 100644
> --- a/user/v9/drbdadm_postparse.c
> +++ b/user/v9/drbdadm_postparse.c
> @@ -514,9 +514,9 @@ void set_peer_in_resource(struct d_resource* res, int 
> peer_required)
>                 add_no_bitmap_opt(res);
>  }
>  
> -void set_disk_in_res(struct d_resource *res)
> +void set_stacked_disk_in_res(struct d_resource *res)
>  {
> -       struct d_host_info *host;
> +       struct d_host_info *host, *lower_host;
>         struct d_volume *a, *b;
>  
>         if (res->ignore)
> @@ -526,41 +526,40 @@ void set_disk_in_res(struct d_resource *res)
>                 if (!host->lower)
>                         continue;
>  
> -               if (host->lower->ignore)
> -                       continue;
> -
> -               check_volume_sets_equal(res, host, host->lower->me);
> -               if (!config_valid)
> -                       /* don't even bother for broken config. */
> -                       continue;
> +               for_each_host(lower_host, &host->lower->all_hosts) {
> +                       check_volume_sets_equal(res, host, lower_host);
> +                       if (!config_valid)
> +                               /* don't even bother for broken config. */
> +                               continue;
>  
> -               /* volume lists are sorted on vnr */
> -               a = STAILQ_FIRST(&host->volumes);
> -               b = STAILQ_FIRST(&host->lower->me->volumes);
> -               while (a) {
> -                       while (b && a->vnr > b->vnr) {
> -                               /* Lower resource has more volumes.
> -                                * Probably unusual, but we decided
> -                                * that it should be legal.
> -                                * Skip those that do not match */
> -                               b = STAILQ_NEXT(b, link);
> -                       }
> -                       if (a && b && a->vnr == b->vnr) {
> -                               if (b->device)
> -                                       m_asprintf(&a->disk, "%s", b->device);
> -                               else
> -                                       m_asprintf(&a->disk, "/dev/drbd%u", 
> b->device_minor);
> -                               /* stacked implicit volumes need internal 
> meta data, too */
> -                               if (!a->meta_disk)
> -                                       m_asprintf(&a->meta_disk, "internal");
> -                               if (!a->meta_index)
> -                                       m_asprintf(&a->meta_index, "internal");
> -                               a = STAILQ_NEXT(a, link);
> -                               b = STAILQ_NEXT(b, link);
> -                       } else {
> -                               /* config_invalid should have been set
> -                                * by check_volume_sets_equal */
> -                               assert(0);
> +                       /* volume lists are sorted on vnr */
> +                       a = STAILQ_FIRST(&host->volumes);
> +                       b = STAILQ_FIRST(&lower_host->volumes);
> +                       while (a) {
> +                               while (b && a->vnr > b->vnr) {
> +                                       /* Lower resource has more volumes.
> +                                        * Probably unusual, but we decided
> +                                        * that it should be legal.
> +                                        * Skip those that do not match */
> +                                       b = STAILQ_NEXT(b, link);
> +                               }
> +                               if (a && b && a->vnr == b->vnr) {
> +                                       if (b->device)
> +                                               m_asprintf(&a->disk, "%s", 
> b->device);
> +                                       else
> +                                               m_asprintf(&a->disk, 
> "/dev/drbd%u", b->device_minor);
> +                                       /* stacked implicit volumes need 
> internal meta data, too */
> +                                       if (!a->meta_disk)
> +                                               m_asprintf(&a->meta_disk, 
> "internal");
> +                                       if (!a->meta_index)
> +                                               m_asprintf(&a->meta_index, 
> "internal");
> +                                       a = STAILQ_NEXT(a, link);
> +                                       b = STAILQ_NEXT(b, link);
> +                               } else {
> +                                       /* config_invalid should have been 
> set
> +                                        * by check_volume_sets_equal */
> +                                       assert(0);
> +                               }
>                         }
>                 }
>         }
> @@ -1161,7 +1160,7 @@ void post_parse(struct resources *resources, enum 
> pp_flags flags)
>         // Needs "me" set already
>         for_each_resource(res, resources)
>                 if (res->stacked_on_one)
> -                       set_disk_in_res(res);
> +                       set_stacked_disk_in_res(res);
>  
>         for_each_resource(res, resources)
>                 fixup_peer_devices(res);
 
