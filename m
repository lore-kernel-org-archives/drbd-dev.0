Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D47DB101AC7C
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:59:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CBBE63C0EF6
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:59:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xsXNCAaZxhq6 for <drbd-dev@lists.linbit.com>;
	Mon, 16 Jun 2014 14:59:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9DBC63C41EA
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:59:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 83u4QWdpp-Xe for <drbd-dev@lists.linbit.com>;
	Mon, 16 Jun 2014 14:59:22 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 835243C0EF6
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 14:59:22 +0200 (CEST)
Resent-Message-ID: <20140616125921.GC28884@soda.linbit>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
	[209.85.223.173]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4ACA1101AC71
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 11:36:25 +0200 (CEST)
Received: by mail-ie0-f173.google.com with SMTP id y20so4784093ier.18
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jun 2014 02:36:24 -0700 (PDT)
Date: Mon, 16 Jun 2014 02:28:57 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Kepplinger <martink@posteo.de>
In-Reply-To: <1402793121-17181-1-git-send-email-martink@posteo.de>
Message-ID: <alpine.DEB.2.02.1406160225510.30205@chino.kir.corp.google.com>
References: <1402787275-12258-1-git-send-email-martink@posteo.de>
	<1402793121-17181-1-git-send-email-martink@posteo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: change one-bit bitfield to be an
	unsigned int
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

On Sun, 15 Jun 2014, Martin Kepplinger wrote:

> The one-bit bitfield has no negative values and thus becomes an
> unsigned int.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

I'm unsure what you're correcting here.  These bitfields are inherently 
signed, "int local:1" and "int waiting:1" are signed.  They can have one 
of two values, 0 or -1.  So I don't know what you're saying in your 
changelog.

This patch would only make sense if something is testing `local' or 
`waiting' to be equal to 1.  Is that what you're fixing?  If so, please 
specify it in the changelog with an example.

> ---
> Sorry for the visually ugly first patch. Take this one, if any.
> 
> thanks,
>                      martin
> 
> 
>  drivers/block/drbd/drbd_interval.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
> index f38fcb0..8d670e6 100644
> --- a/drivers/block/drbd/drbd_interval.h
> +++ b/drivers/block/drbd/drbd_interval.h
> @@ -9,8 +9,8 @@ struct drbd_interval {
>  	sector_t sector;	/* start sector of the interval */
>  	unsigned int size;	/* size in bytes */
>  	sector_t end;		/* highest interval end in subtree */
> -	int local:1		/* local or remote request? */;
> -	int waiting:1;
> +	unsigned int local:1;	/* local or remote request? */
> +	unsigned int waiting:1;
>  };
>  
>  static inline void drbd_clear_interval(struct drbd_interval *i)
