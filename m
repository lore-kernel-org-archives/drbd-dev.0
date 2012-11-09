Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 31FB3103B4D5
	for <drbd-dev@lists.linbit.com>; Fri,  9 Nov 2012 16:19:53 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 09 Nov 2012 16:19:52 +0100
Message-ID: <15372058.EgEfohI4mf@fat-tyre>
In-Reply-To: <509D1830.8010103@kernel.dk>
References: <3042269.jrNem7z1LI@fat-tyre> <509D10A3.8040203@kernel.dk>
	<509D1830.8010103@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4.2 for the linux-3.8 merge window
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 9. November 2012, 15:50:24 schrieb Jens Axboe:
> On 2012-11-09 15:18, Jens Axboe wrote:
> > On 2012-11-09 14:33, Philipp Reisner wrote:
> >> Jens, here it is without the sysfs stuff
> > 
> > Thanks, pulled into for-3.8/drivers
> 
> I didn't say anything, but I've been fuming a bit the last few series of
> merge windows. You need to stop these insanely massive pull requests.
> I've been large since this is "just a driver", but it can't continue. We
> should have reached stability a long time ago. Your pull requests
> contain a shit load of items, are you guys paying per commit? Look at
> these:
> 
>       drbd: Request lookup code cleanup (1)
>       drbd: Request lookup code cleanup (2)
>       drbd: Request lookup code cleanup (3)
>       drbd: Request lookup code cleanup (4)
> 

We are living there in the belief that we should break up big
changes in review able chunks....

> or
> 
>       drbd: conn_send_cmd2(): Return 0 upon success and an error code
> otherwise drbd: _conn_send_cmd(): Return 0 upon success and an error code
> otherwise drbd: _drbd_send_cmd(): Return 0 upon success and an error code
> otherwise drbd: conn_send_cmd(): Return 0 upon success and an error code
> otherwise
> 

Function by function gets converted to the "return 0 upon success" call
semantics.
Do you prefer that all of that should be done in a single commit?

> along with FIFTY or so more of these. WTF is this?
> 
>       drbd: Converted helper functions for drbd_send() to tconn
>       drbd: Converted drbd_send() from mdev to tconn
>       drbd: Converted drbd_send_fp() from mdev to tconn
> 

Should it instead be in a single commit?

> 
> I don't think I need to go on. So from now on, to get items into the
> kernel, what you will do is:
> 
> - Stop doing insane commits like the above. It just doesn't make sense.
> 
> - Send pull requests in a timely fashion. No more of this "lets collect
>   ALL the things" then send it off. Collect small bug fixes, send those
>   off. Develop some feature or make some changes, send that off. Etc.

That works well for individual features, and we have been doing that
for the last two Years.

But at this time we changed the object model. In the old code we had
a single kind of DRBD-in-kernel-object: a resource
Now we have two kinds: resources and volumes.

8.3: a resource had a single implicit volume

8.4: a resource might contain multiple volumes, each volume belongs to
     a single resource.

In the next ~12 month you will get only small features/updates etc... for
the 8.4 code base.

> The fact that your initial pull request had to MASK all these commits
> should have rung big bells in your head. It's a clear sign of a huge
> problem in your development model. If you can't clean this up, then
> it's not going in.

Fundamental changes in our object model require such huge change sets.
Jens, we will not stop where we are today. We plan to introduce a new
object: a connection. (The ability to mirror for one machine to *multiple*
receivers.)

Is it a better fit to introduce it then as a new driver? 
E.g. called it "drbd9". 
Should it use a new major number?

Best,
 Phil
