Return-Path: <foo00@h08.hostsharing.net>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
	[83.223.95.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1FFBA4205E6
	for <drbd-dev@lists.linbit.com>; Fri, 23 Oct 2020 09:23:12 +0200 (CEST)
Date: Fri, 23 Oct 2020 09:23:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Elimar Riesebieter <riesebie@lxtec.de>
Message-ID: <20201023072312.GA14966@wunner.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
	<20201011185117.GA18543@wunner.de>
	<20201011193048.rfe5qvuba2ovrwed@toy.home.lxtec.de>
	<20201012005410.GA28362@wunner.de>
	<20201012111439.jyewfvopfsjeyvp3@toy.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012111439.jyewfvopfsjeyvp3@toy.home.lxtec.de>
Cc: Michael Hierweck <michael.hierweck@hostsharing.net>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH drbd-9.0] compat: __vmalloc() pgprot argument
 was removed in v5.8
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

Hi Elimar,

my apologies for the delay.

On Mon, Oct 12, 2020 at 01:14:39PM +0200, Elimar Riesebieter wrote:
> * Lukas Wunner <lukas@wunner.de> [2020-10-12 02:54 +0200]:
> > If you're unsuccessful debugging the build failure on your own,
> > maybe you can upload your drbd build directory somewhere so I
> > can take a look.
> 
> https://lxtec.de/drbd/drbd_dkms_buildir_hsh_201012.tar.xz

If coccinelle is not available, drbd-kernel-compat/gen_compat_patch.sh
attempts to fetch the coccinelle-generated patch from the cloud by
sending a POST request to https://drbd.io:2020/api/v1/spatch/9.0.25-1
with the locally-generated compat.h.

Because the cloud service generates the patch for the release version
9.0.25-1 and not for your locally-patched source, you end up with a
patch which doesn't work.

The solution is to disable usage of the cloud service by setting the
environment variable SPAAS=false and adding coccinelle >= 1.0.8 to
the drbd-dkms package's prerequisites.  It's not safe to use the
cloud service if you apply custom patches to the source code.

I was unable to reproduce the issue because I built from the git repo
and gen_compat_patch.sh never uses the cloud service in that case.

HTH,

Lukas
