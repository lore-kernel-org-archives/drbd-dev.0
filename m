Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B886A1056792
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 11:46:10 +0200 (CEST)
Resent-Message-ID: <20110725094610.GH31805@barkeeper1-xen.linbit>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7362F1056792
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 11:39:52 +0200 (CEST)
From: Andreas Gruenbacher <agruen@linbit.com>
To: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
Date: Mon, 25 Jul 2011 11:39:45 +0200
References: <20110724233847.GA2356@swan.nt.tuwien.ac.at>
In-Reply-To: <20110724233847.GA2356@swan.nt.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201107251139.45806.agruen@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] initialize tconn->peer_integrity_tfm in
	drbd_adm_connect()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thomas,

On Monday 25 July 2011 01:38:48 Thomas Zeitlhofer wrote:
> The support for data-integrity-alg seems to be broken with drbd-8.4.0.
> E.g., when trying to resync, the SyncTarget hits:
> 
>    ASSERTION IS_ALIGNED(data_size, 512) FAILED in read_in_block
>    error receiving RSDataReply, e: -5 l: 126996! read_in_block
> 
> This is caused by an uninitialized tconn->peer_integrity_tfm. Therefore,
> the digest data is not used/removed at the receiver which leads to
> additional 20 bytes that trigger the assertion above.

thanks for tracking this down.  Your analysis and the fix are correct.  As it 
happens, we also ran into this bug here meanwhile.  Here is what we did to 
address it:

  http://git.drbd.org/?p=drbd-8.4.git;a=commit;h=4811eceb393c274f94bfd8926e714d6271cf1f57

The two fixes are slightly different, but both should do the job.  Sorry for 
not letting you know of our fix in time.

The master branch in http://git.drbd.org/?p=drbd-8.4.git contains a few 
additional minor fixes.

Thanks,
Andreas
