Return-Path: <lmb@suse.de>
Date: Wed, 25 Aug 2004 15:09:34 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Summary (2nd try)
Message-ID: <20040825130934.GZ3125@marowsky-bree.de>
References: <200408251501.59314.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408251501.59314.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-08-25T15:01:59,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> Hi,
> 
> After I realized that we no longer make any node primary automatically :)
> Here the suggestion of the new configure option:
> 
> after-primary-primary = 

This is in case where after the reconnect there is no primary (s/s),
right?

>  disconnect	No automatic resynchronisation gets performed. One
> 		node should drop its net-conf (preferable the
> 		node that would become sync-target)
> 		I think this should be default.
>  ass-older	Auto sync source is the oder primary (current default i.t.s.)
>  ass-younger	Auto sync source is the younger primary
>  ass-furthest   Auto sync source is the node that did more modifications
>  ass-NODENAME   Auto sync source is the named node 
> 
> Falls es schon einen pirmary gibt (also dieses:
> 
[snip]

> ) Dann:
> 
>  disconnect   (current behaviour in the situation.)
>  ass-*        Auto sync, but the current primary gets sync-source.
> 
> What do you think ?

Sounds good, one scenario is missing.

P-P scenario:

disconnect	(same same)
ass-*		the node which would be SyncTarget needs to crash
		itself to 'clear' the higher levels, and then would
		(after the reboot) go through the first scenario.

This may be useful for unattended embedded scenarios, but as it is
pretty severe recovery for a grave error, may even value an additional
flag.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

