Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (c-134-72-181.b.dial.de.ignite.net [62.134.72.181])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A005142F2
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jul 2004 14:12:06 +0200 (CEST)
Date: Fri, 30 Jul 2004 14:11:18 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] changelog for 0.7.1
Message-ID: <ntrcIE9nh4jqHK4hoAc39VQ=lge@web.de>
References: <200407301312.43896.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301312.43896.philipp.reisner@linbit.com>
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

/ 2004-07-30 13:12:43 +0200
\ Philipp Reisner:
> Everything there ?


hold it. I need to check in the "use_nbd_major" parameter again,
or lmb is unhappy ...

> 0.7.1 (api:75/proto:74)
> -----
>   *) Upgrade instructions for 0.6.x -> 0.7.0 and 0.7.0 -> 0.7.1
>   *) Workaround for XFS' IO requests with page count of zero.
>   *) Handle the human and the timeout count correctly in the new init script.
>   *) The implementation of the incon-degr-cmd was missing, added.
>   *) Longer timeouts in drbdadm for drbdsetup commands witch operate on 
>      meta data.
>   *) New major number 147 (officially registered at lanana.org).
>   *) Added a missing w_resume_next_wg() in case we stop syncing because
>      of connection loss.
>   *) Fixed a Linux-2.2-ismus in recieve_data_tail(). Should considerably
>      speed up protocols A and B.
>   *) Some work on vendor kernel compatibility

anything else?
I have to skimm on a diff first...

	lge
