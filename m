Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A60BE4203D0
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2020 11:08:48 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id q4so8339440edv.13
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2020 02:08:48 -0700 (PDT)
To: "T.J. Yang" <tjyang2001@gmail.com>
References: <CAD2GW8rEcO0rYaFbi3y8FC3ps7koyyN_ihvHZ8iRGrps_=-TFQ@mail.gmail.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <1c55844c-a927-3ae3-e31b-a1de4addef79@linbit.com>
Date: Mon, 27 Jul 2020 11:08:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAD2GW8rEcO0rYaFbi3y8FC3ps7koyyN_ihvHZ8iRGrps_=-TFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Lower MIN_SPATCH_VERSION to 1.0.7 ?
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

On 22.03.20 17:33, T.J. Yang wrote:
> Hi
> 
> Can MIN_SPATCH_VERSION be set to 1.0.7 in upstream code base ?
> 
> CentOS 8 only have rpm package(coccinelle) for version 1.0.7.
> With version 1.0.7 set, I was able to make drbd.
> 
> [me@centos8t01 drbd]$ grep MIN_SPATCH_VERSION=   
>   drbd-kernel-compat/gen_compat_patch.sh
> MIN_SPATCH_VERSION=1.0.7
> [me@centos8t01 drbd]$ make
> 
>      Calling toplevel makefile of kernel source tree, which I believe is in
>      KDIR=/lib/modules/4.18.0-187.el8.x86_64/source
> 
> make -C /lib/modules/4.18.0-187.el8.x86_64/source 
>   O=/lib/modules/4.18.0-187.el8.x86_64/build 
> M=/build/me/github/drbd/drbd  modules
>    Building modules, stage 2.
>    MODPOST 2 modules
> mv .drbd_kernelrelease.new .drbd_kernelrelease
> Memorizing module configuration ... done.
> [me@centos8t01 drbd]$
> 
> -- 
> T.J. Yang
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> https://lists.linbit.com/mailman/listinfo/drbd-dev
> 

Hi,

Sorry for the late reply, it seems like this got stuck in moderation.

Unfortunately we need a really recent version of spatch which almost no 
distribution has packaged. This is in part because we use some features 
which we actually requested from the coccinelle developers in order to 
make it work for our use case.

It seems like you got lucky with your kernel. RHEL8 has a pretty recent 
kernel, so there is not a lot to patch, so we don't use a lot of exotic 
new features.

This changes for older distributions, such as RHEL6 (and maybe even 
RHEL7), where there is no way that it would ever build with an spatch 
version <1.0.8. Since we build for lots of different kernels for our 
commercially supported packages (111 at time of writing), the oldest 
spatch version we can safely support is 1.0.8.

However, we have implemented some measures to hopefully ease the pain 
that comes from this. For one, we pre-generate some compat patches for 
the most common distributions. These are included in our release 
tarballs, which are available from our website. I realize that back in 
March these may not have been included for your kernel version, but I'm 
pretty sure they are now.

Secondly, we have also implemented a service called "SPAAS" (spatch as a 
service). This is a webservice which can generate a compat patch for a 
DRBD release for any given kernel version. We made this available to our 
open source users so that building for custom "off-distribution" kernels 
would not be such a massive pain. Again, this is only available if you 
build from a release tarball without modifications to the source code.

And of course, you can make your life the easiest if you (or your 
employer) buy a support contract from us. Then we will build the 
packages for you and deliver them right to your doorstep :)

Best Regards,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
