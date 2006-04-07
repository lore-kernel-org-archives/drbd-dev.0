Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0C31716190
	for <drbd-dev@lists.linbit.com>; Fri,  7 Apr 2006 14:00:18 +0200 (CEST)
Date: Fri, 7 Apr 2006 14:00:19 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20060407120019.GE10083@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] about drbd "fencing" config option
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-04-06 11:15:02 -0600
\ Alan Robertson:
> Philipp Reisner wrote:
> >Hi,
> >Again an 8.0 pre release. There where _no_ actual bug reports
> >for the first pre release, so this release has no actual
> >bug fixes, only smoothing the rough edges:
> >8.0-pre2 (api:81/proto:80)
> >--------
> > * removed the "on-disconnect" and "split-brain-fix" config options and
> >   added the "fencing" config option instead.
> 
> What's a fencing option do?

configure how we behave when we think that "someone" should do fencing.

for example:
 we are Connected Primary/Secondary
 we lose replication channel
 "fencing = DontCare" --> we just keep goin, we are the primary after all
 	this risks diverging data sets in case of split brain.
 "fencing = resource" --> we invoke the "outdate-peer-handler",
	which currently is a hackish script using ssh, but should
	eventually become something that utilises heartbeat comunication
	channels.  heartbeat should not have stonith configured here, or
	we risk that in the event of total communication loss -->
	stonith the other node might win, and we might have acknowledged
	transactions within the time period "connection loss" to "beeing
	stonithed", that then will be gone.
 "fencing = stonith"
	we expect heartbeat to have stonith configured, so we will
	freeze all io immediately, invoke the outdate-peer-handler, and
	will only unfreeze io when this handler returns success --
	or some higher authority explicitly unfreeze us.
	the handler should attempt (or trigger) resource level fencing
	first, (mark peer as "outdated") and fallback to stonith if
	resource level fencing did not work out.

	this could also be called the "oracle mode",
	though orcale people probably want write-quorum >= 2,
	which will be implemented someday, too.

 stonith should, if configured, always be implemented as "switch off",
 not as "reset", to avoid them stonithing each other.

 if you configure drbd fencing=resource, but have stonith configured in
 heartbeat, that is a configuration error.

 if you configure drbd fencing=stonith, but have no stonith configured
 in heartbeat, that will freeze io uneccessarily.
   
 if you have fencing = resource, and no stonith configured, we need not
 freeze io and still avoid diverging data sets even during total
 communication loss: a secondary that has any doubt about the peers disk
 state will refuse to become primary, whereas a primary that does not
 know about its peers disk state will continue to be primary.

 if after a cluster crash the cluster should come up without
 communication, one cannot promote drbd to primary until communication
 is restored or "some authority" explicitly assures one of the nodes
 that the other node has been fenced.
 
 if one node knows that the peers disk is "bad" (has been marked "outdated",
 is "inconsistent"), this is stored in meta data, so that a degraded
 cluster may crash/reboot and become primary anyways.
 obviously we do not store "peers disk is good", that would be stupid.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
