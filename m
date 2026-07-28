Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C341A91D
	for <drbd-dev@lists.linux.dev>; Tue, 28 Jul 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229562; cv=none; b=Tn/X+IdpoWfIitJColrlSuwNvwcGZe3NFAuUVsD+5J5bQ6gbyMRlwEVoUxbFH0UvtzUK7xxZ/UPUMoPcq3wCBHkNmbwvKKUdgFNYSm1/Wk+dOKwYhSuFmFSulPNyMH1D3tZkQwATDjQ8jal6OuUYwvq33AkF3hnYhgm+XK3ztS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229562; c=relaxed/simple;
	bh=ggX439FIkKMIQ3Sm4mS/AwbAG77hWlv46f4GkwynSPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pgny26uzJ9De8V4IWkaLrw23Htsf14BaHuKP/FCQVY/cWUe/9krNE04DNVI1bw57mA/y6oi4jVKvY8P8SVcOdGUkbTwwK9+1ZABo+lhymFsPPKV6I8ovmTF6D883ADrO4to/uaG3oPAHBueTIkrH3HhJk8y1GovS4/hV8ZTE7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xfhzk9fT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xfhzk9fT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OO
	PV6L7HY5yVcZiBAtsBlbq3jqF8pQf+S4wrz3I/d08=; b=Xfhzk9fT7OeGtYRb2S
	/OfJwR+/jTLWRLBc6KYrezFat4ZVBveRrPwFRSTTwEOqdrtnEeMsV1aAtc3tIIr+
	fjjipki36nctOHvQEYW2nVL7+rDOSQ0Kuvm9HbBxiAA5fQC+o3BvnyeZr8Ctv3ci
	SA9unXx6zxy0vGfBA32yvcFQw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfzLcGhqt6JbKA--.64755S3;
	Tue, 28 Jul 2026 17:05:31 +0800 (CST)
From: Guo Tenglong <micronull@163.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Tenglong <micronull@163.com>
Subject: [PATCH] drm/radeon: fix typo in comments
Date: Tue, 28 Jul 2026 17:05:07 +0800
Message-Id: <20260728090507.16847-2-micronull@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728090507.16847-1-micronull@163.com>
References: <20260728090507.16847-1-micronull@163.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfzLcGhqt6JbKA--.64755S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyktw1DGFyxtF4UGF1UGFg_yoW8Xw13pF
	srWFy3Kr90kw4UKw13Zay2yFy5C3Z7ta1jgr4UKw43W345A348XFyfZr1UJr4kJ3y8u3WY
	yFyv934UCF10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJxhJUUUUU=
X-CM-SenderInfo: xplf20hqxozqqrwthudrp/xtbC3BsHPmpocNsyrQAA3I

Correct "sucess" to "success" in function comments.

Signed-off-by: Guo Tenglong <micronull@163.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fc..fb79c990a 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -777,7 +777,7 @@ bool radeon_boot_test_post_card(struct radeon_device *rdev)
  * Allocate the dummy page used by the driver (all asics).
  * This dummy page is used by the driver as a filler for gart entries
  * when pages are taken out of the GART
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  */
 int radeon_dummy_page_init(struct radeon_device *rdev)
 {
@@ -969,7 +969,7 @@ static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
  *
  * Initializes the driver info and register access callbacks for the
  * ATOM interpreter (r4xx+).
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  * Called at driver startup.
  */
 int radeon_atombios_init(struct radeon_device *rdev)
@@ -1045,7 +1045,7 @@ void radeon_atombios_fini(struct radeon_device *rdev)
  * @rdev: radeon_device pointer
  *
  * Initializes the driver info for combios (r1xx-r3xx).
- * Returns 0 on sucess.
+ * Returns 0 on success.
  * Called at driver startup.
  */
 int radeon_combios_init(struct radeon_device *rdev)
-- 
2.25.1

