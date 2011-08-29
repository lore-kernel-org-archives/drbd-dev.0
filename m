Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E10B10556AA
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 17:38:40 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Pekka Enberg <penberg@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Mon, 29 Aug 2011 17:38:33 +0200
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<201108291351.06092.philipp.reisner@linbit.com>
	<CAOJsxLHQFhHaASj9eSJeQ9H_VyS59ztu=caOoUipYEneiB1vAA@mail.gmail.com>
In-Reply-To: <CAOJsxLHQFhHaASj9eSJeQ9H_VyS59ztu=caOoUipYEneiB1vAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108291738.33747.philipp.reisner@linbit.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
	support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 29. August 2011, 14:52:56 schrieb Pekka Enberg:
> On Mon, Aug 29, 2011 at 2:51 PM, Philipp Reisner
> 
> <philipp.reisner@linbit.com> wrote:
> > The new feature set, might be partially broken, but introducing
> > the new features is the whole point of this patch series.
> 
> If that new feature can, for example, corrupt your data while you're
> doing "git bisect" on non-DRBD regression, that's no good. Can that
> happen?
> 

No, that can not happen. Maybe it fails to connect to the peer, etc...
It will not destroy data.

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
