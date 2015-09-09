Return-Path: <cvubrugier@fastmail.fm>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3B08510556B0
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 15:16:16 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 40A5F20091
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 09:16:15 -0400 (EDT)
Received: from PAL-U515208D001.lacie.com (200.5-14-84.ripe.coltfrance.com
	[84.14.5.200])
	by mail.messagingengine.com (Postfix) with ESMTPA id DF8CBC0028F
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 09:16:14 -0400 (EDT)
From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To: drbd-dev@lists.linbit.com
Date: Wed,  9 Sep 2015 15:16:07 +0200
Message-Id: <1441804567-2372-3-git-send-email-cvubrugier@fastmail.fm>
In-Reply-To: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
References: <1441804567-2372-1-git-send-email-cvubrugier@fastmail.fm>
Subject: [Drbd-dev] [PATCH 2/2] drbdmeta: drop usage of strndupa() which is
	not provided by musl
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

The musl C library does not support strndupa() which is an
implementation of strndup() that allocates its buffer on the stack.

This patch changes drbd_str_disk() to compute the string length up to
the first slash (if any) and use the length to match the string with
the state names.

Signed-off-by: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
---
 user/shared/drbdmeta.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/user/shared/drbdmeta.c b/user/shared/drbdmeta.c
index 82482e0..d700747 100644
--- a/user/shared/drbdmeta.c
+++ b/user/shared/drbdmeta.c
@@ -4819,17 +4819,17 @@ static enum drbd_disk_state drbd_str_disk(const char *str)
 	/* drbd 8.4 and earlier provide "Local/Remote"
 	 * drbd 9. only "Local". */
 	const char *slash = strchr(str, '/');
-	const char *tmp;
+	size_t len;
 	int n;
 
 	if (slash)
-		tmp = strndupa(str, slash - str);
+		len = slash - str;
 	else
-		tmp = str;
+		len = strlen(str);
 
 	for (n = 0; n < drbd_disk_state_names.size; n++) {
 		if (drbd_disk_state_names.names[n] &&
-		    !strcmp(tmp, drbd_disk_state_names.names[n]))
+		    !strncmp(str, drbd_disk_state_names.names[n], len))
 			return (enum drbd_disk_state)n;
 	}
 	if (!strcmp(str, "Unconfigured"))
-- 
2.5.0

