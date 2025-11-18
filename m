Return-Path: <BATV+0812c32a4ab075f64334+8122+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C7AE1608F4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 08:08:30 +0100 (CET)
Date: Mon, 17 Nov 2025 22:09:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: Re: [PATCH] drbd: add missing kernel-doc for peer_device parameter
Message-ID: <aRwNfiIWUVl5G0eX@infradead.org>
References: <20251117172557.355797-1-hsukrut3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117172557.355797-1-hsukrut3@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, david.hunter.linux@gmail.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, shuah@kernel.org,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 17, 2025 at 10:55:56PM +0530, Sukrut Heroorkar wrote:
> W=1 build warns that peer_device is undocumented in the bitmap I/O
> handlers. This parameter was introduced in commit 8164dd6c8ae1
> ("drbd: Add peer device parameter to whole-bitmap I/O handlers"), but
> the kernel-doc was not updated.
> 
> Add the missing @peer_device entry.

Or just make it a non-kerneldoc comment as it doesn't document an
external API to start with.

