Return-Path: <senozhatsky@chromium.org>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
	[209.85.214.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7116716090D
	for <drbd-dev@lists.linbit.com>; Tue, 28 Oct 2025 04:31:22 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
	d9443c01a7336-29476dc9860so41562165ad.0
	for <drbd-dev@lists.linbit.com>; Mon, 27 Oct 2025 20:31:21 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:31:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <4tqwviq3dmz2536eahhxxw6nj24tbg5am57yybgmmwcf4vtwdn@s7f4n2yfszbe>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
	<CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
Cc: muchun.song@linux.dev, linux-doc@vger.kernel.org, roman.gushchin@linux.dev,
	mhocko@kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
	drbd-dev@lists.linbit.com, corbet@lwn.net,
	YoungJun Park <youngjun.park@lge.com>,
	jinji zhong <jinji.z.zhong@gmail.com>, senozhatsky@chromium.org,
	linux-block@vger.kernel.org, terrelln@fb.com, dsterba@suse.com,
	cgroups@vger.kernel.org, akpm@linux-foundation.org,
	axboe@kernel.dk, feng.han@honor.com, liulu.liu@honor.com,
	minchan@kernel.org, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, mkoutny@suse.com,
	hannes@cmpxchg.org, tj@kernel.org, zhongjinji@honor.com,
	lars.ellenberg@linbit.com
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

On (25/10/27 15:46), Nhat Pham wrote:
> Another alternative is to make this zram-internal, i.e add knobs to
> zram sysfs, or extend the recomp parameter. I'll defer to zram
> maintainers and users to comment on this :)

I think this cannot be purely zram-internal, we'd need some "hint"
from upper layers which process/cgroup each particular page belongs
to and what's its priority.
