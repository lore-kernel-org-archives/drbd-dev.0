Return-Path: <axboe@kernel.dk>
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
	[209.85.167.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C5204160849
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2026 14:11:24 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id
	5614622812f47-464ba2bb3aeso555922b6e.1
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2026 06:11:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260324152907.2840984-1-christoph.boehmwalder@linbit.com>
References: <20260324152907.2840984-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: use genl pre_doit/post_doit
Message-Id: <177444428198.640671.15773217946231288835.b4-ty@b4>
Date: Wed, 25 Mar 2026 07:11:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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


On Tue, 24 Mar 2026 16:29:07 +0100, Christoph Böhmwalder wrote:
> Every doit handler followed the same pattern: stack-allocate an
> adm_ctx, call drbd_adm_prepare() at the top, call drbd_adm_finish()
> at the bottom. This duplicated boilerplate across 25 handlers and
> made error paths inconsistent, since some handlers could miss sending
> the reply skb on early-exit paths.
> 
> The generic netlink framework already provides pre_doit/post_doit
> hooks for exactly this purpose. An old comment even noted "this
> would be a good candidate for a pre_doit hook".
> 
> [...]

Applied, thanks!

[1/1] drbd: use genl pre_doit/post_doit
      commit: 630bbba45cfd3e4f9247cefd3e2cdc03fe40421b

Best regards,
-- 
Jens Axboe



