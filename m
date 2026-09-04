Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224C4772B8
	for <drbd-dev@lists.linux.dev>; Fri,  4 Sep 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521477; cv=none; b=TIENxdEAHORaulLoqOOLHOljY5io/2UWsuNlxDlikbji/HqgRcRcN2FS8CnbHyJY5NlkKZkyrD5AOCnUkZXLXkDi52W5ULFUm3MpSBOI/FIaOoeRdgrsFBcR4sZM0DWGXy2ALgra/GiQW3Fo2BoRXSp1eAHRvgiWtLZZn4VS900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521477; c=relaxed/simple;
	bh=VrjZr0QY65ey/5ruqoMQdt4mmr1ftcLtXPhGdI3pIbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpsAPYHW0N/PWIpvOOqO3+gKjS2bcrKtuPyjZfz7ysjGkX6BxKhNEwiprK9ty2fA/QZHUuHqsKXPnYpho+qucwxGuG0xHcqzQM/OELJ3y1ydtHXzyV9MiI1STVwAEMaJ95BKaF/hY7EuOuKeWpSTf9TQa2NEpzuBBaH6HXSAdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiKmiqOq; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiKmiqOq"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4b381337e1fso809774b6e.1
        for <drbd-dev@lists.linux.dev>; Fri, 04 Sep 2026 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521474; x=1789126274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvSqaX7ltGau4iZCiWuSB8nu2EopR8JjsAseFdLGvA8=;
        b=PiKmiqOqLPypp8yGuzKJ6zB2jJZuZwafKG0HXEcM+ztkX8Yws8PaINGC0ODJA089pW
         RSlaJGUL9sd0d2wmWZ95/zq15cmQhxOC3MdO/reKoImZac5KgGkWLedtfO00t0778pU7
         U3Q/RfmJj30zY+x2dnwhJhMdMveYpb/avAP5aoEs7UkzpQptPTHk8naZ+xkkpr97uzop
         DlF5sSg1zXLfnbEeeyLccKdDamyREobS16+9eBjK8gAoV5EY7HITKRz2Z5yH4/yUKPMY
         4GWudai4i4nNkh9Sz4t7Q6s7NHgLjN0q+J5y02HJ/djdatxewWqhd4IWtIBrf9XuqVap
         rapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521474; x=1789126274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvSqaX7ltGau4iZCiWuSB8nu2EopR8JjsAseFdLGvA8=;
        b=mX6+11LasGSrgIifgAdGkjwwZNvIhxmvCaVmCLZmfUM+W8aTZCYJ4bJgONZXtXh5jK
         ftkJslyhJTfcHCfkJ2fY0uQGBUdp27iK9YDoGCgs5k4Cqz4ZRxlw5YNoKru0nL8ZOeR2
         aCfnE9VLn2b4GGDFY5IsBF870Tgs3yrVSIaeN8Iq4hmELtKQQTPrOo5SrehJVCiCIiZ+
         gDyt9MT5yHb0yoLN9XZDVFcycQOalqk7tAA/T18mPQ7Y7QUvU8aoq86Kd6FD22x/fisq
         SVMKoZGtuVRW0EUrKbU4hm3VflsP4i3y1yzNgOZ2Km7e4Q+T2HdDNtq9C6MSq4zhFb+7
         nwSA==
X-Forwarded-Encrypted: i=1; AKwUvBwodDJ8nIBx3J512Rc0tP1TTCTBDxNLgKEL6FUVu6iEBgjgzkmSv2Dp7iZKvoEzjhrqkTgCF5WR9g==@lists.linux.dev
X-Gm-Message-State: AFuF++m8JYn9jcwPJmAJ/ZOvTD/pOeAHWwWqtnnmI2twFAxjAk9QEiSx
	KWnsomz7IknUxy1kyOlQuTjLI/Xh2jCRVHTgBpzs1KgsTMjIjnfNy++U
X-Gm-Gg: AYBFou2Y21ImyWcygjYT7JB88YdsSP8Czb66vV2YD79awcjYaRz0ZsVXP0Xfn3PUnNU
	tW81D0cPtaoKdELTSqX2CClxwHbb/aHVJoBpBXjiAvgwMYzOcbyEKFrxbDpuH9Ajkd/BifzvyPo
	zO2K69knTgRTiYmYPz8PLTsg1SiBqgPl72C+3ZsnkrW6rIq0cNTUPgyecuIaMptgQIAo7pK7pY/
	hh5BAQhbG/KBtJd+N/DKroooyiD740Fj6KWEn0+U9Jps4uZIll/GSijugOGesbvo/yPkpDS8kXZ
	x7jIhMOeSfCOhg3+YPhQWPiDSTSuH0ERgnadcwADlY4Mj2EKHU/rMf6NCTGYSVoSsdoTgk1dzjh
	Ej9C4bfgxD79zdr3WlgfycDhiiUPLuDhAHr9t+AK5irVBse1HP3EYq8mqxiHW+zRCDISYlTWlec
	Toh16vVXKq5fBzO1KwfN/7CTNie94/ACj309Gw9+p8jnbXSqUnkR0AB6QKZv5WvXA19jrJOIVon
	EuelRxxWRZySCo=
X-Received: by 2002:a05:6820:810c:b0:6b3:f4b8:bb86 with SMTP id 006d021491bc7-6b6fbcd0911mr3941939eaf.22.1788521474327;
        Fri, 04 Sep 2026 04:31:14 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6039922c88.13.2026.09.04.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:31:14 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix repeated word 'is' in comment
Date: Fri,  4 Sep 2026 17:01:00 +0530
Message-ID: <20260904113103.10805-3-hemanth.selam@gmail.com>
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

Drop the second 'is', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 98abd2351d6d..679b19e6927a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1905,7 +1905,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		int was_io_error = 0;
 		/* corresponding get_ldev was in _drbd_set_state, to serialize
 		 * our cleanup here with the transition to D_DISKLESS.
-		 * But is is still not save to dreference ldev here, since
+		 * But is still not save to dreference ldev here, since
 		 * we might come from an failed Attach before ldev was set. */
 		if (device->ldev) {
 			rcu_read_lock();
-- 
2.48.1

