Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust124.tnt12.ber2.deu.da.uu.net [149.225.238.124])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 21E4E14303
	for <drbd-dev@lists.linbit.com>; Fri, 20 Aug 2004 15:48:30 +0200 (CEST)
Date: Fri, 20 Aug 2004 15:32:15 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary; drbddisk status problem
Message-ID: </+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
References: <20040819110202.GO9601@marowsky-bree.de> <20040819113205.GP9601@marowsky-bree.de> <R+ahoCHARbsLOMKIahWH0/Q=lge@web.de> <200408201452.52512.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408201452.52512.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

/ 2004-08-20 14:52:52 +0200
\ Philipp Reisner:
> On Thursday 19 August 2004 14:14, Lars Ellenberg wrote:
> [...]
> > > Split-brain Szenarien die mit Primary/Primary (beide StandAlone) enden
> > > habe ich schon im neuen Design bedacht (ich schreibe gerade). Was sonst?
> >
> > gar nicht soo unwahrscheinlich:
> >
> > wenn der primary stirbt (oder getötet wird), aber vor dem sterben
> > irgendwie noch geschafft hat, seine drbd connection zu verlieren _und_
> > daher den "ConnectedCount" hochgezählt hat...
> >
> > der "slave" wird jetzt Secondary->Primary, zählt aber, weil < Connected
> > den ArbitraryCount hoch...
> >
> > situation beim nächsten connect:
> >
> >  Flags: consistent,             ,been primary last time
> >
> > früherer Primary  1:X:Y:a+1:b  :10 (nach reboot jetzt Secondary)
> > jetziger Primary  1:X:Y:a  :b+1:10
> >
> > doh. jetziger Primary soll SyncTarget werden... shitty.
> > --> jetziger Primary goes StandAlone.
> >
> > nächster verbindungsversuch (von operator eingeleitet)
> > ... -> "split brain detected"
> > --> both go StandAlone
> >
> > u.U. müssen wir einen zusätzlichen counter einführen, einen "CRM
> > count", und der CRM muss, wenn er den anderen node geschossen hat,
> > sicherheitshalber ein drbdsetup "--crm" (vgl. --human) primary
> > machen, dass würde zumindest das oben beschriebene scenario auflösen...
> >
> 
> Hi,
> 
> Right, old toppic: What should we do after a split-brain situation.
> I have looked up my papers from 2001 to unterstand, why it is done 
> the way it is today:
> 
> The situation:
> 
>  N1    N2
>  P --- S   Everything ok.
>  P - - S   Link breaks.
>  P - - P   A (also split-brained) Cluster-mgr makes N2 primary too.
>  X     X   Both nodes down.
>  P --- S   The current behaviour. 
> 
> What should be done after Split brain ? 
> 
> The current policy is, that the node that was Primary before the
> split-brain situation should be primary afterwards.
> 
> This Policy is hard-coded into DRBD. It is an arbitrary decission, 
> I thought it is a good idea.
> 
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
> 
> The second question to answer is:
> What should we do if the connecting network heals ? I.e.
> 
>  N1    N2
>  P --- S   Everything ok.
>  P - - S   Link breaks.
>  P - - P   A (also split-brained) Cluster-mgr makes N2 primary too.
>  ? --- ?   What now ?
> 
> Current policy: The two nodes will refuse to connect. The administrator
>                 has to resove this.
> 
> Are there any other policies that would make sense ?

and one more scenario, which I described above and consider to be the most
likely one... and you seem to have missed the point...

  N1    N2
  P --- S   Everything ok.
  P - - S   N1 is failing, but for the moment being just can no
            longer answer the network; but it is still able to update
            drbds generation counts
  ?   - S   Now N1 may be dead, or maybe not
  X   - S   A sane Cluster-mgr makes N2 primary, but stonith N1 first ...
  X   - P   N1 now is really dead.
  S --- P   N1 comes back
  S - : P   oops, N1 has "better" generation counts than N2
            N2 shall become sync target, but since it is
            currently Primary, it will refuse this.
            It goes standalone.

Now, I think in that case, N1 needs special handling of the situation,
too, which it currently has not.

Currently this situation is not readily resolvable. One would need to
first make N2 secondary, too, then either make it primary again using
the --humman flag (N2 will become SyncSource), or just reconnect now
(N2 will become SyncTarget).

I think we should allow the drbdadm invalidate in
StandAlone(WFConnection) Secondary/Unknown, too.
It would then just clear the MDF_Consistent.

Yet an other deficiency:
we still do not handle the gencounts correctly in this situation:

  S --- S
  P --- S  drbdsetup primary --human
   now, N1 increments its human cnt, N2 only its connection count after
   failure of N1, N2 will take over, maybe be primary for a whole week.
   then N1 comes back, has the higher human count, and will
   either [see above] (if N2 still is Primary)
   or wipe out a week worth of changes (if N2 was demoted to Secondary
   meanwhile).

   Oops :-(


	Lars Ellenberg
