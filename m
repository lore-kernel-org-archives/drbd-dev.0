Return-Path: <lars.ellenberg@linbit.com>
Date: Sat, 20 Sep 2008 15:18:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Morey Roof <moreyroof@gmail.com>
Subject: Re: [Drbd-dev] New Features
Message-ID: <20080920131821.GB16149@racke>
References: <48D3378E.3020201@gmail.com> <20080919155343.GD9779@soda.linbit>
	<91a37e890809190919g5a746367g54e76d36e1a825f6@mail.gmail.com>
	<20080919221339.GB15916@soda.linbit> <48D42783.1050403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48D42783.1050403@gmail.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 19, 2008 at 04:28:19PM -0600, Morey Roof wrote:
> The first item on the list is a write back cache.  Now don't run  
> screaming to hills yet.  In our setup we have the two nodes in two  
> different buildings which are feed by different power supplies from the  
> city grid.  The machines themselves have dual power supplies which each  
> power supply going to it's own UPS and circuit.  So, we have a good  
> redundant power supply setup.  So, I was thinking about creating a  
> caching system in DRBD to allow for dedicating some of the server's RAM  
> to a large read/write-back cache.  In the event of communication failure  
> between the peers I wanted it to flush the entire cache and then run in  
> write-through mode and move back to write-back mode after communication  
> is present again and the resync is finished.
>
> So that is the basic idea.  I was thinking about having it use the  
> ramdisk system so that you can specify a device that is used as the  
> cache.  The reason I was thinking about this is that if you happen to  
> purchase one of those Gigabyte ram HDD that is just like a large battery  
> backed write cache you could set it as the cache device as well.
>
> What are your thought?

something I though of myself already,
but nothing for the curren drbd architechture.

I sent you my Linux-Kongress 2008 paper off list,
where I scetch what I have in mind for the future.
I'd put in a link here, if I had it online already.

though I did not mention it, a (possibly non-volatile) ram disk
would fit in pretty well as the log device.

let me know what you think.

-- 
: Lars Ellenberg                
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
