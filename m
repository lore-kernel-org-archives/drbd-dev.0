Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BE324103B4CA
	for <drbd-dev@lists.linbit.com>; Tue, 29 Jan 2019 10:47:45 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id q18so21237422wrx.9
	for <drbd-dev@lists.linbit.com>; Tue, 29 Jan 2019 01:47:45 -0800 (PST)
Date: Tue, 29 Jan 2019 10:42:31 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <20190129094230.ezjzpfwf5xx47luu@rck.sh>
References: <20190123064501.GA26147@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123064501.GA26147@embeddedor>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Philip Kelleher <pjk1939@linux.ibm.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: Mark expected switch fall-throughs
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

On Wed, Jan 23, 2019 at 12:45:01AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/block/drbd/drbd_int.h      | 2 +-
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  drivers/block/drbd/drbd_req.c      | 2 +-
>  drivers/block/rsxx/core.c          | 1 +
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 

Hi Gustavo,

as also discussed with Lars in person, obviously OK for the DRBD part.

Acked-by: Roland Kammerer <roland.kammerer@linbit.com>

Best, rck
