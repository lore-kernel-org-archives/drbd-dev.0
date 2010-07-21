Return-Path: <livewire@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8AD5A104B1BA
	for <drbd-dev@lists.linbit.com>; Wed, 21 Jul 2010 17:06:08 +0200 (CEST)
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com
	[172.24.198.101]) by smtp-out.google.com with ESMTP id o6LEtbXf029121
	for <drbd-dev@lists.linbit.com>; Wed, 21 Jul 2010 07:55:37 -0700
Received: from livewire.zrh.corp.google.com (livewire.zrh.corp.google.com
	[172.16.74.99])
	by wpaz37.hot.corp.google.com with ESMTP id o6LEtZn8019243
	for <drbd-dev@lists.linbit.com>; Wed, 21 Jul 2010 07:55:36 -0700
From: Manuel Franceschini <livewire@google.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 21 Jul 2010 16:55:35 +0200
Message-Id: <b338ba23c4a721b53876c40464e5daeb2fe0b14a.1279723469.git.livewire@google.com>
Subject: [Drbd-dev] [PATCH master] Fix bug in split_address() when handling
	IPv6 addresses
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Signed-off-by: Manuel Franceschini <livewire@google.com>
---

Hi all,

this small patch fixes a bug when using "drbdsetup /dev/drbdX net" with
IPv6 addresses without specifying a port number as in
"ipv6:2001:db8::1".

This patch relies, however, on a slighlty different syntax:

$ drbdsetup /dev/drbdX net ipv6:[2001:db8::1] ipv6:[2001:db8::2]:7799 A

The introduction of brackets is necessary, since there is no way to
reliably separate the IPv6 address with the port number being optional.

I'm happy for any feedback/suggestions.


Cheers, Manuel.


 user/drbdsetup.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/user/drbdsetup.c b/user/drbdsetup.c
index b479128..4b030a2 100644
--- a/user/drbdsetup.c
+++ b/user/drbdsetup.c
@@ -673,7 +673,7 @@ static void split_address(char* text, int *af, char** address, int* port)
 	};
 
 	unsigned int i;
-	char *b;
+	char *b1 = NULL, *b2;
 
 	*af=AF_INET;
 	*address = text;
@@ -687,11 +687,30 @@ static void split_address(char* text, int *af, char** address, int* port)
 	if (*af == -1)
 		*af = get_af_ssocks(1);
 
-	b=strrchr(text,':');
-	if (b) {
-		*b = 0;
-		*port = m_strtoll(b+1,1);
-	} else
+	if (*af == AF_INET6) {
+		b2=strchr(*address,'[');
+		if (!b2) {
+			fprintf(stderr, "IPv6 address in '%s' missing starting delimiter '['\n", text);
+			exit(20);
+		}
+		*address += 1;
+		b2=strrchr(*address,']');
+		if (b2) {
+			b1 = strchr(b2,':');
+			*b2 = 0;
+		} else {
+			fprintf(stderr, "IPv6 address in '%s' missing ending delimiter ']'\n", text);
+			exit(20);
+		}
+	} else {
+		b1=strrchr(text,':');
+		if (b1) {
+			*b1 = 0;
+		}
+	}
+	if (b1)
+		*port = m_strtoll(b1+1,1);
+	else
 		*port = 7788;
 }
 
-- 
1.7.1

