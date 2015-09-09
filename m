Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E237210518BD
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D777046E881
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:33:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gsWtHC2LVdWL for <drbd-dev@lists.linbit.com>;
	Wed,  9 Sep 2015 15:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BA2B146E884
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:33:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kbw299jNW-AZ for <drbd-dev@lists.linbit.com>;
	Wed,  9 Sep 2015 15:33:54 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 8D84546E881
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:33:54 +0200 (CEST)
Date: Wed, 9 Sep 2015 15:33:54 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150909133353.GD1313@rck.sh>
References: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
Subject: Re: [Drbd-dev] [PATCH 0/2] drbd-utils: build fixes for the musl C
 library
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

On Wed, Sep 09, 2015 at 03:16:05PM +0200, Christophe Vu-Brugier wrote:
> Hi,
> 
> Here are two patches that fix compilation errors when drbd-utils is
> built with the musl C library.
> 

Hi Christophe,

I like the musl libc and will review the patches in the next days.

Thanks, rck
