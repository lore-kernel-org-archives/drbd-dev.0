Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D53F4DC7
	for <drbd-dev@lists.linux.dev>; Thu, 15 Oct 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103285; cv=none; b=lbo904hYZteTDpy2Odf6MgHvRwDTKuqUG9Ggp0Z/CjAMl0MlGBlbTveGY8DdsnIwdA4doto4Ct9Ukld+Kezhb4SlM2oZgpVZvnPlTLSrK/2iK1oBmN4ixOZMTqg6DOltpIySKEUCrJEj6wPSFSq9VZs00AOCySUx4JFUjJGT6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103285; c=relaxed/simple;
	bh=vpqF2wsjpDekTjyXB8OhTC5nc9ODzZN9cAbZ0mIUUn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ku/fOHGuaaEfUZvDXnvOwc8Kak94dUxf+8omEqmqvkIaJk49wsd3ugy/mPmZh4I0rO3QdHbT3h6uaCSwM3PPdgKpNvueeGt9cqAlSJ3d6lWVyYOfuEVd70k8yuy2PtntbTxfpGvWFar8AsGKqoNTMJ5CHdldBBfeQXJ2WEWlVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Pi6QOi; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Pi6QOi"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so1710800eec.1
        for <drbd-dev@lists.linux.dev>; Thu, 15 Oct 2026 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792103283; x=1792708083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBh6utbT9VXAJmle0MXKCsj9AJ6G5GAVRjk69ReJRuE=;
        b=d0Pi6QOixqm3Yz7RIgWJT9f00c2aG0PQ//vRlgKa7XJ+0ubZwf3TsGF5YADkgDJCE0
         lvAKXMGdDZeN20JdPHkElFVjTwNVXIVp/LpFa2BMXmYc6qKVlZuqsySWj0SP/1Q+iwHP
         1Xzz+afKsVxmkteaNglGRzoZp+S9xVoN+0qAhq7GOtWR9vufnZWYzKKev5g3z+ri2y/j
         9P96LThqeJ22kcu3Wxc7jzo8HTFIG9fBVFSlM8ufyC4H4CoJbC4+IIhEyK+3cOuWNlrN
         ch9nqmAOEb6Bkq974kNyfrvmpvp5nh1s2IUjHVR7bBkUJx7DWIYBRUaaiXAtejIxeChI
         OaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103283; x=1792708083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBh6utbT9VXAJmle0MXKCsj9AJ6G5GAVRjk69ReJRuE=;
        b=N4i/+GoxoZgZ4AD2ke/wLgYYb8CXU9sI1Bq2gWMcDhVT7QvfC0Oss2vf5jCiT09Gdw
         dD/yy45jYm0FSB0UqH7TTqWINj4yKGa9JeWphKSdHybFwusJ+EmtyHLtiMsVZ3+YK9mE
         AgaeIRZuYEucxCsFUgaP+KQhmP+QkwyutAw7/uuN3bsgRufH5Dg3WKG1kHzCqT3JwGiB
         EXgoC+aL9VJz5MT+DLyDlXaoslCGhs2tRO/vqbOWUnD41ao/Y1jomu1CmrqFwWMg4qMi
         69ARG3gPrDvazzaDnHZp6X29wpsBKACmBy7zR34BbSeYvw595vPHYv/YqcOEpuHzgEke
         iEMQ==
X-Gm-Message-State: AFq9FYKof1s0cBBCPknO54RsYioms+Av1hRL1MkW+tZGCQ/fsyR/t44n
	sSmk/BnXya4NdQzTr+7FQqQDa6KM++u9PBymp13Tc1CHWRn0y22btpjP
X-Gm-Gg: AYBFou2A1N0pa39ZOemwDxYeIW3H72ZqFPcLHLd4Q2QiN+eHaaiEl6Fo0orlsgpE/fT
	pZNTS4N0iphJm7wxVmFv3dQzv0gVvx508UY+BqYc4w9krKgOOMpND/ewkdbuyIWDG3b+BWYLNY2
	bjJPxjFCLPGrQZf6X/Pulj7MygA/TpsPmYbuhUP2WvDyvDiSm+hAgNnudpXwTqKG0ehjLqwKtR2
	NFKtOr2RM5nxw7VD41pQ6+k4erPdXcJ+kOrN3gsIbm07CbnSmxEFGAWHAffWZJvDifyMDXRxsMr
	19Uai8tm3d85DXe8FjuV29ERlf3DXHwBZYmqaENMyMLfz405kBRLhYNBFSnTreNjrGCPfmQCikn
	9jSMOU2Zt9y/1/MmiT6qF7ijpMpXNfAOj+i/TNMsz32jyUDTB5DrkyPX75Z6Zhpn6kx0rVUXJQp
	RInUM2x+FgyPa3obrKoc/ZF4hbAmOsHrHgTW5RFGLbgl56zhFZIsrxqfKtm3auSuQTOs/FLrW5/
	8pAvicYRo65d9zXOztRgx/8dGDuhOWKneuP1jV4Zi+jJmHBVEmVt8hZZ6xQBRbHmi7E9oKVlvk=
X-Received: by 2002:a05:7301:4b09:b0:351:2958:1740 with SMTP id 5a478bee46e88-3537e088bf1mr27576078eec.37.1792103282862;
        Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
Received: from yibos-mbp.3500.dhcp.asu.edu ([2620:d8:8000:8078:404b:acf5:562d:50f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm873307eec.16.2026.10.15.15.28.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Liu <yiboliume@gmail.com>
Subject: [PATCH 1/2] drbd: reject data replies whose size does not match the request
Date: Thu, 15 Oct 2026 15:27:59 -0700
Message-Id: <20261015222800.85928-2-yiboliume@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261015222800.85928-1-yiboliume@gmail.com>
References: <20261015222800.85928-1-yiboliume@gmail.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A node that reads from its peer (it has no local disk, the area is not
up to date locally, or read-balancing chose the peer) sends a
P_DATA_REQUEST for req->i.size bytes, and recv_dless_read() copies the
matching P_DATA_REPLY into the original bio. Commit bd910a7660d2
("drbd: reject data replies with an out-of-range payload size") rejects
a negative payload size, but a reply that is shorter or longer than the
request is still accepted.

A shorter reply only fills the start of the bio. data_size still drops
to zero in the copy loop, so the final D_ASSERT() does not fire, and
the read completes successfully although the rest of the caller's
buffer was never written. With a proxy that cut one reply down to
1 KiB, a 4 KiB O_DIRECT read returned 4096 with the last 3 KiB of the
buffer unchanged and nothing in the kernel log. A longer reply leaves
the excess in the socket, where it is parsed as the next packet header.

A correct peer always replies with exactly the requested size. Reject
any other size, as is already done for negative sizes.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yibo Liu <yiboliume@gmail.com>
---

Notes:
    - Reproduced on block-7.3 (41cab3a71dc7) in an arm64 virtme-ng guest,
      with two DRBD 8.4 resources connected over loopback through a proxy
      that rewrites packets. A diskless Primary read 4 KiB with O_DIRECT
      while the proxy cut the P_DATA_REPLY to 1 KiB of data. Before: read()
      returned 4096, the last 3072 bytes of the buffer were never written,
      and nothing was logged. After: "Invalid data reply size 1024, expected
      4096", the connection is dropped and the read fails with -EIO.
      Unmodified 4 KiB reads succeed before and after. The harness is
      available on request.
    - recv_dless_read() in LINBIT's DRBD 9 tree, which the pending DRBD 9
      rework series is based on, has the same check, so the series probably
      needs this change too. I have not checked the posted series itself.

 drivers/block/drbd/drbd_receiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..97b306676626 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1810,8 +1810,9 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 		data_size -= digest_size;
 	}
 
-	if (data_size < 0) {
-		drbd_err(peer_device, "Invalid data reply size\n");
+	if (data_size < 0 || data_size != req->i.size) {
+		drbd_err(peer_device, "Invalid data reply size %d, expected %u\n",
+			 data_size, req->i.size);
 		return -EIO;
 	}
 
-- 
2.39.5 (Apple Git-154)

