Return-Path: <lmb@suse.de>
Date: Sat, 4 Sep 2004 11:48:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20040904094814.GE11820@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<20040819113205.GP9601@marowsky-bree.de>
	<R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: </+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
Subject: [Drbd-dev] Another drbd race
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

lge and I have yesterday discussed a 'new' drbd race condition and also
touched on its resolution.

Scope: in a split-brain, drbd might confirm write to the clients and
might on a subsequent failover lose the transactions which _have been
confirmed_. This is not acceptable.

Sequence:

Step	N1	Link	N2
1	P	ok	S
2	P	breaks	S	node1 notices, goes into stand alone,
				stops waiting for N2 to confirm.
3	P	broken	S	S notices, initiates fencing
4	x	broken	P	N2 becomes primary

Writes which have been done in between step 2-4 will have been confirmed
to the higher layers, but are not actually available on N2. This is data
loss; N2 is still consistent, but lost confirmed transaction.

Partially, this is solved by the Oracle-requested "only ever confirm if
committed to both nodes", but of course then if it's not a broken link,
but N2 really went down, we'd be blocking on N1 forever, which we don't
want to do for HA.

So, here's the new sequence to solve this:

Step	N1	Link	N2
1	P	ok	S
2	P(blk)	ok	X	P blocks waiting for acks; heartbeat
				notices that it has lost N2, and initiates
				fencing.
3	P(blk)	ok	fenced	heartbeat tells drbd on N1 that yes, we
				know it's dead, we fenced it, no point
				waiting.
4	P	ok	fenced	Cluster proceeds to run.

Now, in this super-safe mode, if now N1 also fails after step 3 but
before N2 comes back up and is resynced, we need to make sure that N2
does refuse to become primary itself. This will probably require
additional magic in the cluster manager to handle correctly, but N2
needs an additional flag to prevent this from happening by accident.

Lars?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

