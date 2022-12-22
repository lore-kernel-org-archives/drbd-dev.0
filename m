Return-Path: <raj.khem@gmail.com>
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
	[209.85.215.177])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 20CEA42210F
	for <drbd-dev@lists.linbit.com>; Thu, 22 Dec 2022 04:20:22 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id b12so502066pgj.6
	for <drbd-dev@lists.linbit.com>; Wed, 21 Dec 2022 19:20:22 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: drbd-dev@lists.linbit.com
Message-Id: <20221222032018.1001700-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [Drbd-dev] [PATCH] replace off64_t with off_t
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
Date: Thu, 22 Dec 2022 03:20:25 -0000

off_t is already 64-bits when _FILE_OFFSET_BITS=64
using off_t also makes it portable on musl systems

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 user/v9/drbdadm_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/user/v9/drbdadm_main.c b/user/v9/drbdadm_main.c
index 91e9507d..2030946c 100644
--- a/user/v9/drbdadm_main.c
+++ b/user/v9/drbdadm_main.c
@@ -1264,11 +1264,11 @@ static int adm_resource(const struct cfg_ctx *ctx)
 	return ex;
 }
 
-static off64_t read_drbd_dev_size(int minor)
+static off_t read_drbd_dev_size(int minor)
 {
 	char *path;
 	FILE *file;
-	off64_t val;
+	off_t val;
 	int r;
 
 	m_asprintf(&path, "/sys/block/drbd%d/size", minor);
@@ -1289,9 +1289,9 @@ int adm_resize(const struct cfg_ctx *ctx)
 	char *argv[MAX_ARGS];
 	struct d_option *opt;
 	bool is_resize = !strcmp(ctx->cmd->name, "resize");
-	off64_t old_size = -1;
-	off64_t target_size = 0;
-	off64_t new_size;
+	off_t old_size = -1;
+	off_t target_size = 0;
+	off_t new_size;
 	int argc = 0;
 	int silent;
 	int ex;
-- 
2.39.0

