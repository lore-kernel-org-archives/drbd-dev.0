Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 32AFB1056332
	for <drbd-dev@lists.linbit.com>; Wed, 18 Jan 2017 04:12:34 +0100 (CET)
Message-Id: <587F4E0202000070000AC43C@prv-mh.provo.novell.com>
Date: Tue, 17 Jan 2017 20:14:10 -0700
From: "Nick Wang" <nwang@suse.com>
To: <drbd-dev@lists.linbit.com>
References: <1484288158-25952-1-git-send-email-nwang@suse.com>
	<20170113110345.GA9172@soda.linbit>
	<F749D893-B652-4BA8-AA15-AD88344EE2F9@acsalaska.com>
	<20170116103502.GF9172@soda.linbit>
In-Reply-To: <20170116103502.GF9172@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Fix the default node id
 initialization when upgrade v8 to v9
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>>> On 1/16/2017 at  6:35 下午, in message <20170116103502.GF9172@soda.linbit>,
Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
> > > Also, IMO, in virtually all 8 -> 9 upgrade scenarios, you are better off
> > > creating new DRBD 9 meta data instead of trying to "convert”.
> > 
> > Is there a technical reason
> 
> There are two basic scenarios, "rolling" upgrade,
> and "stop, replace, and restart the world". 
> 
> "stop the world" obviously means downtime.
> But for the "rolling" upgrade,
> you need more steps and at least a switchover,
> which typically also implies a downtime.
> 
> My preferred upgrade procedure would be "replace the world"
>  * make sure all data is "stable" and in sync
>  * stop all services (yes, that means a short down time)
>  * upgrade modules
>  * recreate meta data, and prepare to skip the initial sync,
>    because we know everything is in sync (see first step)
>    potentially allocating more bitmap slots in preparation for N > 2.
>  * bring it all online.
> 
> If that is not acceptable, or you think the rolling upgrade incurs less
> service interruption, you go with the "upgrade meta data in place"
> procedure, and hope we got that right :-)
> 
The rolling upgrade as long as the network protocol support can 
shorten the downtime to the switch-over time. If all data is in sync, 
i think the md(activity log and bitmaps) is safe to be replaced.

So far, for all the scenarios i tried, both "convert meta data" for still 
2 nodes and "replace meta data with a new one" for adding more nodes
works for a rolling upgrade on secondary node when all data is in sync:)

Best regards,
Nick
