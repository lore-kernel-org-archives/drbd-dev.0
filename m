Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8FA131051881
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2017 12:03:46 +0100 (CET)
Date: Fri, 13 Jan 2017 12:03:45 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20170113110345.GA9172@soda.linbit>
References: <1484288158-25952-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484288158-25952-1-git-send-email-nwang@suse.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Fix the default node id
 initialization when upgrade v8 to v9
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

On Fri, Jan 13, 2017 at 02:15:58PM +0800, Nick Wang wrote:
> Node id will be initialized as "0" in md_convert_08_to_09() when upgrading to drbd9 
> (still using two nodes without changing configuration like expliciting set the node id). 

With DRBD 9, you *have* to set the node id in the configuration.
If there is a way around that, we need to fix it.

Also, IMO, in virtually all 8 -> 9 upgrade scenarios, you are better off
creating new DRBD 9 meta data instead of trying to "convert".

Still; your suggestion seems sensible enough.

Thanks,
    Lars

> diff --git a/user/shared/drbdmeta.c b/user/shared/drbdmeta.c
> index 9a28984..e2a9606 100644
> --- a/user/shared/drbdmeta.c
> +++ b/user/shared/drbdmeta.c
> @@ -3868,6 +3868,7 @@ void md_convert_08_to_09(struct format *cfg)
>  
>  	cfg->md.flags &= ~(MDF_CONNECTED_IND | MDF_FULL_SYNC | MDF_PEER_OUT_DATED);
>  
> +	cfg->md.node_id = -1;
>  	cfg->md.magic = DRBD_MD_MAGIC_09;
>  	re_initialize_md_offsets(cfg);
