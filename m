Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B6FFF2D9DB69
	for <drbd-dev@lists.linbit.com>; Wed, 17 Jan 2007 13:01:14 +0100 (CET)
Resent-Message-ID: <20070117120116.GB8413@soda.linbit>
Date: Tue, 16 Jan 2007 11:57:57 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20070116195757.GA6831@ca-server1.us.oracle.com>
References: <200701051506.52840.philipp.reisner@linbit.com>
	<20070109222804.GY6831@ca-server1.us.oracle.com>
	<200701111058.11212.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701111058.11212.philipp.reisner@linbit.com>
Cc: ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: [Ocfs2-devel] Fixing cluster/heartbeat.c's use of
	bio_add_page()
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jan 11, 2007 at 10:58:10AM +0100, Philipp Reisner wrote:
> My try of a 'The perfect patch':
> 
> Moved the bio_put() call into the bio's bi_end_io() function. This makes the
> whole idea of trying to predict the behaviour of bio_add_page() unnecessary.
> Removed compute_max_sectors() and o2hb_compute_request_limits().

Ok, this is uploading to ocfs2.git right now. It needs some testing in -mm
(and internally) for a while before I push it upstream. Have you tried this
in a cluster of more than one node?

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

