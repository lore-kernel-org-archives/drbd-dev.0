Return-Path: <akpm@linux-foundation.org>
Received: from mail-yx0-f202.google.com (mail-yx0-f202.google.com
	[209.85.213.202]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 683B9106DCC0
	for <drbd-dev@lists.linbit.com>; Mon, 26 Mar 2012 21:32:25 +0200 (CEST)
Received: by yenq2 with SMTP id q2so853861yen.3
	for <drbd-dev@lists.linbit.com>; Mon, 26 Mar 2012 12:32:24 -0700 (PDT)
To: oleg@redhat.com, FlorianSchandinat@gmx.de, drbd-dev@lists.linbit.com,
	gregkh@linuxfoundation.org, jmorris@namei.org,
	penguin-kernel@I-love.SAKURA.ne.jp,
	penguin-kernel@i-love.sakura.ne.jp, spock@gentoo.org,
	takedakn@nttdata.co.jp, mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Mon, 26 Mar 2012 12:32:23 -0700
Message-Id: <20120326193223.A5E83A00A9@akpm.mtv.corp.google.com>
Subject: [Drbd-dev] [merged]
	usermodehelper-use-umh_wait_proc-consistently.patch removed
	from -mm tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


The patch titled
     Subject: usermodehelper: use UMH_WAIT_PROC consistently
has been removed from the -mm tree.  Its filename was
     usermodehelper-use-umh_wait_proc-consistently.patch

This patch was dropped because it was merged into mainline or a subsystem tree

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
From: Oleg Nesterov <oleg@redhat.com>
Subject: usermodehelper: use UMH_WAIT_PROC consistently

A few call_usermodehelper() callers use the hardcoded constant instead of
the proper UMH_WAIT_PROC, fix them.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: James Morris <jmorris@namei.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_nl.c               |    2 +-
 drivers/staging/rtl8187se/r8180_core.c     |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c |    4 ++--
 drivers/video/uvesafb.c                    |    2 +-
 security/tomoyo/load_policy.c              |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/block/drbd/drbd_nl.c~usermodehelper-use-umh_wait_proc-consistently drivers/block/drbd/drbd_nl.c
--- a/drivers/block/drbd/drbd_nl.c~usermodehelper-use-umh_wait_proc-consistently
+++ a/drivers/block/drbd/drbd_nl.c
@@ -179,7 +179,7 @@ int drbd_khelper(struct drbd_conf *mdev,
 	dev_info(DEV, "helper command: %s %s %s\n", usermode_helper, cmd, mb);
 
 	drbd_bcast_ev_helper(mdev, cmd);
-	ret = call_usermodehelper(usermode_helper, argv, envp, 1);
+	ret = call_usermodehelper(usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
 		dev_warn(DEV, "helper command: %s %s %s exit code %u (0x%x)\n",
 				usermode_helper, cmd, mb,
diff -puN drivers/staging/rtl8187se/r8180_core.c~usermodehelper-use-umh_wait_proc-consistently drivers/staging/rtl8187se/r8180_core.c
--- a/drivers/staging/rtl8187se/r8180_core.c~usermodehelper-use-umh_wait_proc-consistently
+++ a/drivers/staging/rtl8187se/r8180_core.c
@@ -4159,7 +4159,7 @@ void GPIOChangeRFWorkItemCallBack(struct
 		argv[0] = RadioPowerPath;
 		argv[2] = NULL;
 
-		call_usermodehelper(RadioPowerPath, argv, envp, 1);
+		call_usermodehelper(RadioPowerPath, argv, envp, UMH_WAIT_PROC);
 	}
 }
 
diff -puN drivers/staging/rtl8192e/rtl8192e/rtl_dm.c~usermodehelper-use-umh_wait_proc-consistently drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c~usermodehelper-use-umh_wait_proc-consistently
+++ a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -208,7 +208,7 @@ static void dm_check_ac_dc_power(struct 
 
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		return;
-	call_usermodehelper(ac_dc_check_script_path, argv, envp, 1);
+	call_usermodehelper(ac_dc_check_script_path, argv, envp, UMH_WAIT_PROC);
 
 	return;
 };
@@ -2296,7 +2296,7 @@ void dm_CheckRfCtrlGPIO(void *data)
 
 		argv[0] = RadioPowerPath;
 		argv[2] = NULL;
-		call_usermodehelper(RadioPowerPath, argv, envp, 1);
+		call_usermodehelper(RadioPowerPath, argv, envp, UMH_WAIT_PROC);
 	}
 }
 
diff -puN drivers/video/uvesafb.c~usermodehelper-use-umh_wait_proc-consistently drivers/video/uvesafb.c
--- a/drivers/video/uvesafb.c~usermodehelper-use-umh_wait_proc-consistently
+++ a/drivers/video/uvesafb.c
@@ -121,7 +121,7 @@ static int uvesafb_helper_start(void)
 		NULL,
 	};
 
-	return call_usermodehelper(v86d_path, argv, envp, 1);
+	return call_usermodehelper(v86d_path, argv, envp, UMH_WAIT_PROC);
 }
 
 /*
diff -puN security/tomoyo/load_policy.c~usermodehelper-use-umh_wait_proc-consistently security/tomoyo/load_policy.c
--- a/security/tomoyo/load_policy.c~usermodehelper-use-umh_wait_proc-consistently
+++ a/security/tomoyo/load_policy.c
@@ -102,7 +102,7 @@ void tomoyo_load_policy(const char *file
 	envp[0] = "HOME=/";
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[2] = NULL;
-	call_usermodehelper(argv[0], argv, envp, 1);
+	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
 	tomoyo_check_profile();
 }
 
_

Patches currently in -mm which might be from oleg@redhat.com are

origin.patch
linux-next.patch
avr32-dont-mask-signals-in-the-error-path.patch
avr32-use-set_current_blocked-in-handle_signal-sys_rt_sigreturn.patch
avr32-use-block_sigmask.patch
ia64-use-set_current_blocked-and-block_sigmask.patch
microblaze-dont-reimplement-force_sigsegv.patch
microblaze-no-need-to-reset-handler-if-sa_oneshot.patch
microblaze-fix-signal-masking.patch
microblaze-use-set_current_blocked-and-block_sigmask.patch
mips-use-set_current_blocked-and-block_sigmask.patch
score-dont-mask-signals-if-we-fail-to-setup-signal-stack.patch
score-use-set_current_blocked-and-block_sigmask.patch
unicore32-use-block_sigmask.patch
blackfin-use-set_current_blocked-and-block_sigmask.patch
parisc-use-set_current_blocked-and-block_sigmask.patch
mm-coredump-fail-allocations-when-coredumping-instead-of-oom-killing.patch
frv-use-set_current_blocked-and-block_sigmask.patch
sh-no-need-to-reset-handler-if-sa_oneshot.patch
sh-use-set_current_blocked-and-block_sigmask.patch
h8300-use-set_current_blocked-and-block_sigmask.patch
alpha-use-set_current_blocked-and-block_sigmask.patch
m32r-use-set_current_blocked-and-block_sigmask.patch
m68k-use-set_current_blocked-and-block_sigmask.patch
mn10300-use-set_current_blocked-and-block_sigmask.patch
c6x-use-set_current_blocked-and-block_sigmask.patch
cris-use-set_current_blocked-and-block_sigmask.patch
powerpc-eeh-remove-eeh_event_handler-daemonize.patch
pidns-add-reboot_pid_ns-to-handle-the-reboot-syscall.patch
pidns-add-reboot_pid_ns-to-handle-the-reboot-syscall-fix.patch
sysctl-make-kernelns_last_pid-control-being-checkpoint_restore-dependent.patch
fs-proc-introduce-proc-pid-task-tid-children-entry-v9.patch
c-r-prctl-add-ability-to-set-new-mm_struct-exe_file.patch
c-r-prctl-add-ability-to-get-clear_tid_address.patch
c-r-prctl-add-ability-to-get-clear_tid_address-fix.patch

