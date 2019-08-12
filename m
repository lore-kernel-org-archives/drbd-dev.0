Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BB22E101AC44
	for <drbd-dev@lists.linbit.com>; Mon, 12 Aug 2019 07:18:05 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id 31so103481213wrm.1
	for <drbd-dev@lists.linbit.com>; Sun, 11 Aug 2019 22:18:05 -0700 (PDT)
Date: Mon, 12 Aug 2019 07:18:03 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190812051803.pkmmm5ize2f2plki@rck.sh>
References: <1bc428a7-2cab-fba7-f521-d96ba1f6c7df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bc428a7-2cab-fba7-f521-d96ba1f6c7df@gmail.com>
Subject: Re: [Drbd-dev] using new cocci config on older kernels
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

On Sun, Aug 11, 2019 at 11:20:04AM -0600, David Butterfield wrote:
> In drbd-9.0/drbd, using the August 2 checkin "Prepare 10.0.0a1":
> I tried building with a few different kernel versions, using commands of the form (e.g.):
>     wget https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.4.113.tar.gz
>     ...
>     make clean; make -i KDIR=linux-3.4.113
> 
> First question is whether I should be expecting that to work all the way back to the
> expected DRBD limit of 2.6.32, or if the limit has (intentionally) been changed?

No. With DRBD10 we will give up RHEL6 kernels. From a quick look at the
build matrix, RHEL7 then has the oldest kernel we will support.

All in all the build magic/compat, especially for HEAD (which is the dev
branch for 10; there is also a stable one for 9.0.X) needs some love.

So yeah, thanks, but for now play with something else, it will make you
happier :D

Regards, rck
