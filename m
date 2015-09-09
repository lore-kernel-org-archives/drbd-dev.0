Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 31FA710556A0
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:21:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 263DE46E74F
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:21:08 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lILaLE_B4Evz for <drbd-dev@lists.linbit.com>;
	Wed,  9 Sep 2015 10:21:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 089C746E75F
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:21:08 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B1u9jp27YpXU for <drbd-dev@lists.linbit.com>;
	Wed,  9 Sep 2015 10:21:07 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id C127846E74F
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 10:21:07 +0200 (CEST)
Date: Wed, 9 Sep 2015 10:21:07 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150909082106.GB1313@rck.sh>
References: <55EF7BEA.5060409@alteeve.ca>
 <55EFD2FD.6010500@alteeve.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55EFD2FD.6010500@alteeve.ca>
Subject: Re: [Drbd-dev] rhcs_fence
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

On Wed, Sep 09, 2015 at 02:34:37AM -0400, Digimer wrote:
> On 08/09/15 08:23 PM, Digimer wrote:
> > Is rhcs_fence not shipped with drbd 8.4?
> 
> If not (it appears not), and if there is interest in adding it, I've
> moved it's development into the main striker repo:
> 
> https://github.com/digimer/striker/blob/master/tools/rhcs_fence
> 

Mind the repo-split... There is one in drbd-utils/scripts

Thank you for the hint.

Regards, rck
