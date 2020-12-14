Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
	[209.85.208.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 93168420809
	for <drbd-dev@lists.linbit.com>; Mon, 14 Dec 2020 11:18:28 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id h16so16566859edt.7
	for <drbd-dev@lists.linbit.com>; Mon, 14 Dec 2020 02:18:28 -0800 (PST)
To: Michael D Labriola <michael.d.labriola@gmail.com>
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <73f05081-b548-72cd-0068-5b1641f43ca9@linbit.com>
Date: Mon, 14 Dec 2020 11:18:25 +0100
MIME-Version: 1.0
In-Reply-To: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Get drbd-9.0 branch building with Linux 5.9 and 5.10
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

Hi Michael,

Thanks for this great contribution!

Unfortunately, we duplicated some work here, but neither of us could 
have known that :)
Over the last few days I fabricated some patches that fix some of the 
same problems, ultimately leading to the same result.

I'll review your patches – on first glance it seems like some of your 
approaches may actually be better than mine. If the patches are exactly 
the same, I'll attribute you since you published your patches first. 
I'll mix and match with my patches, since they are more thorough in some 
places (for example, I did go to the trouble of creating a compat test 
for sched_setscheduler()).

Some of these patches are still under internal review, so this may take 
some time, but I'll let you know which of yours I chose.

Thanks again!

--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

On 12/13/20 6:58 AM, Michael D Labriola wrote:
> Hey, everyone! I had the chance to try building the latest drbd-9.0
> code against the 5.9 and 5.10 kernels this afternoon. Things almost
> built, but not quite.  I made a series of commits to get things
> compiling.  Most of it is trivial compat test changes and following
> along w/ what's already been done in the mainline drbd8 module to get
> it ready for 5.10.
> 
> I did not create a compat test for the switch from
> sched_setscheduler() to sched_set_fifo_low() yet.  Mostly, because
> I've never done that and have to wrap my head around how to add
> another test. ;-)
> 
> I tried submitting a pull request via github, but got the auto-close
> message.  So, here's take two.
> 
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> https://lists.linbit.com/mailman/listinfo/drbd-dev
> 
