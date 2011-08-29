Return-Path: <greg.freemyer@gmail.com>
Received: from mail-gy0-f182.google.com (mail-gy0-f182.google.com
	[209.85.160.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4F4971005416
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 15:51:00 +0200 (CEST)
Received: by gyd10 with SMTP id 10so6979542gyd.27
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 06:50:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201108291346.29847.philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<CAGpXXZKem-uEdF4SyUgpQFV6=d5Vo3v9p3wmcaygAKa4w4x01w@mail.gmail.com>
	<201108291346.29847.philipp.reisner@linbit.com>
From: Greg Freemyer <greg.freemyer@gmail.com>
Date: Mon, 29 Aug 2011 09:26:16 -0400
Message-ID: <CAGpXXZK4wSCoVfyGpwt7ygN_8mqQ1cNzuVD4XsWXunJzUvEX+g@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
 support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 29, 2011 at 7:46 AM, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> Am Freitag, 26. August 2011, 15:20:51 schrieb Greg Freemyer:
>> On Thu, Aug 25, 2011 at 11:06 AM, Philipp Reisner <
>>
>> philipp.reisner@linbit.com> wrote:
>> > This the first request for review of drbd-8.4. The complete set has
>> > 500 patches. In this first series there are only 118 of these.
>>
>> Lars,
>>
>> I've only taken a quick glance, but is drbd functional between applying
>> each patch?
>>
>> It doesn't look like it to me, but I didn't look that close. =A0I also s=
aw at
>> least one patch that introduced a new function with no caller to test it=
.
>>
>> The idea is that a patch series leave a testable / functional kernel aft=
er
>> each patch in the series is applied sequentially.
>>
>> That is the only way git bisect can do its job.
>>
>> ie. Introducing a new function but no new caller makes a change, but the=
re
>> is no way to test it. =A0Therefore there is no real value in not merging=
 that
>> patch with one that has the new call in it.
>>
>
> Greg,
>
> You replied to mail 000. Please point out to which patch/function you
> refer, so that we can fix this.
>
> Best,
> =A0Phil

Phillip,

Take a look at patch 115 of 118 in your series.  I did not review the
whole series, I just poked around briefly and noticed this one.

Greg
