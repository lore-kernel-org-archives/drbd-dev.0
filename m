Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6E16D108B5E6
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 14:38:04 +0200 (CEST)
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com
	[172.24.198.81]) by smtp-out.google.com with ESMTP id o4HCc32Z004761
	for <drbd-dev@lists.linbit.com>; Mon, 17 May 2010 05:38:03 -0700
From: Iustin Pop <iustin@google.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 17 May 2010 14:37:57 +0200
Message-Id: <cover.1274099535.git.iustin@google.com>
Cc: Iustin Pop <iustin@google.com>
Subject: [Drbd-dev] [PATCH 0/3] Implement {begin|after}-resync-source
	handlers
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

These small patches duplicate the resync-target handlers for the other
end of the connection.

Some notes:

- I'm not familiar with drbdadm itself, so I'm not sure if the changes
  to it are sane; I did check and test that the kernel changes are fine
  and fire the proper callbacks, but was not able to test the drbdadm
  configuration
- Aborting if the userspace helper exits with non-zero code is done to
  mirror the before-resync-target helper; but ignoring its result is
  another choice, if tearing down the connections is deemed to harsh

Iustin Pop (3):
  Implement before|after-resync-source in drbdadm
  Make the drbd driver generate resync-source callbacks
  Update documentation for resync-source handlers

 documentation/drbd.conf.xml |   27 ++++++++++++++++++++++++++-
 drbd/drbd_worker.c          |   14 ++++++++++++++
 scripts/drbd.conf.example   |    4 ++++
 scripts/global_common.conf  |    2 ++
 user/drbdadm_main.c         |    2 ++
 user/drbdadm_scanner.fl     |    2 ++
 6 files changed, 50 insertions(+), 1 deletions(-)

