Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620925;
	b=4oQWGU5hC5y2l0h/uzQ778pK82CoAVWDPUxmk93c3XXSe5VxbpmGpLri9xTlN8/1qcng
	 TPlnur+vsXFRfdXx7GH2Qm+UgxV8HPoRidXaZuO8Ma2yl+FwF7xHlJwgi+XihJ2ze7HTK
	 8/No2Bw152Z4ggPk7JQYTyugJSvTNiM2jLFGCdMYu6BXccmERWOjzSVfQ768wthwsbZjb
	 rHWcViZ79gb6VWvVWCTMR7hzh9/IzzKjpI8tHvmIzsMERcUxm/HW+9qkJ9Xey4m4cX9wf
	 jlQjy+zEAooxFfgcw1e4b+CYJlm0rwut0ptS9KkajHZ38yFKksle7QcqkIcsV5OUovA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RaW8x3wy2dy9KRWxzMBJFya20NKzKWRFujyB0bIcDJk=;
	b=rXiswrDY6I0cDuXcMWgbFLWopYdPWHq7dOjzKyyRGC14ZqX55OfDVgr0uD/s2MyB5QhZ
	 SHj42p6u4usT6IwJBSsBAI7OoFboNDHBsDjS3l3I6AS7vVIqm+5Ro3gzvt6fpiaXW6hJO
	 HZq6zNfI1t5IvcbvMLi/RCgx/idXq3S9LgLtMbzfFtXtBufBvQl60N+Gz8lUt2oV1XQH3
	 cd8PSJqKIkpbyugneuaSfzyJhs7hF7fp32FxPVhUOqomR3VtmG5KUOcU/oSVQLPIxppsp
	 meE1NkpID2ZhZXr2Rwmii9+LUib/lC73fsKcDrGWDLyGIzEtranPySbAKX9RF56Gokg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=urzxxUUm;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A7606A33E
	for <drbd-dev@lists.linux.dev>; Wed, 25 Nov 2026 15:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF3A7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=urzxxUUm
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so56591865e9.3
        for <drbd-dev@lists.linux.dev>; Wed, 25 Nov 2026 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620923; x=1796225723; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaW8x3wy2dy9KRWxzMBJFya20NKzKWRFujyB0bIcDJk=;
        b=urzxxUUm8T9VqkCGDGDjNc8uHokYZXKa0sO69Tcxr9tRv3bEqUisgTzdRubsk5Vt/2
         x1JSQ+5DMbKsadeOWMObDVodNPsOnndyre7Tsiqj/26yqxzCSGnqGtKJZEvPAQrRlzNy
         Uid5ex2dhTB6LL6m3bucmK3E6KOAaYoo6mMJJr+i9jnkK7WkTY5/1gFvlyTzAsSLvnO7
         Kyt/ShDtvFCZJEnQYG0CsOZqoqBXfQQO+ZhlyEzxEdKvECqJd+vRJ1Xdu/9rgl/F7EkB
         EWJ1BAv+2ezQ7IRPzEc2oYPTlunMSide+8/yIg6yKcC2ixQ4Nxf/b0eFC1WS+Xm/+UU0
         Vhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620923; x=1796225723;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaW8x3wy2dy9KRWxzMBJFya20NKzKWRFujyB0bIcDJk=;
        b=mZ54UMsp6DZPnSGDJhNUAdI27dBYL/4Vm5nWSga4rv3MKRTOM1DC/odFBDxkCwBmK2
         xUjzS9wzEkCER8sQCl4gqkaBqvD+gvyxeyBZPavcly133CGJaUUSCvwVMLH8+MHcF7Bc
         u4kp9abO+GyXT/c/MfpBg41XAd0za6VGDZhu6NWhukopwQJKqYhdNlnhBIGbc9KdULBg
         5BvNQz4ZkBpat2xQecun80uEEe8J2rzqeeeAV47TpnQEVPewPXjv81ya4bEhn02KtXvi
         BSURS5XJFDcASlgLgbkGxcH+x1pTUkH50SeR/a3Zw8DhqfNz8YM3H/QHenL2UWXiNT95
         058g==
X-Gm-Message-State: APuU4Z+BCtP7i3XaceulFY7SEi9f4iPzFYlmyueN3dfF3Vsg6Ghiqqd2
	6/eimw758k7DnefeE3EypFY7ou/5QCcTPMl/1Ipbh6Lth4iA8yX2TUjMVo/Q/oNAEgQ=
X-Gm-Gg: AZFdTZehXM9Ytm36Y+N2bYh3eLGeBARwwWu91pFRzXGX3zZZ6oLb23BkP/7kTBdXnsS
	kJBCbVRA6JQWfq+41NGyC4onyhMx4qpdmiEOgOPIWwLRYh5jETDkZIm0gOIQ99YuLCXO9AsmZ3/
	twraehDIkqIsmeYZ7zcvOwsXEjPcTG4tmc/YqQd94o3pdv5j8PUoDpYBIID8EGzNq4aA5Wwvnbk
	3DRT5buBgeZ3XdQTUxqRZVB4bSC/QCxFHQu6RnwK3fVfhksKQxVbipXLWcdt0gYOmiO8QvtiuAD
	HHtMOCfafe3o5MyaLX7dz2hGr6fZUKepdNQ2g87D2KdywzlfwSdRE8Jk9nAtRASdUFyl/8kTktB
	/WjQcRuTu/PDTM01QDljsBif3Wf2rsJelOh2pVA5YDk9uK/DOamDBtzI0uiAOqmRWtzitanBwF3
	95A5JbF3EoryyonCC0PtF/Ma1GHwIMpDsdyuhJMBlqtNsnU3WJYD8Hm58zo5HcWws8/zUbxlueX
	7yydZhJzqiQmtJnR82PxCHv5l68C0O74BvW1U3lMG4c4m01vAjgMmjFE7REsLSSe+EsWcFUUDBD
	9qcXUM4Vr7N3+huNk/Ed0+nWhWVRUWRmyQ6TkyDY/qUcvAB9n/Q0T5WswJ4ng2hJr6VubdqPzD9
	uvKTzDIEVxD4oDny0QKE=
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr364067455e9.10.1795620922993;
        Wed, 25 Nov 2026 07:35:22 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:22 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 06/21] net/handshake: allow the DRBD TCP transport to enable NET_HANDSHAKE
Date: Wed, 25 Nov 2026 16:34:56 +0100
Message-ID: <20261125153511.3060599-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
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

NET_HANDSHAKE is available only to the subsystems it lists: the SUNRPC
client and the NVMe/TCP host and target. The DRBD TCP transport uses
the handshake API for TLS-encrypted replication in the same way as
NVMe/TCP: its BLK_DEV_DRBD_TCP_TLS option selects NET_HANDSHAKE.

Add BLK_DEV_DRBD_TCP to the list, as NVME_TCP is there for
NVME_TCP_TLS. Otherwise that select would enable NET_HANDSHAKE with
an unmet dependency.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index 76ab44aa439a..db53f7474b7f 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -92,7 +92,7 @@ source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
 	bool
-	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP
+	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP || BLK_DEV_DRBD_TCP
 	default y
 
 config NET_HANDSHAKE_KUNIT_TEST
-- 
2.56.0

