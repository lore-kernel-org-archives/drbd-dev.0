Return-Path: <lmb@suse.de>
Date: Tue, 7 Sep 2004 14:28:40 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040907122840.GA15272@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071139.29609.philipp.reisner@linbit.com>
	<20040907101343.GA5638@nudl>
	<200409071419.55799.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409071419.55799.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T14:19:55,
   Philipp Reisner <philipp.reisner@linbit.com> said:

>  N1  net   N2
>  P/S ---  S/P     everything up and running.
>  P/? - -  S/?     network breaks ; N1 freezes IO
>  P/? - -  S/?     N1 fences N2:
>                   In the Stonith case: turn off N2.
>                   In the "smart" case: 
>                   N1 asks N2 to fence itself from the storage via cnet.
>                   HB calls "drbdadm fence r0" on N2.
>                   N2 replies to N1 that fencins is done via cnet.
>                   N1 calls "drbdadm peer-dead r0".
>  P/D - -  S/?     N1 thaws IO

In this scenario, there is no need to have a special 'fence' operation.
IO is already frozen, so we can simply 'stop' drbd on N2 if we so
chose. (Which will freeze the generation counter, will set the Outdated
flag etc.)

> N2 got the the "Outdated" flag set in its meta-data, by the "fence" 
> command. I am not sure if it should be called "fence", other ideas:
> "considered-dead","die","fence","outdate". What do you think ?
> 
> My question is:
>  Is it planed that heartbeat will be able to perform this kind of fencing ?

It actually comes for free.

If however heartbeat fences or stops N1 in this case, we'll deliver a
(successful) stop or fence notification to the incarnation running on
N2, which will call out to 'drbdadm mark-peer-dead' and basically do the
same.

You may find
http://wiki.trick.ca/linux-ha/ClusterResourceManager_2fMultipleIncarnationResources
an interesting read here. (Also the link to the MultiStateResources in
there.)

It's almost implemented, the drbd agent is already written (proof of
concept code stage), and Andrew tells me we'll have the multiple
incarnations within a few weeks too.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

