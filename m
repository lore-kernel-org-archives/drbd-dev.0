Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704786;
	b=gAVGzFMzRkp1CNijfZNqN1OKN0y+4Epvy2Pza2w0pZdrb3oZrM5E2UAaWEpwcc56fN2y
	 lubZo+61mA/FNG8jN/bKm5Yhf2JD7vXVnhZD+l70XMgcSgGGMDii7aGip6EzD0/M7eLPb
	 ipEfW4ZQGkXdVrmT0shErV8bIM4q/HBiKuxHhD3Pj5QMOcGfq8wCflwQ4bQ3WixNq4FeZ
	 I4N8xXDu1LoCw9vyMZErtTt/svKrAzX9+WJawYhLo7yl3+CiZqjCl0L1HjGUHRvgXGYam
	 hADeEuqc8xA1/enXHsS/NiFI85Z6FNH9V3ejl0BsfmudLbA5EA4Mg7FmqKx8FzyuuiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qRPa/B8ERbaRnXSclOcrcXc2SQlwZ7vaaTwPPh0UliM=;
	b=n2VluYj1XBPtcc45soLeFiRYATZjjJIo0WgJvpW9VWZwJdXDKGaArudmnqgtSjfZLZMF
	 00kzjXWbSSFJergKSFHGALLbLcmdfTCH4+PyhRyp4ujyc0VBwSqcMfg4e6UP5NxqzD332
	 0xg1tYema87RIDe5Rz7O7PLiwSnCgEGvd8I/cQ3RDA0kwqEtytmV7mRybT+xURQRt7tAl
	 J54u9ZhETaQTPAvI4lMF29dJl3NUZFfbpsajuTZjDVAZDsDFpyBxuLu84FZvsRvni4NV2
	 XsKRZ2tVBOy1ojALzHIB56E0dZWhnQ3+YzxjlbQ5oYDZjlT39pbV6PgURdtb5Y9us9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=ge+0A5ID;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD93606A33C
	for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 14:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD93606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=ge+0A5ID
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so66886685e9.2
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704784; x=1796309584; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRPa/B8ERbaRnXSclOcrcXc2SQlwZ7vaaTwPPh0UliM=;
        b=ge+0A5IDBfXVOSUniCDFwSErM8uHSP3zM1j90D0VtFGppe+kMYR7VmcRPVUbZD8Ztz
         4QhVE/nJg6Og9rTQe94E04D12aO+/UsAcXeNYzxsuFNlVpV1HNqOb7Cksp9pa+bNWzM1
         1SfIUTgURn/rPtguLBjg/rLF5c8wfTIHRNK0zwKCqImWLXM+UuIVRSrWyuHIWw3fsgUz
         Kb100o+MRWCGSyABu2eSPh1UznAltABUVTqAPSr7W7LPXrM4sUGLdwLzcEwi8Piy7w3r
         xde8K016dpiDoSAUQnu55HsGiQEsIKg8boCiY90cTi1jZD8F+LN/vIZKncxE0iehf6Jx
         lwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704784; x=1796309584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRPa/B8ERbaRnXSclOcrcXc2SQlwZ7vaaTwPPh0UliM=;
        b=efU27WD9tRVML/yULO4KYXMKULmx6GjIYrCR6KeTK6dTi3457ifK0ZcLX4DVBnsYMB
         JXp7hsfy7Dme/q3J9+GSVVriYeivRGmQcmm36CyOgWw3cESCLf/LeHOlpkaUK39FqvEd
         cNmlk6c7ho/hrO7iEoTArBdhQUBArLNJqMBnnPXNj1gfHEdgOC5p6R8FMa9usd1/z36P
         O9htyOqh+67ItbljCnWFsUqeSUm9zwZVvhHsQl/XU2SKVY5msTM5+LQt0smGUpFRIzsm
         OecDhOOat00N6RmOWraenDh7WizinAeqkrMlUMTGXeRQqktwdD00S9MnenmFvImMoAN1
         JgNw==
X-Forwarded-Encrypted: i=1; AL+hErGHHQ+JCWXWhYWa0vNEnEzw5GqW7AEQag5JYnjqR6oUz0IZQkS1/XL065bwvfOreeLsBSp1Yi6qzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/H8AxZcO9DZBKzbcOcTUYfiywJbRYlpe8ZUnNIA4rnl/N9EwY8
	aSEfeliWCDAcGsy0+zrn7GqVzSh7X7D7Pam5s2sqyBJEA7nMJQA1wyE4Q6OyKjwdblE=
X-Gm-Gg: AZFdTZdidyqT+2S7QeBbanR2TbFybJKe/o+6Zv0Dhb/dg+/LUGrf1FBLj5vgwME6yGg
	LPkA4WXAg8L2OUZB6XEzefzsQY6G9PIzgi4YdKLffHZmQTmT/TXal4LWB5m6MuAEMpEdosSldkU
	7lT8bM+R7WXefZolm7r3GA7tlBFfjZV4MIS6r6Hb4+7YzZwGWmzxV+DXow2x24AkqFBmdPm0urk
	EJueZ9frFM0lgHAc9K34RZxmsyyL1hV3USR/Kvtkj9jTHCAH+zEeAQ5HYjQFeKHoCvqwNCoGCv1
	gDzrnytXbujVvhUwmCZ1vwtKaaI/12NMHRaWCObnGquCWaQfGPFtkm4fJCfLlJ5m9Oi/euv+8IJ
	2GjlV3mqz2CE7eDoOSRN2JxaIzJqsfyFKQ3kaln+tTLfYhE1aGpeY5td25pGtAgpNNUHNnQYuek
	xqM8H8a1Ao2DpDFRp1ucZRWbh6NgdW/va1/H5AOXLGrjmLniJOdlg+ufRvMsF0kPfo/rCjKwfct
	q5EajOqex3uuiLxU1W0FO4FWg9+T2RBjAlWuVXEIliqhnZ6MsT9+WqfOyeQgZZcXn+J/osdjN2a
	3SfrGVXchubXykuWTYQcCkvrhUGP6m59bjnWP1tYoBiObOJGpd15sGRxyfxwbAOGw2QNwiBihg=
	=
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr425912685e9.13.1795704784215;
        Thu, 26 Nov 2026 06:53:04 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:03 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/4] drbd: fix lost bitmap-work wakeup on weakly ordered CPUs
Date: Thu, 26 Nov 2026 15:52:55 +0100
Message-ID: <20261126145257.592085-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
References: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lars Ellenberg <lars.ellenberg@linbit.com>

  drbd_queue_bitmap_io(): set_bit(BITMAP_IO); read ap_bio_cnt (req_lock)
  dec_ap_bio():           dec ap_bio_cnt;     test_bit(BITMAP_IO)

Both sites decide whether to queue the whole-bitmap work by inspecting
the same two locations in opposite order. dec_ap_bio() does not take
req_lock, so the lock gives no mutual exclusion between them. On a
weakly ordered CPU the queue-side set_bit/atomic_read store-load pair
may reorder, so both sites read the other's pre-update value and neither
queues the work. BITMAP_IO then stays set and application IO is frozen
until the connection times out.

Observed on aarch64: a source-side reconnect parks in WFBitMapS,
drbd_send_bitmap never runs (no "send bitmap stats", no WFBitMapS ->
SyncSource), database threads hang in fdatasync/writeback. Not
reproducible on x86, where set_bit() is a full barrier.

Order the BITMAP_IO store before the ap_bio_cnt load.
atomic_dec_return() already orders the dec_ap_bio() side.

Commit 22afd7ee94c1 ("drbd: Fixed race condition in
drbd_queue_bitmap_io") added the req_lock on the queue side only; it
does not close this reorder.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h  | 3 +++
 drivers/block/drbd/drbd_main.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 40be382b24d2..20899a0d7e45 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -2213,6 +2213,9 @@ static inline void dec_ap_bio(struct drbd_device *device)
 
 	D_ASSERT(device, ap_bio >= 0);
 
+	/* atomic_dec_return() above orders this against the
+	 * set_bit(BITMAP_IO) / ap_bio_cnt read in drbd_queue_bitmap_io().
+	 */
 	if (ap_bio == 0 && test_bit(BITMAP_IO, &device->flags)) {
 		if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
 			drbd_queue_work(&first_peer_device(device)->
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index aed1d1ab6d0f..fd83fc492a79 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3497,6 +3497,14 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 
 	spin_lock_irq(&device->resource->req_lock);
 	set_bit(BITMAP_IO, &device->flags);
+	/* Pair with atomic_dec_return() in dec_ap_bio(): order this BITMAP_IO
+	 * store before the ap_bio_cnt load below. dec_ap_bio() decrements
+	 * ap_bio_cnt and then tests BITMAP_IO in the reverse order. Without
+	 * this barrier, on weakly ordered CPUs both sites may observe the
+	 * other's stale value, so neither queues the bitmap work: BITMAP_IO
+	 * stays set and application IO freezes.
+	 */
+	smp_mb__after_atomic();
 	/* don't wait for pending application IO if the caller indicates that
 	 * application IO does not conflict anyways. */
 	if (flags == BM_LOCKED_CHANGE_ALLOWED || atomic_read(&device->ap_bio_cnt) == 0) {
-- 
2.56.0

