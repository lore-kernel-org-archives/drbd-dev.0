Return-Path: <lmb@suse.de>
Date: Fri, 24 Sep 2004 17:15:03 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-ha-dev@lists.linux-ha.org, drbd-dev@lists.linbit.com
Subject: Re: [Linux-ha-dev] Re: [Drbd-dev] [RFC] Handling of internal
	split-brain in multiple state resources
Message-ID: <20040924151503.GX3927@marowsky-bree.de>
References: <20040910185553.GU7359@marowsky-bree.de>
	<bssllma/59fU4MzbzTYqnts=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bssllma/59fU4MzbzTYqnts=lge@web.de>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-20T18:03:42,
   Lars Ellenberg <Lars.Ellenberg@linbit.com> said:

Sorry it took me so long to reply, but I wanted a few moments to
actually read the mails, and I was somewhat busy this week.

I'm replying to you because it's the last mail in the thread and agrees
with what Philipp said ;-)

> the algorithm within the CRM is
>  res = some replicating resource which no longer sees its peer
>  if res is in master state
>     fence the peer (by marking it outdated or stonithing it)
>     tell res about that, and to continue
>  if res is in passive state
>     trigger immediate monitoring of the peer(s),
>     but otherwise do nothing

Yes, that's essentially the algorithm. I should have sticked with
pseudo-code instead of explaining it and fumbling around...

Philipp: This is a "special" case for the CRM, in as far as it's quite
different from anything we did before ;-)

It requires at least an extension to the 'monitor' semantics and a new
action for the secondary.

But, this seems to be what everyone who has considered so far deems
necessary. (I've tried to make the problem go away and figure out how
the resource could handle it internally, but it really seems to need
support from the CRM as above.)

Ok.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

