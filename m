Return-Path: <lmb@suse.de>
Date: Mon, 4 Oct 2004 22:24:43 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <20041004202443.GH1542@marowsky-bree.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
	<20041004134912.GY1542@marowsky-bree.de>
	<200410041609.23272.philipp.reisner@linbit.com>
	<200410041617.21258.philipp.reisner@linbit.com>
	<2AuBE4UNaPcGXlPlToSVgHc=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2AuBE4UNaPcGXlPlToSVgHc=lge@web.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-10-04T17:12:24, Lars Ellenberg <Lars.Ellenberg@linbit.com> wrote:

> but yes, I think a consistent arbitration would do the trick much
> cheaper.

For two nodes yes. I think it's the optimal scheme assuming that write
contention is not the regular case; if a large percentage (>40% or so)
of writes would overlap I assume a coordination algorithm would be
better. But, I assume such workloads have a much more fundamental
problem. ;-)

> though for the (N>2)-node case I'd like to see your paper first ;)

I don't think this scheme will work well for >2 node active scenarios if
all more than two try to write and receive all writes in different
ordering.

But >2 nodes would likely wish to have an efficient multicast protocol
anyway. Three you could do in a triangle, but 4 already would suck for
such a full mesh anyway.

Actually, the 2-node active:active seems so straightforward it may make
sense for 0.8 already. A passive replication to more than 1 standby may
also be doable. >2 node active/active is 0.9 material...

I need to add that to our funding plans ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

