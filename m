Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6F73F10518BE
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:48:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 63509465BBC
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:48:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Kb0_MZZq5KKn for <drbd-dev@lists.linbit.com>;
	Thu, 17 Sep 2015 15:48:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D1F0E465BD2
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:48:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BL_siMABhV2a for <drbd-dev@lists.linbit.com>;
	Thu, 17 Sep 2015 15:48:53 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AE9DA465BBC
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 15:48:53 +0200 (CEST)
Date: Thu, 17 Sep 2015 15:48:53 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150917134853.GG7519@soda.linbit>
References: <1442486932.25039.41.camel@vaduz.fondsnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442486932.25039.41.camel@vaduz.fondsnet.de>
Subject: Re: [Drbd-dev] Bug in DRBD 8.4 potentially leading to data loss
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

On Thu, Sep 17, 2015 at 12:48:52PM +0200, Veit Wahlich wrote:

> -	char mb[12];
> +	char mb[14];

> -	snprintf(mb, 12, "minor-%d", device_to_minor(device));
> +	snprintf(mb, 14, "minor-%d", device_to_minor(device));

Thanks for spotting, applied.

	Lars

