Return-Path: <lmb@suse.de>
Date: Wed, 25 Aug 2004 12:28:52 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary;
	drbddisk status problem
Message-ID: <20040825102852.GS3125@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
	<200408251142.18807.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408251142.18807.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-08-25T11:42:18,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> So, the current policy is: 
>  * The primary node refuses to connect to a peer with higher generation
>    counts. This keeps the data intact. This is very related to the other
>    after-split-brain-policy I want to make expclicit.

Makes sense.

> * Remeber the options so far: (for primary-after-split-brain)
> 
>  - The node that was primary before split brain (current behaviour)
>  - The node that became primary during split brain 
>  - The node that modified more of it's data during the split-brain
>    situation  [ Do not think about implementation yet, just about
>                 the policy ]
>  - None, wait for operator's decission.  [suggested by LMB]
>  - Node that is currently primary [see example above by LGE]

Minor clarification: I think the question is not about "Who becomes
primary", as the Sync* is decoupled from that status, but which side
drbd deems to have the good data and thus the SyncMaster.

Looking at it from this angle, we have two dimensions:

- Node state after the split-brain heals. Each side can either be
  primary or secondary.

- The data state on each side.

Now, obviously, if the node state of both sides is "primary", drbd can't
automatically do something, but _must_ wait for admin intervention. It
can't resolve this internally, because it would destroy the layers
above. -> _MUST_ wait for operator intervention.

(Embedded environments with a dumb cluster manager... Hmm... Ok, maybe
crashing one side (which inherently stops the higher layers and triggers
recovery) and thus reducing the problem to one of the somewhat simpler
ones below might work...)

If only one side is primary, and the algorithms determine that this one
has the good data, and the other side has not touched the data in
between, this is also a simple case.

If both sides are secondary, but only one side has modified the data
since or been primary, again it's simple.

If one side is primary, but the other side has been primary in between
(but not at the time of the connect), drbd can either wait for a
higher-level intervention, or sync the now-secondary. Only two options,
nothing else makes sense. (Changing the data underneath the primary
strikes me as an exceptionally bad idea.)

If both sides are secondary, but both sides have modified the data
since, then we have several choices like picking the most recent
(timestamp?), most data modified, throwing a coin or again waiting for
admin intervention.

(Personally, I'd say operator intervention, after very careful
consideration of the problem, is in fact the only choice; this scenario
is only reached by a combination of several _severe_ faults.)

A special case obviously exists if one secondary side has inconsistent
data and the other has a consistent snapshot, which case it is a
somewhat safer assumption to sync automatically from the consistent to
the inconsistent side. This should be the default, but may be
configurable...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

