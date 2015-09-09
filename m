Return-Path: <cvubrugier@fastmail.fm>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 38D18100EC11
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:16:16 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 696CB206E7
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 09:16:14 -0400 (EDT)
Received: from PAL-U515208D001.lacie.com (200.5-14-84.ripe.coltfrance.com
	[84.14.5.200])
	by mail.messagingengine.com (Postfix) with ESMTPA id D07A4C0028F
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 09:16:13 -0400 (EDT)
From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To: drbd-dev@lists.linbit.com
Date: Wed,  9 Sep 2015 15:16:05 +0200
Message-Id: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
Subject: [Drbd-dev] [PATCH 0/2] drbd-utils: build fixes for the musl C
	library
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

Hi,

Here are two patches that fix compilation errors when drbd-utils is
built with the musl C library.

The errors were encountered when building drbd-utils with Buildroot,
an embedded build system that supports musl toolchains. Buildroot has
a nice build bot that builds a set of packages for several target
architectures and with several toolchains. drbd-utils builds currently
fail when the build is performed with a musl toolchain.

Here is an example of a build that failed:

  http://autobuild.buildroot.net/results/b6a/b6aa71e60f2db5f3378186e06a11d7bbca0f2eb5/build-end.log

Christophe Vu-Brugier (2):
  drbd_endian: fix compilation error with the musl C library
  drbdmeta: drop usage of strndupa() which is not provided by musl

 user/shared/drbd_endian.h | 2 +-
 user/shared/drbdmeta.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.5.0

