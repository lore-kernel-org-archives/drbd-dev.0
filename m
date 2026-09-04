Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243147668A
	for <drbd-dev@lists.linux.dev>; Fri,  4 Sep 2026 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521474; cv=none; b=TI0aahSjh2LPpC6wPJOHqgP82BhSLvjNj1HN27hXy7S78K1JvHiuvYIfNfZAkRR6kU8cU788BzUmnzGWMxY3iKLWD4pKISssueB7ikBB1sgsBAnXoOdQFtp+9moMS3tsRtutWD9amJ/9mvd4B2BrxBkFCtEG2fpI7lWPsXRjM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521474; c=relaxed/simple;
	bh=Q9VNhfOJpV0f6GAYSCL1Z6cTQvWb7SN7DQFyzoIQGiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPNgJ1Bj9mR2pKZJG0AQH6uQ9lDwNzUgH62qOptMnhvk4pAGCDCUxXI+QAY6kR/LF5KWjsvBAVTmO2u11744usSjAzE9etRAK1tJw985KS5Y0vyiZP/3pu2fmWkkZ8fDMNA0hxkzJSk/ffuw+OmcVEVxu9zHzIbnfx0d5Zni9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfHNXtDq; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfHNXtDq"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aca0f482e5so845407eaf.2
        for <drbd-dev@lists.linux.dev>; Fri, 04 Sep 2026 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521471; x=1789126271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dH+xoxlA23TxNw4X4P0nYpbdDmv6zzTVoV0RNrE+c+Y=;
        b=DfHNXtDqEEeqcKMLRi5pki5uNPpiIxVBVWl58uU8rtCUE+9VzhQIZRabjuhHtVwgby
         IP+0DycJYL+9o7H9PVBAnTFN18W9CflFLY0YqLatetCH+xV8wMUXdSc/qVQUwg/DunFY
         UT82g5tmtz14k1+bbszsad7d0UFfn3i60PVhOtp7vagxocID3reN2gVcTvYpHENddIcQ
         PDMZNQlMoRuhlXTy5YDcNk8ecyo6SoctNs58ymxNhWgnj2UFL6E2zdA5kisI6FeJXds+
         t9CBYtAnnXLvf4hJzIrNGlR70pYMcYmkKBEYUqLvpmRWgILJ2zdTOiCqlctBYI1cYsRS
         p4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521471; x=1789126271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dH+xoxlA23TxNw4X4P0nYpbdDmv6zzTVoV0RNrE+c+Y=;
        b=QLeF05EMUAIiYf+yHaF9NEhgq/HvuNW9rDFCiq35T8MGWj8yvqi11HhhyD69NjYtMX
         qxeiYA6WVw/oORP7IToYWUqIH8fxgORntqS1M0TmPnz7QNZ9kzQCnaAmwmMS48iyu8WS
         mQ1dT+c2TyeZ3/oRJVUH7GUZv6rkhKsSDKl+gfjm1K3naHCUvmf1JJoAJescgGjk/oMV
         zcVJ+rqQ8OBJb5G7/I5eD2E7pfrkpn+rhJlnk0N9djWjbe50eYzqQd+RyiDanCohYNIk
         QxzN4RmRckENZa4tMNUGE18Z2j/LsQM69pF/ah+ThZuzi0pytZAyHwkI5hGM8NQgoZ7M
         sgqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC49X2S7eefmLdRMA8A2hWw6qiLwqVNpxJJ+kJ36l9DwlIK6/3gOk/bckuneSABrzRddRrl3VKSw==@lists.linux.dev
X-Gm-Message-State: AFuF++nwR44OpF6/T/J/QiPk/ASqqxH0OKd1JzLwtMpw0UzCbvg6uJZw
	XT+MzymwTk5smGhAY2WLNBubXa0yRU/0PG50XWkArdPjT8swRgvHEhBEFlKr6V0CKuw=
X-Gm-Gg: AYBFou0swyFDSG8OOVGP38UVrInaDwSQz6SgzEL0AazBWswVkR8W8Rdp7B5rKpHmRVp
	WL0T8BGia8zCNoNAMQHCd2c8vNEemI05iZYppox3+/ccC9RHTjPxb+3Zi2Gcs0bcMrUBJgN5CA8
	N1LuR5HpWBvyMXFhPA1uJ0iXRxG6uiyLiuqovJKNMqoyBU0xm7SmMAwS6WesWKDvvcQ5QfFZGwV
	HTYA5c+ZPT01h5l6zeofFwJMiQHsywNAOikndFCm1DxtZvIhGjVP+SfpTMp74eJLqUduz9Nk/ns
	asj/WpF7lj6idUQ8eHfTRLj3DUuv4L4csMUbVrQ9vdhJvOgmcG16r/hJ7GSw1sHE7LjsDStWSz/
	iER+7aBpw6l8Dby8EZ/QyFsVG+EWSlAEJ9hr1jGr9Teyonwi2G6PvzJtC9jkY/lQPji1/mCe/6n
	qjmGTvBsKITQRLVdxRHG8BWVfimiQfkSVnh+07Tesn1B+gJXRP8C5DIr3LGEnGAutbhsr7Ap9zs
	oCioz22vOnxVulaIhhCzP4PRQ==
X-Received: by 2002:a05:6820:81c9:b0:6b1:7251:4210 with SMTP id 006d021491bc7-6b6fc7d3e3emr4024717eaf.22.1788521470789;
        Fri, 04 Sep 2026 04:31:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6039922c88.13.2026.09.04.04.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:31:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: drbd: fix typos in comments
Date: Fri,  4 Sep 2026 17:00:59 +0530
Message-ID: <20260904113103.10805-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904113103.10805-1-hemanth.selam@gmail.com>
References: <20260904113103.10805-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/block/drbd/drbd_nl.c    | 2 +-
 drivers/block/drbd/drbd_req.c   | 4 ++--
 drivers/block/drbd/drbd_state.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b77f901fc3ef..f180c2eb996c 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -605,7 +605,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	spin_lock_irq(&resource->req_lock);
 	if (connection->cstate < C_WF_REPORT_PARAMS && !test_bit(STATE_SENT, &connection->flags)) {
 		if (connection->connect_cnt != connect_cnt)
-			/* In case the connection was established and droped
+			/* In case the connection was established and dropped
 			   while the fence-peer handler was running, ignore it */
 			drbd_info(connection, "Ignoring fence-peer exit code\n");
 		else
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 70f75ef07945..6709c45cbd5f 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1576,7 +1576,7 @@ void do_submit(struct work_struct *ws)
 		 * Be strictly non-blocking here,
 		 * we already have something to commit.
 		 *
-		 * Commit if we don't make any more progres.
+		 * Commit if we don't make any more progress.
 		 */
 
 		while (list_empty(&incoming)) {
@@ -1747,7 +1747,7 @@ void request_timer_fn(struct timer_list *t)
 	 * but which is still waiting for an ACK. */
 	req_peer = connection->req_ack_pending;
 
-	/* if we don't have such request (e.g. protocoll A)
+	/* if we don't have such request (e.g. protocol A)
 	 * check the oldest requests which is still waiting on its epoch
 	 * closing barrier ack. */
 	if (!req_peer)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index adcba7f1d8ea..98abd2351d6d 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1339,7 +1339,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 	remember_new_state(state_change);
 
-	/* put replicated vs not-replicated requests in seperate epochs */
+	/* put replicated vs not-replicated requests in separate epochs */
 	if (drbd_should_do_remote((union drbd_dev_state)os.i) !=
 	    drbd_should_do_remote((union drbd_dev_state)ns.i))
 		start_new_tl_epoch(connection);
-- 
2.48.1

