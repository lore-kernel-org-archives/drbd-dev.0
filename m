Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 21 Mar 2011 09:56:11 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Message-ID: <20110321085611.GG28441@barkeeper1-xen.linbit>
References: <87vczde0rg.wl%chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vczde0rg.wl%chamas@h4.dion.ne.jp>
Cc: zbr@ioremap.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD on container, lxc
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Mar 21, 2011 at 10:10:59AM +0900, Ken-ichirou MATSUZAWA wrote:
>  Hello Evgeniy, list
> 
> I did not know where I should post, here is my starting point. I
> started to try DRBD on lxc but did not work. I thought first thing
> to do is makeing connector to net namespace aware. Appended patch
> may have many issue but I noticed only a few though. 
> 
> First this does not add connector sock to struct net, but just
> holding sock as a list and send message to all net namespace. I
> referred lib/kobject_uevent.c
> 
> Next I could not know the plan of relationship sock and work queue,
> that is, call cn_queue_alloc_dev() with NULL sock.
> 
> Finaly, is this a correct way to run DRBD on lxc?

In the upcoming drbd 8.4 and further,
we abandoned connector, and switched to generic netlink,
which already supports net namespace aware.

May I ask for some more details about the background of your project?
What is the use case, what exactly is it you are trying to achieve?

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
