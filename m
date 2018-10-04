Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 451D5101E042
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2018 21:18:56 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so11148755wrs.0
	for <drbd-dev@lists.linbit.com>; Thu, 04 Oct 2018 12:18:56 -0700 (PDT)
Date: Thu, 4 Oct 2018 21:18:54 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <20181004191854.GD10984@soda.linbit>
References: <20181002171447.10765-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002171447.10765-1-natechancellor@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH RESEND] drbd: avoid clang warning about
 pointless switch statement
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

On Tue, Oct 02, 2018 at 10:14:48AM -0700, Nathan Chancellor wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The drbd code causes warnings that we cannot easily disable when building with clang:
> 
> In file included from drivers/block/drbd/drbd_debugfs.c:10:
> In file included from drivers/block/drbd/drbd_int.h:48:
> In file included from include/linux/drbd_genl_api.h:53:
> In file included from include/linux/genl_magic_struct.h:237:
> include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'
> 
> There is nothing wrong with the code, and adding 'default:' labels
> in the right place is enough to let clang shut up about the warning.

Actually, I think I'd prefer a "case 0:" instead of the "default:",
because that would assert that we don't use a 0 for op or field numbers.

As at least some people seem to care, I suggest we bundle up
this and the other clang warning you just resent the patch for
with whatever else we may come up with for the next merge window
and send a pull request to Jens then.
In case we forget, please send a friendly reminder.

Thanks,

    Lars

