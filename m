Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
	[209.85.166.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8B22B4203DB
	for <drbd-dev@lists.linbit.com>; Tue, 14 Dec 2021 00:31:52 +0100 (CET)
Received: by mail-io1-f48.google.com with SMTP id p65so21060430iof.3
	for <drbd-dev@lists.linbit.com>; Mon, 13 Dec 2021 15:31:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Kees Cook <keescook@chromium.org>
In-Reply-To: <20211118203712.1288866-1-keescook@chromium.org>
References: <20211118203712.1288866-1-keescook@chromium.org>
Message-Id: <163943830994.160816.6815884532342154175.b4-ty@kernel.dk>
Date: Mon, 13 Dec 2021 16:31:49 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Use struct_group() to zero algs
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

On Thu, 18 Nov 2021 12:37:12 -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add a struct_group() for the algs so that memset() can correctly reason
> about the size.
> 
> [...]

Applied, thanks!

[1/1] drbd: Use struct_group() to zero algs
      commit: 52a0cab35c568f896067641d8e07f798341954f5

Best regards,
-- 
Jens Axboe


