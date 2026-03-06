Return-Path: <john.g.garry@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D31C7160881
	for <drbd-dev@lists.linbit.com>; Fri,  6 Mar 2026 16:51:39 +0100 (CET)
Message-ID: <a60a80a7-e612-4eb1-a151-eaaef57ac14c@oracle.com>
Date: Fri, 6 Mar 2026 15:51:29 +0000
Subject: Re: [PATCH 2/4] block: get rid of blk_status_to_{errno,str}
	inconsistency
To: Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20260304190424.291743-1-agruenba@redhat.com>
	<20260304190424.291743-3-agruenba@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
In-Reply-To: <20260304190424.291743-3-agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 04/03/2026 19:04, Andreas Gruenbacher wrote:
> Change blk_status_to_str() to be consistent with blk_status_to_errno()
> and return "I/O" for undefined status codes.
> 
> With that, the fallback case in the blk_errors array can be removed with
> no change in behavior.
> 
> Signed-off-by: Andreas Gruenbacher<agruenba@redhat.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
