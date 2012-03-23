Return-Path: <akpm@linux-foundation.org>
Received: from mail-yw0-f74.google.com (mail-yw0-f74.google.com
	[209.85.213.74]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 230CD106DCC6
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 23:10:47 +0100 (CET)
Received: by yhgm50 with SMTP id m50so583512yhg.3
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 15:10:46 -0700 (PDT)
To: torvalds@linux-foundation.org
From: akpm@linux-foundation.org
Date: Fri, 23 Mar 2012 15:02:46 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20120323220246.CFBDCA08F7@akpm.mtv.corp.google.com>
Cc: FlorianSchandinat@gmx.de, penguin-kernel@I-love.SAKURA.ne.jp,
	gregkh@linuxfoundation.org, oleg@redhat.com, jmorris@namei.org,
	penguin-kernel@i-love.sakura.ne.jp, spock@gentoo.org,
	akpm@linux-foundation.org, takedakn@nttdata.co.jp,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [patch 128/142] usermodehelper: use UMH_WAIT_PROC
	consistently
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

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
