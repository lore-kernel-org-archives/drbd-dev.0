Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8A6801028A68
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 13:24:06 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
References: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
	<20190425104320.s2dahoydcw5oztbl@rck.sh>
	<20190425110255.hrc6xdagdygixpac@rck.sh>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9996c784-5710-7afa-ac4e-5d3d63f70c43@i-love.sakura.ne.jp>
Date: Thu, 25 Apr 2019 20:23:55 +0900
MIME-Version: 1.0
In-Reply-To: <20190425110255.hrc6xdagdygixpac@rck.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 2019/04/25 20:02, Roland Kammerer wrote:
> On Thu, Apr 25, 2019 at 12:43:21PM +0200, Roland Kammerer wrote:
>> On Thu, Apr 25, 2019 at 06:29:11PM +0900, Tetsuo Handa wrote:
>>>  drbd/drbd_main.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
>>> index 80afdd8a..d48a5ea3 100644
>>> --- a/drbd/drbd_main.c
>>> +++ b/drbd/drbd_main.c
>>> @@ -966,7 +966,7 @@ static void new_or_recycle_send_buffer_page(struct drbd_send_buffer *sbuf)
>>>  		if (count == 1)
>>>  			goto have_page;
>>>  
>>> -		page = alloc_page(GFP_KERNEL);
>>> +		page = alloc_page(GFP_ATOMIC);
>>>  		if (page) {
>>>  			put_page(sbuf->page);
>>>  			sbuf->page = page;
>>
>> Thanks for reporting and a proposed fix. By coincidence this was already
>> fixed by Phil in our internal tree like this:

OK.

>>
>>> -		page = alloc_page(GFP_KERNEL);
>>> +		page = alloc_page(GFP_NOIP | __GFP_NOWARN);
> 
> And that is what you get when you type instead of copy/paste... This is
> the correcte one:
> 
> -               page = alloc_page(GFP_KERNEL);
> +               page = alloc_page(GFP_NOIO | __GFP_NOWARN);

Due to 'The "too small to fail" memory-allocation rule'
( https://lwn.net/Articles/627419/ ), I think that this allocation
would loop forever inside the page allocator until somebody volunteers
a page because this is called by a kernel thread which won't be killed
by the OOM killer. That is, __GFP_NOWARN unlikely makes sense.

What happens if nobody volunteers a page when current thread is
calling new_or_recycle_send_buffer_page() ? In other words, may I ask
the reason why GFP_NOIO is safe here?
