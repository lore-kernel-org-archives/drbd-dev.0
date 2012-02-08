Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5D8381019A68
	for <drbd-dev@lists.linbit.com>; Wed,  8 Feb 2012 15:10:42 +0100 (CET)
Date: Wed, 8 Feb 2012 15:04:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <20120208140402.GB3547@redhat.com>
References: <20120202173504.GA25528@redhat.com>
	<201202032254.GCJ30240.SLMOVFFHtJOFOQ@I-love.SAKURA.ne.jp>
	<20120203151534.GB32503@redhat.com>
	<201202041426.ICI23458.FFFtOMLOJOVSQH@I-love.SAKURA.ne.jp>
	<201202051415.JEB43260.SFMJOHLtOFVQOF@I-love.SAKURA.ne.jp>
	<201202072055.GEC05251.FFMSVHOLOFOQJt@I-love.SAKURA.ne.jp>
	<20120207171031.GA11215@redhat.com>
	<201202080227.q182RnCp077670@www262.sakura.ne.jp>
	<20120208140333.GA3547@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120208140333.GA3547@redhat.com>
Cc: john.johansen@canonical.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	fhrbata@redhat.com, rusty@rustcorp.com.au, apw@canonical.com,
	Michal Januszewski <spock@gentoo.org>, rientjes@google.com,
	tj@kernel.org, akpm@linux-foundation.org, arjan@linux.intel.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 1/1] usermodehelper: use UMH_WAIT_PROC
	consistently
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

A few call_usermodehelper() callers use the hardcoded constant
instead of the proper UMH_WAIT_PROC, fix them.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/block/drbd/drbd_nl.c               |    2 +-
 drivers/staging/rtl8187se/r8180_core.c     |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c |    4 ++--
 drivers/video/uvesafb.c                    |    2 +-
 security/tomoyo/load_policy.c              |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index af2a250..e407da6 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -179,7 +179,7 @@ int drbd_khelper(struct drbd_conf *mdev, char *cmd)
 	dev_info(DEV, "helper command: %s %s %s\n", usermode_helper, cmd, mb);
 
 	drbd_bcast_ev_helper(mdev, cmd);
-	ret = call_usermodehelper(usermode_helper, argv, envp, 1);
+	ret = call_usermodehelper(usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
 		dev_warn(DEV, "helper command: %s %s %s exit code %u (0x%x)\n",
 				usermode_helper, cmd, mb,
diff --git a/drivers/staging/rtl8187se/r8180_core.c b/drivers/staging/rtl8187se/r8180_core.c
index 04c2391..24072f7 100644
--- a/drivers/staging/rtl8187se/r8180_core.c
+++ b/drivers/staging/rtl8187se/r8180_core.c
@@ -4144,7 +4144,7 @@ void GPIOChangeRFWorkItemCallBack(struct work_struct *work)
 		argv[0] = RadioPowerPath;
 		argv[2] = NULL;
 
-		call_usermodehelper(RadioPowerPath, argv, envp, 1);
+		call_usermodehelper(RadioPowerPath, argv, envp, UMH_WAIT_PROC);
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index a7fa9aa..f026b71 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -208,7 +208,7 @@ static void dm_check_ac_dc_power(struct net_device *dev)
 
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
 
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index e7f69ef..506d16e 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -121,7 +121,7 @@ static int uvesafb_helper_start(void)
 		NULL,
 	};
 
-	return call_usermodehelper(v86d_path, argv, envp, 1);
+	return call_usermodehelper(v86d_path, argv, envp, UMH_WAIT_PROC);
 }
 
 /*
diff --git a/security/tomoyo/load_policy.c b/security/tomoyo/load_policy.c
index 6797540..078fac0 100644
--- a/security/tomoyo/load_policy.c
+++ b/security/tomoyo/load_policy.c
@@ -102,7 +102,7 @@ void tomoyo_load_policy(const char *filename)
 	envp[0] = "HOME=/";
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[2] = NULL;
-	call_usermodehelper(argv[0], argv, envp, 1);
+	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
 	tomoyo_check_profile();
 }
 
-- 
1.5.5.1


