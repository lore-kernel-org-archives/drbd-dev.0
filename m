Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704785;
	b=4rYUs95MoVSAG153ZkNEimBeV9Kr5xBXWqPPCto/hLaNpcX3Qvc6GvXqxHK9nmPrcvqM
	 wyXSEFNaeqNY8BavDqhRW4yDs0Qs+3HF4GId/3Pmo7qt9zNn1JvNLBqfwDYwv7CAId4yy
	 X+in01+qJGGKXXFra6UDkZbhs3nwAu5X+fJy7rlcL1kSK88VZ5VztuDUuRu1Ky/oMc94A
	 LsXjagAM91IxXKlQxWjc+VNch9kvwCS6FUQ5S24m8uV9fPdeUP79zuqgEizXNYIeNq4S5
	 C+wrpOo67xug+G45DxEDgIGJL1glq9leHT2iIs3r86qaMTpRyCQKvM4pU8aEBcWU5eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TGfh22Ic+UUZqpUU8zmfI3BWZ3bedmz86wF+EG5USP4=;
	b=vgXWJ/t/9Qig70ToQC6kzWKUOEWEWa0PV2lQC6YtUWRNfs9mSzkYV+qjb2Iz8Bsd/4nc
	 P6QVcIrBVHI0dVKMyaWQiJGo7HmxcpCE0yJVlFRT1iNCR1t94MXzCjBxWOt9MYAOIjvHp
	 hilnnYp8OTMMJ0NlE3Gg+/2P02oWvPXbjgYFHKJqJWy8U/P4PqX6J4bJprsE4+KqZuCCG
	 78TSLTsQn1OPG8w006wwO+NDl5TMM6hX7o68ZnFLQUmJ67/iLYiHcQVVOWWvu/XxfELES
	 h4lL77hpHGiMaVTX+C7gBVh3MFc34Pl/nTOELJgbB7zhpqdHlj5GHKanW8hf9/6y/ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=U9Lbp70g;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3DE606A326
	for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 14:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3DE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=U9Lbp70g
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so57570195e9.3
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 06:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704783; x=1796309583; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TGfh22Ic+UUZqpUU8zmfI3BWZ3bedmz86wF+EG5USP4=;
        b=U9Lbp70gmtv1Nk8DwHoO+GAjWC9RQRcrSib9EmQmGxDoP/6lsejFA7pFGcpQ7kLsdz
         NKNLuY6dBvZ9HYPdKFdvTB3YMVFpzpTwi/6WHQIXGIz77Vh8z67BVxkVdvzU1myjYWub
         WJXybbuC0KrBwxfAvjW8zk2iQYYyolI30D+f+G+4PXwV2oSwuMms8OPeePX2TjPLQ2rp
         ChPvQ8DxOcd9CNqiur/jD7S7VRMn1s6BhBIhsvAK4qQ6T/VqKw8fDzYyMsC+AkQgCchd
         7o2bhuWaJf2PTMt0GOC6Nqczz6GdXdOFiQdO+GtBuQKHnzWMWxrW45DLb6N9ZD7ttUZm
         DKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704783; x=1796309583;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGfh22Ic+UUZqpUU8zmfI3BWZ3bedmz86wF+EG5USP4=;
        b=LJWvgqQ4J9749sR2v8aGzUgkkhb6qBLKkhk6wcAOIx21VLLQnst7TtTVD7siDownLf
         Pobw76MwJRUwXAt2gsO7gk1JQIWuMwfLCG5bHNAg+lPlmwZgW7tcKiaJ2IXcoCu+6lVo
         UZxfv/EVODJoARozc6vm+euXjQqeH5jG1vZRwxQSkQBcXyhN8HZ0lftFubRzServVM0S
         HsDeErWbZSnDUIuSreU0v0sswq0G5TTsqeRFX0ovoKajt1Uj5EEsRtx9XEBzjMILqRxj
         AW1q7p8rSd6xNo7K2rBzUkWRMP1cNCL+BIXtj+9D9pWT73wlSBlZTDP9jnvg184vbF9N
         gWcA==
X-Forwarded-Encrypted: i=1; AL+hErFayx/17ewGuFyhMiL8XZdN8NIOwnMuVVEYf9tlx2wOPIdTK5OPhQWM9Rwh68GTLHxCjr5LFN2w1A==@lists.linux.dev
X-Gm-Message-State: APuU4Z86vyNKj75PEM/Yj3z4mrxrr095oruOj/zSh8VbJmPqwcFsJVAT
	ut/W7pPtLES8CGqs2SUgAdgMwHRv1dp6YPuJUomZTVhC8TyECapekk4E2jyY/k0oU+w=
X-Gm-Gg: AZFdTZdlm2ngLx+3K/eXyoq9xHYjFE+iHh+z2XPY9lokzfeJBc1webEaWlUBMRes+X/
	pkz/A0yxu0zwGDJIyIbhhLoEr8EquIPt7cqy9x2AITUKhFsRcpulzA1dHL5SYRjkCENT7Ym+zdW
	8+AVqtLxF9nmOyX58DrWtwcVsfaphGX4FED4+YQFnLi1BjczRvQsGbBgZ4n5nCJ/A/VZdMCOda6
	xzJiiuV565U8mQh2wRo9tY5aV1pIVugGIQiFye3+HRMmjL34Hyc73+61kqx1Ai3U79WHQdfEb8l
	ANLs6CYfUQ+GLNdmBqXkVyPCNoMldXzFSVQ+8IpB2txvaQUq/0AD2KQRZwybOa06N1XRTavulh5
	kwls8EIV/2carItdwIJnTUNa7C7SMsnqB1KKs8yEBpbxOOTirI/bk3Y8gzXkiFXNWMf6gvsZUNW
	OPC1Oce/j8ljxQ3cZ78u0xPQjPkfR2f+D/68udCZMc/SDxq+U2G8EpRN1jDN3GEXFQ9iD1Tc8M3
	8hFyebMQ8KpODLxF5PIloB7Tn++WsfsJDjUQT8l3M2iz9wv/vwjnTHLFF8b9QSMhprwDnkcmprF
	5zZl7y/jftS10q37PqZ8AezM0kQRjR1KwBNJ7gDW5jmct11MEgLQvD1IUEDkI13oB24x8YvbXA=
	=
X-Received: by 2002:a05:600c:828e:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb88785a99mr406595745e9.0.1795704783242;
        Thu, 26 Nov 2026 06:53:03 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:02 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/4] drbd: assume a capable peer for the discard limit before the handshake
Date: Thu, 26 Nov 2026 15:52:54 +0100
Message-ID: <20261126145257.592085-2-christoph.boehmwalder@linbit.com>
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

Before the first handshake, agreed_features is 0, so
drbd_max_discard_sectors() limits discards to 4 MiB, the limit for
peers without WRITE_SAME support. Devices stacked on top of DRBD copy
that limit at setup and keep it, even after DRBD connects to a capable
peer and allows 128 MiB.

Assume a capable peer until a handshake has completed. If the
handshake finds an incapable peer, receive_sizes() lowers the limit
again before DRBD sends any request to that peer.

A discard that DRBD split at 128 MiB before the handshake, and that
DRBD submits to an incapable peer after it, exceeds the peer's limit.
The peer then drops the connection, and the resync after the reconnect
covers the range. A module parameter that rejects incapable peers
would avoid this, but adds a permanent interface for a rare case.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3511a943e4b1..efa6e46326a2 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1257,8 +1257,11 @@ static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
 static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 {
 	/* when we introduced REQ_WRITE_SAME support, we also bumped
-	 * our maximum supported batch bio size used for discards. */
-	if (connection->agreed_features & DRBD_FF_WSAME)
+	 * our maximum supported batch bio size used for discards.
+	 * Until a handshake completed, assume a capable peer.
+	 */
+	if (connection->agreed_pro_version < PRO_VERSION_MIN ||
+	    connection->agreed_features & DRBD_FF_WSAME)
 		return DRBD_MAX_BBIO_SECTORS;
 	/* before, with DRBD <= 8.4.6, we only allowed up to one AL_EXTENT_SIZE. */
 	return AL_EXTENT_SIZE >> 9;
-- 
2.56.0

