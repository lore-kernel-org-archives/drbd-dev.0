Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[96.44.175.130])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2036E420471
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 18:18:38 +0200 (CEST)
Message-ID: <49a877f33a088edc232eb98029e46e53884c5cd6.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiang Jian <jiangjian@cdjrlc.com>, axboe@kernel.dk
Date: Wed, 22 Jun 2022 12:10:59 -0400
In-Reply-To: <20220622155220.8704-1-jiangjian@cdjrlc.com>
References: <20220622155220.8704-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: drbd: drbd_state: Fix typo in comments
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

On Wed, 2022-06-22 at 23:52 +0800, Jiang Jian wrote:
> Replace 'is' with 'it'
> 
> file: drivers/block/drbd/drbd_state.c
> line: 1900
> 
> * But is is still not save to dreference ldev here, since
> 
> changed to:
> 
> * But it is still not save to dreference ldev here, since

I honestly don't think spelling and grammar updates to comments provide
much value.  However, there's no value at all if it's still two
spelling errors in that one line after the proposed patch ...

James


