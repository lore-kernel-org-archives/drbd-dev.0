Return-Path: <lmb@suse.de>
Date: Sat, 4 Sep 2004 12:18:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040904101813.GF11820@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<20040819113205.GP9601@marowsky-bree.de>
	<R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
	<20040904094814.GE11820@marowsky-bree.de>
	<20040904100008.GA14645@nudl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040904100008.GA14645@nudl>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-04T12:00:08,
   Lars Ellenberg <lars.ellenberg@linbit.com> said:

Yep, that should be enough to detect this on the secondary. But:

> Most likely right after connection loss the Primary should blocks for a
> configurable (default: infinity?) amount of time before giving end_io
> events back to the upper layer.
> We then need to be able to tell it to resume operation (we can do this,
> as soon as we took precautions to prevent the Secondary to become
> Primary without being forced or resynced before).
> 
> Or, if the cluster decides to do so, the Secondary has time to STONITH
> the Primary (while that is still blocking) and take over.
> 
> I want to include a timeout, so the cluster manager don't need to
> know about "peer is dead" notification, it only needs to know about
> STONITH.

If it defaults to an 'infinite' timeout, which is safe, we need the
resume operation. (Or rather, notification about the successful "peer is
dead now" event.) This is easy to add.

And it is needed, because 

a) if the fencing _failed_, the primary needs to stay blocked until it
eventually succeeds. This is a correctness issue.

a) otherwise drbd would _always_ block for at least that amount of time
when it lost the secondary, even though it's been fenced since seconds
(or even we may have fenced it before drbd's internal peer timeout hits,
in which case it wouldn't ever block). This is a performance issue.

The combination of a+b gives a very good argument for having a resume
operation, which the new CRM will be able to drive in a couple of weeks
;-)

> Maybe we want to introduce this functionality as a new wire protocoll,
> or only in proto C.

It doesn't actually need to be a new wire protocol, it just needs an
additional option set (ie, the Oracle mode) and the 'resume' operation
on the primary; or actually, that could be mapped to an explicit switch
from WFConnection to StandAlone.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

