Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5B379103B4BE
	for <drbd-dev@lists.linbit.com>; Tue, 18 Dec 2018 14:36:20 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id u6so7832027plm.8
	for <drbd-dev@lists.linbit.com>; Tue, 18 Dec 2018 05:36:20 -0800 (PST)
To: Nathan Chancellor <natechancellor@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
	<20181004200912.32348-1-natechancellor@gmail.com>
	<20181217172401.GA30635@flashbox>
	<0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
	<20181218092202.GJ5026@soda.linbit>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e5a59a80-791a-2c42-9820-31e1fe86d72f@kernel.dk>
Date: Tue, 18 Dec 2018 06:29:13 -0700
MIME-Version: 1.0
In-Reply-To: <20181218092202.GJ5026@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH v2] drbd: Avoid Clang warning about pointless
 switch statment
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

On 12/18/18 2:22 AM, Lars Ellenberg wrote:
> On Mon, Dec 17, 2018 at 10:29:38AM -0700, Jens Axboe wrote:
>>> Hi Lars and Philipp,
>>>
>>> Could you please make sure that this patch and the other one I sent make
>>> it into 4.21/5.0? I am not sure when you were planning on sending the
>>> pull request to Jens that you mentioned in the other thread but I've
>>> noticed most maintainers typically send their requests for the impending
>>> merge window around -rc7 or so and I wanted to make sure it was on your
>>> radar.
> 
> I'm sorry.
> From my point of view, "fixing the pointless switch" is just "pointless",
> so it (again) fell through.  I get it that it is important to others,
> and getting rid of Clang warnings is a good thing.  So sorry again.
> 
>> It needs to get here now, but drbd hasn't really sent anything in for
>> about a year,
> 
> Last actual fix was 2018-06-25 64dafbc9530c drbd: fix access after free
> so almost six month, yes.

It just dropped from its usual cadence of regular updates.

>> so I'm starting to doubt how maintained it is at this
>> point.
> 
> Oh, it is maintained.  It is just happens to be "stable".
> We don't add new features there,
> and I'm currently not aware of any misbehavior.

Well, I guess that's good news then :-)

> I'll prepare a pull request containing this,
> the other Clang warning patch from Nathan,
> and possibly other small stuff that accumulated,
> if I can find any, and send that out later today.
> 
> Thanks for the reminder,

Thank.

-- 
Jens Axboe

