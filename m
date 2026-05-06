Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DFF081622C5
	for <drbd-dev@lists.linbit.com>; Wed,  6 May 2026 14:45:00 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
	5b1f17b1804b1-4890d945eb4so5607455e9.0
	for <drbd-dev@lists.linbit.com>; Wed, 06 May 2026 05:45:00 -0700 (PDT)
Date: Wed, 6 May 2026 14:44:58 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/2] drbd: switch from genl_magic to YNL
Message-ID: <afs3cyhtAbsr6T1D@localhost.localdomain>
References: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
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

On Wed, May 06, 2026 at 02:39:24PM +0200, Christoph Böhmwalder wrote:
>DRBD's genetlink interface was defined using a custom multi-include
>macro system, genl_magic_{func,struct}.h. This system generated struct
>definitions, netlink policies, serialization functions and more
>from a single "magic" header.
>It never really caught on; DRBD is its only user, its internal macro
>jungle is next to impossible to understand, and even harder to debug.
>
>This series replaces it with the standard solution, YNL.
>The *_gen.[ch] files were created with a modified YNL generator, but
>these modifications are not shipped because the current DRBD family is
>effectively frozen.
>
>Note: this family primarily aims for compatibility with existing
>userspace. The next planned step is a new (also YNL-based) family,
>"drbd2", which will implement all the actual modern recommendations for
>new netlink families.
>
>Changes from v1:
>- Remove YNL generator patches, ship just the generated code

Sorry everyone, this series was based on an old commit and does not
compile. Please disregard and look at v3 instead.
