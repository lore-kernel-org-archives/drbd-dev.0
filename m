Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C3C072DF624E
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2008 11:37:12 +0200 (CEST)
Date: Thu, 11 Sep 2008 11:37:12 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Message-ID: <20080911093712.GD9756@soda.linbit>
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<20080911092512.GC9756@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080911092512.GC9756@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Sep 11, 2008 at 11:25:12AM +0200, Lars Ellenberg wrote:
> On Tue, Sep 09, 2008 at 04:02:30PM +0200, schoebel wrote:
> > Hi,
> > 
> > my company is considering drbd for building up failover clusters in
> > shared hosting.
> > 
> > During our preliminary tests, we noticed that a "drbdadm verify
> > /dev/drbdx" detects differences on a heavily loaded test server
> > (several thousand customers).
> > 
> > We noticed two kind of verify differences: one is surely temporary
> > (not repeatable), but the other is persistent, even after umounting
> > the filesystem.
> > 
> > According to the manpage on drbd.conf (section "notes on data integrity"), 
> > these should be "false positives".  Indeed, we found no real corruptions (all 
> > different blocks were associated with deleted files).
> > 
> > However, this means that verify is (in _our_ point of view) no _reliable_ 
> > check for data integrity. Since data integrity of our valuable customer data 
> > is of great concern for us, we look for possibilities to change the behavior 
> > such that no false positives are reported any more, i.e. any difference 
> > reported by verify should be _guaranteed_ to be a "true positive". In my 
> > humble opinion, so-called "mission critical" applications demand for that in 
> > general.

now.
an other thought here.

any application doing what your test perl scripts do
is risking its data, and is not crash safe.

aparently there are many of those.

if an application starts to rewrite a portion of a file it has written
to before, it should fsync() at some point, before it starts the
overwrite, so the buffers will be on disk
(ok "on device", no necessarily on rotating rust yet,
 but, while related, that is an other topic).

so as long as you run a postfix mailq
or a database tablespace on DRBD,
or similar applications that know how to behave,
I'd not expect any such "modify of in-flight buffers" to happen.

any application that does "not behave" is risking data integrity
(in event of [application, file system, device or node]crash/
 ower outage/failover).

For any "behaving" application, the "drbd verify integrity check" is
expected to be your "_reliable_" from above.

Am I missing something?

-- 
: Lars Ellenberg                
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
