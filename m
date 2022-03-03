Return-Path: <keescook@chromium.org>
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
	[209.85.216.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5EA60420060
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2022 18:30:24 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id v4so5130802pjh.2
	for <drbd-dev@lists.linbit.com>; Thu, 03 Mar 2022 09:30:23 -0800 (PST)
Date: Thu, 3 Mar 2022 09:29:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <202203030929.BF0DE2B4@keescook>
References: <20220303113223.326220-1-hch@lst.de>
	<20220303113223.326220-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303113223.326220-6-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 5/5] loadpin: stop using bdevname
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

On Thu, Mar 03, 2022 at 02:32:23PM +0300, Christoph Hellwig wrote:
> Use the %pg format specifier to save on stack consuption and code size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
