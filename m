Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 314961622C4
	for <drbd-dev@lists.linbit.com>; Fri,  3 Apr 2026 15:24:42 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
	5b1f17b1804b1-4853e1ce427so24151555e9.3
	for <drbd-dev@lists.linbit.com>; Fri, 03 Apr 2026 06:24:42 -0700 (PDT)
Date: Fri, 3 Apr 2026 15:24:39 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/20] DRBD 9 rework
Message-ID: <ac-_fAsaSk-E_80R@localhost.localdomain>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
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

On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
>On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
>> As discussed (context: [0]), here is the first version of our DRBD 9
>> rework series, intended for for-next via for-7.1/drbd.
>
>Will you fixup the kerneldoc (nits) and the assigned-but-not-read
>issues and send out a new version? Also looks this series doesn't
>actually apply to for-7.1/block, patch 12 fails.
>
>-- 
>Jens Axboe

Right, the recent genl changes now cause a conflict. I'm rebasing now.
The nits are already incorporated and will land with v2.

Just for my own planning: what does your timing cycle look like for the
-next branch? I assume you also want to have that ready before the merge
window opens? Or is the schedule for -next more liberal?

Thanks,
Christoph
