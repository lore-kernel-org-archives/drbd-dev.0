Return-Path: <lmb@suse.de>
Date: Sat, 25 Sep 2004 10:54:28 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@linbit.com, linux-ha-dev@lists.linux-ha.org
Message-ID: <20040925085428.GA4267@marowsky-bree.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<20040924211133.GC3927@marowsky-bree.de>
	<qEu8Pd/NWgF9/2NlEKWF2r4=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qEu8Pd/NWgF9/2NlEKWF2r4=lge@web.de>
Cc: 
Subject: [Drbd-dev] Re: [Linux-ha-dev] [RFC] (CRM and) DRBD (0.8) states and
	transistions, recovery strategies
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-25T01:04:57,
   Lars Ellenberg <Lars.Ellenberg@linbit.com> said:

> > I don't see any difference here between meta-data and backing store
> > loss, actually, that complicates things unnecessarily.
> 
> well, DRBD needs to make a difference, because they meta-data storage
> and data storage may be physically different devices, and therefore can
> fail independently. (ok, single blocks can fail on the same physical
> storage independently, too, but this is an other thing)

The point I was trying to make is that meta-data loss and backing
storage loss can essentially be mapped to a generic local IO failure.

The special case where we only loss access to the backing store and not
to the meta-data allows us to set a flag there (for whatever use it may
be the next time we compare GCs), but then it amounts to the same: Loss
of the local storage.

I don't see any benefit in keeping the two as distinct failure modes...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

