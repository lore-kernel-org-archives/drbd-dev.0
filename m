Return-Path: <axboe@kernel.dk>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D6E18101AC56
	for <drbd-dev@lists.linbit.com>; Sat,  1 Dec 2018 19:38:52 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id z9so4399273pfi.2
	for <drbd-dev@lists.linbit.com>; Sat, 01 Dec 2018 10:38:52 -0800 (PST)
To: Frank Lee <tiny.windzz@gmail.com>
References: <20181201142414.7766-1-tiny.windzz@gmail.com>
	<5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
	<CAEExFWtJEJwgGR3gqfHDXw-c4nyA7dkQTd9fkzVsht=ROmfgMQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <92334639-9d34-5e6a-2c43-945a20077394@kernel.dk>
Date: Sat, 1 Dec 2018 11:38:48 -0700
MIME-Version: 1.0
In-Reply-To: <CAEExFWtJEJwgGR3gqfHDXw-c4nyA7dkQTd9fkzVsht=ROmfgMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	pjk1939@linux.vnet.ibm.com, nbd@other.debian.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, ed.cashin@acm.org,
	josh.h.morris@us.ibm.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] block: Change to use
	DEFINE_SHOW_ATTRIBUTE macro
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

On 12/1/18 11:31 AM, Frank Lee wrote:
> On Sun, Dec 2, 2018 at 2:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/1/18 7:24 AM, Yangtao Li wrote:
>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>>
>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>> ---
>>> changes in v2:
>>> -Modify some function names to avoid compilation errors
>>
>> The fact that your previous patch didn't even compile doesn't fill me
>> with a lot of confidence in the amount of diligence and testing
>> you apply to your patches.
>>
>> Why would you send something out that you didn't even compile?
>>
>> --
>> Jens Axboe
>>
> These changes are the same and only require a small change.
> Most of the changes are fine, so it's a bit negligent.

When someone is sending a patch for inclusion, at the very minimum
I expect it to have been compiled, and preferably tested too. Doesn't
matter how small the change is, even a one-liner should go through that.

That said, I'm not a huge fan of changes like this. It completely
hides what is going on for someone reading the code, and it's not
like there's a win on code size for example. The only win seems to
be that driver writes can't mess it up, which is a nice benefit.

-- 
Jens Axboe

