Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Or Gerlitz <ogerlitz@voltaire.com>
Date: Thu, 13 Jan 2011 16:04:57 +0100
References: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
In-Reply-To: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101131604.58153.philipp.reisner@linbit.com>
Cc: Jens Axboe <jaxboe@fusionio.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 13. Januar 2011, um 10:34:35 schrieb Or Gerlitz:
> drop code present under #ifdef which is relevant to 2.6.28 and below
> 
> Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
> 
> ---
> 
> Philipp, I haven't noted if/where the drbd updates for 2.6.38 were posted,
> have them? do you typically post the pull request to LKML or there's a
> lower volume mailing list where this can be tracked?
> 

Yes, I send my pull requests to Jens, and CC them to LKML. 
See http://kerneltrap.org/mailarchive/linux-kernel/2010/11/25/4651216

If it would help you I can start to CC them to drbd-dev@lists.linbit.com 
as well. It is a really low traffic mailing list.

BTW, I will pick up the patch and send it with the next pull request
to Jens. (That will be for the 2.6.39 merge window).

FYI, We are missing the (current) 2.6.38 merge window, with drbd-8.3.10

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
