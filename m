Return-Path: <kyle@moffetthome.net>
Received: from mail-wy0-f182.google.com (mail-wy0-f182.google.com
	[74.125.82.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7DF7C1055FBC
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 18:00:25 +0200 (CEST)
Received: by wyh15 with SMTP id 15so1756644wyh.27
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 09:00:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201108241641.42676.philipp.reisner@linbit.com>
References: <201108241641.42676.philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 24 Aug 2011 12:00:02 -0400
Message-ID: <CAGZ=bq+A1ExZYRnuBBwfAq7Ez37mpBtT1_T91AWcchDBZ3iqPw@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4 for mainline
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 24, 2011 at 10:41, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> Hi Jens,
>
> First the announcement of drbd-8.4, then the git pull-request text:
>
> We are proud to announce the availability of DRBD-8.4.0.
>
> =C2=A0The most noticeable change is the support for multiple replicated
> =C2=A0volumes in a single DRBD connection.
> =C2=A0Write-ordering is obeyed among all writes in all volumes in a
> =C2=A0single connection.
> =C2=A0This feature is really important for users who DRBD for mirroring
> =C2=A0over longer distances. (Protocol A).
>
> We do not only release DRBD-8.4.0 today:
> The DRBD User's Guide was reviewed and updated to match DRBD-8.4.
>
> I suggest to everybody who considers to upgrade from 8.3 to 8.4
> to have a look at the "Recent changes" appendix of the UG:
> http://www.drbd.org/users-guide/ap-recent-changes.html
>
> =C2=A0This release brings a new meta-data format. Forward (8.3 -> 8.4)
> =C2=A0conversion happens complete seamless. Backward conversion
> =C2=A0is done by a single command (drbdadm apply-al res).
>
> =C2=A0This release is protocol compatible with all it predecessor.
> =C2=A0Although, we do not recommend to run it in 8.3 - 8.4 for long
> =C2=A0time frames. We recommend to use that capability only for the
> =C2=A0rolling upgrade.
>
> =C2=A0drbdadm of 8.4 can parse config files of 8.3. We recommend
> =C2=A0to switch to the new configuration syntax after the upgrade
> =C2=A0of both nodes. (Use drbdadm dump to learn about the new
> =C2=A0config syntax)

Hm...

That's a lot of patches (including some protocol changes) that have not
yet been reviewed by other kernel developers.

By officially releasing the kernel and user-space bits and then posting
them to LKML and expecting them to be merged as-is, you are not really
following the linux kernel development process.

Some of the reverts and commit messages make me concerned that your
patch series has bisection issues; are you sure it compiles and runs
after every patch?

I'm obviously not anywhere in the maintenance chain for this code, but
it does look really funny.

Cheers,
Kyle Moffett
