Return-Path: <greg.freemyer@gmail.com>
Received: from mail-vx0-f182.google.com (mail-vx0-f182.google.com
	[209.85.220.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5DC7C10556C6
	for <drbd-dev@lists.linbit.com>; Fri, 26 Aug 2011 15:29:16 +0200 (CEST)
Received: by vxh11 with SMTP id 11so4636332vxh.27
	for <drbd-dev@lists.linbit.com>; Fri, 26 Aug 2011 06:29:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
From: Greg Freemyer <greg.freemyer@gmail.com>
Date: Fri, 26 Aug 2011 09:20:51 -0400
Message-ID: <CAGpXXZKem-uEdF4SyUgpQFV6=d5Vo3v9p3wmcaygAKa4w4x01w@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: multipart/alternative; boundary=bcaec5171ec5d7abc504ab686b1e
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

--bcaec5171ec5d7abc504ab686b1e
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 25, 2011 at 11:06 AM, Philipp Reisner <
philipp.reisner@linbit.com> wrote:

> This the first request for review of drbd-8.4. The complete set has
> 500 patches. In this first series there are only 118 of these.
>
>
Lars,

I've only taken a quick glance, but is drbd functional between applying each
patch?

It doesn't look like it to me, but I didn't look that close.  I also saw at
least one patch that introduced a new function with no caller to test it.

The idea is that a patch series leave a testable / functional kernel after
each patch in the series is applied sequentially.

That is the only way git bisect can do its job.

ie. Introducing a new function but no new caller makes a change, but there
is no way to test it.  Therefore there is no real value in not merging that
patch with one that has the new call in it.

Greg

--bcaec5171ec5d7abc504ab686b1e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Aug 25, 2011 at 11:06 AM, Philip=
p Reisner <span dir=3D"ltr">&lt;<a href=3D"mailto:philipp.reisner@linbit.co=
m" target=3D"_blank">philipp.reisner@linbit.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">


This the first request for review of drbd-8.4. The complete set has<br>
500 patches. In this first series there are only 118 of these.<br>
<br></blockquote></div><br>Lars,<br><br>I&#39;ve only taken a quick glance,=
 but is drbd functional between applying each patch?<br><br>It doesn&#39;t =
look like it to me, but I didn&#39;t look that close.=A0 I also saw at leas=
t one patch that introduced a new function with no caller to test it.<br>

<br>The idea is that a patch series leave a testable / functional kernel af=
ter each patch in the series is applied sequentially.<br>
<br>That is the only way git bisect can do its job.<br><br>ie. Introducing =
a new function but no new caller makes a change, but there is no way to tes=
t it.=A0 Therefore there is no real value in not merging that patch with on=
e that has the new call in it.<br>

<br>Greg<br>

--bcaec5171ec5d7abc504ab686b1e--
