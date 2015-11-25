Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F01601028A50
	for <drbd-dev@lists.linbit.com>; Thu, 26 Nov 2015 09:50:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E182B2AF46C
	for <drbd-dev@lists.linbit.com>; Thu, 26 Nov 2015 09:50:01 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JJ8pJx5XnMhy for <drbd-dev@lists.linbit.com>;
	Thu, 26 Nov 2015 09:50:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BEF482B5460
	for <drbd-dev@lists.linbit.com>; Thu, 26 Nov 2015 09:50:01 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Cg7ag09p7RW for <drbd-dev@lists.linbit.com>;
	Thu, 26 Nov 2015 09:50:01 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9042A2AF46C
	for <drbd-dev@lists.linbit.com>; Thu, 26 Nov 2015 09:50:01 +0100 (CET)
Resent-Message-ID: <20151126085001.GN8170@soda.linbit>
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
	[67.231.153.30]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E0E5210003FC
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 19:14:57 +0100 (CET)
To: Philipp Reisner <philipp.reisner@linbit.com>,
	<linux-kernel@vger.kernel.org>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5655F77E.9000007@fb.com>
Date: Wed, 25 Nov 2015 11:01:34 -0700
MIME-Version: 1.0
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/38] DRBD update
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

On 11/25/2015 03:53 AM, Philipp Reisner wrote:
> Hi Jens,
>
> please pull these patches into your for-4.5/drivers branch.
>
> This huge patch set updates the in-tree DRBD to what we have out of tree.
> All of this has been extensively tested and in production use by LINBIT's
> customers.
>
> Andreas' patches backport some DRBD-9 interface functionality, easing
> smooth migration of the user base to DRBD-9 later on. These patches
> add contains touch the most lines in the series.
>
> Lars and others did the maintenance and bug-fixing work.

Applied for 4.5, thanks.

-- 
Jens Axboe

