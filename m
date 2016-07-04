Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DD0E61056445
	for <drbd-dev@lists.linbit.com>; Mon,  4 Jul 2016 11:30:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C094F4038B5
	for <drbd-dev@lists.linbit.com>; Mon,  4 Jul 2016 11:30:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6ecpdflOW_kJ for <drbd-dev@lists.linbit.com>;
	Mon,  4 Jul 2016 11:30:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A323C4044CF
	for <drbd-dev@lists.linbit.com>; Mon,  4 Jul 2016 11:30:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QRJVAsbuD_bz for <drbd-dev@lists.linbit.com>;
	Mon,  4 Jul 2016 11:30:05 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id C9CE54038B5
	for <drbd-dev@lists.linbit.com>; Mon,  4 Jul 2016 11:30:05 +0200 (CEST)
Date: Mon, 4 Jul 2016 11:30:05 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160704093004.GK1324@rck.sh>
References: <1467109471-16112-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467109471-16112-1-git-send-email-nwang@suse.com>
Subject: Re: [Drbd-dev] [PATCH] drbdadm: Fix segfault while starting stacked
 resource in DRBD9
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

On Tue, Jun 28, 2016 at 06:24:31PM +0800, Nick Wang wrote:
>   Happens in:
>     adm_new_peer()
>       argv[NA(argc)] = ssprintf("%s", conn->peer->node_id);
>       conn->peer == 0x0
> 
>   Example config:
>     resource r0-U {
>       stacked-on-top-of r0 {
>         address    192.168.122.5:7788;
>       }
>     }
> 
> The name of stacked host_info is set as all hosts's
> name concatenate by '_'. Fail to find the fake hostname
> in on_hosts list, which make peer of conn set to 0x0.
> 

Hi Nick,

The segfault happens because conn->peer is NULL? It could still be NULL
with your patch. I need a real/complete configuration and please provide
more information how and why you think this fixes anything. As is, I can
not apply this patch, the intention is unclear to me and it looks broken.

Regards, rck
