Return-Path: <lmb@suse.de>
Date: Fri, 8 Oct 2004 14:55:44 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <20041008125544.GO8249@marowsky-bree.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
	<200410041617.21258.philipp.reisner@linbit.com>
	<2AuBE4UNaPcGXlPlToSVgHc=lge@web.de>
	<200410081432.09710.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200410081432.09710.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-10-08T14:32:09, Philipp Reisner <philipp.reisner@linbit.com> wrote:

>   3. Concurrent writes, high latency for data packets.
>     The problem now is that N2 does can not detect that this was
>     a concurrent write, since it got the ACK before the conflicting
>     data packets comes in. 

Uhm. I don't see how this can be a problem.

In this case, one write has logically happened before the other, and
from they don't overlap - the second write will simply wipe out the
first one, which seems fine?

>   5. New write while processing a write from the peer.

Sounds just like case 1.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

