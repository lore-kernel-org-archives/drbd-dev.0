Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFB48BD26
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301582; cv=none; b=a4rgzHQPD2HTY+ll1AhYTIlP/8ryDXPJcn2oc7T24+LSXBcJp2/YYk34uo393ZCp80Uuxy2HZplKaOFTYbXpg0wLkAFnvWlGNNJ+MCxxxthDhoxGoOHvZxetNY2ZqV4NF9fkD68fURjgl+RLN2nIqPDG2cGNc4RTebMrtiiKaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301582; c=relaxed/simple;
	bh=NdKVx/kAAvIcfHYBklfeMUqMKDPbPiekB2a6KQ9cR4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itO5t63PBN7FEJguggPKwRpX3zXK3qbao8ca6Mo0VGTrWR9OLdhrrJgd5DbowekuT5t07sOSUIGLLKnwKkL77RYk+8K5FyVPqo0Pq9A6QxF4vx67+SIiZJCwZM2MH9lprtnX3XB0v1RcFzdxGp+liIQi8Se9VG5fLZRqYoqYOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=aSTI2T0U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="aSTI2T0U"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso26185895e9.3
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301577; x=1791906377; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/gteuD3CKm9wTyoGyLA2Y7vgXDVvYBBJ9de/wZCxOo=;
        b=aSTI2T0UNBsQzQAC5iUlr6L/igno5U3qHxn4dWk2DiLMK71EYJNlfqUHkC1I8Nargv
         Iq8sJnzmCDSWHtNTB3bZh+tBI3koCbyU0WBkwHVbeisaoWCuI8YxNpMZvUkaDmCw6eHp
         MDTrwSO1us+TifWGGdrqhIvkxaM3wT2UUN1U2Rd0V8eyjLFKnHv3QCOC2fOwGD1x9tdv
         Sa6/SwBgpySTVNoIg/EvgEa6VEpXUQU4xCaPhnyj1AElOnwsjwBW3Z6yMPFnLkWL0oZJ
         CLes7vDtFNtcEK4kCNfSJxPhHFa53C9INcjo2sPDjlTgTRtuDnrcmLcD+gN4Fy3za3bz
         EN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301577; x=1791906377;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/gteuD3CKm9wTyoGyLA2Y7vgXDVvYBBJ9de/wZCxOo=;
        b=wk8Ibn9nhLVNZwpkwoJhs0kAWJRZkGkqhTzJuqnPA4jKVoeaoO+CkABzn8vtF8GKoj
         UuaYL37+wcOBv6lnmoFgTUM4+yhleC1S9U1lec5zBYflw/fYzM4NJkAj/RdKacTvLRiE
         zuJAnS42Yuc9WJTAY99LMKEJpU5kGgzKtmEUI296j0lIlQpjMQesyqq82qnd4oaRv3vt
         JfLRXfXmwb3j+etrnt5TWxV2S4+xhrdrSGtYdLFgX5/6/PIu2jXSaV6ZIKxWmmG4PA/n
         xVWVhtQtQdzY8b3br4MyfErklUpYu4TKyyJDJc8nYEXxwAYRCM8nCTbsEHIULJIf5/Iw
         Ylmw==
X-Forwarded-Encrypted: i=1; AKwUvBxgM9onVmcg7u4k+yLGBX3eyQLnfFkIcYtj41nCHvfNYvoWQPLhMVfP4fUJQ1fWY+RXiT2/rqYUqA==@lists.linux.dev
X-Gm-Message-State: AFuF++mAzYVsRTd9kTRaG+gc4Dfg1kI3qWP91UH1TFMk/WpfeKa39bB9
	o9tegZdEriSl6BVoXz1Q6CcdNeyHAD6tW0b42NbdSd4yovTZUxW0vvUNtzfM0B6zLwE=
X-Gm-Gg: AYBFou3/Yt9xNRjavo+eBdozwDfOtzNo1M3Gz5LrZSe3rOqjsIiL6rjlt9lJI5zzTnG
	i9x9VsjTww3XbyruNWrlpI8IaAhmeBfWr6X9TaCo+KSMVK451PHrEV/L4hQarZ9Hl9TyJubZprz
	4wF+QMtNCkgmw+tVm36jiKIhO8PYxowWKZySN21oOT8to4ZPJ2VYHHl28h/D9HqY7S9XZ9DQs5s
	6QhvxZB8vl1X/S7gr5otVfTkYlPd8QtB4SUZRvHdYFSIjW7DQ4lEE05ALy2OxuOtMdWZS4MHPfd
	clieRvlkPGUjmFqbk+jJyojdbAwljWlnlSU+cS+MRycxvgxHryBfjEK6ixtDZ//4ExDCNoSAXZB
	D6bEQ2SgWn+EEjceKHNdFnijcQXingwVfSkAGHWRrPtFna1sqc4raMGJJIgJOwx7OhZSwkVlrF4
	MY4Tq2SY8CwxIYWS9rjli7GCc6MMczZunQb4F3eyLnm4BYC/CHNXVQG8/F+E9aoe48Kgi89tTMT
	c6WCnRqMH93xwYKDpX0DA2rXjcCNms6
X-Received: by 2002:a05:600c:4687:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a1777b8a37mr65460095e9.14.1791301576850;
        Tue, 06 Oct 2026 08:46:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:16 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 00/20] drbd: DRBD 9 rework
Date: Tue,  6 Oct 2026 17:45:47 +0200
Message-ID: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As discussed (context: [0]), here is our DRBD 9 rework series, intended
for linux-next via for-7.x/drbd.

This replays about 10-15 years of active out-of-tree development work
[1], depending on your way of counting. The out-of-tree module has
severely diverged from the in-tree version over the years, which is
what we are aiming to fix now.

Hopefully that somewhat excuses (or at least explains) the massive
diffs -- we've tried to come up with a way to group the changes by
topic, but I realize it's still not exactly trivial to review.

We've been polishing this series for a while now, and we have taken
great care to make it as "upstream-presentable" as possible. That said,
there are still probably imperfections. It's a start -- feedback
welcome!

The netlink interface has been reworked so that userspace is not
broken: the existing "drbd" generic netlink family keeps being served
at version 1, and this series does not touch its generated
serialization or its UAPI header.
Every shipped drbd-utils release therefore keeps working against this
driver. DRBD 9's own utilities speak a new family, "drbd2", written as
a YNL specification under Documentation/netlink/specs/ and following
current genetlink conventions; its generated code is checked in as
usual. The driver registers both families and translates each onto the
same wire-neutral core, so the multi-peer administration model is only
reachable through drbd2, while version-1 clients see the single-peer
semantics they expect.

The RDMA and load-balancing TCP (lb-tcp) transports are not part of
this series; they will be submitted separately once they have had the
same treatment. The rdma_ctrl_rcvbuf_size
and rdma_ctrl_sndbuf_size net options do remain in the UAPI: they are
generic transport options that are interpreted by whichever transport is
in use, so there is no reason to remove and later re-add them.

The base for these patches is for-7.4/block, plus a set of preparation
patches that were sent earlier but have not yet been applied [2].

As discussed, the goal is to get this applied to a for-7.x/drbd branch
so it can land in linux-next via block-next. After letting it mature
in linux-next for a while, it should go in via the block tree.

Thanks,
Christoph

[0] https://lore.kernel.org/linux-next/899e0337-9642-4ca6-9050-aeab14fa22ef@kernel.dk/
[1] https://github.com/LINBIT/drbd
[2] https://lore.kernel.org/linux-block/20260923140608.1116713-1-christoph.boehmwalder@linbit.com/


Changes since v1:
- New modern YNL-based drbd2 netlink family
- Compat layer that serves the old drbd v1 netlink family for userspace
  backward compatibility
- Dropped rdma and lb-tcp transports to reduce the diff size, these will
  be sent later
- Incoroporated review feedback from the previous series
- Many checkpatch/style fixes


Christoph Böhmwalder (20):
  drbd: mark as BROKEN during DRBD 9 rework
  drbd: extend wire protocol definitions for DRBD 9
  drbd: introduce DRBD 9 on-disk metadata format
  drbd: add transport layer abstraction
  drbd: add TCP transport implementation
  drbd: add DAX/PMEM support for metadata access
  drbd: add optional compatibility layer for DRBD 8.4
  drbd: add application/resync IO synchronization documentation
  drbd: rework sender for DRBD 9 multi-peer
  drbd: replace per-device state model with multi-peer data structures
  drbd: rewrite state machine for DRBD 9 multi-peer clusters
  drbd: rework activity log and bitmap for multi-peer replication
  drbd: rework request processing for DRBD 9 multi-peer IO
  drbd: rework module core for DRBD 9 transport and multi-peer
  drbd: rework receiver for DRBD 9 transport and multi-peer protocol
  drbd: rework the netlink core for DRBD 9
  drbd: serve the "drbd" genl family at version 1 for existing userspace
  drbd: add the "drbd2" genl family
  drbd: update monitoring interfaces for multi-peer topology
  drbd: remove BROKEN for DRBD

 .../application-resync-synchronization.rst    |   208 +
 .../admin-guide/blockdev/drbd/index.rst       |     1 +
 Documentation/netlink/specs/drbd2.yaml        |  2476 +++
 drivers/block/drbd/Kconfig                    |    43 +
 drivers/block/drbd/Makefile                   |     9 +-
 drivers/block/drbd/drbd2_nl_gen.c             |   748 +
 drivers/block/drbd/drbd2_nl_gen.h             |   107 +
 drivers/block/drbd/drbd_actlog.c              |  1267 +-
 drivers/block/drbd/drbd_bitmap.c              |  1989 +-
 drivers/block/drbd/drbd_config.h              |    44 +-
 drivers/block/drbd/drbd_dax_pmem.c            |   172 +
 drivers/block/drbd/drbd_dax_pmem.h            |    43 +
 drivers/block/drbd/drbd_debugfs.c             |  1721 +-
 drivers/block/drbd/drbd_debugfs.h             |     2 +
 drivers/block/drbd/drbd_int.h                 |  3748 ++--
 drivers/block/drbd/drbd_interval.c            |    37 +-
 drivers/block/drbd/drbd_interval.h            |   125 +-
 drivers/block/drbd/drbd_legacy_84.c           |   641 +
 drivers/block/drbd/drbd_legacy_84.h           |   129 +
 drivers/block/drbd/drbd_main.c                |  6680 +++++--
 drivers/block/drbd/drbd_meta_data.h           |   154 +
 drivers/block/drbd/drbd_nl.c                  |  9477 ++++++---
 drivers/block/drbd/drbd_nl.h                  |   390 +
 drivers/block/drbd/drbd_nl_84.c               |  3622 ++++
 drivers/block/drbd/drbd_nl_defaults.c         |   167 +
 drivers/block/drbd/drbd_nl_drbd2.c            |  2533 +++
 drivers/block/drbd/drbd_nl_types.h            |   388 +
 drivers/block/drbd/drbd_polymorph_printk.h    |    37 +-
 drivers/block/drbd/drbd_proc.c                |   327 +-
 drivers/block/drbd/drbd_protocol.h            |   614 +-
 drivers/block/drbd/drbd_receiver.c            | 16314 ++++++++++++----
 drivers/block/drbd/drbd_req.c                 |  3172 ++-
 drivers/block/drbd/drbd_req.h                 |   332 +-
 drivers/block/drbd/drbd_sender.c              |  4354 +++--
 drivers/block/drbd/drbd_state.c               |  8963 +++++++--
 drivers/block/drbd/drbd_state.h               |   326 +-
 drivers/block/drbd/drbd_state_change.h        |    80 +-
 drivers/block/drbd/drbd_strings.c             |   103 +-
 drivers/block/drbd/drbd_strings.h             |     4 +-
 drivers/block/drbd/drbd_transport.c           |   545 +
 drivers/block/drbd/drbd_transport.h           |   480 +
 drivers/block/drbd/drbd_transport_tcp.c       |  1746 ++
 drivers/block/drbd/drbd_transport_template.c  |   164 +
 include/uapi/linux/drbd.h                     |   299 +-
 include/uapi/linux/drbd2.h                    |  1012 +
 include/uapi/linux/drbd_limits.h              |   135 +-
 46 files changed, 58914 insertions(+), 17014 deletions(-)
 create mode 100644 Documentation/admin-guide/blockdev/drbd/application-resync-synchronization.rst
 create mode 100644 Documentation/netlink/specs/drbd2.yaml
 create mode 100644 drivers/block/drbd/drbd2_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd2_nl_gen.h
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h
 create mode 100644 drivers/block/drbd/drbd_legacy_84.c
 create mode 100644 drivers/block/drbd/drbd_legacy_84.h
 create mode 100644 drivers/block/drbd/drbd_meta_data.h
 create mode 100644 drivers/block/drbd/drbd_nl.h
 create mode 100644 drivers/block/drbd/drbd_nl_84.c
 create mode 100644 drivers/block/drbd/drbd_nl_defaults.c
 create mode 100644 drivers/block/drbd/drbd_nl_drbd2.c
 create mode 100644 drivers/block/drbd/drbd_nl_types.h
 create mode 100644 drivers/block/drbd/drbd_transport.c
 create mode 100644 drivers/block/drbd/drbd_transport.h
 create mode 100644 drivers/block/drbd/drbd_transport_tcp.c
 create mode 100644 drivers/block/drbd/drbd_transport_template.c
 create mode 100644 include/uapi/linux/drbd2.h


base-commit: c3bcce56763375946bc31a4dac859b4b4cc07ccd
-- 
2.55.0

