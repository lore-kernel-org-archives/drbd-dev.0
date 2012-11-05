Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 349F9103B4D5
	for <drbd-dev@lists.linbit.com>; Mon,  5 Nov 2012 16:28:12 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <jaxboe@fusionio.com>
Date: Mon, 05 Nov 2012 16:28:11 +0100
Message-ID: <52007966.kIcQoKP8TK@fat-tyre>
In-Reply-To: <5097D090.1000208@fusionio.com>
References: <3728568.yDZLErye6B@fat-tyre> <1433815.PN8uhmSntl@fat-tyre>
	<5097D090.1000208@fusionio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [GIT PULL] 4 fixes for drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 5. November 2012, 15:43:28 schrieb Jens Axboe:
> On 2012-11-05 15:35, Philipp Reisner wrote:
> >> Can you rebase this against for-3.8/drivers? Thanks.
> > 
> > Hi Jens,
> > 
> > One of these changes fixes a regression that was introduced in the last
> > merge window. Please consider to pull this single commit.
> > (I will rebase the other 3 commit on for-3.8/drivers)
> > 
> > The following changes since commit a13c29ddf73d3be4fbb2b1bbced64014986cd87a:
> >   Jens Axboe (1):
> >         Merge branch 'for-jens' of
> >         git://git.kernel.org/pub/scm/linux/kernel/git/jikos/linux-block
> >         into for-3.7/drivers> 
> > are available in the git repository at:
> >   git://git.drbd.org/linux-drbd.git for-jens
> > 
> > Lars Ellenberg (1):
> >       drbd: fix regression: potential NULL pointer dereference
> >  
> >  drivers/block/drbd/drbd_int.h  |    5 +++++
> >  drivers/block/drbd/drbd_main.c |    8 ++++++--
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> Sure, of course I'll take a regression fix. But the fix does not apply
> to current tree:
> 
> axboe@nelson:/src/linux-block $ patch -p1 --dry-run < ~/1.txt
> patching file drivers/block/drbd/drbd_int.h
> Hunk #1 FAILED at 2545.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/block/drbd/drbd_int.h.rej patching file
> drivers/block/drbd/drbd_main.c
> Hunk #1 FAILED at 4232.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/block/drbd/drbd_main
> 
> Regression fixes for the current tree should be based on the current
> tree, looks like you used an outdated for-3.7/drivers branch and this
> fix depends on other fixes.

Hmm, apparently the changes I submitted to you on October 2 and 3
(which where pulled by you into the for-3.7/drivers tree) never found 
their way into Linus' tree. (I was not aware of that)

The mentioned patch fixes a regression there. 

Ok, then please ignore this pull request. I will send a new one for
for-3.8/drivers in a few days.

Best,
 Phil
