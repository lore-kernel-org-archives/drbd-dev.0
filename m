Return-Path: <lmb@suse.de>
Date: Mon, 23 Aug 2004 23:56:56 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary;
	drbddisk status problem
Message-ID: <20040823215656.GC17118@marowsky-bree.de>
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
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-08-20T15:32:15,
   Lars Ellenberg <Lars.Ellenberg@linbit.com> said:

>   N1    N2
>   P --- S   Everything ok.
>   P - - S   N1 is failing, but for the moment being just can no
>             longer answer the network; but it is still able to update
>             drbds generation counts
>   ?   - S   Now N1 may be dead, or maybe not
>   X   - S   A sane Cluster-mgr makes N2 primary, but stonith N1 first ...

As you pointed out, the sane cluster manager (or admin) ought to be
setting a Kain flag when it knows for sure it has slain it's brother...

Now, that would even help catch the case where the crm had a malfunction
and made both sides primary, in which case it really really shouldn't
automatically connect, but will require higher level help (to make one
side secondary first).

>   X   - P   N1 now is really dead.
>   S --- P   N1 comes back
>   S - : P   oops, N1 has "better" generation counts than N2
>             N2 shall become sync target, but since it is
>             currently Primary, it will refuse this.
>             It goes standalone.
> 
> Now, I think in that case, N1 needs special handling of the situation,
> too, which it currently has not.

> Yet an other deficiency:
> we still do not handle the gencounts correctly in this situation:
> 
>   S --- S
>   P --- S  drbdsetup primary --human
>    now, N1 increments its human cnt, N2 only its connection count after
>    failure of N1, N2 will take over, maybe be primary for a whole week.
>    then N1 comes back, has the higher human count, and will
>    either [see above] (if N2 still is Primary)
>    or wipe out a week worth of changes (if N2 was demoted to Secondary
>    meanwhile).
> 
>    Oops :-(

Ouchie. Probably should send that across the wire...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \        This space          /
SUSE Labs, Research and Development |       intentionally        |
SUSE LINUX AG - A Novell company    \        left blank          /
