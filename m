Return-Path: <JAxboe@fusionio.com>
Received: from mx2.fusionio.com (mx2.fusionio.com [66.114.96.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 213D31013804
	for <drbd-dev@lists.linbit.com>; Mon,  5 Nov 2012 16:03:19 +0100 (CET)
Message-ID: <5097D090.1000208@fusionio.com>
Date: Mon, 5 Nov 2012 15:43:28 +0100
From: Jens Axboe <jaxboe@fusionio.com>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <3728568.yDZLErye6B@fat-tyre> <20121101100658.GM27975@kernel.dk>
	<1433815.PN8uhmSntl@fat-tyre>
In-Reply-To: <1433815.PN8uhmSntl@fat-tyre>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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

On 2012-11-05 15:35, Philipp Reisner wrote:
>>
>> Can you rebase this against for-3.8/drivers? Thanks.
> 
> Hi Jens,
> 
> One of these changes fixes a regression that was introduced in the last
> merge window. Please consider to pull this single commit.
> (I will rebase the other 3 commit on for-3.8/drivers)
> 
> 
> The following changes since commit a13c29ddf73d3be4fbb2b1bbced64014986cd87a:
>   Jens Axboe (1):
>         Merge branch 'for-jens' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/linux-block into for-3.7/drivers
> 
> are available in the git repository at:
> 
>   git://git.drbd.org/linux-drbd.git for-jens
> 
> Lars Ellenberg (1):
>       drbd: fix regression: potential NULL pointer dereference
> 
>  drivers/block/drbd/drbd_int.h  |    5 +++++
>  drivers/block/drbd/drbd_main.c |    8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)

Sure, of course I'll take a regression fix. But the fix does not apply
to current tree:

axboe@nelson:/src/linux-block $ patch -p1 --dry-run < ~/1.txt 
patching file drivers/block/drbd/drbd_int.h
Hunk #1 FAILED at 2545.
1 out of 1 hunk FAILED -- saving rejects to file drivers/block/drbd/drbd_int.h.rej
patching file drivers/block/drbd/drbd_main.c
Hunk #1 FAILED at 4232.
1 out of 1 hunk FAILED -- saving rejects to file drivers/block/drbd/drbd_main

Regression fixes for the current tree should be based on the current
tree, looks like you used an outdated for-3.7/drivers branch and this
fix depends on other fixes.

-- 
Jens Axboe

