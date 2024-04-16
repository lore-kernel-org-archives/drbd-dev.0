Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D31524201D7
	for <drbd-dev@lists.linbit.com>; Tue, 16 Apr 2024 15:42:20 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
	ffacd0b85a97d-346359c8785so3402119f8f.0
	for <drbd-dev@lists.linbit.com>; Tue, 16 Apr 2024 06:42:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:42:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: I-HSIN CHENG <richard120310@gmail.com>
Subject: Re: [PATCH] lru_cache: Initialize hlist_head in lc_create
Message-ID: <Zh6AOaymY1kF+V8F@grappa.linbit>
References: <20240311030735.233470-1-richard120310@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311030735.233470-1-richard120310@gmail.com>
Cc: philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On Mon, Mar 11, 2024 at 11:07:35AM +0800, I-HSIN CHENG wrote:
> Use INIT_HLIST_HEAD to perform the initialization for each pointer to
> struct list_head in the variable "slot" to provide more safety and
> prevent possible bugs from uninitialized behavior.

Completely pointless.  It is kcalloc'd.  Why explicitly zero-out something
that was already explicitly zeroed out to begin with.

    Lars
