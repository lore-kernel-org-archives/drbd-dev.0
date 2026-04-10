Return-Path: <axboe@kernel.dk>
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
	[74.125.82.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B5C051630D4
	for <drbd-dev@lists.linbit.com>; Fri, 10 Apr 2026 03:14:37 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
	5a478bee46e88-2ce102afb0aso1924914eec.1
	for <drbd-dev@lists.linbit.com>; Thu, 09 Apr 2026 18:14:37 -0700 (PDT)
Message-ID: <0cf7c152-a341-40e3-8359-23a633c812c6@kernel.dk>
Date: Thu, 9 Apr 2026 19:14:34 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: Christoph Hellwig <hch@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
	<adXk_m3SbRcWTOIC@infradead.org>
	<c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
	<addJ6uTc8Zo4GKpW@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <addJ6uTc8Zo4GKpW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/9/26 12:40 AM, Christoph Hellwig wrote:
> First an apology, I thought it was in your tree, but it looks like
> the drbd branch just has minor fixes.  So a lot less urgency.

No worries, figured you hadn't seen the previous discussion.

> On Wed, Apr 08, 2026 at 06:58:58AM -0600, Jens Axboe wrote:
>> See the previous discussion,
> 
> Do you have a pointer to that discussion?  I can't remember one.

I'm on pretty poor connectivity right now, but find some of my complaining
on linux-block in response to a previous Christian email.

>> the goal is to sync the two drbd code
>> bases. It's followed the "usual" pattern of the in-kernel driver being
>> neglected and development and users pushed to the out-of-tree one,
>> which is highly annoying.
> 
> I don't think that's a a usual pattern.  Also the new version looks
> like a complete rewrite and not something incremental:
> 
>  45 files changed, 45891 insertions(+), 16264 deletions(-)
> 
> For a code base that is "29482 total".
> 
> I think reviewing it would be easier by just adding an new drbd9 driver
> and then steering people toward it carefully, as that is actually
> reviewable compared to non-bisectable patches changing large chunks
> of code in a non-atomic way.

That is another approach we could take, but I don't think that would
make it any easier to review, to be honest. Nobody reviews a full
driver, their eyes just kind of gloss over.

Heads up - OOO for 1 week, will prep merge window stuff to the best
of my abilities, but won't be super responsive outside of that. As
this particular driver isn't going anywhere right now, there's no
urgency on that side of things.

-- 
Jens Axboe

