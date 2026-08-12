Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4732594BD
	for <drbd-dev@lists.linux.dev>; Wed, 12 Aug 2026 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495609; cv=none; b=XMd10+kiksG7Opx0666LkNyidWEeCkyyl2XDyzKHkdTgvN01PZpZmBpOudO++T6I5GjzwQXW85ofQZOCjrpfrz5y/tUtMR86QUtyuR8UsiEFuzkDXJFh/v84qeA/bOpK/5WSo0gIYLFh/1GcX6iI9IR4U1fIJZq9IHeemTnwkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495609; c=relaxed/simple;
	bh=NrK1RBmYlnA06i8IoGcw9mwv7mEtaqo2SOZasr20nHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0Ly2UrEXjgSirNTA+IuSAI6vX7vmmNSUmaBddB8eH6Qeu3S8LxpOTuFrVEPVHjH/TMak9t6+reKjQz9V+G8EvSh7e6R20bAzx/k/DmwHx2L4vtzI8ZMX6BVQYM5Qea+QilqC74cGT0PEGfP0nB6ybOwuSjwviCUboFdUa/m8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DdHnH3En; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DdHnH3En"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so320758f8f.3
        for <drbd-dev@lists.linux.dev>; Tue, 11 Aug 2026 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786495606; x=1787100406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0IfDFRall+oCSkLI1U0TG5CqnF6f2okqMRuS89yUp4=;
        b=DdHnH3En6droQI+0fVQsdI+Jb5GimXV8zry72WbkcxxO5sVimk3ZD6MOVP+DfP5vqC
         3yh/SHtz3rvAelTXb5U59fxn9/IrN30Ay+IBERxQcNta4cKvOnQZogWQSwjxuJGFs3R5
         AYaNxKX5oUckGUiFAUCeExJsh6tv0RskKsuX4Us3dO/fSBjxxx9KnkEloa/pU5foc8EF
         sgprSvmRY4OTJ05e/kUDAscQh75bLWs4angfSJCYb1iOf0G3eEfJXFm05+7smLbphqjQ
         2Svkep72oRESVDptqU2eq3/hOVnITvy0AP5CjAGUtBrGmeQsI7W7SNxSDAHc9G9TGg6/
         Merg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786495606; x=1787100406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0IfDFRall+oCSkLI1U0TG5CqnF6f2okqMRuS89yUp4=;
        b=jScxmdKE+IKynJdQ/DxsMfzLhTuGaMDnFeUCGEWxbWT4Yr6aqiqw8JDhoq66/Agbea
         Kp7xDA31pv6+TJul0yy5aBgxRR2YgMxRYba7labVNTf+piNgVyOqh7D088b33W8uFhFw
         gIdHKmRLBs4U6PTz26VZupb9psZR5Qq4pnom1+QOlIBHa8SidbY1YBP3ewHa5NZu55cA
         FXSUGdN6w25sEmObiMy3V8LZ8mJ3/pQAQb54COWz3zdt4ZWStZELXp/W3ZtJPQcw5M24
         HHArvKQ5g0tFnYiIGStoxTlyLl1f6ozPsb0AylJD3W/DoF7l5FP/z3IqCbfRr8B3QKcE
         /9ig==
X-Forwarded-Encrypted: i=1; AHgh+Rqg+308LqPDkAweZaqEfBeTSJSeVey3SYcQRRGiK2/Vj4nQ1WKGOhW17i4oWUHX2bDuYrDrnrtjZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw20qwniel3fpPwAxafK/Ku7qGvmZpLt4EgTQF98exCYYwIuYLG
	UyRIKnwNmWV62mhI5E5vQKCavtIKP1LDx5m7ePqOAD8NekSiNR5wpeS7fe51wp9YEo0=
X-Gm-Gg: AR+sD11vRU3T3UPLiQz3nVCImMI9DWHcDXeIrDSB9Ci5zE2K5T5KqgM3tZog/846cIB
	Al4IJIL+icjI66ESDxlNqLeLfz+WgUVXXn64VmRN59cxNhZ6tG7ymj3qHnIqHq/R5sBmCVkJBFY
	E53ILap4MmuFXXo9zIYS0x0mVOlW5RR1dKbxpIzOB1aFI9dlAMmttcKmrei4inZS5gXG2tCXZ2k
	QeD6ff1y2B+NOTt+dn8EhCuxhRSiF5jcP6pPeAqtkYvs4MrgIl7IZbjUlIOVxmN9MMmdkhsTHYb
	ll22FrcZdOXHbLIaZIOSjL2ikmBqsd53K1R/ujXAcyU+y+fpmlZaqFSBlUofUMr8Ybv0A2bkG46
	L1TwOIUs87SuTAiVVfKFROcJL5qi7/n36cG/i0JyZegI/yLGekRLobzTeHQAKuLH2nmmcN7xL0y
	bNYnU2D3vXH0zpQKZEwQa7/aZeR86MAqVXMoZC2eW6D68E4iTePIn0PVdDkftP1Clfkz0dkg==
X-Received: by 2002:a05:600c:68d4:b0:499:49f2:bb86 with SMTP id 5b1f17b1804b1-4997c0f2251mr9644745e9.6.1786495606238;
        Tue, 11 Aug 2026 17:46:46 -0700 (PDT)
Received: from localhost.localdomain ([2605:52c0:2:27d1:8ca3:89ff:fe18:2252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141243819eesm3789934c88.0.2026.08.11.17.46.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 17:46:45 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: drbd-dev@lists.linbit.com,
	drbd-dev@lists.linux.dev
Cc: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	joel.colledge@linbit.com,
	Su Yue <glass.su@suse.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Claude Fable 5 <noreply@anthropic.com>,
	Gemini <gemini-code-assist@google.com>
Subject: [PATCH RESEND] drbd: consider resync after peer forced Primary from Outdated/Outdated
Date: Wed, 12 Aug 2026 08:46:31 +0800
Message-ID: <20260812004631.83718-1-glass.su@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a node is force-promoted to Primary with --force while both nodes
are Outdated, it generates a new current data generation UUID.

If they are connected, the state change transition updates the peer disk
state to UpToDate. However, because if both nodes were Outdated,
the state machine does not automatically trigger a sync handshake
(the CONSIDER_RESYNC flag is only set if both disks were D_INCONSISTENT).

CONSIDER_RESYNC was only armed when both sides' previous disk state was
D_INCONSISTENT. When both disks are D_OUTDATED instead (e.g. after both
nodes were explicitly outdated and reconnected) and one side is then
force-promoted to Primary/D_UP_TO_DATE, only the promoted node redoes
the UUID handshake and moves to L_WF_BITMAP_S. The peer never arms
CONSIDER_RESYNC, stays in L_ESTABLISHED, and drops the
incoming bitmap in receive_bitmap() with "unexpected repl_state
(Established) in receive_bitmap". The two nodes then diverge
permanently: the Primary stuck at WFBitMapS/Consistent, the Secondary
falsely reporting UpToDate/UpToDate.

To reproduce:
====================================
ssh node2 drbdadm down drbd0
sleep 1
drbdadm down drbd0
sleep 1
drbdadm outdate drbd0 && drbdadm up drbd0
sleep 1
ssh node2 "drbdadm outdate drbd0 && drbdadm up drbd0 "
sleep 1
drbdadm status
echo "node2 drbdadm status:"
ssh node2 drbdadm status
drbdadm primary --force drbd0
drbdadm status
ssh node2 drbdadm status
====================================

Fix this by expanding the CONSIDER_RESYNC check in finish_state_change()
to also cover D_OUTDATED disk states when the peer is force-promoted to
Primary and UpToDate. This successfully triggers the subsequent handshake,
completing the resync and elevating both nodes disks to UpToDate cleanly.

Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
Co-Authored-By: Gemini <gemini-code-assist@google.com>
---
 drbd/drbd_state.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index e7f9cab01c58..73cd2807d1fc 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -3147,9 +3147,16 @@ static void finish_state_change(struct drbd_resource *resource, const char *tag)
 					}
 				}
 
-				/* Peer was forced D_UP_TO_DATE & R_PRIMARY, consider to resync */
-				if (disk_state[OLD] == D_INCONSISTENT &&
-				    peer_disk_state[OLD] == D_INCONSISTENT && peer_disk_state[NEW] == D_UP_TO_DATE &&
+				/* Peer was forced D_UP_TO_DATE & R_PRIMARY, consider to resync.
+				 * Also cover D_OUTDATED, not just D_INCONSISTENT: e.g. after both
+				 * nodes were D_OUTDATED (both --outdate'd, then reconnected) and
+				 * one side is force-promoted to Primary/D_UP_TO_DATE, we still
+				 * need to redo the handshake here, or we get stuck: the newly
+				 * forced Primary moves on to L_WF_BITMAP_S and sends its bitmap,
+				 * while we never armed CONSIDER_RESYNC and stay in L_ESTABLISHED. */
+				if ((disk_state[OLD] == D_INCONSISTENT || disk_state[OLD] == D_OUTDATED) &&
+				    (peer_disk_state[OLD] == D_INCONSISTENT || peer_disk_state[OLD] == D_OUTDATED) &&
+				    peer_disk_state[NEW] == D_UP_TO_DATE &&
 				    peer_role[OLD] == R_SECONDARY && peer_role[NEW] == R_PRIMARY)
 					set_bit(CONSIDER_RESYNC, &peer_device->flags);
 
-- 
2.54.0

