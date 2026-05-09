Return-Path: <axboe@kernel.dk>
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
	[209.85.161.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C9DD81611C5
	for <drbd-dev@lists.linbit.com>; Sat,  9 May 2026 15:58:20 +0200 (CEST)
Received: by mail-oo1-f51.google.com with SMTP id
	006d021491bc7-6948fb494a0so1584185eaf.2
	for <drbd-dev@lists.linbit.com>; Sat, 09 May 2026 06:58:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
References: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Message-Id: <177833509787.32015.11244289527797673484.b4-ty@b4>
Date: Sat, 09 May 2026 07:58:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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


On Wed, 06 May 2026 14:45:39 +0200, Christoph Böhmwalder wrote:
> DRBD's genetlink interface was defined using a custom multi-include
> macro system, genl_magic_{func,struct}.h. This system generated struct
> definitions, netlink policies, serialization functions and more
> from a single "magic" header.
> It never really caught on; DRBD is its only user, its internal macro
> jungle is next to impossible to understand, and even harder to debug.
> 
> [...]

Applied, thanks!

[1/2] drbd: move UAPI headers to include/uapi/linux/
      (no commit info)
[2/2] drbd: replace genl_magic with explicit netlink serialization
      (no commit info)

Best regards,
-- 
Jens Axboe



