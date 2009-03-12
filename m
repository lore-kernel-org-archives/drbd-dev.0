Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 12 Mar 2009 11:32:25 +0100
References: <1236792621.7981.25.camel@octane>
In-Reply-To: <1236792621.7981.25.camel@octane>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903121132.26169.philipp.reisner@linbit.com>
Cc: "ILLES, Marton" <illes.marton@balabit.hu>
Subject: Re: [Drbd-dev] invalidate broken in 8.3.0 regression from 8.2.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 11 March 2009 18:30:21 ILLES, Marton wrote:
> Hi,
>
> First of all thanks for drbd, it is such a nice piece of code, we love
> to use it.
>
> In my current setup I use drbd 8.3.0 with linux 2.6.27 and some ubuntu
> patches (but it does not really matter), while I discovered that
> "drbdsetup /dev/drbd0 invalidate" does not do anything. No error code,
> nothing. In 8.2.6 it worked well, so some regression is here.
>
> After some debugging and git digging I realized that invalidate logic
> was changed in this patch:
>

Thanks a lot for pointing this out!

See...
http://git.drbd.org/?p=drbd-8.3.git;a=commitdiff;h=a8403ade52180175a0e657770d8698abe394a707

best,
 Philipp
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

