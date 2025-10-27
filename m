Return-Path: <nphamcs@gmail.com>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C60A21626D9
	for <drbd-dev@lists.linbit.com>; Mon, 27 Oct 2025 23:46:22 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
	5b1f17b1804b1-475dbc3c9efso19996135e9.0
	for <drbd-dev@lists.linbit.com>; Mon, 27 Oct 2025 15:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 27 Oct 2025 15:46:10 -0700
Message-ID: <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
To: jinji zhong <jinji.z.zhong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-doc@vger.kernel.org, roman.gushchin@linux.dev, mhocko@kernel.org,
	linux-mm@kvack.org, shakeel.butt@linux.dev,
	drbd-dev@lists.linbit.com, corbet@lwn.net,
	YoungJun Park <youngjun.park@lge.com>, senozhatsky@chromium.org,
	linux-block@vger.kernel.org, terrelln@fb.com, dsterba@suse.com,
	cgroups@vger.kernel.org, akpm@linux-foundation.org,
	axboe@kernel.dk, feng.han@honor.com, liulu.liu@honor.com,
	muchun.song@linux.dev, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	mkoutny@suse.com, hannes@cmpxchg.org, tj@kernel.org,
	zhongjinji@honor.com, lars.ellenberg@linbit.com
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

On Sat, Oct 25, 2025 at 6:53=E2=80=AFPM jinji zhong <jinji.z.zhong@gmail.co=
m> wrote:
>
> Hello everyone,
>
> On Android, different applications have varying tolerance for
> decompression latency. Applications with higher tolerance for
> decompression latency are better suited for algorithms like ZSTD,
> which provides high compression ratio but slower decompression
> speed. Conversely, applications with lower tolerance for
> decompression latency can use algorithms like LZ4 or LZO that
> offer faster decompression but lower compression ratios. For example,
> lightweight applications (with few anonymous pages) or applications
> without foreground UI typically have higher tolerance for decompression
> latency.
>
> Similarly, in memory allocation slow paths or under high CPU
> pressure, using algorithms with faster compression speeds might
> be more appropriate.
>
> This patch introduces a per-cgroup compression priority mechanism,
> where different compression priorities map to different algorithms.
> This allows administrators to select appropriate compression
> algorithms on a per-cgroup basis.
>
> Currently, this patch is experimental and we would greatly
> appreciate community feedback. I'm uncertain whether obtaining
> compression priority via get_cgroup_comp_priority in zram is the
> best approach. While this implementation is convenient, it seems
> somewhat unusual. Perhaps the next step should be to pass
> compression priority through page->private.

I agree with TJ's and Shakeel's take on this. You (or some other
zram/zswap users) will have to present a more compelling case for the
necessity of a hierarchical structure for this property :)

The semantics itself is unclear to me - what's the default? How should
inheritance be defined? What happens when cgroups are killed etc?

As a side note, seems like there is a proposal for swap device
priority (+ Youngjun)

https://lore.kernel.org/all/20250716202006.3640584-1-youngjun.park@lge.com/

Is this something you can leverage?

Another alternative is to make this zram-internal, i.e add knobs to
zram sysfs, or extend the recomp parameter. I'll defer to zram
maintainers and users to comment on this :)
