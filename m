Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D76CD1056446
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 17:02:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C68BC4208ED
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 17:02:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id p33Sylxapqg3 for <drbd-dev@lists.linbit.com>;
	Tue,  2 Aug 2016 17:02:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A63DD421D8E
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 17:02:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ErNdFKuRPdM3 for <drbd-dev@lists.linbit.com>;
	Tue,  2 Aug 2016 17:02:57 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 7A3524208ED
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 17:02:57 +0200 (CEST)
Date: Tue, 2 Aug 2016 17:02:56 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160802150256.GE51653@rck.sh>
References: <20160802140952.27683-1-mmazur@axeos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160802140952.27683-1-mmazur@axeos.com>
Subject: Re: [Drbd-dev] [PATCH] Fix systemd service file
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

On Tue, Aug 02, 2016 at 04:09:52PM +0200, mmazur@axeos.com wrote:
> From: Mariusz Mazur <mmazur@axeos.com>
> 
> Previous commit introduced an issue by putting PrivateTmp in the
> [Install] section.
> ---
>  conf/drbdmanaged.service | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/conf/drbdmanaged.service b/conf/drbdmanaged.service
> index af2b141..ae03c37 100644
> --- a/conf/drbdmanaged.service
> +++ b/conf/drbdmanaged.service
> @@ -6,8 +6,7 @@ Requires=dbus.service
>  [Service]
>  ExecStart=/usr/bin/dbus-drbdmanaged-service
>  User=root
> +PrivateTmp=yes
>  
>  [Install]
>  WantedBy=multi-user.target
> -
> -PrivateTmp=yes
> -- 
> 2.9.2

Thanks, applied to internal repo, will be visible public eventually.

Regards, rck
