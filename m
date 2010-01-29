Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4D1241011BEC
	for <drbd-dev@lists.linbit.com>; Fri, 29 Jan 2010 16:14:13 +0100 (CET)
Date: Fri, 29 Jan 2010 10:13:51 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20100129151351.GB19249@hmsreliant.think-freely.org>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100129151024.GA19249@hmsreliant.think-freely.org>
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp, oleg@redhat.com,
	spock@gentoo.org, mingo@redhat.com, viro@zeniv.linux.org.uk,
	mfasheh@suse.com, akpm@linux-foundation.org,
	drbd-dev@lists.linbit.com, shemminger@linux-foundation.org,
	menage@google.com, abelay@mit.edu, t.sailer@alumni.ethz.ch
Subject: Re: [Drbd-dev] [PATCH 1/2] exec: allow core_pipe recursion check to
 look for a value of 1 rather than 0 (v2)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Add init function to usermodehelper

Convert call_usermodehelper_cleanup to usermodehelper_fns and allow it to assign
both an init function and a cleanup function.  The init function is called from
the context of the forked process and allows for customization of the helper
process prior to calling exec.  Its return code gates the continuation of the
process, or causes its exit.  Also add an arbitrary data pointer to the
subprocess_info struct allowing for data to be passed from the caller to the new
process, and the subsequent cleanup process

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 include/linux/kmod.h |   21 +++++++++++++-------
 kernel/kmod.c        |   53 ++++++++++++++++++++++++++++++++++++++++++---------
 kernel/sys.c         |    4 +--
 3 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 25d227c..54db3ff 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -48,7 +48,8 @@ struct subprocess_info;
 
 /* Allocate a subprocess_info structure */
 struct subprocess_info *call_usermodehelper_setup(char *path, char **argv,
-						  char **envp, gfp_t gfp_mask);
+						  char **envp, void *data,
+						  gfp_t gfp_mask);
 
 /* Set various pieces of state into the subprocess_info structure */
 void call_usermodehelper_setkeys(struct subprocess_info *info,
@@ -56,7 +57,9 @@ void call_usermodehelper_setkeys(struct subprocess_info *info,
 int call_usermodehelper_stdinpipe(struct subprocess_info *sub_info,
 				  struct file **filp);
 void call_usermodehelper_setcleanup(struct subprocess_info *info,
-				    void (*cleanup)(char **argv, char **envp));
+		    void (*cleanup)(char **argv, char **envp, void *data));
+void call_usermodehelper_setinit(struct subprocess_info *info,
+				 int (*init)(void *data));
 
 enum umh_wait {
 	UMH_NO_WAIT = -1,	/* don't wait at all */
@@ -72,15 +75,18 @@ int call_usermodehelper_exec(struct subprocess_info *info, enum umh_wait wait);
 void call_usermodehelper_freeinfo(struct subprocess_info *info);
 
 static inline int
-call_usermodehelper_cleanup(char *path, char **argv, char **envp, enum umh_wait wait,
-			    void (*cleanup)(char **, char **))
+call_usermodehelper_fns(char *path, char **argv, char **envp,
+		    enum umh_wait wait, int (*init)(void *data),
+		    void (*cleanup)(char **, char **, void *data), void *data)
 {
 	struct subprocess_info *info;
 	gfp_t gfp_mask = (wait == UMH_NO_WAIT) ? GFP_ATOMIC : GFP_KERNEL;
 
-	info = call_usermodehelper_setup(path, argv, envp, gfp_mask);
+	info = call_usermodehelper_setup(path, argv, envp, data, gfp_mask);
 	if (info == NULL)
 		return -ENOMEM;
+	if (init)
+		call_usermodehelper_setinit(info, init);
 	if (cleanup)
 		call_usermodehelper_setcleanup(info, cleanup);
 	return call_usermodehelper_exec(info, wait);
@@ -89,7 +95,8 @@ call_usermodehelper_cleanup(char *path, char **argv, char **envp, enum umh_wait
 static inline int
 call_usermodehelper(char *path, char **argv, char **envp, enum umh_wait wait)
 {
-	return call_usermodehelper_cleanup(path, argv, envp, wait, NULL);
+	return call_usermodehelper_fns(path, argv, envp,
+				       wait, NULL, NULL, NULL);
 }
 
 static inline int
@@ -99,7 +106,7 @@ call_usermodehelper_keys(char *path, char **argv, char **envp,
 	struct subprocess_info *info;
 	gfp_t gfp_mask = (wait == UMH_NO_WAIT) ? GFP_ATOMIC : GFP_KERNEL;
 
-	info = call_usermodehelper_setup(path, argv, envp, gfp_mask);
+	info = call_usermodehelper_setup(path, argv, envp, NULL, gfp_mask);
 	if (info == NULL)
 		return -ENOMEM;
 
diff --git a/kernel/kmod.c b/kernel/kmod.c
index 2db0689..cab23a8 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -51,7 +51,7 @@ static struct workqueue_struct *khelper_wq;
 */
 char *modprobe_path = "/sbin/modprobe";
 
-static void free_arg(char **argv, char **env)
+static void free_arg(char **argv, char **env, void *unused)
 {
 	kfree(argv[0]);
 }
@@ -133,8 +133,9 @@ int __request_module(bool wait, const char *fmt, ...)
 
 	trace_module_request(module_name, wait, _RET_IP_);
 
-	ret = call_usermodehelper_cleanup(mp_copy, argv, envp,
-			wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC, free_arg);
+	ret = call_usermodehelper_fns(mp_copy, argv, envp,
+			wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC,
+			NULL, free_arg, NULL);
 	mp_copy = NULL; /* free_arg frees */
 	atomic_dec(&kmod_concurrent);
 error:
@@ -154,7 +155,9 @@ struct subprocess_info {
 	enum umh_wait wait;
 	int retval;
 	struct file *stdin;
-	void (*cleanup)(char **argv, char **envp);
+	int (*init)(void *data);
+	void (*cleanup)(char **argv, char **envp, void *data);
+	void *data;
 };
 
 /*
@@ -198,6 +201,12 @@ static int ____call_usermodehelper(void *data)
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed_ptr(current, cpu_all_mask);
 
+	if (sub_info->init) {
+		retval = sub_info->init(sub_info->data);
+		if (retval)
+			goto fail;
+	}
+
 	/*
 	 * Our parent is keventd, which runs with elevated scheduling priority.
 	 * Avoid propagating that into the userspace child.
@@ -207,6 +216,7 @@ static int ____call_usermodehelper(void *data)
 	retval = kernel_execve(sub_info->path, sub_info->argv, sub_info->envp);
 
 	/* Exec failed? */
+fail:
 	sub_info->retval = retval;
 	do_exit(0);
 }
@@ -214,7 +224,7 @@ static int ____call_usermodehelper(void *data)
 void call_usermodehelper_freeinfo(struct subprocess_info *info)
 {
 	if (info->cleanup)
-		(*info->cleanup)(info->argv, info->envp);
+		(*info->cleanup)(info->argv, info->envp, info->data);
 	if (info->cred)
 		put_cred(info->cred);
 	kfree(info);
@@ -385,7 +395,8 @@ static inline void helper_unlock(void) {}
  * exec the process and free the structure.
  */
 struct subprocess_info *call_usermodehelper_setup(char *path, char **argv,
-						  char **envp, gfp_t gfp_mask)
+						  char **envp, void *data,
+						  gfp_t gfp_mask)
 {
 	struct subprocess_info *sub_info;
 	sub_info = kzalloc(sizeof(struct subprocess_info), gfp_mask);
@@ -396,6 +407,7 @@ struct subprocess_info *call_usermodehelper_setup(char *path, char **argv,
 	sub_info->path = path;
 	sub_info->argv = argv;
 	sub_info->envp = envp;
+	sub_info->data = data;
 	sub_info->cred = prepare_usermodehelper_creds();
 	if (!sub_info->cred) {
 		kfree(sub_info);
@@ -430,19 +442,41 @@ EXPORT_SYMBOL(call_usermodehelper_setkeys);
  * @info: a subprocess_info returned by call_usermodehelper_setup
  * @cleanup: a cleanup function
  *
- * The cleanup function is just befor ethe subprocess_info is about to
+ * The cleanup function is just before ethe subprocess_info is about to
  * be freed.  This can be used for freeing the argv and envp.  The
  * Function must be runnable in either a process context or the
  * context in which call_usermodehelper_exec is called.
  */
 void call_usermodehelper_setcleanup(struct subprocess_info *info,
-				    void (*cleanup)(char **argv, char **envp))
+		    void (*cleanup)(char **argv, char **envp, void *data))
 {
 	info->cleanup = cleanup;
 }
 EXPORT_SYMBOL(call_usermodehelper_setcleanup);
 
 /**
+ * call_usermodehelper_setinit - set a init function
+ * @info - a subprocess_info returned by a call_usermodehelper_setup
+ * @init - an init function
+ *
+ * The init function is called from the context of the process that
+ * the call to call_usermodehelper forks, just prior to it calling
+ * exec.  Its purpose is to customize the process in whatever way
+ * the caller feels is needed just prior to execing and entering
+ * user space.  the init function pointer returns an int.  A return
+ * of 0 from the init function is treated as a success case, and
+ * allows the usermodehelper process to complete its task.  A return
+ * of anything non-zero, causes the usermodehelper to set that return
+ * code in @info->retval, and exits the process immediately
+ */
+void call_usermodehelper_setinit(struct subprocess_info *info,
+				 int (*init)(void *data))
+{
+	info->init = init;
+}
+EXPORT_SYMBOL(call_usermodehelper_setinit);
+
+/**
  * call_usermodehelper_stdinpipe - set up a pipe to be used for stdin
  * @sub_info: a subprocess_info returned by call_usermodehelper_setup
  * @filp: set to the write-end of a pipe
@@ -535,7 +569,8 @@ int call_usermodehelper_pipe(char *path, char **argv, char **envp,
 	struct subprocess_info *sub_info;
 	int ret;
 
-	sub_info = call_usermodehelper_setup(path, argv, envp, GFP_KERNEL);
+	sub_info = call_usermodehelper_setup(path, argv, envp,
+					     NULL, GFP_KERNEL);
 	if (sub_info == NULL)
 		return -ENOMEM;
 
diff --git a/kernel/sys.c b/kernel/sys.c
index ef286ab..207cf36 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1728,7 +1728,7 @@ SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep,
 
 char *poweroff_cmd = "/sbin/poweroff";
 
-static void argv_cleanup(char **argv, char **envp)
+static void argv_cleanup(char **argv, char **envp, void *unused)
 {
 	argv_free(argv);
 }
@@ -1762,7 +1762,7 @@ int orderly_poweroff(bool force)
 		goto out;
 	}
 
-	info = call_usermodehelper_setup(argv[0], argv, envp, GFP_ATOMIC);
+	info = call_usermodehelper_setup(argv[0], argv, envp, NULL, GFP_ATOMIC);
 	if (info == NULL) {
 		argv_free(argv);
 		goto out;
