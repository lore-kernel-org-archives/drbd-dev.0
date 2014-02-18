Return-Path: <axboe@kernel.dk>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
	[209.85.216.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 487FB101AC75
	for <drbd-dev@lists.linbit.com>; Tue, 18 Feb 2014 21:27:30 +0100 (CET)
Received: by mail-qc0-f182.google.com with SMTP id c9so26153484qcz.41
	for <drbd-dev@lists.linbit.com>; Tue, 18 Feb 2014 12:27:29 -0800 (PST)
Date: Tue, 18 Feb 2014 12:20:54 -0800
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20140218202054.GD25515@kernel.dk>
References: <1426530.nXFczoq90f@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1426530.nXFczoq90f@fat-tyre>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT pull] DRBD code reorganization
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

On Mon, Feb 17 2014, Philipp Reisner wrote:
> Hi Jens,
> 
> I have here a number of patches, that do not change any functionality.
> All patches from Rashika Kheria clean up compiler warnings, like making
> functions static etc... . All patches from Andreas Grünbacher restructure
> code for further improvements. A single bugfix is hidden in there, that
> was committed by me.
> 
> Rashika patches where posted for review on LKML on December 19, 2013.
> The other patches where posted for review on LKML on December 20 and 23.
> 
> This is of course for your tree that is intended for the 3.15 merge window.
> Since you have not created a for-3.15/drivers branch as of today, I based
> this on Linus' 2.14-rc3.

Pulled into a for-3.15/drivers branch.

-- 
Jens Axboe

