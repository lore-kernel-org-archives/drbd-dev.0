Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
	[209.85.166.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7C3C14202E9
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2023 21:26:41 +0200 (CEST)
Received: by mail-il1-f179.google.com with SMTP id e6so5167512ilu.9
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2023 12:26:41 -0700 (PDT)
Message-ID: <e5b78f91-122a-0b0d-8d3f-922d462ba44d@kernel.dk>
Date: Mon, 27 Mar 2023 13:26:39 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Joel Fernandes <joel@joelfernandes.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
	<CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, "Uladzislau Rezki \(Sony\)" <urezki@gmail.com>,
	linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 01/14] drbd: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
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

On 3/26/23 6:27 AM, Joel Fernandes wrote:
> On Wed, Mar 15, 2023 at 2:19 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
>>
>> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>>
>> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
>> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
>> avoid accidental use of the single-argument forms, which can introduce
>> functionality bugs in atomic contexts and latency bugs in non-atomic
>> contexts.
>>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: Philipp Reisner <philipp.reisner@linbit.com>
>> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Jens/Others, any chance for an Ack here?

Begrudgingly-acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


