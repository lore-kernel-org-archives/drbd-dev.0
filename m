Return-Path: <evdo.hsdpa@gmail.com>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7E0CD1017A2C
	for <drbd-dev@lists.linbit.com>; Wed, 16 May 2012 08:45:24 +0200 (CEST)
Received: by yhgm50 with SMTP id m50so650309yhg.27
	for <drbd-dev@lists.linbit.com>; Tue, 15 May 2012 23:45:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4277851.LeAnKnANCB@fat-tyre>
References: <4277851.LeAnKnANCB@fat-tyre>
Date: Wed, 16 May 2012 15:45:22 +0900
Message-ID: <CA+xKNSheVa7d22oztUQao1s3HdZeQCM-QQzwDNsSHasH-scOQg@mail.gmail.com>
From: Robert Kim App and Facebook Marketing <evdo.hsdpa@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: multipart/alternative; boundary=14dae9d678cad4d30204c021a990
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.3 updates
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--14dae9d678cad4d30204c021a990
Content-Type: text/plain; charset=ISO-8859-1

Jens,

Guys...

Can you post this online... on a blog or something so i have a goto place
for all updates???

My email just gets swamped!


Hi Jens,
>
> This are the updates we have in the drbd-8.3 tree. They are intended
> for your "for-3.5/drivers" drivers branch.
>
> These changes include one new feature:
>  * Allow detach from frozen backing devices with the new --force option;
>   configurable timeout for backing devices by the new disk-timeout option
>
> And huge number of bug fixes:
>  * Fixed a write ordering problem on SyncTarget nodes for a write
>   to a block that gets resynced at the same time. The bug can
>   only be triggered with a device that has a firmware that
>   actually reorders writes to the same block
>  * Fixed a race between disconnect and receive_state, that could cause
>   a IO lockup
>  * Fixed resend/resubmit for requests with disk or network timeout
>  * Make sure that hard state changed do not disturb the connection
>   establishing process (I.e. detach due to an IO error). When the
>   bug was triggered it caused a retry in the connect process


-- 
Robert Q Kim
Social Media Agencies and Publicity
http://www.youtube.com/watch?v=cIFyEuGqdwI
2611 S Coast Highway
San Diego, CA 92007
310 598 1606

--14dae9d678cad4d30204c021a990
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jens,=A0<div><br></div><div>Guys...</div><div><br></div><div>Can you post t=
his online... on a blog or something so i have a goto place for all updates=
???</div><div><br></div><div>My email just gets swamped!<br><br><br><div cl=
ass=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Jens,<br>
<br>
This are the updates we have in the drbd-8.3 tree. They are intended<br>
for your &quot;for-3.5/drivers&quot; drivers branch.<br>
<br>
These changes include one new feature:<br>
=A0* Allow detach from frozen backing devices with the new --force option;<=
br>
 =A0 configurable timeout for backing devices by the new disk-timeout optio=
n<br>
<br>
And huge number of bug fixes:<br>
=A0* Fixed a write ordering problem on SyncTarget nodes for a write<br>
 =A0 to a block that gets resynced at the same time. The bug can<br>
 =A0 only be triggered with a device that has a firmware that<br>
 =A0 actually reorders writes to the same block<br>
=A0* Fixed a race between disconnect and receive_state, that could cause<br=
>
 =A0 a IO lockup<br>
=A0* Fixed resend/resubmit for requests with disk or network timeout<br>
=A0* Make sure that hard state changed do not disturb the connection<br>
 =A0 establishing process (I.e. detach due to an IO error). When the<br>
 =A0 bug was triggered it caused a retry in the connect process</blockquote=
></div><div><br></div>-- <br>Robert Q Kim<br>Social Media Agencies and Publ=
icity</div><div><a href=3D"http://www.youtube.com/watch?v=3DcIFyEuGqdwI">ht=
tp://www.youtube.com/watch?v=3DcIFyEuGqdwI</a></div>
<div>2611 S Coast Highway<br>San Diego, CA 92007<br>310 598 1606<br>
</div>

--14dae9d678cad4d30204c021a990--
