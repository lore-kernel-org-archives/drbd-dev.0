Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 973BD14315
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 11:42:19 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary;
	drbddisk status problem
Date: Wed, 25 Aug 2004 11:42:18 +0200
References: <20040819110202.GO9601@marowsky-bree.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
In-Reply-To: </+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408251142.18807.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]

> and one more scenario, which I described above and consider to be the most
> likely one... and you seem to have missed the point...
>
>   N1    N2
>   P --- S   Everything ok.
>   P - - S   N1 is failing, but for the moment being just can no
>             longer answer the network; but it is still able to update
>             drbds generation counts
>   ?   - S   Now N1 may be dead, or maybe not
>   X   - S   A sane Cluster-mgr makes N2 primary, but stonith N1 first ...
>   X   - P   N1 now is really dead.
>   S --- P   N1 comes back
>   S - : P   oops, N1 has "better" generation counts than N2
>             N2 shall become sync target, but since it is
>             currently Primary, it will refuse this.
>             It goes standalone.
>
> Now, I think in that case, N1 needs special handling of the situation,
> too, which it currently has not.

So, the current policy is: 
 * The primary node refuses to connect to a peer with higher generation
   counts. This keeps the data intact. This is very related to the other
   after-split-brain-policy I want to make expclicit.

* Remeber the options so far: (for primary-after-split-brain)

 - The node that was primary before split brain (current behaviour)
 - The node that became primary during split brain 
 - The node that modified more of it's data during the split-brain
   situation  [ Do not think about implementation yet, just about
                the policy ]
 - None, wait for operator's decission.  [suggested by LMB]
 - Node that is currently primary [see example above by LGE]

* We should probabely have a second configurable policy
       (loosers-data-after-split-brain)

 - Keep
 - Overwrite

Currently we have no clear line in regard in regard to the
loosers-data-after-split-brain.

> Currently this situation is not readily resolvable. One would need to
> first make N2 secondary, too, then either make it primary again using
> the --humman flag (N2 will become SyncSource), or just reconnect now
> (N2 will become SyncTarget).

Hmmm. 

> I think we should allow the drbdadm invalidate in
> StandAlone(WFConnection) Secondary/Unknown, too.
> It would then just clear the MDF_Consistent.

For 0.7 thats is a good idea I think.

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

The real bug here is that we allow the counters to become different,
while the two nodes are connected. [I have to blame myself for, allowing
patches in, I blame Lars for writing them :)]

Here is an excerpt from the
http://www.drbd.org/fileadmin/drbd/publications/drbd_lk9.pdf
Paper. [middle of Page 7]

With the exception of the consistency  flag, connection indicator and the 
primary indicator, all parts of the meta-data are synchronized while 
communication is working. After system start the secondary node inherits the 
counter values from the newly selected primary node.

PS: I really like it to have documents describing the ideas the algorithms
    first, and writing the code to conform to these documents.

PS2: Sorry for the late answers lately...

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
