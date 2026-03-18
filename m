Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 150D51622B5
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 22:13:56 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
	5b1f17b1804b1-48538c5956bso2098375e9.0
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 14:13:56 -0700 (PDT)
Message-ID: <f67a657b-bec5-404f-9435-a69f11b7e396@linbit.com>
Date: Wed, 18 Mar 2026 22:13:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH][next] drbd: Fix typos: "receive_peer_dagatg" ->
	"receive_peer_dagtag"
To: Jens Axboe <axboe@kernel.dk>, Colin Ian King <colin.i.king@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
References: <20260316202549.33978-1-colin.i.king@gmail.com>
	<ea558bc4-3efe-4eca-9da6-56f4a5302056@kernel.dk>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <ea558bc4-3efe-4eca-9da6-56f4a5302056@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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



Am 18.03.26 um 20:05 schrieb Jens Axboe:
> On 3/16/26 2:25 PM, Colin Ian King wrote:
>> There are a couple of typos in drbd_info and drbd_err messages.
>> Fix them.
> 
> Doesn't apply against for-next?
> 

This is against the drbd-next tree, which is included in linux-next
since a few days.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees#n267

I realize this is a bit awkward, since there is no way to really know
which patches target linux-next and which block/for-next.
Is there any specific way we could handle this to make it easier for you?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

