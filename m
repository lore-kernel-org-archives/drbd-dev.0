Return-Path: <lmb@suse.de>
Date: Tue, 7 Sep 2004 14:06:31 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040907120631.GI10035@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071139.29609.philipp.reisner@linbit.com>
	<20040907101343.GA5638@nudl>
	<200409071332.02477.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409071332.02477.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T13:32:02,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> > similar after bootup:
> >   we refuse to be promoted to Primary from Secondary/Unknown,
> >   unless we got an explicit "peer dead" confirmation by someone.
> >
> > does that make any sense?
> >
> I like it a lot!
> 
> Thus we will not call it "drbdadm resume-io r0" but 
> "drbdadm peer-dead r0"

The drbd proof of concept Resource Agent I wrote actually calls this
command "mark-peer-dead", so we are quite in alignment ;-)

Note that in particular this could be set before even drbd itself
notices; which is more easily understood than getting a "resume_io"
command before drbd had even suspended IO.

> Also the question at the startup-user-dialog: 
> 
> Is the peer dead ? 
> 
> Is easier to get right....

Yep. It's also much easier to code for.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

