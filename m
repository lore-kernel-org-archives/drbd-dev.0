Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 781131056320
	for <drbd-dev@lists.linbit.com>; Fri,  3 Feb 2017 15:06:38 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id b65so30696961wmf.0
	for <drbd-dev@lists.linbit.com>; Fri, 03 Feb 2017 06:06:38 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	i73sm3171469wmd.11.2017.02.03.05.59.46
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Feb 2017 05:59:47 -0800 (PST)
Resent-Message-ID: <20170203135946.GA27111@soda.linbit>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8419E105630C
	for <drbd-dev@lists.linbit.com>; Wed,  1 Feb 2017 18:09:05 +0100 (CET)
From: Arnd Bergmann <arnd@arndb.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Wed,  1 Feb 2017 17:55:02 +0100
Message-Id: <20170201165532.2605534-1-arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: avoid clang warning about pointless switch
	statement
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
---
 include/linux/genl_magic_struct.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 6270a56e5edc..c6fbafb834f1 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -190,6 +190,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -208,6 +209,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -218,6 +220,7 @@ static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
 		s_fields						\
+		default:						\
 			;						\
 	}								\
 }
-- 
2.9.0

