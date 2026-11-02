Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602880;
	b=ppqn+CbqOpLRFiqwPz6+NknJgswBmB91C1P/IbQYmsGAPjUjGAa15qlOZlqIoJU7h7Ma
	 hJ9dB8oFdRMorc6aVilYVkCPNXpV7DXChy2lsMweTxA79rVXJUIsL2fdDi2Q0oynmcm51
	 1PyPnn4EOgUHgoemglf9c8DOuQovlj2xiw1lU2TSkeMst5/keT8UHaUCjmhHHUKJslDv2
	 FatVLu0lV+xRlGI0KXMm9BQZzjqrgMd0B+JJw/wgj09m6Y7TXDPZR09VTpJHms2SLCD69
	 M6woCGLTtRPRiQTYR37oCAgpxwqdRIZHCRZ4v46P1llD0vxZ/nPSkqO1xappkPoZaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MrLu4JAhxR8kj09jGcEi9VYiJLe48/kmfVt9PcwNue8=;
	b=F7GpMWfCYi9SjJDNlbd1swbduiEnAe9u0jJgHKG6Zk/FyRjKsmM7qr+RU9ZjJ6xIttdH
	 PKQ4If04GU7e8uplotIsfKklvjt8heykHRq3Ur8czXYULOQeEbGTb5WwEGU+sjcozIIW4
	 cYuR4Q4UTAP+k8pt0OO17xd60rlpJzKI0t+RzFTGNXGPc2HZuDvgkdcuoMxSsb9IycRhd
	 AqpGAe475VH+hF8hBa5jh9ZcGHWosQ+pMK0GL4ya2xZc3ClmV2wcFI3HMg0rJCGNGQEdA
	 b+ztw+8sQrBzJcfmw6y+FlH+187OYaE2QaExr9D2oAFAOFKGaapZNgadKjgqC0+bYKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dI9KADv6;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D36606A32C
	for <drbd-dev@lists.linux.dev>; Mon,  2 Nov 2026 07:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D36606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dI9KADv6
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1101540a91.3
        for <drbd-dev@lists.linux.dev>; Sun, 01 Nov 2026 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793602879; x=1794207679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MrLu4JAhxR8kj09jGcEi9VYiJLe48/kmfVt9PcwNue8=;
        b=dI9KADv6bmuj7ZkkCLNYisHQJhG2TB54SG+WbCHZDVIrs8zFCQRZwcKDhorZQ04skg
         B3pWOVJQoVCCrJtVP5IK/cZuELXpJ8tVtWbphR0TV5njdTXW4YO6FnoZHkY6iLZvLOG7
         +qqsUrY1gowqqi7ri0umgB5lcdvgCzGhvOYLPkklAYOkuFGTQFuPbxeRnSWL/squdkPp
         dZagYYEUlRwALEkGdhj2HGiqKvcR2kaG+FVHFhXKVZ02ZW/1u1jJcGttnc5y8BIwgtVx
         /Ripjn9WwKd650RXvUXR9s3k3oOxgAHxvVN03LZU9G86i051Mgh0BQ2vpDX1hlexlsFg
         iQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793602879; x=1794207679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MrLu4JAhxR8kj09jGcEi9VYiJLe48/kmfVt9PcwNue8=;
        b=VoH4bu/3pqd8vzR1ACztYk1Qy3CjoLcxeDR9+MU1kTq3BH2RRJSDIC7+dUikUI37Wo
         XOWEeDB3ruFi5uU4Eg9T9rKV8u8ep4DLfOz3NOTWX1X0BhxIsC0rptO3G99tZz82rDlh
         +q7s3zcsqaeoPP0pdMLdcQBS/W+QYgCd979ZnqP7gJ1hNf/oBbCHCJa93mBSaFiiWN+1
         xjiJsR54AtWQHeihDozTRwXhYqNLNh7Vfh8wqFmQy1dmJEw2JDmbllA3FEviigQ5g/4C
         aL7tK0tMMzghCTd5bRcEO+fLP86J4zCY8WOuwe0PdPaVdSD+ym7YuSSY7aqIwF9Mc5ST
         nZOw==
X-Gm-Message-State: APuU4Z+wpw6ncttIBzey+JXrvO2Cu4rQL5vr4LO/FRFifMx65VIBgQ2D
	aOSBSUBMIirJ7igJkZ9wHf33Ig+fS2/nG9qo++q9i5kVATWVjIY/D4zpd+SSiQ==
X-Gm-Gg: AYBFou3Kgk6EMSkSoOx5h5tzvwpsVSXMjOK9wElMUAntQ5hOk8TLcc/447v8Ho2UBRa
	LKhAx/eqSEegvwbItnzd1qV1G1gGjByL3sa3QemP2KgNWabQ9HiwRLIjKsX1BGXmZo5wu5WPeAm
	X8lyyHYXm4O+aabsVt/jxzF810dpOiTMYgsftnW8MxbbQ+sjRuBXM/8Y8B/4eZ967xRRixe3cAh
	mZegCbVtAZlKGA2jYfjoctEhTz+796qsQ17rgKQWVnbAwaf/Y3dn3GwAPrsSSM31xRd2GpxsYxz
	saaAHhHOCTaLrCTvNNa+Gy+P6Zm4mrYY8K9cxvd+rrx77fkln21vN6EaGadUNVTtPOYhi4HsgoZ
	fojHw3km1XLezT9R15bA0BPr6bwVkconhwB//aC6dorGqfkAbKJMFyt/TwPYm34qJk9gFrWSk6E
	0ZpM1/Z9GphUTLV/dt/F1jDifVHEBa++AAp25VzM+El33x6K7CJri+kSJ6lW1MoRWMiOKvt+XDX
	sSDX3B/jUuwe7f5H9Y7tn+fP1WO1BjsMi7/bSNc9/HshKsF8O40NK60HR/iHzgbET9NcoeAeceL
	MEd9cF42nSiXrOtKM3bJg7OLA81xlT1mtReU5++OLouAYSUxQly7LuA=
X-Received: by 2002:a17:90b:4ac8:b0:3ac:7116:434a with SMTP id 98e67ed59e1d1-3ae897ccac3mr6741605a91.15.1793602879205;
        Sun, 01 Nov 2026 23:01:19 -0800 (PST)
Received: from localhost.localdomain ([219.251.253.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm12690009a91.17.2026.11.01.23.01.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 23:01:18 -0800 (PST)
From: Kitae Yoo <ryugitae777@gmail.com>
To: drbd-dev@lists.linux.dev
Cc: Kitae Yoo <ryugitae777@gmail.com>
Subject: [PATCH] drbd: fix resync stall when P_RS_CANCEL_AHEAD overtakes the state change
Date: Mon,  2 Nov 2026 16:01:13 +0900
Message-ID: <20261102070113.52210-1-ryugitae777@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the sync source pulls ahead (on-congestion pull-ahead) during a
resync, it answers pending resync requests with P_RS_CANCEL_AHEAD on the
control socket and sends its Ahead state change on the data socket. The
two sockets are not ordered, so the cancel can arrive first.
got_NegRSDReply() then sets SYNC_TARGET_TO_BEHIND while we are still
L_SYNC_TARGET, and make_resync_request() returns early without re-arming
resync_timer. Nothing else re-arms it.

This ends in a permanent stall in two ways:

1) The Ahead state arrives and we become Behind. With resync_timer dead,
   w_resync_timer() never runs the branch that clears resync_active.
   When the peer returns to SyncSource, the "resync-after-behind" start
   is postponed forever by do_start_resync() because resync_active is
   still set ("postponing start_resync" repeats).

2) A previously postponed resync start fires while the peer is Ahead
   again, so we become SyncTarget and the peer cancels our requests. The
   flag is set while we are SyncTarget. When the peer returns to
   SyncSource we never left SyncTarget, so neither the
   non-sync -> sync transition that clears the flag nor the
   "resync-after-behind" path (old peer state L_BEHIND) is taken.

In both cases the connection stays up, out-of-sync stays constant and no
resync traffic flows. Only a disconnect/connect recovers.

Fix both:
- Keep re-arming resync_timer on the early return, so that once we are
  Behind, w_resync_timer() clears resync_active as intended.
- In receive_state(), when the peer reports SyncSource while we are
  SyncTarget with SYNC_TARGET_TO_BEHIND set, clear the flag and kick
  resync_timer.

This does not remove the reordering itself, which would need a protocol
change; it makes the target recover from it.

Signed-off-by: Kitae Yoo <ryugitae777@gmail.com>
---

Notes:
    Environment:
      DRBD 9.3.4 (Ubuntu PPA 9.3.4-1ppa1~noble1), kernel 6.8.0-124-generic,
      2 nodes, protocol A, on-congestion pull-ahead, congestion-fill 8M,
      sndbuf-size 10M, max-buffers 20000, c-max-rate 200M.
      Link: WireGuard tunnel (MTU 1280) between two sites.
      Resources managed by LINSTOR.
    
    Reproduction:
      On the primary, repeated bursts of 64k random writes (fio, iodepth 16,
      20s on / 5s off) on a 5G volume, so the source repeatedly pulls ahead
      while a resync from the previous burst is still running.
    
      Unpatched (both nodes): 2 stalls in one run; each needed a
      disconnect/connect to recover. Earlier runs showed the same, with
      "postponing start_resync" repeating on the target.
    
      Patched module on the sync target only (source unpatched), two runs of
      40 bursts each:
        - source went Ahead 15 times, 13 of them during a resync
        - "peer pulled ahead during resync" logged 5 times on the target:
          2 with the case 1 order (pulled ahead -> SyncTarget->Behind ~1s
          later -> Behind->SyncTarget the next second), 3 with the case 2
          order, each followed within 1s by "peer back from ahead, resuming
          resync requests"
        - 0 stalls; resync finished each time shortly after the last burst
        - no warnings or oopses in the kernel log
    
      Not covered: the patched node acting as sync source, and >2 nodes.
    
    Side note, not addressed by this patch: while we are SyncTarget, a stale
    queued start_resync keeps logging "postponing start_resync" about every
    100ms (~1900 lines in 3 minutes in one run). An alternative/additional
    approach would be to drop such a stale start once we are already
    SyncTarget, or to not start the resync while the peer is still Ahead.

 drbd/drbd_receiver.c | 12 ++++++++++++
 drbd/drbd_sender.c   |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 51a61fbc3..357c3aafa 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -10569,6 +10569,18 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 		return 0;
 	}
 
+	/* The peer pulled ahead and came back while we stayed SyncTarget
+	 * (its P_RS_CANCEL_AHEAD outran the Ahead state change), so the
+	 * SyncTarget -> Behind -> SyncTarget path that would clear the flag
+	 * is never taken.  Clear it here and resume issuing requests.
+	 */
+	if (peer_state.conn == L_SYNC_SOURCE &&
+	    peer_device->repl_state[NOW] == L_SYNC_TARGET &&
+	    test_and_clear_bit(SYNC_TARGET_TO_BEHIND, peer_device->flags)) {
+		drbd_info(peer_device, "peer back from ahead, resuming resync requests\n");
+		mod_timer(&peer_device->resync_timer, jiffies + RS_MAKE_REQS_INTV);
+	}
+
 	/* Start resync after AHEAD/BEHIND */
 	if (connection->agreed_pro_version >= 110 &&
 	    peer_state.conn == L_SYNC_SOURCE && old_peer_state.conn == L_BEHIND) {
diff --git a/drbd/drbd_sender.c b/drbd/drbd_sender.c
index 5c27980d8..a6d1be578 100644
--- a/drbd/drbd_sender.c
+++ b/drbd/drbd_sender.c
@@ -1390,8 +1390,12 @@ static int make_resync_request(struct drbd_peer_device *peer_device, int cancel)
 	if (test_bit(SYNC_TARGET_TO_BEHIND, peer_device->flags)) {
 		/* If a P_RS_CANCEL_AHEAD on control socket overtook the
 		 * already queued data and state change to Ahead/Behind,
-		 * don't add more resync requests, just wait it out. */
+		 * don't add more resync requests, just wait it out.
+		 * Keep polling: once we are Behind, w_resync_timer() clears
+		 * resync_active; nothing else re-arms this timer.
+		 */
 		drbd_info_ratelimit(peer_device, "peer pulled ahead during resync\n");
+		mod_timer(&peer_device->resync_timer, jiffies + RS_MAKE_REQS_INTV);
 		return 0;
 	}
 	if (!get_ldev(device)) {
-- 
2.50.1 (Apple Git-155)

