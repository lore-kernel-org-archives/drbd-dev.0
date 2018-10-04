Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7AFC11011B93
	for <drbd-dev@lists.linbit.com>; Thu, 11 Oct 2018 11:02:42 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so8142425wma.3
	for <drbd-dev@lists.linbit.com>; Thu, 11 Oct 2018 02:02:42 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	q17-v6sm16058610wrw.19.2018.10.11.02.02.40
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Oct 2018 02:02:41 -0700 (PDT)
Resent-Message-ID: <20181011090240.GD5528@soda.linbit>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 80E401011BEC
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2018 22:10:03 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so10136360wmf.1
	for <drbd-dev@lists.linbit.com>; Thu, 04 Oct 2018 13:10:03 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Date: Thu,  4 Oct 2018 13:09:13 -0700
Message-Id: <20181004200912.32348-1-natechancellor@gmail.com>
In-Reply-To: <20181002171447.10765-1-natechancellor@gmail.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2] drbd: Avoid Clang warning about pointless
	switch statment
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

There are several warnings from Clang about no case statement matching
the constant 0:

In file included from drivers/block/drbd/drbd_receiver.c:48:
In file included from drivers/block/drbd/drbd_int.h:48:
In file included from ./include/linux/drbd_genl_api.h:54:
In file included from ./include/linux/genl_magic_struct.h:236:
./include/linux/drbd_genl.h:321:1: warning: no case matching constant
switch condition '0'
GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/genl_magic_struct.h:220:10: note: expanded from macro
'GENL_struct'
        switch (0) {
                ^

Silence this warning by adding a 'case 0:' statement. Additionally,
adjust the alignment of the statements in the ct_assert_unique macro to
avoid a checkpatch warning.

This solution was originally sent by Arnd Bergmann with a default case
statement: https://lore.kernel.org/patchwork/patch/756723/

Link: https://github.com/ClangBuiltLinux/linux/issues/43
Suggested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Since this is not the same as Arnd's patch, I took authorship for it
while leaving a link to the original patch in the commit message. If
this is not how it should have been done, please let me know.

 include/linux/genl_magic_struct.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 5972e4969197..eeae59d3ceb7 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -218,7 +220,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
 static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
-		s_fields						\
+	s_fields							\
+	case 0:								\
 			;						\
 	}								\
 }
-- 
2.19.0

