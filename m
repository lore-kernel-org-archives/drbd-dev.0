Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id BD532142F3
	for <drbd-dev@lists.linbit.com>; Tue,  7 Sep 2004 14:47:46 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Date: Tue, 7 Sep 2004 14:47:45 +0200
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071419.55799.philipp.reisner@linbit.com>
	<20040907122840.GA15272@marowsky-bree.de>
In-Reply-To: <20040907122840.GA15272@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409071447.45785.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 07 September 2004 14:28, Lars Marowsky-Bree wrote:
> On 2004-09-07T14:19:55,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> >  N1  net   N2
> >  P/S ---  S/P     everything up and running.
> >  P/? - -  S/?     network breaks ; N1 freezes IO
> >  P/? - -  S/?     N1 fences N2:
> >                   In the Stonith case: turn off N2.
> >                   In the "smart" case:
> >                   N1 asks N2 to fence itself from the storage via cnet.
> >                   HB calls "drbdadm fence r0" on N2.
> >                   N2 replies to N1 that fencins is done via cnet.
> >                   N1 calls "drbdadm peer-dead r0".
> >  P/D - -  S/?     N1 thaws IO
>
> In this scenario, there is no need to have a special 'fence' operation.
> IO is already frozen, so we can simply 'stop' drbd on N2 if we so
> chose. (Which will freeze the generation counter, will set the Outdated
> flag etc.)
>
> > N2 got the the "Outdated" flag set in its meta-data, by the "fence"
> > command. I am not sure if it should be called "fence", other ideas:
> > "considered-dead","die","fence","outdate". What do you think ?
> >
> > My question is:
> >  Is it planed that heartbeat will be able to perform this kind of fencing
> > ?
>
> It actually comes for free.
>
> If however heartbeat fences or stops N1 in this case, we'll deliver a
> (successful) stop or fence notification to the incarnation running on
> N2, which will call out to 'drbdadm mark-peer-dead' and basically do the
> same.

(I think you swapped N1 and N2 accidentially in the paragraph above )

No. It would be better to have a "drbdadm fence r0" operation on N2!
The "drbdadm fence r0" command would only set the "Outdated" flag.

The big advantage over stopping DRBD on N2 is that in case the network
recoveres N2 will be resynced to up-to-date automatically.

>
> It's almost implemented, the drbd agent is already written (proof of
> concept code stage), and Andrew tells me we'll have the multiple
> incarnations within a few weeks too.
>

I hope that it is possible to make this agent to call "drbdadm fence r0"
on the secondary instead of "/etc/init.d/drbd stop".

-philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
