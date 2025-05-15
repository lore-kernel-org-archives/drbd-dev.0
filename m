Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 92CC716B836
	for <drbd-dev@lists.linbit.com>; Thu, 15 May 2025 04:48:24 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
	ffacd0b85a97d-3a0b3f62d1aso61177f8f.1
	for <drbd-dev@lists.linbit.com>; Wed, 14 May 2025 19:48:24 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [PATCH v2 0/2] fix drbd-utils minor issues
Date: Thu, 15 May 2025 10:48:13 +0800
Message-ID: <20250515024817.25717-1-heming.zhao@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: zzhou@suse.com
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

This patchset fixes two issues:
- configure reports WARNING for SuSe-release file
- lock file permission issue in SELinux env

v1->v2
factor out shared code for creating lfname
add free lfname job after unlink()

Heming Zhao (2):
  build: changing SUSE release file
  remove lock file after using it

 configure.ac              |  4 ++--
 user/shared/drbdmeta.c    |  3 +++
 user/shared/shared_tool.c | 40 +++++++++++++++++++++++++++++----------
 user/shared/shared_tool.h |  2 +-
 user/v84/drbdsetup.c      |  2 +-
 user/v9/drbdsetup.c       |  2 +-
 6 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.43.0

