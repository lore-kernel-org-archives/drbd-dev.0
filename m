Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4D84A2E23449
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2007 13:33:42 +0100 (CET)
Resent-Message-ID: <20070307123343.GB8356@soda.linbit>
Date: Wed, 7 Mar 2007 14:59:14 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20070307115914.GA1287@2ka.mipt.ru>
References: <200703071226.13088.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200703071226.13088.philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: connector: Bugfix for cn_call_callback()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 07, 2007 at 12:26:12PM +0100, Philipp Reisner (philipp.reisner@linbit.com) wrote:
> Hi Evgeniy,

Hi Philipp.

> When one stresses the connector code, with sending many messages
> from userspace to kernel, one could get in the "unlikely()"
> part in cn_call_callback().
> 
> There a new __cbq gets allocated, and a NULL pointer got assigned
> to the callback by dereferencing __cbq. This is the bug. The right
> thing is the dereference the original __cbq. Therefore the bugfix
> is to use a new variable for the newly allocated __cbq. 
> 
> This is tested, and it fixes the issue.

Yes, your patch is correct.

> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

I will push it, thanks a lot.

-- 
	Evgeniy Polyakov

