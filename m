Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 243EC1056446
	for <drbd-dev@lists.linbit.com>; Fri,  5 May 2017 13:32:05 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id 142so3399891wma.1
	for <drbd-dev@lists.linbit.com>; Fri, 05 May 2017 04:32:05 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	g21sm5914653wrg.22.2017.05.05.04.32.04
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 May 2017 04:32:04 -0700 (PDT)
Resent-Message-ID: <20170505113204.GF28116@soda.linbit>
Received: from mail3-relais-sop.national.inria.fr
	(mail3-relais-sop.national.inria.fr [192.134.164.104])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EFBF1057FCC
	for <drbd-dev@lists.linbit.com>; Thu,  4 May 2017 22:45:35 +0200 (CEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu,  4 May 2017 22:10:48 +0200
Message-Id: <1493928654-18768-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	kernel-janitors@vger.kernel.org, keescook@chromium.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/9] drbd: Drop unnecessary static
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

Drop static on a local variable, when the variable is initialized before
any use, on every possible execution path through the function.  The static
has no benefit, and dropping it reduces the code size.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@

static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@

-static
 T x@p;
 ... when != x
     when strict
?x = e;
// </smpl>

The change in code size is indicates by the following output from the size
command.

before:
   text    data     bss     dec     hex filename
  67299    2291    1056   70646   113f6 drivers/block/drbd/drbd_nl.o

after:
   text    data     bss     dec     hex filename
  67283    2291    1056   70630   113e6 drivers/block/drbd/drbd_nl.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/block/drbd/drbd_nl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 02255a0..ad0fcb4 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2294,7 +2294,7 @@ static bool conn_ov_running(struct drbd_connection *connection)
 static enum drbd_ret_code
 check_net_options(struct drbd_connection *connection, struct net_conf *new_net_conf)
 {
-	static enum drbd_ret_code rv;
+	enum drbd_ret_code rv;
 	struct drbd_peer_device *peer_device;
 	int i;
 

