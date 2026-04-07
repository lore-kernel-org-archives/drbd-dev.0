Return-Path: <axboe@kernel.dk>
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
	[209.85.161.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 67AD5160645
	for <drbd-dev@lists.linbit.com>; Tue,  7 Apr 2026 04:22:16 +0200 (CEST)
Received: by mail-oo1-f46.google.com with SMTP id
	006d021491bc7-682fce74c06so2701387eaf.3
	for <drbd-dev@lists.linbit.com>; Mon, 06 Apr 2026 19:22:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260403132953.2248751-1-christoph.boehmwalder@linbit.com>
References: <20260403132953.2248751-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: remove DRBD_GENLA_F_MANDATORY flag handling
Message-Id: <177552853342.149947.7297762019080456826.b4-ty@b4>
Date: Mon, 06 Apr 2026 20:22:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Johannes Berg <johannes.berg@intel.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
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


On Fri, 03 Apr 2026 15:29:53 +0200, Christoph Böhmwalder wrote:
> DRBD used a custom mechanism to mark netlink attributes as "mandatory":
> bit 14 of nla_type was repurposed as DRBD_GENLA_F_MANDATORY. Attributes
> sent from userspace that had this bit present and that were unknown
> to the kernel would lead to an error.
> 
> Since commit ef6243acb478 ("genetlink: optionally validate strictly/dumps"),
> the generic netlink layer rejects unknown top-level attributes when
> strict validation is enabled. DRBD never opted out of strict
> validation, so unknown top-level attributes are already rejected by
> the netlink core.
> 
> [...]

Applied, thanks!

[1/1] drbd: remove DRBD_GENLA_F_MANDATORY flag handling
      commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31

Best regards,
-- 
Jens Axboe



