Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 66C674210CD
	for <drbd-dev@lists.linbit.com>; Thu,  2 Mar 2023 13:55:26 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id d30so67213913eda.4
	for <drbd-dev@lists.linbit.com>; Thu, 02 Mar 2023 04:55:25 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  2 Mar 2023 13:54:39 +0100
Message-Id: <20230302125445.2653493-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
References: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 1/7] genetlink: make _genl_cmd_to_str static
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

Primarily to silence warnings like:
warning: no previous prototype for 'xxx_genl_cmd_to_str' [-Wmissing-prototypes]

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/linux/genl_magic_func.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 4a4b387181ad..2984b0cb24b1 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -209,7 +209,7 @@ static int s_name ## _from_attrs_for_change(struct s_name *s,		\
  * Magic: define op number to op name mapping				{{{1
  *									{{{2
  */
-const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
+static const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
 {
 	switch (cmd) {
 #undef GENL_op
-- 
2.39.1

