Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C0481AB5
	for <drbd-dev@lists.linux.dev>; Fri, 14 Aug 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720613; cv=none; b=UZsue8ph9+2GopSEa39UyhoZIVR00RqWdHT+9W4vHSshZfzFkDSvBsl8S4FnftMiKzjqgPRTxAuJG6W8br0MkCLCoLT9hsGwifR/1r1fYgMAOcszpxdylmm/pj7lXhKT7HJEYdfLpoCsUdFfIP4hAxTDggXwvhaNB2Tan5P4A24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720613; c=relaxed/simple;
	bh=6dgBdo0kz8D0VhXyVT7VOnoNHF/p9ue86NPOyUvtC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hoWWpkvsq9nLCcKWFZp3PtiZJUbaEgd4w+jnmXX4DnR+xpWUB3w0AiRZtetKLD00Q0kL56LMNR2YvHssPZ0oTHsumPmv4ov0yXLVFVbf1HPNOv51/S5AY79Mdz/pqx+eoI6xYDuFI6NJHWPXYT+tPfvrdxNrZm9Uli53iFhnMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=ulYBqBCU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="ulYBqBCU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f84023916so1036758f8f.3
        for <drbd-dev@lists.linux.dev>; Fri, 14 Aug 2026 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786720609; x=1787325409; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRB4JuBVbvsbT/EXF82Pi+P9sAHp5M7GCKevXhSfrjU=;
        b=ulYBqBCU9Hdea/CYqILe4IePRJ807ytDN/cvlXQbAHIQIMnICsdr2NqCpwjzFCh2Yy
         EglZQVrYwt4w18aci/Lyh6YN5WmbsmhbMxpczfcT4/n1KN+YbniRxUsy1YoeCpQjfqfE
         S5sqTlaB0yp09o6/DaG5nSSvueGaN9HvLON+fW64rhZQrOUP7fgJKxWGjEdUXxBvfvOn
         EQGBC3im05III2go37ATEEzdYNH5Ke4K9O4jQRjohwovkyr36Aa7HXS0K63HwfELhAl4
         oNwSplwc/oJ8lhaC23TxWgJUf6DLqFC7veZ+CToTPqMlkXtdXiHGcQ1A7bubskwRRTe1
         O22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720609; x=1787325409;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRB4JuBVbvsbT/EXF82Pi+P9sAHp5M7GCKevXhSfrjU=;
        b=Sp4G8zQmt2Z837QTEhqN8IxdF889tBZZVW4nrkxfidiS7tRjE6ra5oLpfgfgsD9C1i
         PTxRD2SZEljNHtlFW6z5wyms+QsO5z9lvxyb8W9iPnZ/nccSxmV9gmXR82s5+/nmDgZs
         6j61eaRCyyu63dnax5b8zUXv2ZtIebRVNTrexJKGIhS1Yx+Xp/RgD3XEtBiZ1ZtLOZLa
         pcVMR+ssFpSs6FTfY7Ba+FK7SjdnKLLFFQqEW3FQI/kp2gyMDywGMrpG851h/iC5JPy6
         8OMVjbq/CUwMxtREkEf1FyHHUFRKkSMjruFaW+rrHJ3pGdCjBQP0Ms5s6RQhgQIvXUfP
         //MQ==
X-Gm-Message-State: AOJu0YzALoVKGBzxIo6SS3L2ZY/mpXIkTJPxcDyNLuXNAKTzutJvuF3q
	xZ0RbOYxai+ZgSOBtdTAMamj5XfMCtZBfM5YW1jAv6yRecuDc5izjHQA0SaiZzHgGws=
X-Gm-Gg: AR+sD10PzHkL3dguLH4UsUAlzUSl0zzQeua70bc31LyH3VLNFNJpWvDjsKEj2JQNdK4
	sGD0nDLXkCXGhzIa66OAqMyqeYdte44Hw47RDSgp67UBF+mjdfriwr2t7GTAOTE5fAs0MJI2oGq
	R3dGCFFWDqPivWSj3Y4PObQB63/Iy3vBnjKdLuK7jMwX5UXV5luMrDYI3OMociA8/u2H/DKZmsA
	30NKl92rnzs6Oo4XoJcMEtI1q/MZ58zFM4srgWLllaaAEj5u1DmlU1n+oXZW81oiYrBwN7xFPQd
	pq84YGWsaeG10yj7naCnq78dRBOuM/9tEx0NmRdPg6c+6z8GOzPXkWJppgKon2KH5RzGEp25+FF
	HJB+lVFy5QVWQeei4g+qY4646SXZHBvc4yAPHiLXBcgnbWDcJrJFMdHMslMRXG9hNwsNp0CKHmn
	o9g3uhNO3iyFsp3QeNiAZsqAIS+WN3C1a1X7DwEFAfAQOsCm7lftx+VTs6n5bfI9OP/qVzIG6q6
	ROSzKNTihfjZszFhmqyvaYokbu4HBkBHpOw1EJniXMdgw==
X-Received: by 2002:a05:6000:2c01:b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-48160760c23mr9039764f8f.22.1786720609341;
        Fri, 14 Aug 2026 08:16:49 -0700 (PDT)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219f7bsm8742381f8f.13.2026.08.14.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:16:48 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Vivek Parikh <vivek.parikh@breachx.ai>
Subject: [PATCH] drbd: don't leak the shared secret to unprivileged netlink dumps
Date: Fri, 14 Aug 2026 17:16:17 +0200
Message-ID: <20260814151617.73752-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The conversion to explicit netlink serialization dropped the
exclude_sensitive parameter from net_conf_to_skb(), so each caller has
to sanitize by hand. Two dump paths were missed:
drbd_nl_get_connections_dumpit() and the volume-less connection branch
of get_one_status(). Neither op carries GENL_ADMIN_PERM, so any
unprivileged local user could read the CRAM-HMAC secret.

Add a net_conf_to_skb_sanitized() wrapper and route all three callers
through it.

Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
Intended for 7.2 if at all possible. Sorry for the short notice, we only
learned of this today.

 drivers/block/drbd/drbd_nl.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f9ffcd67607b..b77f901fc3ef 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3306,6 +3306,26 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+/*
+ * net_conf_to_skb() serializes the shared secret verbatim. Any path that can
+ * answer a request from an unprivileged process must pass exclude_sensitive,
+ * so the secret is blanked in a private copy before it reaches the skb.
+ */
+static int net_conf_to_skb_sanitized(struct sk_buff *skb, struct net_conf *nc,
+				     bool exclude_sensitive)
+{
+	struct net_conf nc_clean;
+
+	if (!exclude_sensitive)
+		return net_conf_to_skb(skb, nc);
+
+	nc_clean = *nc;
+	memset(nc_clean.shared_secret, 0, sizeof(nc_clean.shared_secret));
+	nc_clean.shared_secret_len = 0;
+
+	return net_conf_to_skb(skb, &nc_clean);
+}
+
 /*
  * The generic netlink dump callbacks are called outside the genl_lock(), so
  * they cannot use the simple attribute parsing code which uses global
@@ -3621,7 +3641,8 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_callback
 			goto out;
 		net_conf = rcu_dereference(connection->net_conf);
 		if (net_conf) {
-			err = net_conf_to_skb(skb, net_conf);
+			err = net_conf_to_skb_sanitized(skb, net_conf,
+							!capable(CAP_SYS_ADMIN));
 			if (err)
 				goto out;
 		}
@@ -3842,18 +3863,8 @@ static int nla_put_status_info(struct sk_buff *skb, struct drbd_device *device,
 		struct net_conf *nc;
 
 		nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
-		if (nc) {
-			if (exclude_sensitive) {
-				struct net_conf nc_clean = *nc;
-
-				memset(nc_clean.shared_secret, 0,
-				       sizeof(nc_clean.shared_secret));
-				nc_clean.shared_secret_len = 0;
-				err = net_conf_to_skb(skb, &nc_clean);
-			} else {
-				err = net_conf_to_skb(skb, nc);
-			}
-		}
+		if (nc)
+			err = net_conf_to_skb_sanitized(skb, nc, exclude_sensitive);
 	}
 	rcu_read_unlock();
 	if (err)
@@ -4058,7 +4069,7 @@ static int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
 				struct net_conf *nc;
 
 				nc = rcu_dereference(connection->net_conf);
-				if (nc && net_conf_to_skb(skb, nc) != 0)
+				if (nc && net_conf_to_skb_sanitized(skb, nc, true) != 0)
 					goto cancel;
 			}
 			goto done;

base-commit: c7c76f9232bd34835d821f14abdc5fafc17bc938
-- 
2.55.0

