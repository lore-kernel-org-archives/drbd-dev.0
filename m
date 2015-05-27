Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 373201056180
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 11:31:38 +0200 (CEST)
Date: Wed, 27 May 2015 11:31:36 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Message-ID: <20150527093136.GJ18767@soda.linbit>
References: <1432584909-5349-1-git-send-email-shailendra.capricorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432584909-5349-1-git-send-email-shailendra.capricorn@gmail.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block:drbd:drbd_receiver - Change 1/0 to
 true/false for bool type variable rv in function
 overlapping_resync_write().
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

On Tue, May 26, 2015 at 01:45:09AM +0530, Shailendra Verma wrote:
> In function overlapping_resync_write() variable rv is bool type.
> Hence assigning the values as true/false instead of 1/0.

I like 0 and 1 better.  So unless the powers that be rule this to be the
recommended or mandatory coding style, I consider this just noise.

    Lars

> -	bool rv = 0;
> +	bool rv = false;

> -			rv = 1;
> +			rv = true;

