Return-Path: <lmb@suse.de>
Date: Tue, 24 Aug 2004 00:01:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <Lars.Ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary;
	drbddisk status problem
Message-ID: <20040823220147.GE17118@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<20040819113205.GP9601@marowsky-bree.de>
	<R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
	<200408201452.52512.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408201452.52512.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-08-20T14:52:52,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> The situation:
> 
>  N1    N2
>  P --- S   Everything ok.
>  P - - S   Link breaks.
>  P - - P   A (also split-brained) Cluster-mgr makes N2 primary too.

Big fat bug in the setup and in the cluster manager. ;-) Thus, while it
must be resolveable, it doesn't need to be resolved efficiently.

>  X     X   Both nodes down.
>  P --- S   The current behaviour. 
> 
> What should be done after Split brain ? 

Both sides should detect this and by default refuse to connect until a
human (or higher up being such as the cluster manager) interferes and
explicitly and force-fully demotes one side to secondary again.

> The question are:
> Should this policy be configurable ? (IMO: yes)
> Which policies do we want to offer ?
> 
>  * The node that was primary before split brain (current behaviour)
>  * The node that becaume primary during split brain 
>  * The node that modified more of it's data during the split-brain
>    situation  [ Do not think about implementation yet, just about
>                 the policy ]
>  * others ?...

See above. None of your three choices seems the safe answer, because it
will need an admin to sort out which side really has the 'better' data,
or even worse, may require an image to be taken of both sides and the
changes merged.

> The second question to answer is:
> What should we do if the connecting network heals ? I.e.
> 
>  N1    N2
>  P --- S   Everything ok.
>  P - - S   Link breaks.
>  P - - P   A (also split-brained) Cluster-mgr makes N2 primary too.

(Comment about broken setup applies again.)

>  ? --- ?   What now ?
> 
> Current policy: The two nodes will refuse to connect. The administrator
>                 has to resove this.
> 
> Are there any other policies that would make sense ?

This is the best solution I can think of for the above reasons. As there
may be higher level services running on both nodes, you can't
(internally to drbd) resolve this. The higher level services need to be
stopped, and one side explicitly demoted. Or both demoted and one
explicitly promoted, which should come out the same.


Mit freundlichen Grüßen,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \        This space          /
SUSE Labs, Research and Development |       intentionally        |
SUSE LINUX AG - A Novell company    \        left blank          /
