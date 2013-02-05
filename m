Return-Path: <axboe@kernel.dk>
Received: from bombadil.infradead.org
	(173-166-109-252-newengland.hfc.comcastbusiness.net
	[173.166.109.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9F6771019A3E
	for <drbd-dev@lists.linbit.com>; Tue,  5 Feb 2013 14:20:55 +0100 (CET)
Date: Tue, 5 Feb 2013 14:19:55 +0100
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20130205131955.GT15092@kernel.dk>
References: <2148524.Qc3kYa9ye0@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2148524.Qc3kYa9ye0@fat-tyre>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd build fix in case CONFIG_CRYPTO_HMAC
	is not set
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Feb 04 2013, Philipp Reisner wrote:
> The following changes since commit d88c3ab963d4cce09b25ef661b871bd7af6dad0d:
> 
>   drbd: only fail empty flushes if no good data is reachable (2013-01-30 10:40:33 +0100)
> 
> are available in the git repository at:
> 
>   git://git.drbd.org/linux-drbd.git for-jens-3.8-fix
> 
> for you to fetch changes up to 78aa7987a223e8542f2735dace439690c6171ac5:
> 
>   drbd: Fix build error when CONFIG_CRYPTO_HMAC is not set (2013-02-04 18:14:03 +0100)

NOT pulled. Base the branch off my for-linus. When I pull the below into
that, I don't get a small patch, I get all changes from 3.7 to 3.8-rc5.

-- 
Jens Axboe

