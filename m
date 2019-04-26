Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 91BE81028A61
	for <drbd-dev@lists.linbit.com>; Fri, 26 Apr 2019 12:07:12 +0200 (CEST)
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
	<3329030.LK3q2FzS93@fat-tyre>
	<95efb6b1-4f0c-e965-2977-5c8c85e04567@i-love.sakura.ne.jp>
	<4867162.iqFBJbCNh0@fat-tyre>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a16907b9-1363-e6b1-d61b-f4903f524908@i-love.sakura.ne.jp>
Date: Fri, 26 Apr 2019 19:07:03 +0900
MIME-Version: 1.0
In-Reply-To: <4867162.iqFBJbCNh0@fat-tyre>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Avoid GFP_KERNEL allocation from
 alloc_send_buffer()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2019/04/26 18:29, Philipp Reisner wrote:
>> If you guarantee that page count drops to 1 by waiting for the previous
>> send_page() to finish, GFP_NOWAIT | __GFP_NOWARN or GFP_NOIO |
>> __GFP_NORETRY | __GFP_NOWARN should be used instead of GFP_NOIO |
>> __GFP_NOWARN.
> 
> Ack. Do you want to send a patch that turns the current master into
> GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN
> ?
> 
> I will ack and apply it.
> 
> cheers.
> 

You can write that patch. Thank you for responding.
