Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Lars Ellenberg <Lars.Ellenberg@linbit.com>,
	Lars Marowsky-Bree <lmb@suse.de>, drbd-dev@lists.linbit.com
Date: Fri, 20 Aug 2004 14:52:52 +0200
References: <20040819110202.GO9601@marowsky-bree.de> <20040819113205.GP9601@marowsky-bree.de> <R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
In-Reply-To: <R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408201452.52512.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: drbd Frage zu secondary vs primary; drbddisk status problem
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

On Thursday 19 August 2004 14:14, Lars Ellenberg wrote:
[...]
> > Split-brain Szenarien die mit Primary/Primary (beide StandAlone) enden
> > habe ich schon im neuen Design bedacht (ich schreibe gerade). Was sonst?
>
> gar nicht soo unwahrscheinlich:
>
> wenn der primary stirbt (oder getötet wird), aber vor dem sterben
> irgendwie noch geschafft hat, seine drbd connection zu verlieren _und_
> daher den "ConnectedCount" hochgezählt hat...
>
> der "slave" wird jetzt Secondary->Primary, zählt aber, weil < Connected
> den ArbitraryCount hoch...
>
> situation beim nächsten connect:
>
>  Flags: consistent,             ,been primary last time
>
> früherer Primary  1:X:Y:a+1:b  :10 (nach reboot jetzt Secondary)
> jetziger Primary  1:X:Y:a  :b+1:10
>
> doh. jetziger Primary soll SyncTarget werden... shitty.
> --> jetziger Primary goes StandAlone.
>
> nächster verbindungsversuch (von operator eingeleitet)
> ... -> "split brain detected"
> --> both go StandAlone
>
> u.U. müssen wir einen zusätzlichen counter einführen, einen "CRM
> count", und der CRM muss, wenn er den anderen node geschossen hat,
> sicherheitshalber ein drbdsetup "--crm" (vgl. --human) primary
> machen, dass würde zumindest das oben beschriebene scenario auflösen...
>

Hi,

Right, old toppic: What should we do after a split-brain situation.
I have looked up my papers from 2001 to unterstand, why it is done 
the way it is today:

The situation:

 N1    N2
 P --- S   Everything ok.
 P - - S   Link breaks.
 P - - P   A (also split-brained) Cluster-mgr makes N2 primary too.
 X     X   Both nodes down.
 P --- S   The current behaviour. 

What should be done after Split brain ? 

The current policy is, that the node that was Primary before the
split-brain situation should be primary afterwards.

This Policy is hard-coded into DRBD. It is an arbitrary decission, 
I thought it is a good idea.

The question are:
Should this policy be configurable ? (IMO: yes)
Which policies do we want to offer ?

 * The node that was primary before split brain (current behaviour)
 * The node that becaume primary during split brain 
 * The node that modified more of it's data during the split-brain
   situation  [ Do not think about implementation yet, just about
                the policy ]
 * others ?...

The second question to answer is:
What should we do if the connecting network heals ? I.e.

 N1    N2
 P --- S   Everything ok.
 P - - S   Link breaks.
 P - - P   A (also split-brained) Cluster-mgr makes N2 primary too.
 ? --- ?   What now ?

Current policy: The two nodes will refuse to connect. The administrator
                has to resove this.

Are there any other policies that would make sense ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
