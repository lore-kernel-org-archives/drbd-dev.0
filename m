Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C4BC01012A9A
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2018 21:10:09 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so10051386wme.3
	for <drbd-dev@lists.linbit.com>; Thu, 04 Oct 2018 12:10:09 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	x186-v6sm9220613wmx.24.2018.10.04.12.03.57
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 04 Oct 2018 12:03:57 -0700 (PDT)
Resent-Message-ID: <20181004190357.GC10984@soda.linbit>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A33B91013836
	for <drbd-dev@lists.linbit.com>; Tue,  2 Oct 2018 19:20:23 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id n23-v6so2975251wmc.1
	for <drbd-dev@lists.linbit.com>; Tue, 02 Oct 2018 10:20:23 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Date: Tue,  2 Oct 2018 10:14:48 -0700
Message-Id: <20181002171447.10765-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH RESEND] drbd: avoid clang warning about pointless
	switch statement
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

From: Arnd Bergmann <arnd@arndb.de>

The drbd code causes warnings that we cannot easily disable when building with clang:

In file included from drivers/block/drbd/drbd_debugfs.c:10:
In file included from drivers/block/drbd/drbd_int.h:48:
In file included from include/linux/drbd_genl_api.h:53:
In file included from include/linux/genl_magic_struct.h:237:
include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'

There is nothing wrong with the code, and adding 'default:' labels
in the right place is enough to let clang shut up about the warning.

Fixes: ec2c35ac1ea2 ("drbd: prepare the transition from connector to genetlink")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

This was recently resent by Philipp Klocke but the attribution on it
was incorrect (had Arnd's signoff but no From: line) and linux-block
wasn't cc'd, who presumably should take this patch since this file was
introduced by commit ec2c35ac1ea2 ("drbd: prepare the transition from
connector to genetlink"). If that is the case, perhaps these files
should be added to the drbd MAINTAINERS entry since they were introduced
by drbd and have been the only consumers since; I'd be happy to send a
patch if others agree.

It was acked by Lars on https://lore.kernel.org/patchwork/patch/756723/
so I don't know if this patch should carry

Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>

or not. I'll leave that up to the maintainer to decide.

Thanks!
Nathan

 include/linux/genl_magic_struct.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 5972e4969197..c11f42179c63 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -219,6 +221,7 @@ static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
 		s_fields						\
+		default:						\
 			;						\
 	}								\
 }
-- 
2.19.0

