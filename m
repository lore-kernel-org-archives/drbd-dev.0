Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust31.tnt10.ber2.deu.da.uu.net [149.225.214.31])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 455F2142F3
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 15:38:57 +0200 (CEST)
Date: Wed, 25 Aug 2004 15:38:51 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary;
	drbddisk status problem
Message-ID: <IQ57r/NAiFPkpPV48gdA/oo=lge@web.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
	<200408251142.18807.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408251142.18807.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Yet an other deficiency:
> > we still do not handle the gencounts correctly in this situation:
> >
> >   S --- S
> >   P --- S  drbdsetup primary --human
> >    now, N1 increments its human cnt, N2 only its connection count after
> >    failure of N1, N2 will take over, maybe be primary for a whole week.
> >    then N1 comes back, has the higher human count, and will
> >    either [see above] (if N2 still is Primary)
> >    or wipe out a week worth of changes (if N2 was demoted to Secondary
> >    meanwhile).
> 
> The real bug here is that we allow the counters to become different,
> while the two nodes are connected. [I have to blame myself for, allowing
> patches in, I blame Lars for writing them :)]
> 
> Here is an excerpt from the
> http://www.drbd.org/fileadmin/drbd/publications/drbd_lk9.pdf
> Paper. [middle of Page 7]
> 
> With the exception of the consistency  flag, connection indicator and the 
> primary indicator, all parts of the meta-data are synchronized while 
> communication is working. After system start the secondary node inherits the 
> counter values from the newly selected primary node.
> 
> PS: I really like it to have documents describing the ideas the algorithms
>     first, and writing the code to conform to these documents.
> 
> PS2: Sorry for the late answers lately...

to defend myself, and to suggest it as solution:

 Author: phil
 Date: 2004-07-27 18:58:09 +0200 (Tue, 27 Jul 2004)
 New Revision: 1459
 
 Modified:
    trunk/drbd/drbd_fs.c
    trunk/drbd/drbd_int.h
    trunk/drbd/linux/drbd.h
    trunk/drbd/linux/drbd_config.h
    trunk/user/drbdadm_main.c
    trunk/user/drbdsetup.c
 Log:
 * Increment the human-count if someone types in "yes" at the
   user's dialog.
 * Make sure the timeout-count is increased if the timeout
   expires at the user's dialog.
 
 
 Modified: trunk/drbd/drbd_fs.c
 ===================================================================
 --- trunk/drbd/drbd_fs.c        2004-07-27 09:01:05 UTC (rev 1458)
 +++ trunk/drbd/drbd_fs.c        2004-07-27 16:58:09 UTC (rev 1459)
 @@ -714,15 +714,6 @@
                                 return -EIO;
                         }
                 }
 -#if 0
 -               else if (mdev->cstate >= Connected) {
 -                       /* do NOT increase the Human count if we are connected,
 -                        * and there is no reason for it.  I'm not yet sure
 -                        * wether this is what I mean, though...
 -                        */
 -                       newstate &= ~(Human|DontBlameDrbd);
 -               }
 -#endif
         }
 
...
