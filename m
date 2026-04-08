Return-Path: <axboe@kernel.dk>
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
	[209.85.210.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7CB96160849
	for <drbd-dev@lists.linbit.com>; Wed,  8 Apr 2026 14:59:00 +0200 (CEST)
Received: by mail-ot1-f51.google.com with SMTP id
	46e09a7af769-7dbf23885dfso1380143a34.3
	for <drbd-dev@lists.linbit.com>; Wed, 08 Apr 2026 05:59:00 -0700 (PDT)
Message-ID: <c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
Date: Wed, 8 Apr 2026 06:58:58 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: Christoph Hellwig <hch@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
	<adXk_m3SbRcWTOIC@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <adXk_m3SbRcWTOIC@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
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

On 4/7/26 11:17 PM, Christoph Hellwig wrote:
> On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
>> On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
>>> As discussed (context: [0]), here is the first version of our DRBD 9
>>> rework series, intended for for-next via for-7.1/drbd.
>>
>> Will you fixup the kerneldoc (nits) and the assigned-but-not-read
>> issues and send out a new version? Also looks this series doesn't
>> actually apply to for-7.1/block, patch 12 fails.
> 
> Looks like all this went in without any review?  Since when have we
> started these grand replacements anyway, as they are known to cause
> bugs and regressions?

See the previous discussion, the goal is to sync the two drbd code
bases. It's followed the "usual" pattern of the in-kernel driver being
neglected and development and users pushed to the out-of-tree one,
which is highly annoying.

As per the previous thread, the intent is not to push to to mainline
right now, but rather give it -next exposure without running into
conflicts between the trees. for-7.x/drbd will be rebased as needed,
and it's only in for-next for the stated reason.

-- 
Jens Axboe

