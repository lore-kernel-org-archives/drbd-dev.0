Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust184.tnt13.ber2.deu.da.uu.net
	[149.225.240.184])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4C872142F8
	for <drbd-dev@lists.linbit.com>; Mon, 23 Aug 2004 16:32:42 +0200 (CEST)
Date: Mon, 23 Aug 2004 16:28:04 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] gen_counts and primary --human
Message-ID: <LytGKyglmnZR/Bdz2MpV2To=lge@web.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<20040819113205.GP9601@marowsky-bree.de>
	<R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: </+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

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

I'd suggest to ignore the --human flag when connected.
It does not make sense in the connected case.

	lge


