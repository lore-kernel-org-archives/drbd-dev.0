Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704788;
	b=1DGgNdcBlOP+ndBk4Ch1QeilsMQT8DLbwLYfkhCEiuXKNq+6F6U91VchHNRQUcfkuUgf
	 wpzxeG225SbDxDT8ru4mZ6G1+TY5Mzu+N/z6iqZh/2S3UlDpi2cOUvoVUnsv3NcwHzwZS
	 FuvSMlb1f+ZC6HMozTFm/Mv4nJ6Z18KLrCSHgO0LVFiy+UcEm3oNyrEJOLCsX/pHZFeiM
	 jgbwv5lCmBdkJCYyptvEAe36zugRCGILR82vBBKAMqD3pO5rdCFZ1tsg1YCroi99iW6in
	 oSUPGs0tuJa84bT2FVDDYh7LTDT28r0LIkJzutF6EsoVF/ZJ4qxHnnPcNwlE2z4TlWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KxeOng6tNZx6tK0gchpIz6DNn1HOF5OU8odsnbpqQQ8=;
	b=Q/bkM+GthAx5PMXgSVwZnikitwOLfDx9uAiQuLq+DOAwwM4pP5DhB+W/adn2d2chwYbh
	 HJN+nfwXohODCz1Xx36/CdMOrW3xLk0S5jaBomb8+13t8lsOQXkRQRpVd+DKWTc9Yx59W
	 fC5QlM8/60Rsr4G9NOk6nRBADrzcjN/mb0IkwM6ltEV0L8I5eQbloQUfWgvqAVaU+ri5H
	 fjzAHwp5O09EePRufzJRFFIRk+NApMbr4rVzpkQYPskvh+Vq08yi3Jnrr7FZitar3uSUb
	 GUQHzOYWxto8SuquIrc9GuDUI7WqUFdN6Dm90NeIempkEa+KuTlXIt3rEKW3e5Nxpvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=dN9KCn8v;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA617606A6AB
	for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 14:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA617606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=dN9KCn8v
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so69152775e9.0
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704786; x=1796309586; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KxeOng6tNZx6tK0gchpIz6DNn1HOF5OU8odsnbpqQQ8=;
        b=dN9KCn8vGJhOTVybhTKIZylXog5mXuAqudNIskKm4CHMIw0DxdKClkgs454rFlEQUT
         wzu/YbvOapfVcZaWww4zbPubWrfjyni1xnA6mmZgT3yjt/udIWTaVsNGkyMK59edBH2C
         DeJOlQ1w1aP9cNK7MSWcCS6oC3Pwau0X1U54Nmk6J2HD0btsePEctH9fqHiRP404rIxI
         jrGJmJWYmrVT+4+yhXnTyd/BAnC6Z85qKZOm+y+k9U/CTTcg/6Fnfw0HEqXiyQHcmBld
         434AEC2rWLuW85BE1eS96u5SO7CCCViHW1V7ndT56c8bNo4JMPuAZ35RbapsXHUMuXsh
         wT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704786; x=1796309586;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxeOng6tNZx6tK0gchpIz6DNn1HOF5OU8odsnbpqQQ8=;
        b=Sy0zE9WnxqST2YyQhgJNnKVfpKjNTJdqd66uPl0YQzSP9cWkbYAeXfH7sUhdT8Stkb
         PwuXeM/bT4uq+uvyBnOjnvOIxZFlYFifrKZ0eOR9g9c4KOamNqMSEP17bRVZ3n1hUiIb
         XQqxDTMSRGhktLTQPLLl00UuebDLqT6yNcZb8aQiI4w/3PcATr35pozTgh51VaxKPH+c
         DUpGpYA+RX3eK8ik4CLYsSJKXDLn3E6scc2gnVARhLQVDdAxdY4l/UbqwRUppsx+5dKm
         MvJvnLUkzEZTsrayzGuMYxpQAM7Nro+iayz5z9vnYEEiuBnKmqqsAl+juQyqB8YhSR1p
         hUHg==
X-Forwarded-Encrypted: i=1; AL+hErEyc817jznK7kLnlUnavfLBSTTdFmqt7s9g8JuLb3nZb6sjjDaPxxQA3xzTR19pi76IQ2AmA1MnRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9HOOCZ9IOAEGhghGiVu86MRCGUaTVfnuu0thbEzjeEpnXIWxm/
	1YMBC53AI03x2qt1Vs/bXBAifF4feauS4TaVo7qmpNSluzB2vPQrHPNuF7HPXN0r3eQ=
X-Gm-Gg: AZFdTZdAEz4w6eZ4kLxnpBIspf/uRJRgyao6lB9afSYp3iHOqsyPfpbLIxNDC6wjtk/
	CDXgGNaWDMfZwgqRZqzq8tgbVmq2SDxiiBui8ZgK+bzVe09G66uV2KUHLM8wWrpxxG6rRwaqM4c
	3WKfw8/Ahw+ulZsqPmPOP9WT7IjcVtusJvjWdfrrWgSlHFifgefOPsVozndt8Wjr254nNkBnq3T
	zEditSZ3j6+k8LyZfM3bPliWi+PCXVv/4Hx6hWes7lADoXzzWHy5qeNQz6gA081n5lln56xgaLm
	90yUKpUGyOjxg+ubrW9Uxhglc1sU96DUWCIJ4VMSXfMHHfN5OcdUwA60EulEWIRGbP4B/TI+Hck
	2W7R/JHL2CB/z3I/fOaPFmjp4IPuOsw2RkaiJ/ojNRA8gqSe41M07hP6iSv1BGx7MeoZe5bo6nD
	TAOObW+CYljePknBsTu2zVFvn8DG+yngan9rN8wfyQdVDvYmF5m3/tcpBMCfsSB1X2Ul6juzI0e
	U2uTSZxJhiuKod7g2WFHbbeffq02isTd0rLwb9LLDI7AsN1WNrAucIORHJ60C8uT3JSSmfFn3JU
	JBYFiPwnPWQRHcRdBwGzMYjIn6BeqVER20zU8IEqzCL53gNpBwbdWiIj9oPTYn7yO57IrBc/Wg=
	=
X-Received: by 2002:a05:600c:828e:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4bb88786ddemr394721475e9.0.1795704786159;
        Thu, 26 Nov 2026 06:53:06 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:05 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/4] drbd: resize: do not silently "truncate" the effective size
Date: Thu, 26 Nov 2026 15:52:56 +0100
Message-ID: <20261126145257.592085-4-christoph.boehmwalder@linbit.com>
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

During the connection handshake, a node with an established "effective"
(aka last agreed to) size can detect that a peer has a "too small"
backing disk, and refuse to connect to that peer.

Unfortunately it still "caches" the maximum size that peer could
support. We remember that size so we could still grow to an agreeable
size on an unconnected node, if this node's backend size was the
limiting factor and the peer was known to be able to support more.

Now, if we remember a size we rejected because it was too small, that
same logic will silently truncate our own size if we are asked to
"resize" before that cached information is properly reset (by taking
DRBD down/up, or by connecting to a peer that has a backing device of
sufficient size).

Workaround: only ask DRBD to resize when the connection to the peer is
fully established.

Fix: reset that cached size to zero in the moment we refuse the
connection.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 101192d8398f..9cc41bc07ae5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3931,6 +3931,11 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		    (device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS)) {
 			drbd_err(device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
 					(unsigned long long)new_size, (unsigned long long)cur_size);
+			/* We rejected that size, reset to zero so it won't
+			 * confuse the aggregation with min_not_zero() if
+			 * someone requests a resize later.
+			 */
+			device->p_size = 0;
 			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
 			put_ldev(device);
 			return -EIO;
-- 
2.56.0

