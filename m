Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E838DC52
	for <drbd-dev@lists.linux.dev>; Thu, 15 Oct 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103284; cv=none; b=oVOrdKxhVG/BrLbHpG94A0qkBQzDNsO+eTImrN5qE31i5P4oXi/lBO/si1wF9h4Y5F6IIWv7+XJhQQVvor4QsZPxINEk5e/nNTu0gWaN4ZW0DeF0Zh54tVbqqu/73hF3rOrPPyEo+16l9jSop9YnIN0svFsbRXWbmesTPSga0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103284; c=relaxed/simple;
	bh=/uz/mgNzqCCdIWB+lfcRdHFZzkBpQy210rPi/3Saxps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXioI+GGRagYYUnaHhTuoa1O3la7D9jUcDmwTgcr7syXTDYp4XlFfqI1Il9u7A82X9p5Z6LocihhZBB4dZTTsW0yiTyJsCurxIcP3cEGYbqUJUKpaLuDTQG4RLA1fh4dOydGFDazO5zUoCZzfmdVxz7MpHaaDlsZAWOyFtmRZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG8TcDlC; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG8TcDlC"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so953612eec.0
        for <drbd-dev@lists.linux.dev>; Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792103282; x=1792708082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rH7qDh5A3FEMtgpSQimqE0vvF6ppC/OBh5O5bMiH+AE=;
        b=IG8TcDlCrDVlCZmryQxZQIQKqIMNby2cbDZOFwj+N2yOnvtNH3B6UNd2l/jEYBQsOR
         hbaXw4KZ8yKAbzHQ2CU3HkLIE2CGsqlbGXh9EiuKCXb3AuROwqoDQPMcB9qNndekRWXO
         cV/Iq2PQ7imBs6rNfe943ub6q2wS/F9VpqILWvXxink35kbY9UyoBmAfRt5uV+L+gMyz
         qmjQDwkspnuM6bD7zqz96hYFMlVfb4XOBrDmi7zriv/MC/vhG4T0I5aZSNiaOmPmg4Mz
         EKarmbEWFJG+jSQB5ARsfUVk3HhB+ZXn7E4tJ0ux9juarnPc8PR/wNm4SSUw+X662WuD
         B9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103282; x=1792708082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rH7qDh5A3FEMtgpSQimqE0vvF6ppC/OBh5O5bMiH+AE=;
        b=v4MCEskEuABC6j33EPbtqkKFdLNpysEgOjD0BuhKhARDG/aMNQdXbapjbaD1JUnPSW
         UPotwco0LuBQspKNJZdUi5C1/7+iDZwIwIK9mjJxQ2JyZXeuMfKsafpCT1TDkMo3Kwh7
         NHjL3i3EXzu/KBsGnyi8W+qg/DkuOv1+c3QW7lZteCEGgaw2rjuBmQ1dELCpMuFF+c9h
         IHiQCPiEmVrEbDbT/yKCehT5dP9JBzxvQKm60qrjxi7KV6jPZAEU6oijARYvIf4pMDN5
         Do/YWcFWppj+iExrgej5qrw7ezEV+b7lVkerl1p4PcaSFFYGzjtFUtKLM6RVtKEtYj7y
         1HGg==
X-Gm-Message-State: AFq9FYI0Nb83MUlqiGZxh+L39upim/0K7EHhOZtH+LMr9XCMjEkgjI2z
	tyEpSiRb+Vptv+0+Lo8J8Z4j/A4RKoZmhtofCYvHXc/dDXnvzVAcVP3h
X-Gm-Gg: AYBFou3Pf3bC/+FfyCXXo4u1decL5IgJK/5RknzHMp3T6CoBtW6OdLvO4NwwRp94veM
	Ddor2p+MyTdgLOUMkZsyRJ5Aae/BziUkElhIyk5Cl7IdSG8JOZ70ltSOCjbPWN4OoPjgxbMt3/o
	9NICfh+U1LoFuVaoiyWCqKn+eYobxs4/tzcz5RD1zoyXgWE0fFM1CLp6ISpB/SXjJnNbGOgQ2sR
	padsHiAPx4nqotoWfhoiBPqeGBIuVfGa6KLTw+3nS1YqAvIhuCSJvGE7VtCjwOqFO8p2z9QQFXu
	14jRcVy5eniDG95Tk3hWRGp+F1Ou+E8pfqXZEkg/E+d3X4OsdNHWyLxXC5Dv88FIN2qtMiicGLx
	tnffpy8NUW6qekYjnktTrNMxomV/0Mqo+UGYgCtZVLEFkWjJw2mQXIP/MNhd0yeA9MumZ/YJf6e
	tFy51ahg2XQjE7HxV4xhyvF6htr5IxjgM5Gu3HX/Uu0lWMZcpSTchZ2WvrUO8U/+lzKSRq2m7+9
	8JZQGuFeCtH5X9kQxZX3qW2QgagR6cCvvH3wqIDZMoWLK1hFkvlg/nKeAYhbtv6H4rPDoEpxaQ=
X-Received: by 2002:a05:7301:e10e:b0:35c:707b:acba with SMTP id 5a478bee46e88-35c707baed8mr12276609eec.3.1792103281885;
        Thu, 15 Oct 2026 15:28:01 -0700 (PDT)
Received: from yibos-mbp.3500.dhcp.asu.edu ([2620:d8:8000:8078:404b:acf5:562d:50f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm873307eec.16.2026.10.15.15.28.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 15:28:01 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Liu <yiboliume@gmail.com>
Subject: [PATCH 0/2] drbd: validate payload sizes received from the peer
Date: Thu, 15 Oct 2026 15:27:58 -0700
Message-Id: <20261015222800.85928-1-yiboliume@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two places in the DRBD receive path take a payload size from the peer's
packet header and use it without comparing it to the size they expect.
Commit bd910a7660d2 ("drbd: reject data replies with an out-of-range
payload size") already rejects negative sizes in recv_dless_read();
these patches cover the remaining cases:

1/2 rejects a P_DATA_REPLY whose size differs from the read request.
    A short reply currently completes the read successfully with part
    of the bio never written.

2/2 rejects P_CSUM_RS_REQUEST and P_OV_REPLY packets whose digest
    length does not match the configured algorithm, and makes the
    worker compare digests only when their sizes match. A short digest
    currently causes an out-of-bounds read in memcmp(), and a huge one
    triggers a page allocator warning.

Like the earlier fixes, this only matters for a peer that does not
follow the protocol; a correct peer always sends the expected sizes.

The problems were found with the help of an AI coding assistant and
were reproduced on block-7.3 before posting (details below the "---" of
each patch). Testing:
- before/after runs of the reproducer in an arm64 virtme-ng KASAN guest
- a complete csums-alg resync and an online verify as regression tests
- each patch built with W=1 and sparse (C=2), arm64, gcc 13.3: no new
  warnings
- checkpatch.pl --strict clean
Not built with clang or for other architectures.

Yibo Liu (2):
  drbd: reject data replies whose size does not match the request
  drbd: validate digest size in checksum resync and verify requests

 drivers/block/drbd/drbd_receiver.c | 14 ++++++++++++--
 drivers/block/drbd/drbd_worker.c   |  8 ++++----
 2 files changed, 16 insertions(+), 6 deletions(-)


base-commit: 41cab3a71dc7be62114d91cc849424879062d324
-- 
2.39.5 (Apple Git-154)

