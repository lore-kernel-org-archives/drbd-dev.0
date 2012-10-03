Return-Path: <axboe@kernel.dk>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2C0F6100540F
	for <drbd-dev@lists.linbit.com>; Wed,  3 Oct 2012 12:24:15 +0200 (CEST)
Message-ID: <506BDECA.90701@kernel.dk>
Date: Wed, 03 Oct 2012 08:44:26 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <8391701.3EY4hQfmFv@fat-tyre>
In-Reply-To: <8391701.3EY4hQfmFv@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.3 updates
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2012-10-02 15:02, Philipp Reisner wrote:
> Hi Jens,
> 
> Please consider to pull these changes for the 3.7 merge window.
> 
> Best,
>  Phil
> 
> The following changes since commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:
> 
>   Linux 3.6 (2012-09-30 16:47:46 -0700)
> 
> are available in the git repository at:
> 
>   git://git.drbd.org/linux-drbd.git for-jens
> 
> for you to fetch changes up to a783d564a1badbb87b3f96aa8df581ed4167a9c9:
> 
>   drbd: log request sector offset and size for IO errors (2012-10-02 14:52:24 +0200)

Not pulled. Two reasons:

- It's late (in the merge window)
- and it's not based off my for-3.7/drivers branch, hence I get a ton of
  unrelated changes with a pull into that branch.

-- 
Jens Axboe

