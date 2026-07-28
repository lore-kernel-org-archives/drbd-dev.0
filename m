Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC040DB3F
	for <drbd-dev@lists.linux.dev>; Tue, 28 Jul 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229540; cv=none; b=iSY/HeBRzBBwlCWLnReH+kcQ4MG7PIh/4fgARmcqW6OVwH20EC9bbhkSpnvf6+iKzUhMURiDOYDX2JvbFPpvJXhe8wNnkqanFflNaSiZ+NPkZt2yEBzAlilDIMzHuBqhTu36UMeLyTOiZHPJx7JGKHg2dyRR3I2Tqw4Fq9tyPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229540; c=relaxed/simple;
	bh=c68EiEBN0V+lnQbIJAo9ltizEXZfV3rYv2z9U0Ncyfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ME6YyTnNHXW/VCVdvehmfpDAR53qKqI7L1UPNpCdNGctp42gIqYPTSgVmUOypkqeA4y0MTzUSnHnA564quU3x5aOidZLLebrDqqj7NijDN+Xe1GtX1xo60m7cMnGni4Nsiunrw1wq/GK2XMnqaK9/8j2dZX+1C9J2G3w/gvF7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oScaIDnP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oScaIDnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dZ
	vgQ8yDjAtKBY6NS/1B57sF6P+AUVSJmuMxOaEr5G4=; b=oScaIDnPK6b0btMG5H
	OOwLJcDl5q3oia4480/mcS8GuhXWibpqACQv4Mx1ozG0qc8n8//ts7Ar+BXqnXL0
	Cbi/eV6F5KU2NhOPKCKXpXwHakywb3tOfVU5mFS1qrtPB41G349KScfdtRmS5Xox
	rYKm1XZDYC6DMkR/ODTJcJT0o=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfzLcGhqt6JbKA--.64755S2;
	Tue, 28 Jul 2026 17:05:18 +0800 (CST)
From: Guo Tenglong <micronull@163.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Tenglong <micronull@163.com>
Subject: [PATCH] drbd: fix typo in comment
Date: Tue, 28 Jul 2026 17:05:06 +0800
Message-Id: <20260728090507.16847-1-micronull@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfzLcGhqt6JbKA--.64755S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyxZw47JFyruF1xur45ZFb_yoWfJFg_Cw
	4xGrs7Jr4kKF4fAryYyrySvw1vkw1DZFZ5Zr4SqF1rAFy7GFW2gwn7uFyjgasxW3WUWw4Y
	qF12qw4S93Za9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjoUDtUUUUU==
X-CM-SenderInfo: xplf20hqxozqqrwthudrp/xtbC+A4EO2pocM7nsAAA3i

Correct "seperate" to "separate" in a comment.

Signed-off-by: Guo Tenglong <micronull@163.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index adcba7f1d..98abd2351 100644
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
2.25.1

