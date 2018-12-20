Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:33 +0100
Message-Id: <20181220162344.8430-7-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/17] drbd: fix confusing error message during
	attach
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

If we attach a (consistent) backing device,
which knows about a last-agreed effective size,
and that effective size is *larger* than the currently requested size,
we refused to attach with ERR_DISK_TOO_SMALL
  Failure: (111) Low.dev. smaller than requested DRBD-dev. size.
which is confusing to say the least.

This patch changes the error code in that case to ERR_IMPLICIT_SHRINK
  Failure: (170) Implicit device shrinking not allowed. See kernel log.
  additional info from kernel:
  To-be-attached device has last effective > current size, and is consistent
  (9999 > 7777 sectors). Refusing to attach.

It also allows to attach with an explicit size.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d02d38fd1288..e4774f720de5 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -127,6 +127,35 @@ static int drbd_msg_put_info(struct sk_buff *skb, const char *info)
 	return 0;
 }
 
+__printf(2, 3)
+static int drbd_msg_sprintf_info(struct sk_buff *skb, const char *fmt, ...)
+{
+	va_list args;
+	struct nlattr *nla, *txt;
+	int err = -EMSGSIZE;
+	int len;
+
+	nla = nla_nest_start(skb, DRBD_NLA_CFG_REPLY);
+	if (!nla)
+		return err;
+
+	txt = nla_reserve(skb, T_info_text, 256);
+	if (!txt) {
+		nla_nest_cancel(skb, nla);
+		return err;
+	}
+	va_start(args, fmt);
+	len = vscnprintf(nla_data(txt), 256, fmt, args);
+	va_end(args);
+
+	/* maybe: retry with larger reserve, if truncated */
+	txt->nla_len = nla_attr_size(len+1);
+	nlmsg_trim(skb, (char*)txt + NLA_ALIGN(txt->nla_len));
+	nla_nest_end(skb, nla);
+
+	return 0;
+}
+
 /* This would be a good candidate for a "pre_doit" hook,
  * and per-family private info->pointers.
  * But we need to stay compatible with older kernels.
@@ -1947,11 +1976,21 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* Prevent shrinking of consistent devices ! */
-	if (drbd_md_test_flag(nbc, MDF_CONSISTENT) &&
-	    drbd_new_dev_size(device, nbc, nbc->disk_conf->disk_size, 0) < nbc->md.la_size_sect) {
-		drbd_warn(device, "refusing to truncate a consistent device\n");
-		retcode = ERR_DISK_TOO_SMALL;
-		goto force_diskless_dec;
+	{
+	unsigned long long nsz = drbd_new_dev_size(device, nbc, nbc->disk_conf->disk_size, 0);
+	unsigned long long eff = nbc->md.la_size_sect;
+	if (drbd_md_test_flag(nbc, MDF_CONSISTENT) && nsz < eff) {
+		if (nsz == nbc->disk_conf->disk_size) {
+			drbd_warn(device, "truncating a consistent device during attach (%llu < %llu)\n", nsz, eff);
+		} else {
+			drbd_warn(device, "refusing to truncate a consistent device (%llu < %llu)\n", nsz, eff);
+			drbd_msg_sprintf_info(adm_ctx.reply_skb,
+				"To-be-attached device has last effective > current size, and is consistent\n"
+				"(%llu > %llu sectors). Refusing to attach.", eff, nsz);
+			retcode = ERR_IMPLICIT_SHRINK;
+			goto force_diskless_dec;
+		}
+	}
 	}
 
 	lock_all_resources();
-- 
2.17.1

