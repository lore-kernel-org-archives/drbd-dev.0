Return-Path: <axboe@kernel.dk>
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
	[209.85.210.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 69BF04201DC
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2022 01:09:54 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id s11so942188pfu.13
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2022 16:09:54 -0700 (PDT)
Message-ID: <078e8084-8fea-5b69-89a6-9488a28163cf@kernel.dk>
Date: Thu, 31 Mar 2022 17:09:51 -0600
MIME-Version: 1.0
Content-Language: en-US
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jakob Koschel <jakobkoschel@gmail.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
	<20220331220349.885126-2-jakobkoschel@gmail.com>
	<4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	linux-block@vger.kernel.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] drbd: remove check of list iterator
 against head past the loop body
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

On 3/31/22 4:28 PM, Christoph B?hmwalder wrote:
> Am 01.04.22 um 00:03 schrieb Jakob Koschel:
>> When list_for_each_entry() completes the iteration over the whole list
>> without breaking the loop, the iterator value will be a bogus pointer
>> computed based on the head element.
>>
>> While it is safe to use the pointer to determine if it was computed
>> based on the head element, either with list_entry_is_head() or
>> &pos->member == head, using the iterator variable after the loop should
>> be avoided.
>>
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element [1].
>>
> 
> Hi Jakob,
> 
> Both of these look good to me, thanks.
> 
> Reviewed-by: Christoph B?hmwalder <christoph.boehmwalder@linbit.com>

Applied both, but shortened title of this commit. Jakob, please keep it
within the usual 74 chars. In general, it's great to use a cover letter
for anything that's more than one patch. Just some pointers if you're
doing more of these.

-- 
Jens Axboe

