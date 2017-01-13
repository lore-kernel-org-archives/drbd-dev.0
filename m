Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 41176105630C
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2017 10:00:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EC32C46232E
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2017 10:00:56 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qen60VfGCpRG for <drbd-dev@lists.linbit.com>;
	Fri, 13 Jan 2017 10:00:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C487246232D
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2017 10:00:56 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hSgQF0JNYTz5 for <drbd-dev@lists.linbit.com>;
	Fri, 13 Jan 2017 10:00:56 +0100 (CET)
Received: from localhost (213-47-144-126.static.upcbusiness.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 969D8462313
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2017 10:00:56 +0100 (CET)
Date: Fri, 13 Jan 2017 10:00:56 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170113090055.GE47371@rck.sh>
References: <1484288158-25952-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484288158-25952-1-git-send-email-nwang@suse.com>
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
> Signed-off-by: Nick Wang <nwang@suse.com>
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: Roland Kammerer <roland.kammerer@linbit.com>
> CC: drbd-dev@lists.linbit.com 
> 
> ---
>  user/shared/drbdmeta.c | 1 +
>  1 file changed, 1 insertion(+)
> 
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
>  
> -- 
> 1.8.5.6

Looks good to me, we do the same if we initialize v9 meta data, but so
far we did not do it when we converted.

Thanks, rck
