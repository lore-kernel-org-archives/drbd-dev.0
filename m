Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
	[209.85.214.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BD4FA4202CC
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2024 12:22:32 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
	d9443c01a7336-20570b42f24so22757735ad.1
	for <drbd-dev@lists.linbit.com>; Fri, 27 Sep 2024 03:22:32 -0700 (PDT)
Message-ID: <4a250753-2bca-4ea3-87ef-af6d6a6b0ac5@kernel.dk>
Date: Fri, 27 Sep 2024 04:22:29 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v1] drbd: Fix typos in the comment
To: Yan Zhen <yanzhen@vivo.com>, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com
References: <20240927095735.228661-1-yanzhen@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240927095735.228661-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, opensource.kernel@vivo.com,
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

On 9/27/24 3:57 AM, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'mutliple' ==> 'multiple',
> 'droped' ==> 'dropped',
> 'Suprisingly' ==> 'Surprisingly',
> 'chage' ==> 'change',
> 'typicaly' ==> 'typically',
> 'progres' ==> 'progress',
> 'catched' ==> 'caught',
> 'protocoll' ==> 'protocol',
> 'stroage' ==> 'storage',
> 'independend' ==> 'independent'.

We generally don't do spelling fixes, unless it's done as part of
a fix. That avoids needless churn that just causes backporting pain.

-- 
Jens Axboe

