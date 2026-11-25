Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620918;
	b=i79HGzR1gNxr75Y5Sm2XfZsLSMOq02EL8QIQs9kwbTAZgsJSK/mQ8tJTlLgrydZ839cW
	 sXrLRUdTUl5jifnUte/uQo/me8QtOZv53SeqV+JsqwXaHv2Z2mRdVfbu07fxjoujv5y1M
	 KbzB9iixPFHgGNtMjhgPC7cQ7Ino2aegtP10NWBVF8paJ09uII32BIsaN40hJnC+pcrZt
	 YxFD7aqssIjitbdK5UdIAfyr+3O9JOv3/VRSemI7/hdOCF6WnoJSixQnehnB/zwcEykgL
	 GlYkjtarN6xccM30D6duoQDsAxX9ReMimEXPdNfSxUsZNloKVvSjn01X6NU3DCbmG+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vhkFSXBg3GgpQvepNDJMBuRf8NhXV0xRBkRjdJ1kVu0=;
	b=oskm72eH1WDNB7Tg6/MFhcGCPHxueUPhS/l7Qas6Eo2zjm9pm3btEbTpFL1NSCwZwhdd
	 g4wPrGamIVvJjsJl08v4xwd1bVvOtbdHfMGqoSQpORsyT0vpOG2wWnGYVcdPHF3vvznEm
	 usYvYp35BqrVqwZuQKRXboV8boHupwnc/lvLnCXW8j7AVJdGdtu2ggiEwMNoLNWpNY3bh
	 Ine9uDM9h4nhN9aaf48Mcxlfr6Il5dkHM87GoDMtT3PniqnMAZvsxhUgw4iNHAgCH0U+r
	 cFEsYWUOtZKxwQDI89FQWLpvqW8hUjHG5ZsoqEzhsBx0duEJcgmUXpo4q71ctRFwyjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=RfD1cAeP;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29676606A331
	for <drbd-dev@lists.linux.dev>; Wed, 25 Nov 2026 15:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29676606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=RfD1cAeP
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a9be758734so3756302f8f.1
        for <drbd-dev@lists.linux.dev>; Wed, 25 Nov 2026 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620916; x=1796225716; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vhkFSXBg3GgpQvepNDJMBuRf8NhXV0xRBkRjdJ1kVu0=;
        b=RfD1cAeP9S9A3aYXTZPUwAACY0jHW11H3AXU8SqaKMxS/KyJr46IGby3D9pHtsnNbc
         XT5xmhcWtBF5/5RVpXXGyNN8/oWBr2df8Rwhpx/u8hCZ9KbAGcsm58T+tcKaUqC7kHtl
         S07yddYK8hbvcRxD/NG3n1yauZcCDASqKgsSCrpRMyaZswETfTrvVc0HdoUgg2JfJIiI
         pqyTwY7LfJryyTbdIe83FyyQ0aMk5bZQYobSP7soWzY+DOwWGfN56IvvVgHNfOIkTa/2
         iucikuIgMoQ/x35ccmcv71cUn4q/jw62TP8Aq2ynY4FNfoHZ4VM52x0lHRjKvSpg74G7
         VVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620916; x=1796225716;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhkFSXBg3GgpQvepNDJMBuRf8NhXV0xRBkRjdJ1kVu0=;
        b=ldYGhXnL+saN/SZAKEYdEE0y6IbzsSl6l7TWpqcsGqGpJfxNbBFL2Tb+udGRmEQri3
         nSZK1to09M+PzPkgmdCn21iacVCg22c6hOf49SmjPsgmNENpGvAQ4iyE6n02PMP48741
         RdJC+7rrY97Md4Hf0xJizVOP9/BIYRtzkpvWDgeLUrRGAZvT6SxRdF7keCIMU8ggS9Mn
         kHYvnMQVt1R2G8j/a9v7nVO9EoDxJLlka1FGFk9xk8pq3cXGFpRdiIjSlMFB5nNEbn2m
         COYh1RUJyxGuzpgyaIzHwKqYdcRubJy4zK0RufyaOfEzjDt2z34zgjAHgaOEV0Sq9OKL
         23SA==
X-Gm-Message-State: APuU4Z+HLVlmvy2szM7W1lesBRlltzPK+Yw0rhAC5hOzp1v01HZXz3GW
	9Beh/fRpQDM4pKz4/IzqS5jiQxdOiODKqS/kVKoBRf1uRJRZU/SnSIND4QTT+kI5a2Y=
X-Gm-Gg: AZFdTZcx0e1v7u3cyqjpzRgot7LTje9nen/JHcaKRKIGgl2UG1CtkNJpqUmGNx4qLBL
	r2frZcoT3vxRi5ndBnHlAXiHMn2yMe5cfDmDeBmhWxdJzvXN2iBKAhiLOB8rbumvB2ozwtuJ5xM
	O3EewrJOmG6smcomSIG2r21aKo/JEV0lX6+bjGwQWJVZE7iYhPq9gTrii5wUEya6ECoCs53/QiM
	okfB0wDdii64OhdcoGlFiIGO4NDGw3HIyfQNzEVTvzL/IqG+Jd3Rrd30TbC5PnsxfDl93HGwEeS
	yQMhmqVZomrh3efhf0BEhKS4pj1b9rMGyXFTE9l0n2TxnpLGWPMYCojkweAMFpfOhyHsFVUySqt
	u5ltWRu9/roxvccuKhZiuY+oST+UVOZMfy97uBN+7go/FdMUQ+EHKJ2EDxaxAFk0c6W/iUIs6xz
	z4PMnkoLi7RcLzI/10Pqns5jHM34/mlFfnFbJ7lI59R1Flu7tyQ/6lMoXN7Owvh81kPyhxb7Zh+
	VYUUeFZZS0nycFKaU4X8KHMrOJtieb5S53ZBU6uIrhkcaYUpZGSiY10DdD9k8BELnuc5LhTwGLU
	Cc/pc6RCsj2PpSILEd+Csfv3GN2FxxBRY0yFkzsbUACO7vZvoWurRsULuYeB2TFhicsgae+DqA=
	=
X-Received: by 2002:a05:6000:29d6:b0:4a8:bca4:f295 with SMTP id ffacd0b85a97d-4abb32a4173mr23941677f8f.38.1795620916557;
        Wed, 25 Nov 2026 07:35:16 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:16 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v4 01/21] drbd: mark as BROKEN during DRBD 9 rework
Date: Wed, 25 Nov 2026 16:34:51 +0100
Message-ID: <20261125153511.3060599-2-christoph.boehmwalder@linbit.com>
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

Mark DRBD as BROKEN while the driver is being reworked for DRBD 9
multi-peer support. The following commits restructure the driver
extensively, and intermediate states do not compile. DRBD will be
re-enabled once the rework is complete.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..b907b07468bb 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,6 +8,7 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
+	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.56.0

