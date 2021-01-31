Return-Path: <axboe@kernel.dk>
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
	[209.85.210.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6DA11420308
	for <drbd-dev@lists.linbit.com>; Sun, 31 Jan 2021 16:06:09 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id o20so9856330pfu.0
	for <drbd-dev@lists.linbit.com>; Sun, 31 Jan 2021 07:06:08 -0800 (PST)
To: Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <cover.1598331148.git.joe@perches.com>
	<1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
	<5deee552f4bcfd81c6dc6ec3e8139c0c4ba27d31.camel@perches.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8a2099ab-9b25-d79c-f421-0a3a2ca15720@kernel.dk>
Date: Sun, 31 Jan 2021 08:06:09 -0700
MIME-Version: 1.0
In-Reply-To: <5deee552f4bcfd81c6dc6ec3e8139c0c4ba27d31.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/29] drbd: Avoid comma separated statements
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

On 1/30/21 11:57 AM, Joe Perches wrote:
> On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
>> Use semicolons and braces.
> 
> ping?

Queued for 5.12.

-- 
Jens Axboe

