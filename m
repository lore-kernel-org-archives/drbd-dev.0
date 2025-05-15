Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AA17E16B860
	for <drbd-dev@lists.linbit.com>; Thu, 15 May 2025 04:48:28 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
	ffacd0b85a97d-3a0bcb1f1afso62840f8f.0
	for <drbd-dev@lists.linbit.com>; Wed, 14 May 2025 19:48:28 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [PATCH v2 2/2] remove lock file after using it
Date: Thu, 15 May 2025 10:48:15 +0800
Message-ID: <20250515024817.25717-3-heming.zhao@suse.com>
In-Reply-To: <20250515024817.25717-1-heming.zhao@suse.com>
References: <20250515024817.25717-1-heming.zhao@suse.com>
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

In a SELinux env, if a user runs as root to set up a DRBD device,
it will leave a lock file in "/var/run/drbd/lock/". Then HA pacemaker
will fail to set up DRBD because of a permission issue.

This commit removes the lock file when drbdsetup and drbdmeta close
the lock fd.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 user/shared/drbdmeta.c    |  3 +++
 user/shared/shared_tool.c | 40 +++++++++++++++++++++++++++++----------
 user/shared/shared_tool.h |  2 +-
 user/v84/drbdsetup.c      |  2 +-
 user/v9/drbdsetup.c       |  2 +-
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/user/shared/drbdmeta.c b/user/shared/drbdmeta.c
index 099592a530da..c84c09abef86 100644
--- a/user/shared/drbdmeta.c
+++ b/user/shared/drbdmeta.c
@@ -5482,6 +5482,9 @@ int main(int argc, char **argv)
 	if (minor_attached)
 		fprintf(stderr, "# Output might be stale, since minor %d is attached\n", cfg->minor);
 
+	if ((cfg->minor != -1) && (cfg->lock_fd != -1))
+		dt_unlock_drbd(cfg->lock_fd, cfg->minor);
+
 	// dummy bool normalization to not return negative values, the usual "FIXME sane exit codes" still applies */
 	return !!rv;
 	/* and if we want an explicit free,
diff --git a/user/shared/shared_tool.c b/user/shared/shared_tool.c
index 20598132a0ac..b45d71379d96 100644
--- a/user/shared/shared_tool.c
+++ b/user/shared/shared_tool.c
@@ -759,9 +759,26 @@ void ensure_dir(const char *dirname)
 	}
 }
 
+static char *get_lock_filename(int minor, int check_dir)
+{
+	int sz;
+	char *lfname;
+
+	if (check_dir)
+		ensure_dir(drbd_lock_dir());
+
+	sz = asprintf(&lfname, "%s/drbd-%d-%d",
+		      drbd_lock_dir(), LANANA_DRBD_MAJOR, minor);
+	if (sz < 0) {
+		perror("");
+		exit(20);
+	}
+	return lfname;
+}
+
 int dt_lock_drbd(int minor)
 {
-	int sz, lfd;
+	int lfd;
 	char *lfname;
 
 	/* THINK.
@@ -777,14 +794,7 @@ int dt_lock_drbd(int minor)
 	 * We should store something in the meta data to detect such abuses.
 	 */
 
-	ensure_dir(drbd_lock_dir());
-	sz = asprintf(&lfname, "%s/drbd-%d-%d",
-		      drbd_lock_dir(), LANANA_DRBD_MAJOR, minor);
-	if (sz < 0) {
-		perror("");
-		exit(20);
-	}
-
+	lfname = get_lock_filename(minor, 1);
 	lfd = get_fd_lockfile_timeout(lfname, 1);
 	free (lfname);
 	if (lfd < 0)
@@ -793,10 +803,20 @@ int dt_lock_drbd(int minor)
 }
 
 /* ignore errors */
-void dt_unlock_drbd(int lock_fd)
+void dt_unlock_drbd(int lock_fd, int minor)
 {
+	int ret;
+	char *lfname;
+
 	if (lock_fd >= 0)
 		unlock_fd(lock_fd);
+
+	lfname = get_lock_filename(minor, 0);
+	ret = unlink(lfname);
+	free(lfname);
+	if (ret < 0) {
+		perror("unlink");
+	}
 }
 
 void dt_print_gc(const uint32_t* gen_cnt)
diff --git a/user/shared/shared_tool.h b/user/shared/shared_tool.h
index 3dedf79683f5..44f10b549a77 100644
--- a/user/shared/shared_tool.h
+++ b/user/shared/shared_tool.h
@@ -108,7 +108,7 @@ extern bool addr_scope_local(const char *input);
 extern unsigned long long m_strtoll(const char* s,const char def_unit);
 extern int only_digits(const char *s);
 extern int dt_lock_drbd(int minor);
-extern void dt_unlock_drbd(int lock_fd);
+extern void dt_unlock_drbd(int lock_fd, int minor);
 extern int dt_minor_of_dev(const char *device);
 extern void dt_print_gc(const uint32_t* gen_cnt);
 extern void dt_pretty_print_gc(const uint32_t* gen_cnt);
diff --git a/user/v84/drbdsetup.c b/user/v84/drbdsetup.c
index 9127a4462a0e..530af7b70b95 100644
--- a/user/v84/drbdsetup.c
+++ b/user/v84/drbdsetup.c
@@ -3715,7 +3715,7 @@ int main(int argc, char **argv)
 	rv = cmd->function(cmd, argc, argv);
 
 	if ((context & CTX_MINOR) && !cmd->lockless)
-		dt_unlock_drbd(lock_fd);
+		dt_unlock_drbd(lock_fd, minor);
 	return rv;
 }
 #endif
diff --git a/user/v9/drbdsetup.c b/user/v9/drbdsetup.c
index 8aa9b7c48a6a..e7fa4d8bad7b 100644
--- a/user/v9/drbdsetup.c
+++ b/user/v9/drbdsetup.c
@@ -4779,6 +4779,6 @@ int drbdsetup_main(int argc, char **argv)
 	rv = cmd->function(cmd, argc, argv);
 
 	if ((context & CTX_MINOR) && !cmd->lockless)
-		dt_unlock_drbd(lock_fd);
+		dt_unlock_drbd(lock_fd, minor);
 	return rv;
 }
-- 
2.43.0

