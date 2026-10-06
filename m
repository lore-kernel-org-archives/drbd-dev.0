Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA54A013F
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301687; cv=none; b=t4sgVA/a8Pa7yKU+3UfclwORI/Gak3d5YfG56FDSjmmZhNIgW5itSTlu3127mlhm6+a1NgKNsnTn43zLg8ppwlW2f0kuhjFSckFFHcOwsQA9WPHEml76rX86Kg2XnpSlb9pKwGnLYup+Gcg8LaHRgSpK85milViW3FOmQ1v24V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301687; c=relaxed/simple;
	bh=SI3bAeaAbBMDOrAyHYhYr3xvZex3iBzUp4TFWLdc5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imt/K9+UppO04wdJ8GoaoDSWdqWbiiUs6WITEDP15F8VDuN1Lf5U2CxG6BMaTkETT+iL6TCqXFcl6VccBIw8v/06ajzLB9AqCSPWPfbeKbyEikaF+4Q8Xg6uCjDin+2z6uG3IEYkl5430UP9zv7ibgb4kejwwAO5HtCpEm8Ej/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=wfKTTaNp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="wfKTTaNp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso5288765e9.3
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301633; x=1791906433; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gBuMgl51PLoTdzv8KTRZsb2gB6xDoswfxg/KAnHpgAs=;
        b=wfKTTaNpcfQvZlV4QVWjw74pI1+o7kQuXzdV/LeJQvDBJxPWSumJfsAAwBAXltwxlh
         WWqOwoBNmbyK8y57PhupLzKQHvmkYr2rB0Hb6cT4ILpp+UhXA+fEoz9bZjPKfUQ05Nbw
         x7bEUR/rwJnUJvNVDl9v67qym0Nec+zdxRrCwCxSM4LqTF0BxmxG0q5D33LE/teLqmL7
         BzltEZPXHHvWRLaUEkKCfyzB5xUFF+N8c/dpEqMOXqPBzhpqE0q00tuXqcdHp2PrEoPm
         08ZBWgi49VVF3eXpGu5GabbJrPmhhkPP77vFJaz6GlfxHdpVgL5Xh2an5JjGfkOgo6IL
         /8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301633; x=1791906433;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBuMgl51PLoTdzv8KTRZsb2gB6xDoswfxg/KAnHpgAs=;
        b=kRD52+2W7U+ge0n9bFoGtphNiI0DPeX+diedmxy59y6WaWSDsnS4CHYuiUK50afZIC
         YVkw8szgxyz+idZ1EPlOS9PdtOIrHFEY5eORWX2bX5aZyuaNtI/vMYTT81TlDpkLsAVZ
         WR2yCGu8LEFhi7NzCgN3B8cD7AihhyAxeX9JEaDItIfWXse3uL7RnQ1gTsTlkJa8Z/ll
         z9vxmTLMbB/Cxxm1BVb+xcFY5aSsGmoXvB5pKrOKo4/qxkMKjl7kNoX1E2w2uSga/Swz
         nmlSl+svsQ/tmW+tcu75V4EAE5sfHNsYtTf9UQtzHM8QsKJewS9KKz2dn9dM7NE1hk/E
         Pp3w==
X-Forwarded-Encrypted: i=1; AKwUvBx95MIOs4K5vmHIiVWYAsfDdEOmgyTFbk/E6DjNCYnRn8RT+y3uZaNtcfeSBCfQJPgvMKCGqvE3Gg==@lists.linux.dev
X-Gm-Message-State: AFuF++lx4dVV6ipj36YOcIRe5c3PncmHC1XHfo/Dq2A8IkrXkC0QwHdX
	vm1H69MbtUcgLXdDQCIycbhqojMkxk2QtxrWu+lZlpRJHMdhMh7Tu9KfuPqYisOgShg=
X-Gm-Gg: AYBFou07Bms+AMiivWs6aVhHNJqgVtk/rOmPnjBUi7L8FA2TRPiPWsErAQ/mMvuoUE+
	lvLSkk9VYhZGfdjhWVejufkhjSd7Q44rGL8YczwNl20WfVlTrbOtx79VPG4GtYsvl3fjVAeo8kz
	wVENciircbT8shzvi8P5Otb9YkhdBgnH9gd7Juv2mENhXhuP51CTYYwQv5hodjYYDQXarunUdwi
	wtPQ2SPXAUua7T21wr1YrOGqmrU3TdQeS5b8B7GSIGLyey9aRk3qv2C4EDYqK9m7fCwogOnBWpO
	RP1c26EXaqG0s8kNNIZTIX2VQgNYZwdCXLp+vUbPWH7TSXZEFgi/t7C5J4NfXsEQljHevuaqDfo
	XuTeNf73YeetcxvQ5TeOfH6Gn005sHCMw3+G/TRL7rpHp9c+qlSHmnCWvi4SZLTuTaahiPUzfQQ
	A3YUmxEmIB5vfk3Rzos2sCyH2Am/S4weua54uq6eMJ1koFo0ZzSk4PUmf5Du0EZGlLh2MlhO9V+
	EXDeWv4ll4NVnzETzJT6qPDT3k2xEt6
X-Received: by 2002:a05:600d:9:b0:4a0:2391:6529 with SMTP id 5b1f17b1804b1-4a17b55241fmr34255535e9.29.1791301631030;
        Tue, 06 Oct 2026 08:47:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:47:10 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 18/20] drbd: add the "drbd2" genl family
Date: Tue,  6 Oct 2026 17:46:05 +0200
Message-ID: <20261006154607.3936501-19-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DRBD 9's utilities need the multi-peer administration model that the
version-1 wire cannot express: peers identified by node id, several
paths per connection, per-peer-device options and statistics, and
notifications for all of those. Rather than bump the "drbd" family
and break every existing drbd-utils, add a second family, "drbd2",
written as a YNL specification in Documentation/netlink/specs/ and
following current generic netlink conventions: strict policies with
ranges, nested objects, split do/dump ops, extended ACKs for errors,
and a proper uapi header.

drbd2_nl_gen.[ch] and include/uapi/linux/drbd2.h are generated from
the spec with tools/net/ynl and are not edited by hand.
drbd_nl_drbd2.c is the struct drbd_nl_dialect adapter for the family.
Both families are registered by the same driver and operate on the
same objects; a resource created through either is visible through
both, within what each wire format can express. drbd2 is always
registered, so with DRBD_COMPAT_84=n it is the only family.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 Documentation/netlink/specs/drbd2.yaml | 2476 +++++++++++++++++++++++
 drivers/block/drbd/Kconfig             |    6 +
 drivers/block/drbd/Makefile            |    1 +
 drivers/block/drbd/drbd2_nl_gen.c      |  748 +++++++
 drivers/block/drbd/drbd2_nl_gen.h      |  107 +
 drivers/block/drbd/drbd_nl_drbd2.c     | 2533 ++++++++++++++++++++++++
 include/uapi/linux/drbd2.h             | 1012 ++++++++++
 7 files changed, 6883 insertions(+)
 create mode 100644 Documentation/netlink/specs/drbd2.yaml
 create mode 100644 drivers/block/drbd/drbd2_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd2_nl_gen.h
 create mode 100644 drivers/block/drbd/drbd_nl_drbd2.c
 create mode 100644 include/uapi/linux/drbd2.h

diff --git a/Documentation/netlink/specs/drbd2.yaml b/Documentation/netlink/specs/drbd2.yaml
new file mode 100644
index 000000000000..1b3b1fa19d9f
--- /dev/null
+++ b/Documentation/netlink/specs/drbd2.yaml
@@ -0,0 +1,2476 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: drbd2
+
+protocol: genetlink
+
+doc: 'DRBD 9 management interface: configure and monitor replicated block device resources,
+  their devices, connections to peers, peer devices and network paths.'
+
+uapi-header: linux/drbd2.h
+
+definitions:
+  -
+    name: resource-name-max
+    type: const
+    value: 128
+    doc: Maximum length of a resource name including the terminating NUL.
+
+  -
+    name: connection-name-max
+    type: const
+    value: 64
+    doc: Maximum length of a connection name including the terminating NUL.
+
+  -
+    name: shared-secret-max
+    type: const
+    value: 64
+    doc: Maximum length of the shared secret including the terminating NUL.
+
+  -
+    name: alg-name-max
+    type: const
+    value: 64
+    doc: Maximum length of a crypto algorithm name including the terminating NUL.
+
+  -
+    name: transport-name-max
+    type: const
+    value: 64
+    doc: Maximum length of a network transport name including the terminating NUL.
+
+  -
+    name: device-path-max
+    type: const
+    value: 128
+    doc: Maximum length of a backing/meta device path including the terminating NUL.
+
+  -
+    name: cpu-mask-size
+    type: const
+    value: 256
+    doc: Maximum length of the cpu-mask string.
+
+  -
+    name: helper-name-max
+    type: const
+    value: 32
+    doc: Maximum length of a helper name.
+
+  -
+    name: history-uuids-size
+    type: const
+    value: 256
+    doc: Maximum size in bytes of the history UUID array (32 peer slots of 8 bytes).
+
+  -
+    name: io-error-policy
+    type: enum
+    doc: What to do when the backing device reports an I/O error (on-io-error).
+    entries:
+      -
+        name: pass-on
+        doc: Mark the failed block out of sync, change the disk state to inconsistent and retry the request on a peer.
+      -
+        name: call-local-io-error
+        doc: Call the local-io-error handler.
+      -
+        name: detach
+        doc: Detach the backing device and continue in diskless mode.
+
+  -
+    name: fencing-policy
+    type: enum
+    doc: Fencing policy (fencing).
+    entries:
+      -
+        name: dont-care
+        doc: Take no fencing action at all.
+      -
+        name: resource
+        doc: A node that becomes a disconnected primary calls the fence-peer handler to outdate the peer.
+      -
+        name: stonith
+        doc: A node that becomes a disconnected primary freezes its I/O and calls the fence-peer handler, which may have to shoot the peer.
+
+  -
+    name: after-sb-policy
+    type: enum
+    doc: Split-brain recovery policy (after-sb-0pri, after-sb-1pri, after-sb-2pri, rr-conflict).
+    entries:
+      -
+        name: disconnect
+        doc: Do not resynchronize automatically, simply disconnect.
+      -
+        name: discard-younger-primary
+        doc: Resynchronize from the node that became primary first.
+      -
+        name: discard-older-primary
+        doc: Resynchronize from the node that became primary last.
+      -
+        name: discard-zero-changes
+        doc: Resynchronize from the node that wrote data since the split brain was detected, or disconnect if both nodes wrote.
+      -
+        name: discard-least-changes
+        doc: Resynchronize from the node with more modified blocks.
+      -
+        name: discard-local
+        doc: Discard the data on this node and resynchronize it from the peer.
+      -
+        name: discard-remote
+        doc: Discard the data on the peer and resynchronize it from this node.
+      -
+        name: consensus
+        doc: Discard the data on the secondary if the after-sb-0pri policy would discard it as well, otherwise disconnect.
+      -
+        name: discard-secondary
+        doc: Discard the data on the secondary node.
+      -
+        name: call-pri-lost-after-sb
+        doc: Take the after-sb-0pri decision and call the pri-lost-after-sb handler on the node that has to give up its data.
+      -
+        name: violently-as0p
+        doc: Always take the after-sb-0pri decision, even if that changes the primary's view of the data; this can crash the primary.
+      -
+        name: retry-connect
+        doc: Disconnect now and immediately retry to connect (rr-conflict only).
+      -
+        name: auto-discard
+        doc: Reverse the resync direction so that the current primary is resynchronized from the current secondary (rr-conflict with protocol A only).
+
+  -
+    name: on-no-data-policy
+    type: enum
+    doc: What to do when no data is accessible (on-no-data-accessible).
+    entries:
+      -
+        name: io-error
+        doc: Complete the requests with an I/O error, so that system calls fail with EIO.
+      -
+        name: suspend-io
+        doc: Suspend I/O until the data becomes accessible again or the administrator forces I/O to resume.
+
+  -
+    name: on-no-quorum-policy
+    type: enum
+    doc: What to do when quorum is lost (on-no-quorum).
+    entries:
+      -
+        name: io-error
+        doc: Complete the requests with an I/O error while the resource has no quorum.
+      -
+        name: suspend-io
+        doc: Freeze I/O while the resource has no quorum.
+
+  -
+    name: on-suspended-primary-outdated-policy
+    type: enum
+    doc: What to do with a suspended primary that became outdated.
+    entries:
+      -
+        name: disconnect
+        doc: Reject connection attempts and stay isolated.
+      -
+        name: force-secondary
+        doc: Demote to secondary immediately and fail all pending and new I/O requests.
+
+  -
+    name: on-congestion-policy
+    type: enum
+    doc: What to do when the replication link is congested (on-congestion).
+    entries:
+      -
+        name: block
+        doc: Block application writes until the transport's send queue drains.
+      -
+        name: pull-ahead
+        doc: Switch into ahead/behind mode and record further changes in the bitmap instead of replicating them.
+      -
+        name: disconnect
+        doc: Disconnect from the peer instead of blocking application writes.
+
+  -
+    name: read-balancing-policy
+    type: enum
+    doc: Read balancing policy (read-balancing).
+    entries:
+      -
+        name: prefer-local
+        doc: Always read from the local disk.
+      -
+        name: prefer-remote
+        doc: Always read from a peer's disk.
+      -
+        name: round-robin
+        doc: Alternate between the local disk and a peer for consecutive reads.
+      -
+        name: least-pending
+        doc: Read from the disk with the fewest pending requests.
+      -
+        name: when-congested-remote
+        doc: Read from a peer only while the local disk is congested; deprecated since DRBD 9.1.12.
+      -
+        name: striping-32k
+        doc: Read alternating 32 KiB stripes from the local disk and from a peer.
+      -
+        name: striping-64k
+        doc: Read alternating 64 KiB stripes from the local disk and from a peer.
+      -
+        name: striping-128k
+        doc: Read alternating 128 KiB stripes from the local disk and from a peer.
+      -
+        name: striping-256k
+        doc: Read alternating 256 KiB stripes from the local disk and from a peer.
+      -
+        name: striping-512k
+        doc: Read alternating 512 KiB stripes from the local disk and from a peer.
+      -
+        name: striping-1m
+        doc: Read alternating 1 MiB stripes from the local disk and from a peer.
+
+  -
+    name: wire-protocol
+    type: enum
+    doc: Replication protocol (protocol).
+    entries:
+      -
+        name: a
+        value: 1
+        doc: Writes complete as soon as they reached the local disk and the local send buffer.
+      -
+        name: b
+        doc: Writes complete as soon as they reached the local disk and all peers acknowledged their receipt.
+      -
+        name: c
+        doc: Writes complete as soon as they reached the local disk and all remote disks.
+
+  -
+    name: role
+    type: enum
+    doc: Role of a resource on a node. Values mirror enum drbd_role in linux/drbd.h so both netlink dialects share one numbering.
+    entries:
+      -
+        name: unknown
+        doc: The role is not known, for example because the peer is not connected.
+      -
+        name: primary
+        doc: The resource is primary; its devices may be opened for writing.
+      -
+        name: secondary
+        doc: The resource is secondary; its devices may not be opened for writing.
+
+  -
+    name: connection-state
+    type: enum
+    doc: State of a connection to a peer. Values mirror enum drbd_conn_state in linux/drbd.h so both netlink dialects share one numbering.
+    entries:
+      -
+        name: standalone
+        doc: No network configuration is in effect and no connection is attempted.
+      -
+        name: disconnecting
+        doc: Temporary state on the way to standalone while the connection is torn down.
+      -
+        name: unconnected
+        doc: Temporary state before the next connection attempt starts.
+      -
+        name: timeout
+        doc: The connection was dropped because the peer did not answer in time.
+      -
+        name: broken-pipe
+        doc: The connection was dropped because the transport reported a broken connection.
+      -
+        name: network-failure
+        doc: The connection was dropped because of a network failure.
+      -
+        name: protocol-error
+        doc: The connection was dropped because the peer violated the replication protocol.
+      -
+        name: tear-down
+        doc: Temporary state while the peer closes the connection.
+      -
+        name: connecting
+        doc: Listening for the peer and trying to establish a connection.
+      -
+        name: connected
+        doc: A connection to the peer is established.
+
+  -
+    name: repl-state
+    type: enum
+    doc: Replication state of a peer device. Values mirror enum drbd_repl_state in linux/drbd.h so both netlink dialects share one numbering.
+    entries:
+      -
+        name: 'off'
+        value: 9
+        doc: The peer device does not replicate because the connection is not established.
+      -
+        name: established
+        doc: The peer device is connected and replicating normally.
+      -
+        name: starting-sync-s
+        doc: A full resynchronization was requested by the administrator and starts with this node as the source.
+      -
+        name: starting-sync-t
+        doc: A full resynchronization was requested by the administrator and starts with this node as the target.
+      -
+        name: wf-bitmap-s
+        doc: Waiting for the bitmap exchange to finish, with this node as the prospective resync source.
+      -
+        name: wf-bitmap-t
+        doc: Waiting for the bitmap exchange to finish, with this node as the prospective resync target.
+      -
+        name: wf-sync-uuid
+        doc: Waiting for the resync source to create and send the new resync UUID.
+      -
+        name: sync-source
+        doc: Resynchronization is running with this node as the source.
+      -
+        name: sync-target
+        doc: Resynchronization is running with this node as the target.
+      -
+        name: verify-s
+        doc: Online verification is running with this node as the initiator.
+      -
+        name: verify-t
+        doc: Online verification is running with this node as the target.
+      -
+        name: paused-sync-s
+        doc: Resynchronization with this node as the source is paused.
+      -
+        name: paused-sync-t
+        doc: Resynchronization with this node as the target is paused.
+      -
+        name: ahead
+        doc: Replication is suspended because the link is congested; changes are only recorded in the bitmap.
+      -
+        name: behind
+        doc: The peer is ahead of this node, which will be resynchronized once the congestion is over.
+
+  -
+    name: disk-state
+    type: enum
+    doc: State of a backing disk. Values mirror enum drbd_disk_state in linux/drbd.h so both netlink dialects share one numbering.
+    entries:
+      -
+        name: diskless
+        doc: No backing device is attached.
+      -
+        name: attaching
+        doc: The backing device's metadata is being read.
+      -
+        name: detaching
+        doc: The backing device is being detached while pending I/O drains.
+      -
+        name: failed
+        doc: The backing device failed; the disk becomes diskless once the peers have been told.
+      -
+        name: negotiating
+        doc: Attaching while connected, with the data generation still being negotiated with the peers.
+      -
+        name: inconsistent
+        doc: The data is inconsistent, for example because a resynchronization is in progress.
+      -
+        name: outdated
+        doc: The data is consistent but known to be stale relative to a peer.
+      -
+        name: unknown
+        doc: The disk state is not known; used only for a peer's disk.
+      -
+        name: consistent
+        doc: The data is consistent but it is not yet known whether it is up to date.
+      -
+        name: up-to-date
+        doc: The data is consistent and up to date; only this state allows application I/O.
+
+  -
+    name: write-ordering
+    type: enum
+    doc: Write ordering method in use for the backing device.
+    entries:
+      -
+        name: none
+        doc: No ordering between dependent writes is enforced on the backing device.
+      -
+        name: drain-io
+        doc: Dependent writes are ordered by draining the backing device's request queue.
+      -
+        name: bdev-flush
+        doc: Dependent writes are ordered by issuing flushes to the backing device.
+      -
+        name: bio-barrier
+        doc: Dependent writes are ordered with block device barriers, which the Linux block layer no longer provides.
+
+  -
+    name: timeout-type
+    type: enum
+    doc: Which wait-for-connection timeout applies (timeout-type-get reply).
+    entries:
+      -
+        name: default
+        doc: The regular wait-for-connection timeout applies.
+      -
+        name: degraded
+        doc: The degraded-cluster timeout applies because the local data is not up to date.
+      -
+        name: peer-outdated
+        doc: The timeout for an outdated peer applies.
+
+  -
+    name: helper-phase
+    type: enum
+    doc: Whether a helper notification announces the call or reports its result.
+    entries:
+      -
+        name: call
+        doc: The helper script is about to be called.
+      -
+        name: response
+        doc: The helper script has finished and its exit status is reported.
+
+  -
+    name: state-change-action
+    type: enum
+    doc: What a state-change message reports about the object it carries. Values are assigned independently of the legacy drbd_notification_type.
+    entries:
+      -
+        name: exists
+        doc: The object already existed when the notification stream was opened.
+      -
+        name: create
+        doc: The object was just created.
+      -
+        name: change
+        doc: The state or statistics of the object changed.
+      -
+        name: destroy
+        doc: The object was destroyed.
+      -
+        name: rename
+        doc: The resource was renamed; the new name is carried in resource.new-name.
+
+  -
+    name: state-result
+    type: enum
+    doc: Outcome of a state change request. Error values equal the negated kernel-internal SS_* codes (value 3 is unused); success and the other non-error outcomes follow at 29 and above.
+    entries:
+      -
+        name: unknown-error
+        doc: The state change failed for an unspecified reason.
+      -
+        name: two-primaries
+        doc: Multiple primaries are not allowed by the configuration.
+      -
+        name: no-up-to-date-disk
+        doc: The request needs access to up-to-date data.
+      -
+        name: no-local-disk
+        value: 4
+        doc: Cannot resynchronize without a local disk.
+      -
+        name: no-remote-disk
+        doc: Cannot resynchronize without a remote disk.
+      -
+        name: connected-outdates
+        doc: Refusing to become outdated while connected.
+      -
+        name: primary-nop
+        doc: Refusing to become primary while the peer is not outdated.
+      -
+        name: resync-running
+        doc: Cannot start online verify or resynchronization because one is already active.
+      -
+        name: already-standalone
+        doc: Cannot disconnect a connection that is already standalone.
+      -
+        name: cw-failed-by-peer
+        doc: The cluster-wide state change was refused by a peer node.
+      -
+        name: is-diskless
+        doc: The device is diskless but the requested operation requires a disk.
+      -
+        name: device-in-use
+        doc: The device is held open by someone.
+      -
+        name: no-net-config
+        doc: There is no network configuration for this connection.
+      -
+        name: no-verify-alg
+        doc: Starting online verify requires a verify algorithm to be configured.
+      -
+        name: need-connection
+        doc: The state change requires an established connection.
+      -
+        name: lower-than-outdated
+        doc: The disk state is lower than outdated.
+      -
+        name: not-supported
+        doc: The peer does not support the requested protocol feature.
+      -
+        name: in-transient-state
+        doc: The object is in a transient state; retry after the next state change.
+      -
+        name: concurrent-state-change
+        doc: Concurrent state changes were detected and this one was aborted.
+      -
+        name: other-volume-peer-primary
+        doc: Another volume is primary on the peer, which the configuration does not allow.
+      -
+        name: interrupted
+        doc: The state change was interrupted.
+      -
+        name: primary-reader
+        doc: The peer may not become primary while the device is open for reading here.
+      -
+        name: timeout
+        doc: The state change timed out.
+      -
+        name: weakly-connected
+        doc: Primary nodes must be strongly connected among each other.
+      -
+        name: no-quorum
+        doc: The resource does not have quorum.
+      -
+        name: attach-no-bitmap
+        doc: An intentionally diskless peer may not attach a disk.
+      -
+        name: handshake-disconnect
+        doc: Disconnect was chosen during the connection handshake.
+      -
+        name: handshake-retry
+        doc: Retry was chosen during the connection handshake.
+      -
+        name: success
+        value: 29
+        doc: The state change succeeded.
+      -
+        name: nothing-to-do
+        doc: The requested state was already in effect, so nothing had to be done.
+      -
+        name: cw-success
+        doc: The cluster-wide state change succeeded.
+      -
+        name: cw-no-need
+        doc: No cluster-wide state change was necessary.
+
+attribute-sets:
+  -
+    name: address
+    doc: A socket address.
+    attributes:
+      -
+        name: family
+        type: u16
+        doc: Address family (AF_INET or AF_INET6).
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+        doc: Port number.
+      -
+        name: ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+        doc: IPv4 address, present when family is AF_INET.
+      -
+        name: ipv6
+        type: binary
+        checks:
+          exact-len: 16
+        display-hint: ipv6
+        doc: IPv6 address, present when family is AF_INET6.
+
+  -
+    name: context
+    doc: Identifies the object a request, reply or notification refers to.
+    attributes:
+      -
+        name: resource-name
+        type: string
+        checks:
+          max-len: resource-name-max
+        doc: Resource name.
+      -
+        name: volume
+        type: u32
+        doc: Volume number within the resource.
+      -
+        name: minor
+        type: u32
+        doc: Minor number of the DRBD device.
+      -
+        name: peer-node-id
+        type: u32
+        doc: Node ID of the peer.
+      -
+        name: connection-name
+        type: string
+        checks:
+          max-len: connection-name-max
+        doc: Name of the connection to the peer.
+      -
+        name: my-address
+        type: nest
+        nested-attributes: address
+        doc: Local address of a path.
+      -
+        name: peer-address
+        type: nest
+        nested-attributes: address
+        doc: Peer address of a path.
+
+  -
+    name: disk-conf
+    doc: Options of an attached backing disk (drbd.conf disk section).
+    attributes:
+      -
+        name: backing-dev
+        type: string
+        checks:
+          max-len: device-path-max
+        doc: Path of the lower-level block device used to store the actual data (drbd.conf option disk).
+      -
+        name: meta-dev
+        type: string
+        checks:
+          max-len: device-path-max
+        doc: Path of the device holding the metadata, or "internal" to store it on the backing device (drbd.conf option meta-disk).
+      -
+        name: meta-dev-idx
+        type: s32
+        doc: Index selecting which slot to use on a shared external metadata device (drbd.conf option meta-disk index).
+      -
+        name: size
+        type: u64
+        doc: Size of the backing device to use, in sectors, overriding automatic detection.
+      -
+        name: on-io-error
+        type: u32
+        enum: io-error-policy
+        doc: Action to take when the backing disk reports an I/O error.
+      -
+        name: resync-after
+        type: s32
+        doc: Volume number of another volume that must finish resynchronizing before this one starts (drbd.conf option resync-after).
+      -
+        name: al-extents
+        type: u32
+        doc: Number of 4 MiB activity log extents that can be active at the same time.
+      -
+        name: disk-barrier
+        type: u8
+        doc: Whether to use disk barriers to enforce the ordering of dependent write requests on the backing device.
+      -
+        name: disk-flushes
+        type: u8
+        doc: Whether to issue disk flushes to the backing device to enforce the ordering of dependent write requests.
+      -
+        name: disk-drain
+        type: u8
+        doc: Whether to wait for the local I/O request queue to drain before completing a write barrier.
+      -
+        name: md-flushes
+        type: u8
+        doc: Whether to issue disk flushes to the metadata device.
+      -
+        name: disk-timeout
+        type: u32
+        doc: Time to wait for the backing device to complete an I/O request before treating it as failed, in units of 0.1 seconds, or 0 to disable (drbd.conf option disk-timeout).
+      -
+        name: read-balancing
+        type: u32
+        enum: read-balancing-policy
+        doc: Policy for balancing reads across the local disk and peers (drbd.conf option read-balancing).
+      -
+        name: unplug-watermark
+        type: u32
+        doc: Legacy watermark, in pages, that used to trigger an early unplug of the backing device's request queue (drbd.conf option unplug-watermark).
+      -
+        name: rs-discard-granularity
+        type: u32
+        doc: Size, in bytes, of the resync requests DRBD tries to discard on the sync target when the source's data is all zeroes (drbd.conf option rs-discard-granularity).
+      -
+        name: al-updates
+        type: u8
+        doc: Whether to update the activity log on disk, at the cost of a full resync after a primary crash if disabled (drbd.conf option al-updates).
+      -
+        name: discard-zeroes-if-aligned
+        type: u8
+        doc: Whether to treat discarded, aligned blocks on the backing device as reading back as zero (drbd.conf option discard-zeroes-if-aligned).
+      -
+        name: disable-write-same
+        type: u8
+        doc: Whether to avoid using the WRITE SAME command on the backing device, for devices that advertise support but fail such requests (drbd.conf option disable-write-same).
+      -
+        name: bitmap
+        type: u8
+        doc: Whether to allocate the on-disk change-tracking bitmap when the device is attached (drbd.conf option bitmap).
+
+  -
+    name: resource-opts
+    doc: Options of a resource (drbd.conf options section).
+    attributes:
+      -
+        name: cpu-mask
+        type: string
+        checks:
+          max-len: cpu-mask-size
+        doc: CPU affinity mask for DRBD kernel threads, as a hexadecimal number (drbd.conf option cpu-mask).
+      -
+        name: on-no-data-accessible
+        type: u32
+        enum: on-no-data-policy
+        doc: Action to take for I/O requests when the requested data is not available locally or remotely (drbd.conf option on-no-data-accessible).
+      -
+        name: auto-promote
+        type: u8
+        doc: Whether to automatically promote the resource to primary when one of its devices is mounted or opened for writing (drbd.conf option auto-promote).
+      -
+        name: node-id
+        type: u32
+        doc: Unique node identifier of this node in the cluster (drbd.conf option node-id).
+      -
+        name: peer-ack-window
+        type: u32
+        doc: Amount of data, in sectors, DRBD replicates to a peer before issuing a peer-ack for the writes in between (drbd.conf option peer-ack-window).
+      -
+        name: twopc-timeout
+        type: u32
+        doc: Timeout for a two-phase-commit cluster-wide state transition, in units of 0.1 seconds (drbd.conf option twopc-timeout).
+      -
+        name: twopc-retry-timeout
+        type: u32
+        doc: Base multiplier for the randomized backoff before retrying a conflicting two-phase commit, in units of 0.1 seconds (drbd.conf option twopc-retry-timeout).
+      -
+        name: peer-ack-delay
+        type: u32
+        doc: How long to wait after the last write request before sending a peer-ack if no new write request arrives, in milliseconds (drbd.conf option peer-ack-delay).
+      -
+        name: auto-promote-timeout
+        type: u32
+        doc: How long to wait for a device to become promotable when auto-promote triggers a promotion, in units of 0.1 seconds (drbd.conf option auto-promote-timeout).
+      -
+        name: max-io-depth
+        type: u32
+        doc: Maximum number of outstanding application I/O requests on a DRBD device.
+      -
+        name: quorum
+        type: s32
+        doc: Number of nodes with an accessible disk required for a partition to have quorum, or a symbolic value (off, majority, all) (drbd.conf option quorum).
+      -
+        name: on-no-quorum
+        type: u32
+        enum: on-no-quorum-policy
+        doc: Action to take for I/O requests when the resource loses quorum (drbd.conf option on-no-quorum).
+      -
+        name: quorum-min-redundancy
+        type: s32
+        doc: Minimum number of nodes with an UpToDate disk required for a partition to gain quorum, or a symbolic value (off, majority, all) (drbd.conf option quorum-minimum-redundancy).
+      -
+        name: on-suspended-primary-outdated
+        type: u32
+        enum: on-suspended-primary-outdated-policy
+        doc: Action to take for a primary that has I/O suspended due to lost quorum and learns its data is outdated (drbd.conf option on-suspended-primary-outdated).
+      -
+        name: drbd8-compat-mode
+        type: u8
+        doc: Whether the resource operates in DRBD 8 compatible, single-peer mode.
+      -
+        name: explicit-drbd8-compat
+        type: u8
+        doc: Whether to explicitly (re)configure DRBD 8 compatible mode whenever a node-id is configured, instead of leaving it unchanged.
+
+  -
+    name: net-conf
+    doc: Options of a connection to a peer (drbd.conf net section).
+    attributes:
+      -
+        name: shared-secret
+        type: string
+        checks:
+          max-len: shared-secret-max
+        doc: Shared secret used for peer authentication (drbd.conf option shared-secret).
+      -
+        name: cram-hmac-alg
+        type: string
+        checks:
+          max-len: alg-name-max
+        doc: Hash-based message authentication code (HMAC) algorithm used for peer authentication (drbd.conf option cram-hmac-alg).
+      -
+        name: integrity-alg
+        type: string
+        checks:
+          max-len: alg-name-max
+        doc: Data integrity algorithm used, in addition to the TCP/IP checksum, to detect corruption of data received over the network (drbd.conf option data-integrity-alg).
+      -
+        name: verify-alg
+        type: string
+        checks:
+          max-len: alg-name-max
+        doc: Hash algorithm used to compute and compare block checksums during online verification (drbd.conf option verify-alg).
+      -
+        name: csums-alg
+        type: string
+        checks:
+          max-len: alg-name-max
+        doc: Hash algorithm used to compare blocks before resending identical data during a resync (drbd.conf option csums-alg).
+      -
+        name: protocol
+        type: u32
+        enum: wire-protocol
+        doc: Replication protocol used on this connection.
+      -
+        name: connect-int
+        type: u32
+        doc: How long to wait before retrying to establish a connection to the peer, in seconds (drbd.conf option connect-int).
+      -
+        name: timeout
+        type: u32
+        doc: Timeout for replies over the network before considering a peer dead, in units of 0.1 seconds (drbd.conf option timeout).
+      -
+        name: ping-int
+        type: u32
+        doc: Interval of connection idle time after which DRBD sends a keep-alive packet, in seconds (drbd.conf option ping-int).
+      -
+        name: ping-timeo
+        type: u32
+        doc: Timeout for replies to keep-alive packets, in units of 0.1 seconds (drbd.conf option ping-timeout).
+      -
+        name: sndbuf-size
+        type: u32
+        doc: Size of the TCP/IP send buffer, in bytes, or 0 to size it automatically (drbd.conf option sndbuf-size).
+      -
+        name: rcvbuf-size
+        type: u32
+        doc: Size of the TCP/IP receive buffer, in bytes, or 0 to size it automatically (drbd.conf option rcvbuf-size).
+      -
+        name: ko-count
+        type: u32
+        doc: Number of times the timeout may be exceeded before a non-responding peer is excluded from the cluster (drbd.conf option ko-count).
+      -
+        name: max-epoch-size
+        type: u32
+        doc: Maximum number of write requests DRBD may issue before issuing a write barrier (drbd.conf option max-epoch-size).
+      -
+        name: after-sb-0pri
+        type: u32
+        enum: after-sb-policy
+        doc: Split-brain recovery policy when neither node is primary.
+      -
+        name: after-sb-1pri
+        type: u32
+        enum: after-sb-policy
+        doc: Split-brain recovery policy when exactly one node is primary.
+      -
+        name: after-sb-2pri
+        type: u32
+        enum: after-sb-policy
+        doc: Split-brain recovery policy when both nodes are primary.
+      -
+        name: rr-conflict
+        type: u32
+        enum: after-sb-policy
+        doc: Policy for resolving a role/resync conflict left over from a split-brain recovery (drbd.conf option rr-conflict).
+      -
+        name: on-congestion
+        type: u32
+        enum: on-congestion-policy
+        doc: Action to take when the replication link's TCP send queue is congested (drbd.conf option on-congestion).
+      -
+        name: cong-fill
+        type: u32
+        doc: Amount of in-flight data, in sectors, allowed on this connection before switching into ahead/behind mode, or 0 to disable (drbd.conf option congestion-fill).
+      -
+        name: cong-extents
+        type: u32
+        doc: Number of active bitmap extents allowed before switching into ahead/behind mode (drbd.conf option congestion-extents).
+      -
+        name: two-primaries
+        type: u8
+        doc: Whether to allow both nodes of this connection to be primary at the same time (drbd.conf option allow-two-primaries).
+      -
+        name: tcp-cork
+        type: u8
+        doc: Whether to use the TCP_CORK socket option to coalesce partial messages into fewer, bigger packets (drbd.conf option tcp-cork).
+      -
+        name: always-asbp
+        type: u8
+        doc: Whether to apply the automatic split-brain recovery policies even when the UUIDs indicate a third node may be involved (drbd.conf option always-asbp).
+      -
+        name: use-rle
+        type: u8
+        doc: Whether to run-length encode the bitmap exchanged with the peer when a connection is established (drbd.conf option use-rle).
+      -
+        name: fencing
+        type: u32
+        enum: fencing-policy
+        doc: Fencing policy used to avoid a split-brain when both nodes are primary and disconnected.
+      -
+        name: connection-name
+        type: string
+        checks:
+          max-len: connection-name-max
+        doc: Name of the connection this net-conf applies to.
+      -
+        name: csums-after-crash-only
+        type: u8
+        doc: Whether to compare block checksums only for the resync after a primary crash, rather than for every resync (drbd.conf option csums-after-crash-only).
+      -
+        name: sock-check-timeo
+        type: u32
+        doc: Timeout used to poll the send/receive socket for a broken TCP connection when DRBD-proxy is in use, in units of 0.1 seconds (drbd.conf option socket-check-timeout).
+      -
+        name: transport-name
+        type: string
+        checks:
+          max-len: transport-name-max
+        doc: Name of the network transport module used for this connection, e.g. tcp or rdma (drbd.conf option transport).
+      -
+        name: max-buffers
+        type: u32
+        doc: Maximum number of pages used for receive buffers and internal resync/verify buffers per device (drbd.conf option max-buffers).
+      -
+        name: allow-remote-read
+        type: u8
+        doc: Whether to allow reads to be served from a peer's disk when the local disk is not up to date (drbd.conf option allow-remote-read).
+      -
+        name: tls
+        type: u8
+        doc: Whether to encrypt this connection with TLS (drbd.conf option tls).
+      -
+        name: tls-privkey
+        type: s32
+        doc: Serial number of the kernel keyring key holding the private key used for TLS encryption (drbd.conf option tls-privkey).
+      -
+        name: tls-certificate
+        type: s32
+        doc: Serial number of the kernel keyring key holding the certificate used for TLS encryption (drbd.conf option tls-certificate).
+      -
+        name: tls-keyring
+        type: s32
+        doc: Serial number of the kernel keyring used to look up the TLS key material (drbd.conf option tls-keyring).
+      -
+        name: load-balance-paths
+        type: u8
+        doc: Whether to load-balance traffic for this connection across all configured paths instead of using only one at a time (drbd.conf option load-balance-paths).
+      -
+        name: rdma-ctrl-rcvbuf-size
+        type: u32
+        doc: Size, in bytes, of the RDMA transport's control-stream receive buffer, or 0 to derive it from rcvbuf-size (drbd.conf option rdma-ctrl-rcvbuf-size).
+      -
+        name: rdma-ctrl-sndbuf-size
+        type: u32
+        doc: Size, in bytes, of the RDMA transport's control-stream send buffer, or 0 to derive it from sndbuf-size (drbd.conf option rdma-ctrl-sndbuf-size).
+
+  -
+    name: set-role-parms
+    doc: Parameters of the set-role request.
+    attributes:
+      -
+        name: force
+        type: flag
+        doc: Request that the promotion to primary succeed even if some devices are not guaranteed to have up-to-date data (drbdsetup primary option force).
+
+  -
+    name: resize-parms
+    doc: Parameters of the resize request.
+    attributes:
+      -
+        name: size
+        type: u64
+        doc: New size of the device, in sectors, or 0 to use the full size of the backing devices (drbdsetup resize option size).
+      -
+        name: assume-peer-has-space
+        type: flag
+        doc: Request that the resize proceed even though not all peer devices are currently connected, assuming they already have enough space.
+      -
+        name: assume-clean
+        type: flag
+        doc: Request that the additional space not be resynchronized, assuming it is already identical on all nodes.
+      -
+        name: al-stripes
+        type: u32
+        doc: Number of activity log stripes to use after the resize (drbdsetup resize option al-stripes).
+      -
+        name: al-stripe-size
+        type: u32
+        doc: Size of each activity log stripe, in KiB, after the resize (drbdsetup resize option al-stripe-size).
+
+  -
+    name: start-ov-parms
+    doc: Parameters of the start-ov (online verify) request.
+    attributes:
+      -
+        name: start-sector
+        type: u64
+        doc: Sector at which to start online verification, to resume a previously stopped run.
+      -
+        name: stop-sector
+        type: u64
+        doc: Sector at which to stop online verification.
+
+  -
+    name: new-current-uuid-parms
+    doc: Parameters of the new-current-uuid request.
+    attributes:
+      -
+        name: clear-bm
+        type: flag
+        doc: Request that the peer's bitmap also be cleared, marking the peer as fully in sync without a resync (drbdsetup new-current-uuid option clear-bitmap).
+      -
+        name: force-resync
+        type: flag
+        doc: Request that the peer be marked out of sync so that a resync starts, instead of assuming it already has the same data (drbdsetup new-current-uuid option force-resync).
+
+  -
+    name: disconnect-parms
+    doc: Parameters of the disconnect request.
+    attributes:
+      -
+        name: force
+        type: flag
+        doc: Request that the connection be torn down immediately, discarding any pending, not yet acknowledged data instead of waiting for it (drbdsetup disconnect option force).
+
+  -
+    name: detach-parms
+    doc: Parameters of the detach request.
+    attributes:
+      -
+        name: force
+        type: flag
+        doc: Request that the detach proceed immediately, marking the lower-level device failed until pending I/O completes (drbdsetup detach option force).
+      -
+        name: intentional-diskless-detach
+        type: flag
+        doc: Request that the device be marked permanently, intentionally diskless instead of temporarily diskless (drbdsetup detach option diskless).
+
+  -
+    name: device-conf
+    doc: Options of a device, set when the device is created (drbdsetup new-minor).
+    attributes:
+      -
+        name: max-bio-size
+        type: u32
+        doc: Maximum size of a single I/O request the device accepts, in bytes (drbdsetup new-minor option max-bio-size).
+      -
+        name: intentional-diskless
+        type: u8
+        doc: Whether the device is deliberately created without a local disk, e.g. as a diskless client (drbdsetup new-minor option diskless).
+      -
+        name: block-size
+        type: u32
+        doc: Logical block size the device reports, needed to combine differing backing disk block sizes across nodes (drbd.conf option block-size).
+      -
+        name: discard-granularity
+        type: u32
+        doc: Discard granularity, in bytes, advertised by the device; discard requests must be aligned to and a multiple of this value (drbd.conf option discard-granularity).
+
+  -
+    name: resource-info
+    doc: State of a resource.
+    attributes:
+      -
+        name: role
+        type: u32
+        enum: role
+        doc: Role of the resource on this node.
+      -
+        name: susp
+        type: u8
+        doc: Whether I/O on the resource is suspended by the user.
+      -
+        name: susp-nod
+        type: u8
+        doc: Whether I/O on the resource is suspended because no data is accessible.
+      -
+        name: susp-fen
+        type: u8
+        doc: Whether I/O on the resource is suspended because a fence-peer handler is running.
+      -
+        name: susp-quorum
+        type: u8
+        doc: Whether I/O on the resource is suspended because it has lost quorum.
+      -
+        name: fail-io
+        type: u8
+        doc: Whether all I/O on the resource fails because it was forced to demote from primary.
+
+  -
+    name: device-info
+    doc: State of a device.
+    attributes:
+      -
+        name: disk-state
+        type: u32
+        enum: disk-state
+        doc: Current state of the backing disk.
+      -
+        name: is-intentional-diskless
+        type: u8
+        doc: Whether the device is deliberately configured without a local disk.
+      -
+        name: has-quorum
+        type: u8
+        doc: Whether the device currently has quorum.
+      -
+        name: is-open
+        type: u8
+        doc: Whether the device is currently opened by an application.
+      -
+        name: backing-dev-path
+        type: string
+        checks:
+          max-len: device-path-max
+        doc: Path of the backing device, present while it is still accessible after a disk failure.
+
+  -
+    name: connection-info
+    doc: State of a connection to a peer.
+    attributes:
+      -
+        name: connection-state
+        type: u32
+        enum: connection-state
+        doc: Current state of the connection to the peer.
+      -
+        name: role
+        type: u32
+        enum: role
+        doc: Current role of the peer.
+
+  -
+    name: peer-device-info
+    doc: State of a peer device.
+    attributes:
+      -
+        name: repl-state
+        type: u32
+        enum: repl-state
+        doc: Current replication state with the peer.
+      -
+        name: disk-state
+        type: u32
+        enum: disk-state
+        doc: Current state of the peer's disk.
+      -
+        name: resync-susp-user
+        type: u8
+        doc: Whether resynchronization with this peer is suspended by the user.
+      -
+        name: resync-susp-peer
+        type: u8
+        doc: Whether resynchronization with this peer is suspended by the peer.
+      -
+        name: resync-susp-dependency
+        type: u8
+        doc: Whether resynchronization with this peer is suspended because it depends on another volume or connection resynchronizing first.
+      -
+        name: is-intentional-diskless
+        type: u8
+        doc: Whether the peer is deliberately configured without a local disk.
+      -
+        name: resync-susp-max-parallel
+        type: u8
+        doc: Whether resynchronization with this peer is suspended to enforce the maximum number of parallel resyncs.
+
+  -
+    name: resource-statistics
+    doc: Statistics of a resource.
+    attributes:
+      -
+        name: write-ordering
+        type: u32
+        enum: write-ordering
+        doc: Write ordering method currently in use for the resource's backing devices.
+
+  -
+    name: device-statistics
+    doc: Statistics of a device.
+    attributes:
+      -
+        name: size
+        type: u64
+        doc: Capacity of the device, in sectors.
+      -
+        name: read
+        type: u64
+        doc: Total data read from the device, in sectors, since it was attached.
+      -
+        name: write
+        type: u64
+        doc: Total data written to the device, in sectors, since it was attached.
+      -
+        name: al-writes
+        type: u64
+        doc: Number of activity log metadata writes since the device was attached.
+      -
+        name: bm-writes
+        type: u64
+        doc: Number of bitmap metadata writes since the device was attached.
+      -
+        name: upper-pending
+        type: u32
+        doc: Number of application I/O requests currently in flight on the device.
+      -
+        name: lower-pending
+        type: u32
+        doc: Number of I/O requests currently in flight on the backing device.
+      -
+        name: upper-blocked
+        type: u8
+        doc: Whether application I/O to the device is currently throttled.
+      -
+        name: lower-blocked
+        type: u8
+        doc: Whether I/O to the backing device is currently blocked.
+      -
+        name: al-suspended
+        type: u8
+        doc: Whether updates to the activity log are currently suspended.
+      -
+        name: exposed-data-uuid
+        type: u64
+        doc: Data generation UUID currently exposed to peers, identifying the generation of data this node has.
+      -
+        name: current-uuid
+        type: u64
+        doc: Current data generation UUID of the device's metadata.
+      -
+        name: disk-flags
+        type: u32
+        doc: Bitmask of the backing disk's metadata flags.
+      -
+        name: history-uuids
+        type: binary
+        sub-type: u64
+        checks:
+          max-len: history-uuids-size
+        doc: Historical bitmap UUIDs of prior data generations, one slot per peer.
+
+  -
+    name: connection-statistics
+    doc: Statistics of a connection to a peer.
+    attributes:
+      -
+        name: congested
+        type: u8
+        doc: Whether the network transport to the peer is currently congested.
+      -
+        name: ap-in-flight
+        type: u64
+        doc: Application data sent to the peer but not yet acknowledged, in sectors.
+      -
+        name: rs-in-flight
+        type: u64
+        doc: Resync data sent to the peer but not yet acknowledged, in sectors.
+
+  -
+    name: peer-device-statistics
+    doc: Statistics of a peer device.
+    attributes:
+      -
+        name: received
+        type: u64
+        doc: Total data received from the peer for this device, in sectors.
+      -
+        name: sent
+        type: u64
+        doc: Total data sent to the peer for this device, in sectors.
+      -
+        name: pending
+        type: u32
+        doc: Number of requests to this peer waiting for an acknowledgement.
+      -
+        name: unacked
+        type: u32
+        doc: Number of requests from this peer that have not yet been acknowledged.
+      -
+        name: out-of-sync
+        type: u64
+        doc: Amount of data known to differ from this peer, in sectors.
+      -
+        name: resync-failed
+        type: u64
+        doc: Amount of data that failed to resynchronize with this peer, in sectors.
+      -
+        name: bitmap-uuid
+        type: u64
+        doc: Bitmap UUID recorded for this peer.
+      -
+        name: flags
+        type: u32
+        doc: Bitmask of this peer device's metadata flags.
+      -
+        name: rs-total
+        type: u64
+        doc: Total amount of data to resynchronize with this peer for the current resync, in sectors.
+      -
+        name: ov-start-sector
+        type: u64
+        doc: Sector at which the current online verify run started.
+      -
+        name: ov-stop-sector
+        type: u64
+        doc: Sector at which the current online verify run will stop.
+      -
+        name: ov-position
+        type: u64
+        doc: Current position of an ongoing online verify run, in sectors.
+      -
+        name: ov-left
+        type: u64
+        doc: Amount of data left to verify in an ongoing online verify run, in sectors.
+      -
+        name: ov-skipped
+        type: u64
+        doc: Amount of data skipped during an ongoing online verify run, in sectors.
+      -
+        name: rs-same-csum
+        type: u64
+        doc: Amount of resync data found identical by checksum comparison and not retransmitted, in sectors.
+      -
+        name: rs-dt-start-ms
+        type: u64
+        doc: Time elapsed since the current resync with this peer started, in milliseconds.
+      -
+        name: rs-paused-ms
+        type: u64
+        doc: Total time the current resync with this peer has been paused, in milliseconds.
+      -
+        name: rs-dt0-ms
+        type: u64
+        doc: Time since the most recent resync progress mark, in milliseconds.
+      -
+        name: rs-db0-sectors
+        type: u64
+        doc: Data resynchronized since the most recent resync progress mark, in sectors.
+      -
+        name: rs-dt1-ms
+        type: u64
+        doc: Time since the resync progress mark before the most recent one, in milliseconds.
+      -
+        name: rs-db1-sectors
+        type: u64
+        doc: Data resynchronized since the resync progress mark before the most recent one, in sectors.
+      -
+        name: rs-c-sync-rate
+        type: u32
+        doc: Current dynamically controlled resync rate for this peer, in KiB/s.
+      -
+        name: uuid-flags
+        type: u64
+        doc: Bitmask of UUID-related flags negotiated with this peer.
+
+  -
+    name: helper-info
+    doc: Identity and outcome of a handler script invocation.
+    attributes:
+      -
+        name: name
+        type: string
+        checks:
+          max-len: helper-name-max
+        doc: Name of the handler script being invoked.
+      -
+        name: status
+        type: u32
+        doc: Exit status of the handler script, present when phase is response.
+      -
+        name: phase
+        type: u32
+        enum: helper-phase
+        doc: Whether this notification announces the call or reports its result.
+
+  -
+    name: invalidate-parms
+    doc: Parameters of the invalidate request.
+    attributes:
+      -
+        name: sync-from-peer-node-id
+        type: u32
+        doc: Node ID of the peer to resynchronize from; if absent, the kernel chooses a peer.
+      -
+        name: reset-bitmap
+        type: u8
+        doc: Whether to mark the whole bitmap out of sync before starting the resync, instead of resyncing only the blocks already marked out of sync (drbdsetup invalidate option reset-bitmap).
+
+  -
+    name: peer-device-conf
+    doc: Options of a peer device (drbd.conf peer-device-options section).
+    attributes:
+      -
+        name: resync-rate
+        type: u32
+        doc: Bandwidth DRBD may use for resynchronizing with this peer when the dynamic resync controller is disabled, in KiB/s (drbd.conf option resync-rate).
+      -
+        name: c-plan-ahead
+        type: u32
+        doc: How fast the dynamic resync-rate controller adapts to changes in resync speed, in units of 0.1 seconds, or 0 to use a fixed resync-rate instead (drbd.conf option c-plan-ahead).
+      -
+        name: c-delay-target
+        type: u32
+        doc: Delay the dynamic resync-rate controller aims for along the resync path, in units of 0.1 seconds (drbd.conf option c-delay-target).
+      -
+        name: c-fill-target
+        type: u32
+        doc: Amount of resync data the dynamic resync-rate controller aims to keep in flight, in sectors (drbd.conf option c-fill-target).
+      -
+        name: c-max-rate
+        type: u32
+        doc: Maximum bandwidth used by the dynamic resync-rate controller, in KiB/s, or 0 for no limit (drbd.conf option c-max-rate).
+      -
+        name: c-min-rate
+        type: u32
+        doc: Bandwidth reserved for resync I/O against this peer when this node is the sync source and primary, in KiB/s (drbd.conf option c-min-rate).
+      -
+        name: bitmap
+        type: u8
+        doc: Whether to allocate a bitmap slot for this peer, overriding the automatic default for a diskless peer (drbd.conf option bitmap).
+      -
+        name: resync-without-replication
+        type: u8
+        doc: Whether to suspend replication of application writes to this peer while it is being resynchronized (drbd.conf option resync-without-replication).
+      -
+        name: peer-tiebreaker
+        type: u8
+        doc: Whether this peer participates as a tiebreaker in quorum decisions even though it is intentionally diskless (drbd.conf option peer-tiebreaker).
+
+  -
+    name: connect-parms
+    doc: Parameters of the connect request.
+    attributes:
+      -
+        name: tentative
+        type: flag
+        doc: Request that DRBD only determine whether a connection could be established and which resync direction would be used, without actually connecting or resyncing (drbdsetup connect option tentative).
+      -
+        name: discard-my-data
+        type: flag
+        doc: Request that local data be discarded and resynchronized from the peer that has the most up-to-date data (drbdsetup connect option discard-my-data).
+
+  -
+    name: path-info
+    doc: State of a path.
+    attributes:
+      -
+        name: established
+        type: u8
+        doc: Whether the path's transport connection is currently established.
+
+  -
+    name: rename-parms
+    doc: Parameters of the rename request.
+    attributes:
+      -
+        name: new-name
+        type: string
+        checks:
+          max-len: resource-name-max
+        doc: New name for the resource.
+
+  -
+    name: invalidate-peer-parms
+    doc: Parameters of the invalidate-peer request.
+    attributes:
+      -
+        name: reset-bitmap
+        type: u8
+        doc: Whether to mark the whole bitmap out of sync before starting the resync, instead of resyncing only the blocks already marked out of sync (drbdsetup invalidate-remote option reset-bitmap).
+
+  -
+    name: suspend-io-parms
+    doc: Parameters of the suspend-io request.
+    attributes:
+      -
+        name: bdev-freeze
+        type: u8
+        doc: Whether to freeze the filesystem mounted on the device to bring it into a consistent state before suspending I/O (drbdsetup suspend-io option bdev-freeze).
+
+  -
+    name: resource
+    doc: A resource with its context, state, statistics and options.
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        doc: Identity of the object.
+      -
+        name: info
+        type: nest
+        nested-attributes: resource-info
+        doc: State of the object.
+      -
+        name: statistics
+        type: nest
+        nested-attributes: resource-statistics
+        doc: Statistics of the object.
+      -
+        name: new-name
+        type: string
+        checks:
+          max-len: resource-name-max
+        doc: New name of the resource; present in state-change messages with action
+          rename.
+      -
+        name: resource-opts
+        type: nest
+        nested-attributes: resource-opts
+        doc: Resource-wide options in effect.
+
+  -
+    name: device
+    doc: A device with its context, state, statistics and options.
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        doc: Identity of the object.
+      -
+        name: info
+        type: nest
+        nested-attributes: device-info
+        doc: State of the object.
+      -
+        name: statistics
+        type: nest
+        nested-attributes: device-statistics
+        doc: Statistics of the object.
+      -
+        name: disk-conf
+        type: nest
+        nested-attributes: disk-conf
+        doc: Backing disk options in effect; absent while the device is diskless.
+      -
+        name: device-conf
+        type: nest
+        nested-attributes: device-conf
+        doc: Device options in effect.
+
+  -
+    name: connection
+    doc: A connection with its context, state, statistics, options and paths.
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        doc: Identity of the object.
+      -
+        name: info
+        type: nest
+        nested-attributes: connection-info
+        doc: State of the object.
+      -
+        name: statistics
+        type: nest
+        nested-attributes: connection-statistics
+        doc: Statistics of the object.
+      -
+        name: net-conf
+        type: nest
+        nested-attributes: net-conf
+        doc: Connection options in effect; absent when the connection has none.
+      -
+        name: path
+        type: nest
+        nested-attributes: path
+        multi-attr: true
+        doc: The paths of this connection, one attribute each. Also available on
+          their own through path-get.
+
+  -
+    name: peer-device
+    doc: A peer device with its context, state, statistics and options.
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        doc: Identity of the object.
+      -
+        name: info
+        type: nest
+        nested-attributes: peer-device-info
+        doc: State of the object.
+      -
+        name: statistics
+        type: nest
+        nested-attributes: peer-device-statistics
+        doc: Statistics of the object.
+      -
+        name: peer-device-conf
+        type: nest
+        nested-attributes: peer-device-conf
+        doc: Peer device options in effect; absent when the peer device has none.
+
+  -
+    name: path
+    doc: A path with its context and state.
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        doc: Identity of the object.
+      -
+        name: info
+        type: nest
+        nested-attributes: path-info
+        doc: State of the object.
+
+  -
+    name: drbd2
+    doc: Top-level attributes of drbd2 requests, replies and notifications.
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        doc: Object the message refers to.
+      -
+        name: set-defaults
+        type: flag
+        doc: Reset all options not given in this request to their defaults before
+          applying it.
+      -
+        name: state-result
+        type: u32
+        enum: state-result
+        doc: Outcome of the state change performed by the request.
+      -
+        name: message
+        type: string
+        doc: Human-readable explanation accompanying state-result.
+      -
+        name: timeout-type
+        type: u32
+        enum: timeout-type
+        doc: Reply of timeout-type-get.
+      -
+        name: disk-conf
+        type: nest
+        nested-attributes: disk-conf
+        doc: Backing disk options for device-attach and disk-set.
+      -
+        name: resource-opts
+        type: nest
+        nested-attributes: resource-opts
+        doc: Resource-wide options for resource-new and resource-set.
+      -
+        name: net-conf
+        type: nest
+        nested-attributes: net-conf
+        doc: Connection options for connection-new and connection-set.
+      -
+        name: set-role-parms
+        type: nest
+        nested-attributes: set-role-parms
+        doc: Parameters of resource-primary and resource-secondary.
+      -
+        name: resize-parms
+        type: nest
+        nested-attributes: resize-parms
+        doc: Parameters of device-resize.
+      -
+        name: start-ov-parms
+        type: nest
+        nested-attributes: start-ov-parms
+        doc: Parameters of peer-device-start-ov.
+      -
+        name: new-current-uuid-parms
+        type: nest
+        nested-attributes: new-current-uuid-parms
+        doc: Parameters of device-new-current-uuid.
+      -
+        name: disconnect-parms
+        type: nest
+        nested-attributes: disconnect-parms
+        doc: Parameters of connection-disconnect and connection-del.
+      -
+        name: detach-parms
+        type: nest
+        nested-attributes: detach-parms
+        doc: Parameters of device-detach.
+      -
+        name: device-conf
+        type: nest
+        nested-attributes: device-conf
+        doc: Device options set when the device is created by device-new.
+      -
+        name: helper
+        type: nest
+        nested-attributes: helper-info
+        doc: Identity and outcome of the handler script reported by helper-ntf.
+      -
+        name: invalidate-parms
+        type: nest
+        nested-attributes: invalidate-parms
+        doc: Parameters of device-invalidate.
+      -
+        name: peer-device-conf
+        type: nest
+        nested-attributes: peer-device-conf
+        doc: Peer device options for peer-device-set.
+      -
+        name: connect-parms
+        type: nest
+        nested-attributes: connect-parms
+        doc: Parameters of connection-connect.
+      -
+        name: rename-parms
+        type: nest
+        nested-attributes: rename-parms
+        doc: Parameters of resource-rename.
+      -
+        name: invalidate-peer-parms
+        type: nest
+        nested-attributes: invalidate-peer-parms
+        doc: Parameters of peer-device-invalidate.
+      -
+        name: suspend-io-parms
+        type: nest
+        nested-attributes: suspend-io-parms
+        doc: Parameters of resource-suspend-io.
+      -
+        name: resource
+        type: nest
+        nested-attributes: resource
+        doc: A resource (dump reply).
+      -
+        name: device
+        type: nest
+        nested-attributes: device
+        doc: A device (dump reply).
+      -
+        name: connection
+        type: nest
+        nested-attributes: connection
+        doc: A connection (dump reply).
+      -
+        name: peer-device
+        type: nest
+        nested-attributes: peer-device
+        doc: A peer device (dump reply).
+      -
+        name: path
+        type: nest
+        nested-attributes: path
+        doc: A path (dump reply).
+
+  -
+    name: state-change
+    doc: One object of a state change or of the initial state snapshot. Exactly one
+      object nest is present.
+    attributes:
+      -
+        name: action
+        type: u32
+        enum: state-change-action
+        doc: Whether the object exists, was created, changed or destroyed.
+      -
+        name: more
+        type: flag
+        doc: Further messages belong to the same state change.
+      -
+        name: resource
+        type: nest
+        nested-attributes: resource
+        doc: Present when the message describes a resource.
+      -
+        name: device
+        type: nest
+        nested-attributes: device
+        doc: Present when the message describes a device.
+      -
+        name: connection
+        type: nest
+        nested-attributes: connection
+        doc: Present when the message describes a connection.
+      -
+        name: peer-device
+        type: nest
+        nested-attributes: peer-device
+        doc: Present when the message describes a peer device.
+      -
+        name: path
+        type: nest
+        nested-attributes: path
+        doc: Present when the message describes a path.
+
+operations:
+  list:
+    -
+      name: resource-new
+      doc: Create a new DRBD resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - resource-opts
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-del
+      doc: Delete a DRBD resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-set
+      doc: Change resource options.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - resource-opts
+            - set-defaults
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-rename
+      doc: Rename a DRBD resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - rename-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-down
+      doc: Shut down a DRBD resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-primary
+      doc: Promote the resource to primary role.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - set-role-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-secondary
+      doc: Demote the resource to secondary role.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - set-role-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-suspend-io
+      doc: Suspend I/O on a resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - suspend-io-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: resource-resume-io
+      doc: Resume I/O on a resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-new
+      doc: Add a DRBD device as a volume to a resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - device-conf
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-del
+      doc: Delete a DRBD device.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-attach
+      doc: Attach a local backing device to a DRBD device.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - disk-conf
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-detach
+      doc: Detach the local backing device from a DRBD device.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - detach-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: disk-set
+      doc: Change disk options. Applies to the attached backing disk; see
+        device-attach.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - disk-conf
+            - set-defaults
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-resize
+      doc: Resize the DRBD device.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - resize-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-outdate
+      doc: Mark the local data as outdated.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-invalidate
+      doc: Invalidate the local data of a DRBD device.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - invalidate-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: device-new-current-uuid
+      doc: Generate a new current UUID.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - new-current-uuid-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: connection-new
+      doc: Add a new peer to a resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - net-conf
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: connection-del
+      doc: Delete a peer from a resource.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - disconnect-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: connection-connect
+      doc: Connect to a peer.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - connect-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: connection-disconnect
+      doc: Disconnect from a peer.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - disconnect-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: connection-set
+      doc: Change network options.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - net-conf
+            - set-defaults
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: connection-forget
+      doc: Forget a previously connected peer. The peer is identified by
+        context.peer-node-id.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: path-new
+      doc: Add a new network path to a connection.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: path-del
+      doc: Delete a network path from a connection.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: peer-device-set
+      doc: Change peer device options.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - peer-device-conf
+            - set-defaults
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: peer-device-invalidate
+      doc: Invalidate the peer data of a DRBD peer device.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - invalidate-peer-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: peer-device-pause-sync
+      doc: Pause resynchronization.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: peer-device-resume-sync
+      doc: Resume resynchronization.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: peer-device-start-ov
+      doc: Start online verification.
+      attribute-set: drbd2
+      flags:
+        - admin-perm
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+            - start-ov-parms
+        reply:
+          attributes:
+            - state-result
+            - message
+
+    -
+      name: timeout-type-get
+      doc: Get the timeout type for a peer device.
+      attribute-set: drbd2
+      do:
+        pre: drbd2-pre-doit
+        post: drbd2-post-doit
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - timeout-type
+
+    -
+      name: resource-get
+      doc: Dump all DRBD resources. Optionally filtered by context.
+      attribute-set: drbd2
+      dump:
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - resource
+
+    -
+      name: device-get
+      doc: Dump all DRBD devices. Optionally filtered by context.
+      attribute-set: drbd2
+      dump:
+        post: drbd2-nl-device-get-done
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - device
+
+    -
+      name: connection-get
+      doc: Dump all DRBD connections. Optionally filtered by context.
+      attribute-set: drbd2
+      dump:
+        post: drbd2-nl-connection-get-done
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - connection
+
+    -
+      name: peer-device-get
+      doc: Dump all DRBD peer devices. Optionally filtered by context.
+      attribute-set: drbd2
+      dump:
+        post: drbd2-nl-peer-device-get-done
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - peer-device
+
+    -
+      name: path-get
+      doc: Dump all DRBD paths. Optionally filtered by context.
+      attribute-set: drbd2
+      dump:
+        post: drbd2-nl-path-get-done
+        request:
+          attributes:
+            - context
+        reply:
+          attributes:
+            - path
+
+    -
+      name: state-get
+      doc: Dump a consistent snapshot of all resources, devices, connections, peer
+        devices and paths as state-change messages with action exists.
+      attribute-set: state-change
+      dump:
+        post: drbd2-nl-state-get-done
+        reply:
+          attributes:
+            - action
+            - more
+            - resource
+            - device
+            - connection
+            - peer-device
+            - path
+
+    -
+      name: state-change-ntf
+      doc: Notification about a state change; same layout as state-get replies. Messages
+        of one state change have more set on all but the last.
+      notify: state-get
+      mcgrp: events
+
+    -
+      name: helper-ntf
+      doc: A user-space helper is about to be called (phase call) or has finished
+        (phase response).
+      attribute-set: drbd2
+      event:
+        attributes:
+          - context
+          - helper
+      mcgrp: events
+
+mcast-groups:
+  list:
+    -
+      name: events
diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 1b8b3f6efc1b..261965d7b054 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -108,4 +108,10 @@ config DRBD_COMPAT_84
 	  this compile-time option, creating a resource without a node
 	  ID is not possible.
 
+	  This option also provides the "drbd" generic netlink
+	  family at version 1, which drbd-utils have always used to
+	  configure DRBD. Without it, DRBD can only be configured
+	  through the drbd2 family, which older drbd-utils releases
+	  do not know.
+
 	  If unsure, say Y.
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 0b7bc8f5d53a..74694d95fe39 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -6,6 +6,7 @@ drbd-y += drbd_interval.o drbd_state.o
 drbd-$(CONFIG_DRBD_COMPAT_84) += drbd_nl_gen.o
 drbd-y += drbd_nl_defaults.o
 drbd-$(CONFIG_DRBD_COMPAT_84) += drbd_nl_84.o
+drbd-y += drbd_nl_drbd2.o drbd2_nl_gen.o
 drbd-y += drbd_transport.o
 drbd-$(CONFIG_DEV_DAX_PMEM) += drbd_dax_pmem.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
diff --git a/drivers/block/drbd/drbd2_nl_gen.c b/drivers/block/drbd/drbd2_nl_gen.c
new file mode 100644
index 000000000000..332527091b86
--- /dev/null
+++ b/drivers/block/drbd/drbd2_nl_gen.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drbd2.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "drbd2_nl_gen.h"
+
+#include <uapi/linux/drbd2.h>
+
+/* Common nested types */
+const struct nla_policy drbd2_address_nl_policy[DRBD2_A_ADDRESS_IPV6 + 1] = {
+	[DRBD2_A_ADDRESS_FAMILY] = { .type = NLA_U16, },
+	[DRBD2_A_ADDRESS_PORT] = { .type = NLA_BE16, },
+	[DRBD2_A_ADDRESS_IPV4] = { .type = NLA_BE32, },
+	[DRBD2_A_ADDRESS_IPV6] = NLA_POLICY_EXACT_LEN(16),
+};
+
+const struct nla_policy drbd2_connect_parms_nl_policy[DRBD2_A_CONNECT_PARMS_DISCARD_MY_DATA + 1] = {
+	[DRBD2_A_CONNECT_PARMS_TENTATIVE] = { .type = NLA_FLAG, },
+	[DRBD2_A_CONNECT_PARMS_DISCARD_MY_DATA] = { .type = NLA_FLAG, },
+};
+
+const struct nla_policy drbd2_context_nl_policy[DRBD2_A_CONTEXT_PEER_ADDRESS + 1] = {
+	[DRBD2_A_CONTEXT_RESOURCE_NAME] = { .type = NLA_NUL_STRING, .len = DRBD2_RESOURCE_NAME_MAX, },
+	[DRBD2_A_CONTEXT_VOLUME] = { .type = NLA_U32, },
+	[DRBD2_A_CONTEXT_MINOR] = { .type = NLA_U32, },
+	[DRBD2_A_CONTEXT_PEER_NODE_ID] = { .type = NLA_U32, },
+	[DRBD2_A_CONTEXT_CONNECTION_NAME] = { .type = NLA_NUL_STRING, .len = DRBD2_CONNECTION_NAME_MAX, },
+	[DRBD2_A_CONTEXT_MY_ADDRESS] = NLA_POLICY_NESTED(drbd2_address_nl_policy),
+	[DRBD2_A_CONTEXT_PEER_ADDRESS] = NLA_POLICY_NESTED(drbd2_address_nl_policy),
+};
+
+const struct nla_policy drbd2_detach_parms_nl_policy[DRBD2_A_DETACH_PARMS_INTENTIONAL_DISKLESS_DETACH + 1] = {
+	[DRBD2_A_DETACH_PARMS_FORCE] = { .type = NLA_FLAG, },
+	[DRBD2_A_DETACH_PARMS_INTENTIONAL_DISKLESS_DETACH] = { .type = NLA_FLAG, },
+};
+
+const struct nla_policy drbd2_device_conf_nl_policy[DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY + 1] = {
+	[DRBD2_A_DEVICE_CONF_MAX_BIO_SIZE] = { .type = NLA_U32, },
+	[DRBD2_A_DEVICE_CONF_INTENTIONAL_DISKLESS] = { .type = NLA_U8, },
+	[DRBD2_A_DEVICE_CONF_BLOCK_SIZE] = { .type = NLA_U32, },
+	[DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY] = { .type = NLA_U32, },
+};
+
+const struct nla_policy drbd2_disconnect_parms_nl_policy[DRBD2_A_DISCONNECT_PARMS_FORCE + 1] = {
+	[DRBD2_A_DISCONNECT_PARMS_FORCE] = { .type = NLA_FLAG, },
+};
+
+const struct nla_policy drbd2_disk_conf_nl_policy[DRBD2_A_DISK_CONF_BITMAP + 1] = {
+	[DRBD2_A_DISK_CONF_BACKING_DEV] = { .type = NLA_NUL_STRING, .len = DRBD2_DEVICE_PATH_MAX, },
+	[DRBD2_A_DISK_CONF_META_DEV] = { .type = NLA_NUL_STRING, .len = DRBD2_DEVICE_PATH_MAX, },
+	[DRBD2_A_DISK_CONF_META_DEV_IDX] = { .type = NLA_S32, },
+	[DRBD2_A_DISK_CONF_SIZE] = { .type = NLA_U64, },
+	[DRBD2_A_DISK_CONF_ON_IO_ERROR] = NLA_POLICY_MAX(NLA_U32, 2),
+	[DRBD2_A_DISK_CONF_RESYNC_AFTER] = { .type = NLA_S32, },
+	[DRBD2_A_DISK_CONF_AL_EXTENTS] = { .type = NLA_U32, },
+	[DRBD2_A_DISK_CONF_DISK_BARRIER] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_DISK_FLUSHES] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_DISK_DRAIN] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_MD_FLUSHES] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_DISK_TIMEOUT] = { .type = NLA_U32, },
+	[DRBD2_A_DISK_CONF_READ_BALANCING] = NLA_POLICY_MAX(NLA_U32, 10),
+	[DRBD2_A_DISK_CONF_UNPLUG_WATERMARK] = { .type = NLA_U32, },
+	[DRBD2_A_DISK_CONF_RS_DISCARD_GRANULARITY] = { .type = NLA_U32, },
+	[DRBD2_A_DISK_CONF_AL_UPDATES] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_DISCARD_ZEROES_IF_ALIGNED] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_DISABLE_WRITE_SAME] = { .type = NLA_U8, },
+	[DRBD2_A_DISK_CONF_BITMAP] = { .type = NLA_U8, },
+};
+
+const struct nla_policy drbd2_invalidate_parms_nl_policy[DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP + 1] = {
+	[DRBD2_A_INVALIDATE_PARMS_SYNC_FROM_PEER_NODE_ID] = { .type = NLA_U32, },
+	[DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP] = { .type = NLA_U8, },
+};
+
+const struct nla_policy drbd2_invalidate_peer_parms_nl_policy[DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP + 1] = {
+	[DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP] = { .type = NLA_U8, },
+};
+
+const struct nla_policy drbd2_net_conf_nl_policy[DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE + 1] = {
+	[DRBD2_A_NET_CONF_SHARED_SECRET] = { .type = NLA_NUL_STRING, .len = DRBD2_SHARED_SECRET_MAX, },
+	[DRBD2_A_NET_CONF_CRAM_HMAC_ALG] = { .type = NLA_NUL_STRING, .len = DRBD2_ALG_NAME_MAX, },
+	[DRBD2_A_NET_CONF_INTEGRITY_ALG] = { .type = NLA_NUL_STRING, .len = DRBD2_ALG_NAME_MAX, },
+	[DRBD2_A_NET_CONF_VERIFY_ALG] = { .type = NLA_NUL_STRING, .len = DRBD2_ALG_NAME_MAX, },
+	[DRBD2_A_NET_CONF_CSUMS_ALG] = { .type = NLA_NUL_STRING, .len = DRBD2_ALG_NAME_MAX, },
+	[DRBD2_A_NET_CONF_PROTOCOL] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
+	[DRBD2_A_NET_CONF_CONNECT_INT] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_TIMEOUT] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_PING_INT] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_PING_TIMEO] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_SNDBUF_SIZE] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_RCVBUF_SIZE] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_KO_COUNT] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_MAX_EPOCH_SIZE] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_AFTER_SB_0PRI] = NLA_POLICY_MAX(NLA_U32, 12),
+	[DRBD2_A_NET_CONF_AFTER_SB_1PRI] = NLA_POLICY_MAX(NLA_U32, 12),
+	[DRBD2_A_NET_CONF_AFTER_SB_2PRI] = NLA_POLICY_MAX(NLA_U32, 12),
+	[DRBD2_A_NET_CONF_RR_CONFLICT] = NLA_POLICY_MAX(NLA_U32, 12),
+	[DRBD2_A_NET_CONF_ON_CONGESTION] = NLA_POLICY_MAX(NLA_U32, 2),
+	[DRBD2_A_NET_CONF_CONG_FILL] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_CONG_EXTENTS] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_TWO_PRIMARIES] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_TCP_CORK] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_ALWAYS_ASBP] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_USE_RLE] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_FENCING] = NLA_POLICY_MAX(NLA_U32, 2),
+	[DRBD2_A_NET_CONF_CONNECTION_NAME] = { .type = NLA_NUL_STRING, .len = DRBD2_CONNECTION_NAME_MAX, },
+	[DRBD2_A_NET_CONF_CSUMS_AFTER_CRASH_ONLY] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_SOCK_CHECK_TIMEO] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, .len = DRBD2_TRANSPORT_NAME_MAX, },
+	[DRBD2_A_NET_CONF_MAX_BUFFERS] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_ALLOW_REMOTE_READ] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_TLS] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_TLS_PRIVKEY] = { .type = NLA_S32, },
+	[DRBD2_A_NET_CONF_TLS_CERTIFICATE] = { .type = NLA_S32, },
+	[DRBD2_A_NET_CONF_TLS_KEYRING] = { .type = NLA_S32, },
+	[DRBD2_A_NET_CONF_LOAD_BALANCE_PATHS] = { .type = NLA_U8, },
+	[DRBD2_A_NET_CONF_RDMA_CTRL_RCVBUF_SIZE] = { .type = NLA_U32, },
+	[DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE] = { .type = NLA_U32, },
+};
+
+const struct nla_policy drbd2_new_current_uuid_parms_nl_policy[DRBD2_A_NEW_CURRENT_UUID_PARMS_FORCE_RESYNC + 1] = {
+	[DRBD2_A_NEW_CURRENT_UUID_PARMS_CLEAR_BM] = { .type = NLA_FLAG, },
+	[DRBD2_A_NEW_CURRENT_UUID_PARMS_FORCE_RESYNC] = { .type = NLA_FLAG, },
+};
+
+const struct nla_policy drbd2_peer_device_conf_nl_policy[DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER + 1] = {
+	[DRBD2_A_PEER_DEVICE_CONF_RESYNC_RATE] = { .type = NLA_U32, },
+	[DRBD2_A_PEER_DEVICE_CONF_C_PLAN_AHEAD] = { .type = NLA_U32, },
+	[DRBD2_A_PEER_DEVICE_CONF_C_DELAY_TARGET] = { .type = NLA_U32, },
+	[DRBD2_A_PEER_DEVICE_CONF_C_FILL_TARGET] = { .type = NLA_U32, },
+	[DRBD2_A_PEER_DEVICE_CONF_C_MAX_RATE] = { .type = NLA_U32, },
+	[DRBD2_A_PEER_DEVICE_CONF_C_MIN_RATE] = { .type = NLA_U32, },
+	[DRBD2_A_PEER_DEVICE_CONF_BITMAP] = { .type = NLA_U8, },
+	[DRBD2_A_PEER_DEVICE_CONF_RESYNC_WITHOUT_REPLICATION] = { .type = NLA_U8, },
+	[DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER] = { .type = NLA_U8, },
+};
+
+const struct nla_policy drbd2_rename_parms_nl_policy[DRBD2_A_RENAME_PARMS_NEW_NAME + 1] = {
+	[DRBD2_A_RENAME_PARMS_NEW_NAME] = { .type = NLA_NUL_STRING, .len = DRBD2_RESOURCE_NAME_MAX, },
+};
+
+const struct nla_policy drbd2_resize_parms_nl_policy[DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE + 1] = {
+	[DRBD2_A_RESIZE_PARMS_SIZE] = { .type = NLA_U64, },
+	[DRBD2_A_RESIZE_PARMS_ASSUME_PEER_HAS_SPACE] = { .type = NLA_FLAG, },
+	[DRBD2_A_RESIZE_PARMS_ASSUME_CLEAN] = { .type = NLA_FLAG, },
+	[DRBD2_A_RESIZE_PARMS_AL_STRIPES] = { .type = NLA_U32, },
+	[DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE] = { .type = NLA_U32, },
+};
+
+const struct nla_policy drbd2_resource_opts_nl_policy[DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT + 1] = {
+	[DRBD2_A_RESOURCE_OPTS_CPU_MASK] = { .type = NLA_NUL_STRING, .len = DRBD2_CPU_MASK_SIZE, },
+	[DRBD2_A_RESOURCE_OPTS_ON_NO_DATA_ACCESSIBLE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE] = { .type = NLA_U8, },
+	[DRBD2_A_RESOURCE_OPTS_NODE_ID] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_PEER_ACK_WINDOW] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_TWOPC_TIMEOUT] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_TWOPC_RETRY_TIMEOUT] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_PEER_ACK_DELAY] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE_TIMEOUT] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_MAX_IO_DEPTH] = { .type = NLA_U32, },
+	[DRBD2_A_RESOURCE_OPTS_QUORUM] = { .type = NLA_S32, },
+	[DRBD2_A_RESOURCE_OPTS_ON_NO_QUORUM] = NLA_POLICY_MAX(NLA_U32, 1),
+	[DRBD2_A_RESOURCE_OPTS_QUORUM_MIN_REDUNDANCY] = { .type = NLA_S32, },
+	[DRBD2_A_RESOURCE_OPTS_ON_SUSPENDED_PRIMARY_OUTDATED] = NLA_POLICY_MAX(NLA_U32, 1),
+	[DRBD2_A_RESOURCE_OPTS_DRBD8_COMPAT_MODE] = { .type = NLA_U8, },
+	[DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT] = { .type = NLA_U8, },
+};
+
+const struct nla_policy drbd2_set_role_parms_nl_policy[DRBD2_A_SET_ROLE_PARMS_FORCE + 1] = {
+	[DRBD2_A_SET_ROLE_PARMS_FORCE] = { .type = NLA_FLAG, },
+};
+
+const struct nla_policy drbd2_start_ov_parms_nl_policy[DRBD2_A_START_OV_PARMS_STOP_SECTOR + 1] = {
+	[DRBD2_A_START_OV_PARMS_START_SECTOR] = { .type = NLA_U64, },
+	[DRBD2_A_START_OV_PARMS_STOP_SECTOR] = { .type = NLA_U64, },
+};
+
+const struct nla_policy drbd2_suspend_io_parms_nl_policy[DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE + 1] = {
+	[DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE] = { .type = NLA_U8, },
+};
+
+/* DRBD2_CMD_RESOURCE_NEW - do */
+static const struct nla_policy drbd2_resource_new_nl_policy[DRBD2_A_RESOURCE_OPTS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_RESOURCE_OPTS] = NLA_POLICY_NESTED(drbd2_resource_opts_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_DEL - do */
+static const struct nla_policy drbd2_resource_del_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_SET - do */
+static const struct nla_policy drbd2_resource_set_nl_policy[DRBD2_A_RESOURCE_OPTS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_RESOURCE_OPTS] = NLA_POLICY_NESTED(drbd2_resource_opts_nl_policy),
+	[DRBD2_A_SET_DEFAULTS] = { .type = NLA_FLAG, },
+};
+
+/* DRBD2_CMD_RESOURCE_RENAME - do */
+static const struct nla_policy drbd2_resource_rename_nl_policy[DRBD2_A_RENAME_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_RENAME_PARMS] = NLA_POLICY_NESTED(drbd2_rename_parms_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_DOWN - do */
+static const struct nla_policy drbd2_resource_down_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_PRIMARY - do */
+static const struct nla_policy drbd2_resource_primary_nl_policy[DRBD2_A_SET_ROLE_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_SET_ROLE_PARMS] = NLA_POLICY_NESTED(drbd2_set_role_parms_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_SECONDARY - do */
+static const struct nla_policy drbd2_resource_secondary_nl_policy[DRBD2_A_SET_ROLE_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_SET_ROLE_PARMS] = NLA_POLICY_NESTED(drbd2_set_role_parms_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_SUSPEND_IO - do */
+static const struct nla_policy drbd2_resource_suspend_io_nl_policy[DRBD2_A_SUSPEND_IO_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_SUSPEND_IO_PARMS] = NLA_POLICY_NESTED(drbd2_suspend_io_parms_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_RESUME_IO - do */
+static const struct nla_policy drbd2_resource_resume_io_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_NEW - do */
+static const struct nla_policy drbd2_device_new_nl_policy[DRBD2_A_DEVICE_CONF + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_DEVICE_CONF] = NLA_POLICY_NESTED(drbd2_device_conf_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_DEL - do */
+static const struct nla_policy drbd2_device_del_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_ATTACH - do */
+static const struct nla_policy drbd2_device_attach_nl_policy[DRBD2_A_DISK_CONF + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_DISK_CONF] = NLA_POLICY_NESTED(drbd2_disk_conf_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_DETACH - do */
+static const struct nla_policy drbd2_device_detach_nl_policy[DRBD2_A_DETACH_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_DETACH_PARMS] = NLA_POLICY_NESTED(drbd2_detach_parms_nl_policy),
+};
+
+/* DRBD2_CMD_DISK_SET - do */
+static const struct nla_policy drbd2_disk_set_nl_policy[DRBD2_A_DISK_CONF + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_DISK_CONF] = NLA_POLICY_NESTED(drbd2_disk_conf_nl_policy),
+	[DRBD2_A_SET_DEFAULTS] = { .type = NLA_FLAG, },
+};
+
+/* DRBD2_CMD_DEVICE_RESIZE - do */
+static const struct nla_policy drbd2_device_resize_nl_policy[DRBD2_A_RESIZE_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_RESIZE_PARMS] = NLA_POLICY_NESTED(drbd2_resize_parms_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_OUTDATE - do */
+static const struct nla_policy drbd2_device_outdate_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_INVALIDATE - do */
+static const struct nla_policy drbd2_device_invalidate_nl_policy[DRBD2_A_INVALIDATE_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_INVALIDATE_PARMS] = NLA_POLICY_NESTED(drbd2_invalidate_parms_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_NEW_CURRENT_UUID - do */
+static const struct nla_policy drbd2_device_new_current_uuid_nl_policy[DRBD2_A_NEW_CURRENT_UUID_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_NEW_CURRENT_UUID_PARMS] = NLA_POLICY_NESTED(drbd2_new_current_uuid_parms_nl_policy),
+};
+
+/* DRBD2_CMD_CONNECTION_NEW - do */
+static const struct nla_policy drbd2_connection_new_nl_policy[DRBD2_A_NET_CONF + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_NET_CONF] = NLA_POLICY_NESTED(drbd2_net_conf_nl_policy),
+};
+
+/* DRBD2_CMD_CONNECTION_DEL - do */
+static const struct nla_policy drbd2_connection_del_nl_policy[DRBD2_A_DISCONNECT_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_DISCONNECT_PARMS] = NLA_POLICY_NESTED(drbd2_disconnect_parms_nl_policy),
+};
+
+/* DRBD2_CMD_CONNECTION_CONNECT - do */
+static const struct nla_policy drbd2_connection_connect_nl_policy[DRBD2_A_CONNECT_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_CONNECT_PARMS] = NLA_POLICY_NESTED(drbd2_connect_parms_nl_policy),
+};
+
+/* DRBD2_CMD_CONNECTION_DISCONNECT - do */
+static const struct nla_policy drbd2_connection_disconnect_nl_policy[DRBD2_A_DISCONNECT_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_DISCONNECT_PARMS] = NLA_POLICY_NESTED(drbd2_disconnect_parms_nl_policy),
+};
+
+/* DRBD2_CMD_CONNECTION_SET - do */
+static const struct nla_policy drbd2_connection_set_nl_policy[DRBD2_A_NET_CONF + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_NET_CONF] = NLA_POLICY_NESTED(drbd2_net_conf_nl_policy),
+	[DRBD2_A_SET_DEFAULTS] = { .type = NLA_FLAG, },
+};
+
+/* DRBD2_CMD_CONNECTION_FORGET - do */
+static const struct nla_policy drbd2_connection_forget_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PATH_NEW - do */
+static const struct nla_policy drbd2_path_new_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PATH_DEL - do */
+static const struct nla_policy drbd2_path_del_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PEER_DEVICE_SET - do */
+static const struct nla_policy drbd2_peer_device_set_nl_policy[DRBD2_A_PEER_DEVICE_CONF + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_PEER_DEVICE_CONF] = NLA_POLICY_NESTED(drbd2_peer_device_conf_nl_policy),
+	[DRBD2_A_SET_DEFAULTS] = { .type = NLA_FLAG, },
+};
+
+/* DRBD2_CMD_PEER_DEVICE_INVALIDATE - do */
+static const struct nla_policy drbd2_peer_device_invalidate_nl_policy[DRBD2_A_INVALIDATE_PEER_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_INVALIDATE_PEER_PARMS] = NLA_POLICY_NESTED(drbd2_invalidate_peer_parms_nl_policy),
+};
+
+/* DRBD2_CMD_PEER_DEVICE_PAUSE_SYNC - do */
+static const struct nla_policy drbd2_peer_device_pause_sync_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PEER_DEVICE_RESUME_SYNC - do */
+static const struct nla_policy drbd2_peer_device_resume_sync_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PEER_DEVICE_START_OV - do */
+static const struct nla_policy drbd2_peer_device_start_ov_nl_policy[DRBD2_A_START_OV_PARMS + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+	[DRBD2_A_START_OV_PARMS] = NLA_POLICY_NESTED(drbd2_start_ov_parms_nl_policy),
+};
+
+/* DRBD2_CMD_TIMEOUT_TYPE_GET - do */
+static const struct nla_policy drbd2_timeout_type_get_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_RESOURCE_GET - dump */
+static const struct nla_policy drbd2_resource_get_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_DEVICE_GET - dump */
+static const struct nla_policy drbd2_device_get_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_CONNECTION_GET - dump */
+static const struct nla_policy drbd2_connection_get_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PEER_DEVICE_GET - dump */
+static const struct nla_policy drbd2_peer_device_get_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* DRBD2_CMD_PATH_GET - dump */
+static const struct nla_policy drbd2_path_get_nl_policy[DRBD2_A_CONTEXT + 1] = {
+	[DRBD2_A_CONTEXT] = NLA_POLICY_NESTED(drbd2_context_nl_policy),
+};
+
+/* Ops table for drbd2 */
+static const struct genl_split_ops drbd2_nl_ops[] = {
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_NEW,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_new_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_new_nl_policy,
+		.maxattr	= DRBD2_A_RESOURCE_OPTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_DEL,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_del_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_del_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_SET,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_set_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_set_nl_policy,
+		.maxattr	= DRBD2_A_RESOURCE_OPTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_RENAME,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_rename_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_rename_nl_policy,
+		.maxattr	= DRBD2_A_RENAME_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_DOWN,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_down_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_down_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_PRIMARY,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_primary_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_primary_nl_policy,
+		.maxattr	= DRBD2_A_SET_ROLE_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_SECONDARY,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_secondary_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_secondary_nl_policy,
+		.maxattr	= DRBD2_A_SET_ROLE_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_SUSPEND_IO,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_suspend_io_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_suspend_io_nl_policy,
+		.maxattr	= DRBD2_A_SUSPEND_IO_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_RESUME_IO,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_resource_resume_io_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_resource_resume_io_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_NEW,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_new_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_new_nl_policy,
+		.maxattr	= DRBD2_A_DEVICE_CONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_DEL,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_del_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_del_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_ATTACH,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_attach_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_attach_nl_policy,
+		.maxattr	= DRBD2_A_DISK_CONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_DETACH,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_detach_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_detach_nl_policy,
+		.maxattr	= DRBD2_A_DETACH_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DISK_SET,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_disk_set_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_disk_set_nl_policy,
+		.maxattr	= DRBD2_A_DISK_CONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_RESIZE,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_resize_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_resize_nl_policy,
+		.maxattr	= DRBD2_A_RESIZE_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_OUTDATE,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_outdate_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_outdate_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_INVALIDATE,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_invalidate_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_invalidate_nl_policy,
+		.maxattr	= DRBD2_A_INVALIDATE_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_NEW_CURRENT_UUID,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_device_new_current_uuid_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_device_new_current_uuid_nl_policy,
+		.maxattr	= DRBD2_A_NEW_CURRENT_UUID_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_NEW,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_connection_new_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_connection_new_nl_policy,
+		.maxattr	= DRBD2_A_NET_CONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_DEL,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_connection_del_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_connection_del_nl_policy,
+		.maxattr	= DRBD2_A_DISCONNECT_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_CONNECT,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_connection_connect_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_connection_connect_nl_policy,
+		.maxattr	= DRBD2_A_CONNECT_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_DISCONNECT,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_connection_disconnect_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_connection_disconnect_nl_policy,
+		.maxattr	= DRBD2_A_DISCONNECT_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_SET,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_connection_set_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_connection_set_nl_policy,
+		.maxattr	= DRBD2_A_NET_CONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_FORGET,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_connection_forget_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_connection_forget_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PATH_NEW,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_path_new_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_path_new_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PATH_DEL,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_path_del_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_path_del_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PEER_DEVICE_SET,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_peer_device_set_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_peer_device_set_nl_policy,
+		.maxattr	= DRBD2_A_PEER_DEVICE_CONF,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PEER_DEVICE_INVALIDATE,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_peer_device_invalidate_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_peer_device_invalidate_nl_policy,
+		.maxattr	= DRBD2_A_INVALIDATE_PEER_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PEER_DEVICE_PAUSE_SYNC,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_peer_device_pause_sync_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_peer_device_pause_sync_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PEER_DEVICE_RESUME_SYNC,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_peer_device_resume_sync_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_peer_device_resume_sync_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_PEER_DEVICE_START_OV,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_peer_device_start_ov_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_peer_device_start_ov_nl_policy,
+		.maxattr	= DRBD2_A_START_OV_PARMS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_TIMEOUT_TYPE_GET,
+		.pre_doit	= drbd2_pre_doit,
+		.doit		= drbd2_nl_timeout_type_get_doit,
+		.post_doit	= drbd2_post_doit,
+		.policy		= drbd2_timeout_type_get_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRBD2_CMD_RESOURCE_GET,
+		.dumpit		= drbd2_nl_resource_get_dumpit,
+		.policy		= drbd2_resource_get_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRBD2_CMD_DEVICE_GET,
+		.dumpit		= drbd2_nl_device_get_dumpit,
+		.done		= drbd2_nl_device_get_done,
+		.policy		= drbd2_device_get_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRBD2_CMD_CONNECTION_GET,
+		.dumpit		= drbd2_nl_connection_get_dumpit,
+		.done		= drbd2_nl_connection_get_done,
+		.policy		= drbd2_connection_get_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRBD2_CMD_PEER_DEVICE_GET,
+		.dumpit		= drbd2_nl_peer_device_get_dumpit,
+		.done		= drbd2_nl_peer_device_get_done,
+		.policy		= drbd2_peer_device_get_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRBD2_CMD_PATH_GET,
+		.dumpit		= drbd2_nl_path_get_dumpit,
+		.done		= drbd2_nl_path_get_done,
+		.policy		= drbd2_path_get_nl_policy,
+		.maxattr	= DRBD2_A_CONTEXT,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd	= DRBD2_CMD_STATE_GET,
+		.dumpit	= drbd2_nl_state_get_dumpit,
+		.done	= drbd2_nl_state_get_done,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+};
+
+static const struct genl_multicast_group drbd2_nl_mcgrps[] = {
+	[DRBD2_NLGRP_EVENTS] = { "events", },
+};
+
+struct genl_family drbd2_nl_family __ro_after_init = {
+	.name		= DRBD2_FAMILY_NAME,
+	.version	= DRBD2_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= drbd2_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(drbd2_nl_ops),
+	.mcgrps		= drbd2_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(drbd2_nl_mcgrps),
+};
diff --git a/drivers/block/drbd/drbd2_nl_gen.h b/drivers/block/drbd/drbd2_nl_gen.h
new file mode 100644
index 000000000000..fd586cf317da
--- /dev/null
+++ b/drivers/block/drbd/drbd2_nl_gen.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drbd2.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_DRBD2_GEN_H
+#define _LINUX_DRBD2_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/drbd2.h>
+
+/* Common nested types */
+extern const struct nla_policy drbd2_address_nl_policy[DRBD2_A_ADDRESS_IPV6 + 1];
+extern const struct nla_policy drbd2_connect_parms_nl_policy[DRBD2_A_CONNECT_PARMS_DISCARD_MY_DATA + 1];
+extern const struct nla_policy drbd2_context_nl_policy[DRBD2_A_CONTEXT_PEER_ADDRESS + 1];
+extern const struct nla_policy drbd2_detach_parms_nl_policy[DRBD2_A_DETACH_PARMS_INTENTIONAL_DISKLESS_DETACH + 1];
+extern const struct nla_policy drbd2_device_conf_nl_policy[DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY + 1];
+extern const struct nla_policy drbd2_disconnect_parms_nl_policy[DRBD2_A_DISCONNECT_PARMS_FORCE + 1];
+extern const struct nla_policy drbd2_disk_conf_nl_policy[DRBD2_A_DISK_CONF_BITMAP + 1];
+extern const struct nla_policy drbd2_invalidate_parms_nl_policy[DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP + 1];
+extern const struct nla_policy drbd2_invalidate_peer_parms_nl_policy[DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP + 1];
+extern const struct nla_policy drbd2_net_conf_nl_policy[DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE + 1];
+extern const struct nla_policy drbd2_new_current_uuid_parms_nl_policy[DRBD2_A_NEW_CURRENT_UUID_PARMS_FORCE_RESYNC + 1];
+extern const struct nla_policy drbd2_peer_device_conf_nl_policy[DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER + 1];
+extern const struct nla_policy drbd2_rename_parms_nl_policy[DRBD2_A_RENAME_PARMS_NEW_NAME + 1];
+extern const struct nla_policy drbd2_resize_parms_nl_policy[DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE + 1];
+extern const struct nla_policy drbd2_resource_opts_nl_policy[DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT + 1];
+extern const struct nla_policy drbd2_set_role_parms_nl_policy[DRBD2_A_SET_ROLE_PARMS_FORCE + 1];
+extern const struct nla_policy drbd2_start_ov_parms_nl_policy[DRBD2_A_START_OV_PARMS_STOP_SECTOR + 1];
+extern const struct nla_policy drbd2_suspend_io_parms_nl_policy[DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE + 1];
+
+int drbd2_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+void
+drbd2_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		struct genl_info *info);
+int drbd2_nl_device_get_done(struct netlink_callback *cb);
+int drbd2_nl_connection_get_done(struct netlink_callback *cb);
+int drbd2_nl_peer_device_get_done(struct netlink_callback *cb);
+int drbd2_nl_path_get_done(struct netlink_callback *cb);
+int drbd2_nl_state_get_done(struct netlink_callback *cb);
+
+int drbd2_nl_resource_new_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_del_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_rename_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_down_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_primary_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_secondary_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+int drbd2_nl_resource_suspend_io_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int drbd2_nl_resource_resume_io_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+int drbd2_nl_device_new_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_device_del_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_device_attach_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_device_detach_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_disk_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_device_resize_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_device_outdate_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_device_invalidate_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int drbd2_nl_device_new_current_uuid_doit(struct sk_buff *skb,
+					  struct genl_info *info);
+int drbd2_nl_connection_new_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_connection_del_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_connection_connect_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+int drbd2_nl_connection_disconnect_doit(struct sk_buff *skb,
+					struct genl_info *info);
+int drbd2_nl_connection_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_connection_forget_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int drbd2_nl_path_new_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_path_del_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_peer_device_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_peer_device_invalidate_doit(struct sk_buff *skb,
+					 struct genl_info *info);
+int drbd2_nl_peer_device_pause_sync_doit(struct sk_buff *skb,
+					 struct genl_info *info);
+int drbd2_nl_peer_device_resume_sync_doit(struct sk_buff *skb,
+					  struct genl_info *info);
+int drbd2_nl_peer_device_start_ov_doit(struct sk_buff *skb,
+				       struct genl_info *info);
+int drbd2_nl_timeout_type_get_doit(struct sk_buff *skb, struct genl_info *info);
+int drbd2_nl_resource_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb);
+int drbd2_nl_device_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
+int drbd2_nl_connection_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
+int drbd2_nl_peer_device_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
+int drbd2_nl_path_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd2_nl_state_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+
+enum {
+	DRBD2_NLGRP_EVENTS,
+};
+
+extern struct genl_family drbd2_nl_family;
+
+#endif /* _LINUX_DRBD2_GEN_H */
diff --git a/drivers/block/drbd/drbd_nl_drbd2.c b/drivers/block/drbd/drbd_nl_drbd2.c
new file mode 100644
index 000000000000..89fe5810ab17
--- /dev/null
+++ b/drivers/block/drbd/drbd_nl_drbd2.c
@@ -0,0 +1,2533 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, LINBIT HA-Solutions GmbH.
+ */
+
+/*
+ * The "drbd2" generic netlink family: everything that knows about the
+ * bytes on the wire of that dialect. The command implementations
+ * themselves live in drbd_nl.c and only ever see a struct drbd_adm_ctx.
+ *
+ * Unlike the legacy "drbd" family, drbd2 has no fixed message header and
+ * no place to carry a drbd_ret_code, so the outcome of a request is split
+ * in two, as the specification prescribes:
+ *
+ *   - A state change reports its drbd_state_rv in the state-result
+ *     attribute of the reply, together with the accumulated info messages
+ *     in message. A refused state change is data, not a transport error.
+ *   - Everything that failed for a configuration reason (the ERR_* codes)
+ *     becomes an errno plus a description in the extended ACK, and no
+ *     reply is sent at all.
+ *
+ * The description in the extended ACK is the command's own account of the
+ * failure where it left one -- the first of the info messages the core
+ * collected, formatted into the ACK's buffer so that it outlives the
+ * command context -- and the generic text of the ERR_* code otherwise.
+ * Failures that are about one attribute of the request also name that
+ * attribute, the way the netlink policy checks do. Further info messages
+ * are lost on the errno path; the reply of a completed command carries
+ * them all.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <linux/drbd.h>
+#include "drbd2_nl_gen.h"
+#include <net/genetlink.h>
+#include <net/sock.h>
+
+#include "drbd_int.h"
+#include "drbd_nl.h"
+
+static const struct drbd_nl_dialect drbd2_dialect;
+
+/* Per-request state of the drbd2 dialect; hangs off drbd_adm_ctx.req. */
+struct drbd2_req {
+	struct genl_info *info;
+	struct sk_buff *reply_skb;
+	void *reply_hdr;
+	/* the command filled the reply itself; do not add state-result */
+	bool payload_reply;
+};
+
+/* One allocation for both, so that pre_doit zeroes the context only once. */
+struct drbd2_ctx {
+	struct drbd_adm_ctx ctx;
+	struct drbd2_req req;
+};
+
+static inline struct drbd2_req *drbd2_req(struct drbd_adm_ctx *ctx)
+{
+	return ctx->req;
+}
+
+/*
+ * drbd2 numbers its attributes from 1, so attribute 0 is free to serve as
+ * the padding attribute of the 64 bit values, the same way the legacy
+ * marshalling code uses it.
+ */
+#define DRBD2_A_PAD	0
+
+static int drbd2_put_u64(struct sk_buff *skb, int attrtype, u64 value)
+{
+	return nla_put_u64_64bit(skb, attrtype, value, DRBD2_A_PAD);
+}
+
+/*
+ * The internal string buffers carry an explicit length and are
+ * NUL-terminated unless they are completely full; emit them including
+ * that terminating NUL, as the drbd2 policies expect.
+ */
+static int drbd2_put_str(struct sk_buff *skb, int attrtype,
+			 const char *val, u32 len, u32 size)
+{
+	return nla_put(skb, attrtype, min_t(u32, size, len + (len < size)), val);
+}
+
+/* A socket address as the address nest of "attrtype". */
+static int drbd2_put_address(struct sk_buff *skb, int attrtype,
+			     const struct sockaddr_storage *addr)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u16(skb, DRBD2_A_ADDRESS_FAMILY, addr->ss_family))
+		goto fail;
+	switch (addr->ss_family) {
+	case AF_INET: {
+		const struct sockaddr_in *sin = (const struct sockaddr_in *)addr;
+
+		if (nla_put_be16(skb, DRBD2_A_ADDRESS_PORT, sin->sin_port) ||
+		    nla_put_be32(skb, DRBD2_A_ADDRESS_IPV4, sin->sin_addr.s_addr))
+			goto fail;
+		break;
+	}
+	case AF_INET6: {
+		const struct sockaddr_in6 *sin6 = (const struct sockaddr_in6 *)addr;
+
+		if (nla_put_be16(skb, DRBD2_A_ADDRESS_PORT, sin6->sin6_port) ||
+		    nla_put(skb, DRBD2_A_ADDRESS_IPV6,
+			    sizeof(sin6->sin6_addr), &sin6->sin6_addr))
+			goto fail;
+		break;
+	}
+	default:
+		/* the family alone is all this dialect can say about it */
+		break;
+	}
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+/*
+ * The reverse: one address nest into the sockaddr_storage the transports
+ * work with. Returns -ENOMSG if the nest does not describe an address of
+ * a family this dialect knows.
+ */
+static int drbd2_get_address(const struct nlattr *nla, char *dst, __u32 *dst_len)
+{
+	struct nlattr *tb[DRBD2_A_ADDRESS_IPV6 + 1];
+	int err;
+
+	err = nla_parse_nested(tb, DRBD2_A_ADDRESS_IPV6, nla,
+			       drbd2_address_nl_policy, NULL);
+	if (err)
+		return err;
+	if (!tb[DRBD2_A_ADDRESS_FAMILY] || !tb[DRBD2_A_ADDRESS_PORT])
+		return -ENOMSG;
+
+	switch (nla_get_u16(tb[DRBD2_A_ADDRESS_FAMILY])) {
+	case AF_INET: {
+		struct sockaddr_in sin = { .sin_family = AF_INET };
+
+		if (!tb[DRBD2_A_ADDRESS_IPV4])
+			return -ENOMSG;
+		sin.sin_port = nla_get_be16(tb[DRBD2_A_ADDRESS_PORT]);
+		sin.sin_addr.s_addr = nla_get_be32(tb[DRBD2_A_ADDRESS_IPV4]);
+		memcpy(dst, &sin, sizeof(sin));
+		*dst_len = sizeof(sin);
+		return 0;
+	}
+	case AF_INET6: {
+		struct sockaddr_in6 sin6 = { .sin6_family = AF_INET6 };
+
+		if (!tb[DRBD2_A_ADDRESS_IPV6])
+			return -ENOMSG;
+		sin6.sin6_port = nla_get_be16(tb[DRBD2_A_ADDRESS_PORT]);
+		memcpy(&sin6.sin6_addr, nla_data(tb[DRBD2_A_ADDRESS_IPV6]),
+		       sizeof(sin6.sin6_addr));
+		memcpy(dst, &sin6, sizeof(sin6));
+		*dst_len = sizeof(sin6);
+		return 0;
+	}
+	}
+	return -ENOMSG;
+}
+
+static int drbd2_genl_multicast_events(struct sk_buff *skb)
+{
+	return genlmsg_multicast_allns(&drbd2_nl_family, skb, 0,
+				       DRBD2_NLGRP_EVENTS);
+}
+
+/*
+ * The ERR_* codes of the command core translated into what a modern
+ * netlink family reports: an errno and a description for the extended
+ * ACK. The texts are the ones drbdsetup prints for the legacy family.
+ */
+static const struct {
+	int err;
+	const char *msg;
+} drbd2_error_map[AFTER_LAST_ERR_CODE] = {
+	[ERR_LOCAL_ADDR] = { -EADDRINUSE, "local address(port) already in use" },
+	[ERR_PEER_ADDR] = { -EADDRINUSE, "remote address(port) already in use" },
+	[ERR_OPEN_DISK] = { -ENOENT, "can not open backing device" },
+	[ERR_OPEN_MD_DISK] = { -ENOENT, "can not open meta device" },
+	[ERR_DISK_NOT_BDEV] = { -ENOTBLK, "lower device is not a block device" },
+	[ERR_MD_NOT_BDEV] = { -ENOTBLK, "meta device is not a block device" },
+	[ERR_DISK_TOO_SMALL] = { -ENOSPC, "lower device smaller than the requested size" },
+	[ERR_MD_DISK_TOO_SMALL] = { -ENOSPC, "meta device too small" },
+	[ERR_BDCLAIM_DISK] = { -EBUSY, "lower device is already claimed" },
+	[ERR_BDCLAIM_MD_DISK] = { -EBUSY, "meta device is already claimed" },
+	[ERR_MD_IDX_INVALID] = { -EINVAL,
+		"lower device / meta device / index combination invalid" },
+	[ERR_IO_MD_DISK] = { -EIO, "I/O error during initial access to meta-data" },
+	[ERR_MD_INVALID] = { -EINVAL, "no valid meta-data signature found" },
+	[ERR_AUTH_ALG] = { -EINVAL, "cram-hmac-alg not known to the kernel" },
+	[ERR_AUTH_ALG_ND] = { -EINVAL, "cram-hmac-alg is not a digest" },
+	[ERR_NOMEM] = { -ENOMEM, "out of memory" },
+	[ERR_DISCARD_IMPOSSIBLE] = { -EINVAL, "discard-my-data not allowed when primary" },
+	[ERR_DISK_CONFIGURED] = { -EEXIST, "device is attached to a disk" },
+	[ERR_NET_CONFIGURED] = { -EEXIST, "connection has a net-config" },
+	[ERR_MANDATORY_TAG] = { -EINVAL, "invalid or missing attribute" },
+	[ERR_MINOR_INVALID] = { -ENOENT, "device minor not allocated" },
+	[ERR_INTR] = { -EINTR, "interrupted by signal" },
+	[ERR_RESIZE_RESYNC] = { -EBUSY, "resize not allowed during resync" },
+	[ERR_NO_PRIMARY] = { -EINVAL, "need one primary node to resize" },
+	[ERR_RESYNC_AFTER] = { -EINVAL, "the resync-after minor number is invalid" },
+	[ERR_RESYNC_AFTER_CYCLE] = { -EINVAL, "this would cause a resync-after dependency cycle" },
+	[ERR_PAUSE_IS_SET] = { -EALREADY, "sync-pause flag is already set" },
+	[ERR_PAUSE_IS_CLEAR] = { -EALREADY, "sync-pause flag is already cleared" },
+	[ERR_PACKET_NR] = { -EPROTO, "kernel does not know how to handle this request" },
+	[ERR_NO_DISK] = { -ENODEV, "device does not have a disk-config" },
+	[ERR_NOT_PROTO_C] = { -EINVAL, "protocol C required" },
+	[ERR_NOMEM_BITMAP] = { -ENOMEM, "out of memory for the bitmap" },
+	[ERR_INTEGRITY_ALG] = { -EINVAL, "data-integrity-alg not known to the kernel" },
+	[ERR_INTEGRITY_ALG_ND] = { -EINVAL, "data-integrity-alg is not a digest" },
+	[ERR_CPU_MASK_PARSE] = { -EINVAL, "invalid cpu-mask" },
+	[ERR_CSUMS_ALG] = { -EINVAL, "csums-alg not known to the kernel" },
+	[ERR_CSUMS_ALG_ND] = { -EINVAL, "csums-alg is not a digest" },
+	[ERR_VERIFY_ALG] = { -EINVAL, "verify-alg not known to the kernel" },
+	[ERR_VERIFY_ALG_ND] = { -EINVAL, "verify-alg is not a digest" },
+	[ERR_CSUMS_RESYNC_RUNNING] = { -EBUSY,
+		"can not change csums-alg while resync is in progress" },
+	[ERR_VERIFY_RUNNING] = { -EBUSY, "can not change verify-alg while online verify runs" },
+	[ERR_DATA_NOT_CURRENT] = { -EINVAL, "can only attach to the data we lost last" },
+	[ERR_CONNECTED] = { -EBUSY, "need to be standalone" },
+	[ERR_PERM] = { -EPERM, "permission denied" },
+	[ERR_NEED_APV_93] = { -EOPNOTSUPP, "protocol version 93 required for assume-clean" },
+	[ERR_STONITH_AND_PROT_A] = { -EINVAL,
+		"fencing resource-and-stonith needs protocol B or C" },
+	[ERR_CONG_NOT_PROTO_A] = { -EINVAL, "on-congestion pull-ahead needs protocol A" },
+	[ERR_PIC_AFTER_DEP] = { -EALREADY, "sync-pause is cleared, but a dependency is paused" },
+	[ERR_PIC_PEER_DEP] = { -EALREADY, "sync-pause is cleared, but the peer paused" },
+	[ERR_RES_NOT_KNOWN] = { -ENOENT, "unknown resource" },
+	[ERR_RES_IN_USE] = { -EBUSY, "resource still in use" },
+	[ERR_MINOR_CONFIGURED] = { -EBUSY, "minor still configured" },
+	[ERR_MINOR_OR_VOLUME_EXISTS] = { -EEXIST, "minor or volume exists already" },
+	[ERR_INVALID_REQUEST] = { -EINVAL, "invalid configuration request" },
+	[ERR_NEED_APV_100] = { -EOPNOTSUPP, "protocol version 100 required" },
+	[ERR_NEED_ALLOW_TWO_PRI] = { -EINVAL, "can not clear allow-two-primaries now" },
+	[ERR_MD_UNCLEAN] = { -EINVAL, "unclean meta-data found" },
+	[ERR_MD_LAYOUT_CONNECTED] = { -EBUSY, "online meta-data layout change needs a connection" },
+	[ERR_MD_LAYOUT_TOO_BIG] = { -ENOSPC, "resulting activity log area too big" },
+	[ERR_MD_LAYOUT_TOO_SMALL] = { -ENOSPC, "resulting activity log area too small" },
+	[ERR_MD_LAYOUT_NO_FIT] = { -ENOSPC, "resulting activity log does not fit the meta-data" },
+	[ERR_IMPLICIT_SHRINK] = { -EINVAL, "implicit device shrinking not allowed" },
+	[ERR_INVALID_PEER_NODE_ID] = { -EINVAL, "invalid peer-node-id" },
+	[ERR_CREATE_TRANSPORT] = { -ENOENT, "failed to create transport" },
+	[ERR_LOCAL_AND_PEER_ADDR] = { -EADDRINUSE,
+		"combination of local and remote address already in use" },
+	[ERR_ALREADY_EXISTS] = { -EEXIST, "already exists" },
+	[ERR_APV_TOO_LOW] = { -EOPNOTSUPP, "a higher DRBD protocol level is required" },
+	[ERR_PATH_COLLISION] = { -EEXIST, "path collides with an existing path" },
+};
+
+static bool drbd2_is_ret_code(int result)
+{
+	return result > NO_ERROR && result < AFTER_LAST_ERR_CODE;
+}
+
+/* The errno an ERR_* code becomes on the wire. */
+static int drbd2_errno(int result)
+{
+	if (result == NO_ERROR)
+		return 0;
+	if (!drbd2_is_ret_code(result))
+		return result < 0 ? result : -EINVAL;
+	return drbd2_error_map[result].err ? : -EINVAL;
+}
+
+/*
+ * The request attribute a failure is about, for the codes that are
+ * specific to one: the top level nest and the attribute within it.
+ */
+static const struct {
+	u16 nest;
+	u16 attr;
+} drbd2_error_attr[AFTER_LAST_ERR_CODE] = {
+	[ERR_OPEN_DISK]		= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_BACKING_DEV },
+	[ERR_DISK_NOT_BDEV]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_BACKING_DEV },
+	[ERR_BDCLAIM_DISK]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_BACKING_DEV },
+	[ERR_DISK_TOO_SMALL]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_BACKING_DEV },
+	[ERR_OPEN_MD_DISK]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_META_DEV },
+	[ERR_MD_NOT_BDEV]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_META_DEV },
+	[ERR_BDCLAIM_MD_DISK]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_META_DEV },
+	[ERR_MD_DISK_TOO_SMALL]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_META_DEV },
+	[ERR_MD_IDX_INVALID]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_META_DEV_IDX },
+	[ERR_RESYNC_AFTER]	= { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_RESYNC_AFTER },
+	[ERR_RESYNC_AFTER_CYCLE] = { DRBD2_A_DISK_CONF, DRBD2_A_DISK_CONF_RESYNC_AFTER },
+	[ERR_CPU_MASK_PARSE]	= { DRBD2_A_RESOURCE_OPTS, DRBD2_A_RESOURCE_OPTS_CPU_MASK },
+	[ERR_AUTH_ALG]		= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_CRAM_HMAC_ALG },
+	[ERR_AUTH_ALG_ND]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_CRAM_HMAC_ALG },
+	[ERR_INTEGRITY_ALG]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_INTEGRITY_ALG },
+	[ERR_INTEGRITY_ALG_ND]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_INTEGRITY_ALG },
+	[ERR_VERIFY_ALG]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_VERIFY_ALG },
+	[ERR_VERIFY_ALG_ND]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_VERIFY_ALG },
+	[ERR_VERIFY_RUNNING]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_VERIFY_ALG },
+	[ERR_CSUMS_ALG]		= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_CSUMS_ALG },
+	[ERR_CSUMS_ALG_ND]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_CSUMS_ALG },
+	[ERR_CSUMS_RESYNC_RUNNING] = { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_CSUMS_ALG },
+	[ERR_STONITH_AND_PROT_A] = { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_FENCING },
+	[ERR_CONG_NOT_PROTO_A]	= { DRBD2_A_NET_CONF, DRBD2_A_NET_CONF_ON_CONGESTION },
+	[ERR_INVALID_PEER_NODE_ID] = { DRBD2_A_CONTEXT, DRBD2_A_CONTEXT_PEER_NODE_ID },
+};
+
+/*
+ * Describe a failed command in the extended ACK: its own first info
+ * message if it left one, the generic text of its ERR_* code otherwise,
+ * and the request attribute the failure is about if there is one.
+ */
+static void drbd2_set_extack(struct genl_info *info, struct drbd_adm_ctx *ctx)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	int result = ctx->result;
+	const char *msg = NULL;
+	int len = 0;
+
+	if (!extack)
+		return;
+
+	/* what the command itself said, its first message only */
+	if (ctx->msg_len) {
+		len = strnlen(ctx->msg, ctx->msg_len);
+		while (len && (ctx->msg[len - 1] == '\n' || ctx->msg[len - 1] == ' '))
+			len--;
+		if (len)
+			msg = ctx->msg;
+	}
+	if (!msg) {
+		msg = drbd2_is_ret_code(result) && drbd2_error_map[result].msg ?
+			drbd2_error_map[result].msg : "DRBD command failed";
+		len = strlen(msg);
+	}
+	NL_SET_ERR_MSG_FMT(extack, "%.*s",
+			   min(len, NETLINK_MAX_FMTMSG_LEN - 1), msg);
+
+	if (drbd2_is_ret_code(result) && drbd2_error_attr[result].nest) {
+		struct nlattr *nest = info->attrs[drbd2_error_attr[result].nest];
+		struct nlattr *attr = nest ?
+			nla_find_nested(nest, drbd2_error_attr[result].attr) : NULL;
+
+		if (attr)
+			NL_SET_BAD_ATTR(extack, attr);
+	}
+}
+
+/*
+ * The drbd_state_rv of a completed state change as the state-result
+ * attribute: the error values are the negated SS_* codes, the successful
+ * outcomes follow above them in the order of the enum.
+ */
+static u32 drbd2_state_result(int result)
+{
+	if (result == NO_ERROR)
+		return DRBD2_STATE_RESULT_SUCCESS;
+	if (result >= SS_SUCCESS && result <= SS_CW_NO_NEED)
+		return DRBD2_STATE_RESULT_SUCCESS + (result - SS_SUCCESS);
+	if (result <= SS_UNKNOWN_ERROR && result > SS_AFTER_LAST_ERROR)
+		return -result;
+	return DRBD2_STATE_RESULT_UNKNOWN_ERROR;
+}
+
+/*
+ * The info messages of the command, joined into the one string the
+ * message attribute carries. They are NUL-separated in ctx->msg and this
+ * is their last user, so the separators can be turned into newlines in
+ * place; the final NUL stays and terminates the string.
+ */
+static int drbd2_put_message(struct sk_buff *skb, struct drbd_adm_ctx *ctx)
+{
+	unsigned int i;
+
+	if (!ctx->msg_len)
+		return 0;
+	for (i = 0; i + 1 < ctx->msg_len; i++)
+		if (ctx->msg[i] == '\0')
+			ctx->msg[i] = '\n';
+	return nla_put(skb, DRBD2_A_MESSAGE, ctx->msg_len, ctx->msg);
+}
+
+/*
+ * Serialize the outcome of a completed command into the reply. The state
+ * result always fits into a fresh message; the info text may not, and is
+ * then dropped, exactly as the over-full legacy reply dropped it.
+ */
+static void drbd2_put_outcome(struct drbd_adm_ctx *ctx)
+{
+	struct drbd2_req *req = drbd2_req(ctx);
+
+	if (req->payload_reply)
+		return;
+	if (nla_put_u32(req->reply_skb, DRBD2_A_STATE_RESULT,
+			drbd2_state_result(ctx->result)))
+		return;
+	drbd2_put_message(req->reply_skb, ctx);
+}
+
+/*
+ * The identity of an object, as the context nest of "attrtype". Every
+ * pointer is optional; only the parts that are given are described.
+ */
+static int drbd2_put_context(struct sk_buff *skb, int attrtype,
+			     struct drbd_resource *resource,
+			     struct drbd_connection *connection,
+			     struct drbd_device *device,
+			     struct drbd_path *path)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (resource && nla_put_string(skb, DRBD2_A_CONTEXT_RESOURCE_NAME, resource->name))
+		goto fail;
+	if (device &&
+	    (nla_put_u32(skb, DRBD2_A_CONTEXT_VOLUME, device->vnr) ||
+	     nla_put_u32(skb, DRBD2_A_CONTEXT_MINOR, device->minor)))
+		goto fail;
+	if (connection) {
+		struct drbd_net_conf *nc;
+		int err = 0;
+
+		if (nla_put_u32(skb, DRBD2_A_CONTEXT_PEER_NODE_ID, connection->peer_node_id))
+			goto fail;
+		rcu_read_lock();
+		nc = rcu_dereference(connection->transport.net_conf);
+		if (nc)
+			err = nla_put_string(skb, DRBD2_A_CONTEXT_CONNECTION_NAME, nc->name);
+		rcu_read_unlock();
+		if (err)
+			goto fail;
+	}
+	if (path &&
+	    (drbd2_put_address(skb, DRBD2_A_CONTEXT_MY_ADDRESS, &path->my_addr) ||
+	     drbd2_put_address(skb, DRBD2_A_CONTEXT_PEER_ADDRESS, &path->peer_addr)))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+/*
+ * State and statistics of the five object types. The values of the drbd2
+ * enums are those of the kernel-internal ones, so they go on the wire
+ * unchanged.
+ */
+
+static int drbd2_put_resource_info(struct sk_buff *skb, int attrtype,
+				   struct drbd_resource_info *info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_RESOURCE_INFO_ROLE, info->res_role) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_INFO_SUSP, info->res_susp) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_INFO_SUSP_NOD, info->res_susp_nod) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_INFO_SUSP_FEN, info->res_susp_fen) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_INFO_SUSP_QUORUM, info->res_susp_quorum) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_INFO_FAIL_IO, info->res_fail_io))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_resource_statistics(struct sk_buff *skb, int attrtype,
+					 struct drbd_resource_statistics *s)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_RESOURCE_STATISTICS_WRITE_ORDERING,
+			s->res_stat_write_ordering))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_device_info(struct sk_buff *skb, int attrtype,
+				 struct drbd_device_info *info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_DEVICE_INFO_DISK_STATE, info->dev_disk_state) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_INFO_IS_INTENTIONAL_DISKLESS,
+		       info->is_intentional_diskless) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_INFO_HAS_QUORUM, info->dev_has_quorum) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_INFO_IS_OPEN, info->dev_is_open) ||
+	    drbd2_put_str(skb, DRBD2_A_DEVICE_INFO_BACKING_DEV_PATH,
+			  info->backing_dev_path, info->backing_dev_path_len,
+			  sizeof(info->backing_dev_path)))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_device_statistics(struct sk_buff *skb, int attrtype,
+				       struct drbd_device_statistics *s)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_SIZE, s->dev_size) ||
+	    drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_READ, s->dev_read) ||
+	    drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_WRITE, s->dev_write) ||
+	    drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_AL_WRITES, s->dev_al_writes) ||
+	    drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_BM_WRITES, s->dev_bm_writes) ||
+	    nla_put_u32(skb, DRBD2_A_DEVICE_STATISTICS_UPPER_PENDING, s->dev_upper_pending) ||
+	    nla_put_u32(skb, DRBD2_A_DEVICE_STATISTICS_LOWER_PENDING, s->dev_lower_pending) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_STATISTICS_UPPER_BLOCKED, s->dev_upper_blocked) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_STATISTICS_LOWER_BLOCKED, s->dev_lower_blocked) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_STATISTICS_AL_SUSPENDED, s->dev_al_suspended) ||
+	    drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_EXPOSED_DATA_UUID,
+			  s->dev_exposed_data_uuid) ||
+	    drbd2_put_u64(skb, DRBD2_A_DEVICE_STATISTICS_CURRENT_UUID, s->dev_current_uuid) ||
+	    nla_put_u32(skb, DRBD2_A_DEVICE_STATISTICS_DISK_FLAGS, s->dev_disk_flags) ||
+	    nla_put(skb, DRBD2_A_DEVICE_STATISTICS_HISTORY_UUIDS,
+		    min_t(u32, HISTORY_UUIDS_SIZE, s->history_uuids_len), s->history_uuids))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_connection_info(struct sk_buff *skb, int attrtype,
+				     struct drbd_connection_info *info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_CONNECTION_INFO_CONNECTION_STATE,
+			info->conn_connection_state) ||
+	    nla_put_u32(skb, DRBD2_A_CONNECTION_INFO_ROLE, info->conn_role))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_connection_statistics(struct sk_buff *skb, int attrtype,
+					   struct drbd_connection_statistics *s)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u8(skb, DRBD2_A_CONNECTION_STATISTICS_CONGESTED, s->conn_congested) ||
+	    drbd2_put_u64(skb, DRBD2_A_CONNECTION_STATISTICS_AP_IN_FLIGHT, s->ap_in_flight) ||
+	    drbd2_put_u64(skb, DRBD2_A_CONNECTION_STATISTICS_RS_IN_FLIGHT, s->rs_in_flight))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_peer_device_info(struct sk_buff *skb, int attrtype,
+				      struct drbd_peer_device_info *info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_PEER_DEVICE_INFO_REPL_STATE, info->peer_repl_state) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_INFO_DISK_STATE, info->peer_disk_state) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_USER,
+		       !!info->peer_resync_susp_user) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_PEER,
+		       !!info->peer_resync_susp_peer) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_DEPENDENCY,
+		       !!info->peer_resync_susp_dependency) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_INFO_IS_INTENTIONAL_DISKLESS,
+		       info->peer_is_intentional_diskless) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_MAX_PARALLEL,
+		       !!info->peer_resync_susp_max_parallel))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_peer_device_statistics(struct sk_buff *skb, int attrtype,
+					    struct drbd_peer_device_statistics *s)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RECEIVED, s->peer_dev_received) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_SENT, s->peer_dev_sent) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_STATISTICS_PENDING, s->peer_dev_pending) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_STATISTICS_UNACKED, s->peer_dev_unacked) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_OUT_OF_SYNC,
+			  s->peer_dev_out_of_sync) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RESYNC_FAILED,
+			  s->peer_dev_resync_failed) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_BITMAP_UUID,
+			  s->peer_dev_bitmap_uuid) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_STATISTICS_FLAGS, s->peer_dev_flags) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_TOTAL, s->peer_dev_rs_total) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_OV_START_SECTOR,
+			  s->peer_dev_ov_start_sector) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_OV_STOP_SECTOR,
+			  s->peer_dev_ov_stop_sector) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_OV_POSITION,
+			  s->peer_dev_ov_position) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_OV_LEFT, s->peer_dev_ov_left) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_OV_SKIPPED,
+			  s->peer_dev_ov_skipped) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_SAME_CSUM,
+			  s->peer_dev_rs_same_csum) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_DT_START_MS,
+			  s->peer_dev_rs_dt_start_ms) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_PAUSED_MS,
+			  s->peer_dev_rs_paused_ms) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_DT0_MS,
+			  s->peer_dev_rs_dt0_ms) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_DB0_SECTORS,
+			  s->peer_dev_rs_db0_sectors) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_DT1_MS,
+			  s->peer_dev_rs_dt1_ms) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_DB1_SECTORS,
+			  s->peer_dev_rs_db1_sectors) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_STATISTICS_RS_C_SYNC_RATE,
+			s->peer_dev_rs_c_sync_rate) ||
+	    drbd2_put_u64(skb, DRBD2_A_PEER_DEVICE_STATISTICS_UUID_FLAGS,
+			  s->peer_dev_uuid_flags))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_path_info(struct sk_buff *skb, int attrtype,
+			       struct drbd_nl_path_info *info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u8(skb, DRBD2_A_PATH_INFO_ESTABLISHED, info->path_established))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+/*
+ * The configuration of a live object, for the dumps. The notifications
+ * describe state changes and carry no configuration, so they pass NULL.
+ */
+
+static int drbd2_put_res_opts(struct sk_buff *skb, int attrtype, struct drbd_res_opts *c)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_str(skb, DRBD2_A_RESOURCE_OPTS_CPU_MASK, c->cpu_mask,
+			  c->cpu_mask_len, sizeof(c->cpu_mask)) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_ON_NO_DATA_ACCESSIBLE, c->on_no_data) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE, c->auto_promote) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_NODE_ID, c->node_id) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_PEER_ACK_WINDOW, c->peer_ack_window) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_TWOPC_TIMEOUT, c->twopc_timeout) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_TWOPC_RETRY_TIMEOUT,
+			c->twopc_retry_timeout) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_PEER_ACK_DELAY, c->peer_ack_delay) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE_TIMEOUT,
+			c->auto_promote_timeout) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_MAX_IO_DEPTH, c->nr_requests) ||
+	    nla_put_s32(skb, DRBD2_A_RESOURCE_OPTS_QUORUM, c->quorum) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_ON_NO_QUORUM, c->on_no_quorum) ||
+	    nla_put_s32(skb, DRBD2_A_RESOURCE_OPTS_QUORUM_MIN_REDUNDANCY,
+			c->quorum_min_redundancy) ||
+	    nla_put_u32(skb, DRBD2_A_RESOURCE_OPTS_ON_SUSPENDED_PRIMARY_OUTDATED,
+			c->on_susp_primary_outdated) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_OPTS_DRBD8_COMPAT_MODE, c->drbd8_compat_mode) ||
+	    nla_put_u8(skb, DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT,
+		       c->explicit_drbd8_compat))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_disk_conf(struct sk_buff *skb, int attrtype, struct drbd_disk_conf *c)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_str(skb, DRBD2_A_DISK_CONF_BACKING_DEV, c->backing_dev,
+			  c->backing_dev_len, sizeof(c->backing_dev)) ||
+	    drbd2_put_str(skb, DRBD2_A_DISK_CONF_META_DEV, c->meta_dev,
+			  c->meta_dev_len, sizeof(c->meta_dev)) ||
+	    nla_put_s32(skb, DRBD2_A_DISK_CONF_META_DEV_IDX, c->meta_dev_idx) ||
+	    drbd2_put_u64(skb, DRBD2_A_DISK_CONF_SIZE, c->disk_size) ||
+	    nla_put_u32(skb, DRBD2_A_DISK_CONF_ON_IO_ERROR, c->on_io_error) ||
+	    nla_put_s32(skb, DRBD2_A_DISK_CONF_RESYNC_AFTER, c->resync_after) ||
+	    nla_put_u32(skb, DRBD2_A_DISK_CONF_AL_EXTENTS, c->al_extents) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_DISK_BARRIER, c->disk_barrier) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_DISK_FLUSHES, c->disk_flushes) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_DISK_DRAIN, c->disk_drain) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_MD_FLUSHES, c->md_flushes) ||
+	    nla_put_u32(skb, DRBD2_A_DISK_CONF_DISK_TIMEOUT, c->disk_timeout) ||
+	    nla_put_u32(skb, DRBD2_A_DISK_CONF_READ_BALANCING, c->read_balancing) ||
+	    nla_put_u32(skb, DRBD2_A_DISK_CONF_UNPLUG_WATERMARK, c->unplug_watermark) ||
+	    nla_put_u32(skb, DRBD2_A_DISK_CONF_RS_DISCARD_GRANULARITY,
+			c->rs_discard_granularity) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_AL_UPDATES, c->al_updates) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_DISCARD_ZEROES_IF_ALIGNED,
+		       c->discard_zeroes_if_aligned) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_DISABLE_WRITE_SAME, c->disable_write_same) ||
+	    nla_put_u8(skb, DRBD2_A_DISK_CONF_BITMAP, c->d_bitmap))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+/*
+ * The caller decides what the reader may see: the dump hands us a copy
+ * with the shared secret cleared unless the reader has CAP_SYS_ADMIN.
+ */
+static int drbd2_put_net_conf(struct sk_buff *skb, int attrtype, struct drbd_net_conf *c)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_str(skb, DRBD2_A_NET_CONF_SHARED_SECRET, c->shared_secret,
+			  c->shared_secret_len, sizeof(c->shared_secret)) ||
+	    drbd2_put_str(skb, DRBD2_A_NET_CONF_CRAM_HMAC_ALG, c->cram_hmac_alg,
+			  c->cram_hmac_alg_len, sizeof(c->cram_hmac_alg)) ||
+	    drbd2_put_str(skb, DRBD2_A_NET_CONF_INTEGRITY_ALG, c->integrity_alg,
+			  c->integrity_alg_len, sizeof(c->integrity_alg)) ||
+	    drbd2_put_str(skb, DRBD2_A_NET_CONF_VERIFY_ALG, c->verify_alg,
+			  c->verify_alg_len, sizeof(c->verify_alg)) ||
+	    drbd2_put_str(skb, DRBD2_A_NET_CONF_CSUMS_ALG, c->csums_alg,
+			  c->csums_alg_len, sizeof(c->csums_alg)) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_PROTOCOL, c->wire_protocol) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_CONNECT_INT, c->connect_int) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_TIMEOUT, c->timeout) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_PING_INT, c->ping_int) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_PING_TIMEO, c->ping_timeo) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_SNDBUF_SIZE, c->sndbuf_size) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_RCVBUF_SIZE, c->rcvbuf_size) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_KO_COUNT, c->ko_count) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_MAX_EPOCH_SIZE, c->max_epoch_size) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_AFTER_SB_0PRI, c->after_sb_0p) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_AFTER_SB_1PRI, c->after_sb_1p) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_AFTER_SB_2PRI, c->after_sb_2p) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_RR_CONFLICT, c->rr_conflict) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_ON_CONGESTION, c->on_congestion) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_CONG_FILL, c->cong_fill) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_CONG_EXTENTS, c->cong_extents) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_TWO_PRIMARIES, c->two_primaries) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_TCP_CORK, c->tcp_cork) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_ALWAYS_ASBP, c->always_asbp) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_USE_RLE, c->use_rle) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_FENCING, c->fencing_policy) ||
+	    drbd2_put_str(skb, DRBD2_A_NET_CONF_CONNECTION_NAME, c->name,
+			  c->name_len, sizeof(c->name)) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_CSUMS_AFTER_CRASH_ONLY,
+		       c->csums_after_crash_only) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_SOCK_CHECK_TIMEO, c->sock_check_timeo) ||
+	    drbd2_put_str(skb, DRBD2_A_NET_CONF_TRANSPORT_NAME, c->transport_name,
+			  c->transport_name_len, sizeof(c->transport_name)) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_MAX_BUFFERS, c->max_buffers) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_ALLOW_REMOTE_READ, c->allow_remote_read) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_TLS, c->tls) ||
+	    nla_put_s32(skb, DRBD2_A_NET_CONF_TLS_PRIVKEY, c->tls_privkey) ||
+	    nla_put_s32(skb, DRBD2_A_NET_CONF_TLS_CERTIFICATE, c->tls_certificate) ||
+	    nla_put_s32(skb, DRBD2_A_NET_CONF_TLS_KEYRING, c->tls_keyring) ||
+	    nla_put_u8(skb, DRBD2_A_NET_CONF_LOAD_BALANCE_PATHS, c->load_balance_paths) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_RDMA_CTRL_RCVBUF_SIZE,
+			c->rdma_ctrl_rcvbuf_size) ||
+	    nla_put_u32(skb, DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE,
+			c->rdma_ctrl_sndbuf_size))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_device_conf(struct sk_buff *skb, int attrtype, struct drbd_device_conf *c)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_DEVICE_CONF_MAX_BIO_SIZE, c->max_bio_size) ||
+	    nla_put_u8(skb, DRBD2_A_DEVICE_CONF_INTENTIONAL_DISKLESS,
+		       c->intentional_diskless) ||
+	    nla_put_u32(skb, DRBD2_A_DEVICE_CONF_BLOCK_SIZE, c->block_size) ||
+	    nla_put_u32(skb, DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY,
+			c->discard_granularity))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_peer_device_conf(struct sk_buff *skb, int attrtype,
+				      struct drbd_peer_device_conf *c)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (nla_put_u32(skb, DRBD2_A_PEER_DEVICE_CONF_RESYNC_RATE, c->resync_rate) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_CONF_C_PLAN_AHEAD, c->c_plan_ahead) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_CONF_C_DELAY_TARGET, c->c_delay_target) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_CONF_C_FILL_TARGET, c->c_fill_target) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_CONF_C_MAX_RATE, c->c_max_rate) ||
+	    nla_put_u32(skb, DRBD2_A_PEER_DEVICE_CONF_C_MIN_RATE, c->c_min_rate) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_CONF_BITMAP, c->bitmap) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_CONF_RESYNC_WITHOUT_REPLICATION,
+		       c->resync_without_replication) ||
+	    nla_put_u8(skb, DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER, c->peer_tiebreaker))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+/*
+ * The paths of a connection, one attribute each, carried inside the
+ * connection nest as the legacy family carried them inside its
+ * connection message. Only the addresses identify a path here; the
+ * enclosing nest already names the resource and the peer.
+ */
+static int drbd2_put_connection_paths(struct sk_buff *skb,
+				      struct drbd_connection *connection)
+{
+	struct drbd_path *path;
+	int err = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(path, &connection->transport.paths, list) {
+		struct drbd_nl_path_info info = {
+			.path_established = test_bit(TR_ESTABLISHED, &path->flags),
+		};
+		struct nlattr *nla = nla_nest_start(skb, DRBD2_A_CONNECTION_PATH);
+
+		if (!nla) {
+			err = -EMSGSIZE;
+			break;
+		}
+		if (drbd2_put_context(skb, DRBD2_A_PATH_CONTEXT, NULL, NULL, NULL, path) ||
+		    drbd2_put_path_info(skb, DRBD2_A_PATH_INFO, &info)) {
+			nla_nest_cancel(skb, nla);
+			err = -EMSGSIZE;
+			break;
+		}
+		nla_nest_end(skb, nla);
+	}
+	rcu_read_unlock();
+	return err;
+}
+
+/*
+ * The object nests shared by the dumps and the state change messages:
+ * one nest per object type, holding its context, state and statistics.
+ */
+
+static int drbd2_put_resource(struct sk_buff *skb, int attrtype,
+			      struct drbd_resource *resource,
+			      struct drbd_res_opts *res_opts,
+			      struct drbd_resource_info *info,
+			      struct drbd_resource_statistics *statistics,
+			      struct drbd_rename_resource_info *rename_info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_context(skb, DRBD2_A_RESOURCE_CONTEXT, resource, NULL, NULL, NULL))
+		goto fail;
+	if (info && drbd2_put_resource_info(skb, DRBD2_A_RESOURCE_INFO, info))
+		goto fail;
+	if (statistics &&
+	    drbd2_put_resource_statistics(skb, DRBD2_A_RESOURCE_STATISTICS, statistics))
+		goto fail;
+	if (rename_info &&
+	    drbd2_put_str(skb, DRBD2_A_RESOURCE_NEW_NAME, rename_info->res_new_name,
+			  rename_info->res_new_name_len, sizeof(rename_info->res_new_name)))
+		goto fail;
+	if (res_opts && drbd2_put_res_opts(skb, DRBD2_A_RESOURCE_RESOURCE_OPTS, res_opts))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_device(struct sk_buff *skb, int attrtype,
+			    struct drbd_device *device,
+			    struct drbd_disk_conf *disk_conf,
+			    struct drbd_device_conf *device_conf,
+			    struct drbd_device_info *info,
+			    struct drbd_device_statistics *statistics)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_context(skb, DRBD2_A_DEVICE_CONTEXT, device->resource, NULL, device, NULL))
+		goto fail;
+	if (info && drbd2_put_device_info(skb, DRBD2_A_DEVICE_INFO, info))
+		goto fail;
+	if (statistics &&
+	    drbd2_put_device_statistics(skb, DRBD2_A_DEVICE_STATISTICS, statistics))
+		goto fail;
+	if (disk_conf && drbd2_put_disk_conf(skb, DRBD2_A_DEVICE_DISK_CONF, disk_conf))
+		goto fail;
+	if (device_conf &&
+	    drbd2_put_device_conf(skb, DRBD2_A_DEVICE_DEVICE_CONF, device_conf))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_connection(struct sk_buff *skb, int attrtype,
+				struct drbd_resource *resource,
+				struct drbd_connection *connection,
+				struct drbd_net_conf *net_conf,
+				struct drbd_connection_info *info,
+				struct drbd_connection_statistics *statistics)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_context(skb, DRBD2_A_CONNECTION_CONTEXT, resource, connection, NULL, NULL))
+		goto fail;
+	if (info && drbd2_put_connection_info(skb, DRBD2_A_CONNECTION_INFO, info))
+		goto fail;
+	if (statistics &&
+	    drbd2_put_connection_statistics(skb, DRBD2_A_CONNECTION_STATISTICS, statistics))
+		goto fail;
+	if (net_conf && drbd2_put_net_conf(skb, DRBD2_A_CONNECTION_NET_CONF, net_conf))
+		goto fail;
+	if (drbd2_put_connection_paths(skb, connection))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_peer_device(struct sk_buff *skb, int attrtype,
+				 struct drbd_peer_device *peer_device,
+				 struct drbd_peer_device_conf *conf,
+				 struct drbd_peer_device_info *info,
+				 struct drbd_peer_device_statistics *statistics)
+{
+	struct drbd_device *device = peer_device->device;
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_context(skb, DRBD2_A_PEER_DEVICE_CONTEXT, device->resource,
+			      peer_device->connection, device, NULL))
+		goto fail;
+	if (info && drbd2_put_peer_device_info(skb, DRBD2_A_PEER_DEVICE_INFO, info))
+		goto fail;
+	if (statistics &&
+	    drbd2_put_peer_device_statistics(skb, DRBD2_A_PEER_DEVICE_STATISTICS, statistics))
+		goto fail;
+	if (conf &&
+	    drbd2_put_peer_device_conf(skb, DRBD2_A_PEER_DEVICE_PEER_DEVICE_CONF, conf))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+static int drbd2_put_path(struct sk_buff *skb, int attrtype,
+			  struct drbd_resource *resource,
+			  struct drbd_connection *connection,
+			  struct drbd_path *path,
+			  struct drbd_nl_path_info *info)
+{
+	struct nlattr *nla = nla_nest_start(skb, attrtype);
+
+	if (!nla)
+		return -EMSGSIZE;
+	if (drbd2_put_context(skb, DRBD2_A_PATH_CONTEXT, resource, connection, NULL, path))
+		goto fail;
+	if (info && drbd2_put_path_info(skb, DRBD2_A_PATH_INFO, info))
+		goto fail;
+	nla_nest_end(skb, nla);
+	return 0;
+
+fail:
+	nla_nest_cancel(skb, nla);
+	return -EMSGSIZE;
+}
+
+/*
+ * pre_doit / post_doit.
+ */
+
+/* Which objects a command needs resolved, indexed by DRBD2_CMD_*. */
+static const unsigned int drbd2_cmd_flags[] = {
+	[DRBD2_CMD_RESOURCE_NEW]		= 0,
+	[DRBD2_CMD_RESOURCE_DEL]		= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_RESOURCE_SET]		= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_RESOURCE_RENAME]		= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_RESOURCE_DOWN]		= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_RESOURCE_PRIMARY]		= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_RESOURCE_SECONDARY]		= DRBD_ADM_NEED_RESOURCE,
+	/* both act on all devices of the resource, but reach it via a minor */
+	[DRBD2_CMD_RESOURCE_SUSPEND_IO]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_RESOURCE_RESUME_IO]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_NEW]			= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_DEVICE_DEL]			= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_ATTACH]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_DETACH]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DISK_SET]			= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_RESIZE]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_OUTDATE]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_INVALIDATE]		= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_DEVICE_NEW_CURRENT_UUID]	= DRBD_ADM_NEED_MINOR,
+	[DRBD2_CMD_CONNECTION_NEW]		= DRBD_ADM_NEED_PEER_NODE,
+	[DRBD2_CMD_CONNECTION_DEL]		= DRBD_ADM_NEED_CONNECTION,
+	[DRBD2_CMD_CONNECTION_CONNECT]		= DRBD_ADM_NEED_CONNECTION,
+	[DRBD2_CMD_CONNECTION_DISCONNECT]	= DRBD_ADM_NEED_CONNECTION,
+	[DRBD2_CMD_CONNECTION_SET]		= DRBD_ADM_NEED_CONNECTION,
+	/* the peer to forget must not have a connection any more */
+	[DRBD2_CMD_CONNECTION_FORGET]		= DRBD_ADM_NEED_RESOURCE,
+	[DRBD2_CMD_PATH_NEW]			= DRBD_ADM_NEED_CONNECTION,
+	[DRBD2_CMD_PATH_DEL]			= DRBD_ADM_NEED_CONNECTION,
+	[DRBD2_CMD_PEER_DEVICE_SET]		= DRBD_ADM_NEED_PEER_DEVICE,
+	[DRBD2_CMD_PEER_DEVICE_INVALIDATE]	= DRBD_ADM_NEED_PEER_DEVICE,
+	[DRBD2_CMD_PEER_DEVICE_PAUSE_SYNC]	= DRBD_ADM_NEED_PEER_DEVICE,
+	[DRBD2_CMD_PEER_DEVICE_RESUME_SYNC]	= DRBD_ADM_NEED_PEER_DEVICE,
+	[DRBD2_CMD_PEER_DEVICE_START_OV]	= DRBD_ADM_NEED_PEER_DEVICE,
+	[DRBD2_CMD_TIMEOUT_TYPE_GET]		= DRBD_ADM_NEED_PEER_DEVICE,
+};
+
+/* Fill in the identity of the object the request refers to. */
+static int drbd2_parse_context(struct drbd_adm_ctx *ctx, struct genl_info *info)
+{
+	struct nlattr *tb[DRBD2_A_CONTEXT_PEER_ADDRESS + 1];
+	int err;
+
+	ctx->minor = MINORMASK + 1;	/* no such minor */
+	ctx->volume = VOLUME_UNSPECIFIED;
+	ctx->peer_node_id = PEER_NODE_ID_UNSPECIFIED;
+
+	if (!info->attrs[DRBD2_A_CONTEXT])
+		return 0;
+
+	err = nla_parse_nested(tb, DRBD2_A_CONTEXT_PEER_ADDRESS,
+			       info->attrs[DRBD2_A_CONTEXT],
+			       drbd2_context_nl_policy, info->extack);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_CONTEXT_MINOR])
+		ctx->minor = nla_get_u32(tb[DRBD2_A_CONTEXT_MINOR]);
+	if (tb[DRBD2_A_CONTEXT_VOLUME])
+		ctx->volume = nla_get_u32(tb[DRBD2_A_CONTEXT_VOLUME]);
+	if (tb[DRBD2_A_CONTEXT_PEER_NODE_ID])
+		ctx->peer_node_id = nla_get_u32(tb[DRBD2_A_CONTEXT_PEER_NODE_ID]);
+	if (tb[DRBD2_A_CONTEXT_RESOURCE_NAME])
+		ctx->resource_name = nla_data(tb[DRBD2_A_CONTEXT_RESOURCE_NAME]);
+	return 0;
+}
+
+/*
+ * Allocates the command context together with the drbd2 request state,
+ * stores it in info->user_ptr[0], prepares the reply message and resolves
+ * the objects the command refers to. A failure here means post_doit is
+ * not called, so everything is cleaned up before returning.
+ */
+int drbd2_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info)
+{
+	const u8 cmd = info->genlhdr->cmd;
+	struct drbd_adm_ctx *adm_ctx;
+	struct drbd2_ctx *dctx;
+	struct drbd2_req *req;
+	unsigned int flags;
+	int err;
+
+	/*
+	 * genl_rcv_msg() checked CAP_NET_ADMIN for the commands with the
+	 * admin-perm flag; as in the legacy family, configuring DRBD also
+	 * requires CAP_SYS_ADMIN.
+	 */
+	if ((ops->flags & GENL_ADMIN_PERM) && !capable(CAP_SYS_ADMIN)) {
+		GENL_SET_ERR_MSG(info, "CAP_SYS_ADMIN required");
+		return -EPERM;
+	}
+
+	dctx = kzalloc_obj(struct drbd2_ctx);
+	if (!dctx)
+		return -ENOMEM;
+
+	adm_ctx = &dctx->ctx;
+	req = &dctx->req;
+	adm_ctx->d = &drbd2_dialect;
+	adm_ctx->req = req;
+	adm_ctx->result = NO_ERROR;
+	adm_ctx->net = sock_net(skb->sk);
+	/*
+	 * Only the *-set commands accept set-defaults; genl sizes info->attrs
+	 * to the maxattr of the command, so do not index past it elsewhere.
+	 */
+	adm_ctx->set_defaults = ops->maxattr >= DRBD2_A_SET_DEFAULTS &&
+				info->attrs[DRBD2_A_SET_DEFAULTS];
+	req->info = info;
+
+	err = drbd2_parse_context(adm_ctx, info);
+	if (err)
+		goto fail;
+
+	req->reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!req->reply_skb) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	req->reply_hdr = genlmsg_put_reply(req->reply_skb, info,
+					   &drbd2_nl_family, 0, cmd);
+	if (!req->reply_hdr) {
+		err = -EMSGSIZE;
+		goto fail;
+	}
+
+	flags = cmd < ARRAY_SIZE(drbd2_cmd_flags) ? drbd2_cmd_flags[cmd] : 0;
+	if (drbd_adm_ctx_resolve(adm_ctx, flags) != NO_ERROR) {
+		err = drbd2_errno(adm_ctx->result);
+		drbd2_set_extack(info, adm_ctx);
+		drbd_adm_ctx_release(adm_ctx);
+		goto fail;
+	}
+
+	info->user_ptr[0] = adm_ctx;
+	return 0;
+
+fail:
+	nlmsg_free(req->reply_skb);
+	kfree(dctx);
+	info->user_ptr[0] = NULL;
+	return err;
+}
+
+/*
+ * Sends the reply, drops the references acquired while resolving, and
+ * frees the context. The reply is gone when the command failed with an
+ * ERR_* code; the errno and the extended ACK describe that instead.
+ */
+void drbd2_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info)
+{
+	struct drbd_adm_ctx *adm_ctx = info->user_ptr[0];
+	struct drbd2_req *req;
+
+	if (!adm_ctx)
+		return;
+
+	req = drbd2_req(adm_ctx);
+	if (req->reply_skb) {
+		drbd2_put_outcome(adm_ctx);
+		genlmsg_end(req->reply_skb, req->reply_hdr);
+		if (genlmsg_reply(req->reply_skb, info))
+			pr_err("error sending genl reply\n");
+	}
+
+	drbd_adm_ctx_release(adm_ctx);
+	kfree(container_of(adm_ctx, struct drbd2_ctx, ctx));
+}
+
+/*
+ * The attribute sets of a request.
+ */
+
+static bool drbd2_has_set(struct drbd_adm_ctx *ctx, enum drbd_nl_attr_set set)
+{
+	static const u16 tla[__DRBD_NL_SET_MAX] = {
+		[DRBD_NL_SET_DISK_CONF]			= DRBD2_A_DISK_CONF,
+		[DRBD_NL_SET_NET_CONF]			= DRBD2_A_NET_CONF,
+		[DRBD_NL_SET_RES_OPTS]			= DRBD2_A_RESOURCE_OPTS,
+		[DRBD_NL_SET_PEER_DEVICE_CONF]		= DRBD2_A_PEER_DEVICE_CONF,
+		[DRBD_NL_SET_DEVICE_CONF]		= DRBD2_A_DEVICE_CONF,
+		[DRBD_NL_SET_SET_ROLE_PARMS]		= DRBD2_A_SET_ROLE_PARMS,
+		[DRBD_NL_SET_RESIZE_PARMS]		= DRBD2_A_RESIZE_PARMS,
+		[DRBD_NL_SET_START_OV_PARMS]		= DRBD2_A_START_OV_PARMS,
+		[DRBD_NL_SET_NEW_C_UUID_PARMS]		= DRBD2_A_NEW_CURRENT_UUID_PARMS,
+		[DRBD_NL_SET_DISCONNECT_PARMS]		= DRBD2_A_DISCONNECT_PARMS,
+		[DRBD_NL_SET_DETACH_PARMS]		= DRBD2_A_DETACH_PARMS,
+		[DRBD_NL_SET_INVALIDATE_PARMS]		= DRBD2_A_INVALIDATE_PARMS,
+		[DRBD_NL_SET_INVALIDATE_PEER_PARMS]	= DRBD2_A_INVALIDATE_PEER_PARMS,
+		[DRBD_NL_SET_CONNECT_PARMS]		= DRBD2_A_CONNECT_PARMS,
+		[DRBD_NL_SET_RENAME_RESOURCE_PARMS]	= DRBD2_A_RENAME_PARMS,
+		[DRBD_NL_SET_SUSPEND_IO_PARMS]		= DRBD2_A_SUSPEND_IO_PARMS,
+		/* both are carried by the context nest of the request */
+		[DRBD_NL_SET_FORGET_PEER_PARMS]		= DRBD2_A_CONTEXT,
+		[DRBD_NL_SET_PATH_PARMS]		= DRBD2_A_CONTEXT,
+	};
+
+	return drbd2_req(ctx)->info->attrs[tla[set]] != NULL;
+}
+
+/*
+ * Parse the nest of "attrtype" into "tb". Returns -ENOMSG when the nest
+ * is not part of the request at all, which is what the core expects for
+ * a missing parameter set.
+ */
+static int drbd2_parse_set(struct drbd_adm_ctx *ctx, int attrtype, int maxtype,
+			   const struct nla_policy *policy, struct nlattr **tb)
+{
+	struct genl_info *info = drbd2_req(ctx)->info;
+
+	if (!info->attrs[attrtype])
+		return -ENOMSG;
+	return nla_parse_nested(tb, maxtype, info->attrs[attrtype], policy,
+				info->extack);
+}
+
+#define DRBD2_PARSE_SET(ctx, name, NAME, tb)				\
+	drbd2_parse_set((ctx), DRBD2_A_##NAME, ARRAY_SIZE(tb) - 1,	\
+			drbd2_##name##_nl_policy, (tb))
+
+static int drbd2_overlay_disk_conf(struct drbd_adm_ctx *ctx, struct drbd_disk_conf *s)
+{
+	struct nlattr *tb[DRBD2_A_DISK_CONF_BITMAP + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, disk_conf, DISK_CONF, tb);
+	if (err)
+		return err;
+
+	/* the three attributes that describe the disk itself are required */
+	if (!tb[DRBD2_A_DISK_CONF_BACKING_DEV] || !tb[DRBD2_A_DISK_CONF_META_DEV] ||
+	    !tb[DRBD2_A_DISK_CONF_META_DEV_IDX])
+		err = -ENOMSG;
+
+	if (tb[DRBD2_A_DISK_CONF_BACKING_DEV])
+		s->backing_dev_len = nla_strscpy(s->backing_dev,
+						 tb[DRBD2_A_DISK_CONF_BACKING_DEV],
+						 sizeof(s->backing_dev));
+	if (tb[DRBD2_A_DISK_CONF_META_DEV])
+		s->meta_dev_len = nla_strscpy(s->meta_dev, tb[DRBD2_A_DISK_CONF_META_DEV],
+					      sizeof(s->meta_dev));
+	if (tb[DRBD2_A_DISK_CONF_META_DEV_IDX])
+		s->meta_dev_idx = nla_get_s32(tb[DRBD2_A_DISK_CONF_META_DEV_IDX]);
+	if (tb[DRBD2_A_DISK_CONF_SIZE])
+		s->disk_size = nla_get_u64(tb[DRBD2_A_DISK_CONF_SIZE]);
+	if (tb[DRBD2_A_DISK_CONF_ON_IO_ERROR])
+		s->on_io_error = nla_get_u32(tb[DRBD2_A_DISK_CONF_ON_IO_ERROR]);
+	if (tb[DRBD2_A_DISK_CONF_RESYNC_AFTER])
+		s->resync_after = nla_get_s32(tb[DRBD2_A_DISK_CONF_RESYNC_AFTER]);
+	if (tb[DRBD2_A_DISK_CONF_AL_EXTENTS])
+		s->al_extents = nla_get_u32(tb[DRBD2_A_DISK_CONF_AL_EXTENTS]);
+	if (tb[DRBD2_A_DISK_CONF_DISK_BARRIER])
+		s->disk_barrier = nla_get_u8(tb[DRBD2_A_DISK_CONF_DISK_BARRIER]);
+	if (tb[DRBD2_A_DISK_CONF_DISK_FLUSHES])
+		s->disk_flushes = nla_get_u8(tb[DRBD2_A_DISK_CONF_DISK_FLUSHES]);
+	if (tb[DRBD2_A_DISK_CONF_DISK_DRAIN])
+		s->disk_drain = nla_get_u8(tb[DRBD2_A_DISK_CONF_DISK_DRAIN]);
+	if (tb[DRBD2_A_DISK_CONF_MD_FLUSHES])
+		s->md_flushes = nla_get_u8(tb[DRBD2_A_DISK_CONF_MD_FLUSHES]);
+	if (tb[DRBD2_A_DISK_CONF_DISK_TIMEOUT])
+		s->disk_timeout = nla_get_u32(tb[DRBD2_A_DISK_CONF_DISK_TIMEOUT]);
+	if (tb[DRBD2_A_DISK_CONF_READ_BALANCING])
+		s->read_balancing = nla_get_u32(tb[DRBD2_A_DISK_CONF_READ_BALANCING]);
+	if (tb[DRBD2_A_DISK_CONF_UNPLUG_WATERMARK])
+		s->unplug_watermark = nla_get_u32(tb[DRBD2_A_DISK_CONF_UNPLUG_WATERMARK]);
+	if (tb[DRBD2_A_DISK_CONF_RS_DISCARD_GRANULARITY])
+		s->rs_discard_granularity =
+			nla_get_u32(tb[DRBD2_A_DISK_CONF_RS_DISCARD_GRANULARITY]);
+	if (tb[DRBD2_A_DISK_CONF_AL_UPDATES])
+		s->al_updates = nla_get_u8(tb[DRBD2_A_DISK_CONF_AL_UPDATES]);
+	if (tb[DRBD2_A_DISK_CONF_DISCARD_ZEROES_IF_ALIGNED])
+		s->discard_zeroes_if_aligned =
+			nla_get_u8(tb[DRBD2_A_DISK_CONF_DISCARD_ZEROES_IF_ALIGNED]);
+	if (tb[DRBD2_A_DISK_CONF_DISABLE_WRITE_SAME])
+		s->disable_write_same = nla_get_u8(tb[DRBD2_A_DISK_CONF_DISABLE_WRITE_SAME]);
+	if (tb[DRBD2_A_DISK_CONF_BITMAP])
+		s->d_bitmap = nla_get_u8(tb[DRBD2_A_DISK_CONF_BITMAP]);
+	return err;
+}
+
+static int drbd2_overlay_res_opts(struct drbd_adm_ctx *ctx, struct drbd_res_opts *s)
+{
+	struct nlattr *tb[DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, resource_opts, RESOURCE_OPTS, tb);
+	if (err)
+		return err;
+
+	/* the node id identifies this node in the resource; it is required */
+	if (!tb[DRBD2_A_RESOURCE_OPTS_NODE_ID])
+		err = -ENOMSG;
+
+	if (tb[DRBD2_A_RESOURCE_OPTS_CPU_MASK])
+		s->cpu_mask_len = nla_strscpy(s->cpu_mask, tb[DRBD2_A_RESOURCE_OPTS_CPU_MASK],
+					      sizeof(s->cpu_mask));
+	if (tb[DRBD2_A_RESOURCE_OPTS_ON_NO_DATA_ACCESSIBLE])
+		s->on_no_data = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_ON_NO_DATA_ACCESSIBLE]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE])
+		s->auto_promote = nla_get_u8(tb[DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_NODE_ID])
+		s->node_id = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_NODE_ID]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_PEER_ACK_WINDOW])
+		s->peer_ack_window = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_PEER_ACK_WINDOW]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_TWOPC_TIMEOUT])
+		s->twopc_timeout = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_TWOPC_TIMEOUT]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_TWOPC_RETRY_TIMEOUT])
+		s->twopc_retry_timeout =
+			nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_TWOPC_RETRY_TIMEOUT]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_PEER_ACK_DELAY])
+		s->peer_ack_delay = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_PEER_ACK_DELAY]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE_TIMEOUT])
+		s->auto_promote_timeout =
+			nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE_TIMEOUT]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_MAX_IO_DEPTH])
+		s->nr_requests = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_MAX_IO_DEPTH]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_QUORUM])
+		s->quorum = nla_get_s32(tb[DRBD2_A_RESOURCE_OPTS_QUORUM]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_ON_NO_QUORUM])
+		s->on_no_quorum = nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_ON_NO_QUORUM]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_QUORUM_MIN_REDUNDANCY])
+		s->quorum_min_redundancy =
+			nla_get_s32(tb[DRBD2_A_RESOURCE_OPTS_QUORUM_MIN_REDUNDANCY]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_ON_SUSPENDED_PRIMARY_OUTDATED])
+		s->on_susp_primary_outdated =
+			nla_get_u32(tb[DRBD2_A_RESOURCE_OPTS_ON_SUSPENDED_PRIMARY_OUTDATED]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_DRBD8_COMPAT_MODE])
+		s->drbd8_compat_mode = nla_get_u8(tb[DRBD2_A_RESOURCE_OPTS_DRBD8_COMPAT_MODE]);
+	if (tb[DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT])
+		s->explicit_drbd8_compat =
+			nla_get_u8(tb[DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT]);
+	return err;
+}
+
+static int drbd2_overlay_net_conf(struct drbd_adm_ctx *ctx, struct drbd_net_conf *s)
+{
+	struct nlattr *tb[DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, net_conf, NET_CONF, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_NET_CONF_SHARED_SECRET])
+		s->shared_secret_len = nla_strscpy(s->shared_secret,
+						   tb[DRBD2_A_NET_CONF_SHARED_SECRET],
+						   sizeof(s->shared_secret));
+	if (tb[DRBD2_A_NET_CONF_CRAM_HMAC_ALG])
+		s->cram_hmac_alg_len = nla_strscpy(s->cram_hmac_alg,
+						   tb[DRBD2_A_NET_CONF_CRAM_HMAC_ALG],
+						   sizeof(s->cram_hmac_alg));
+	if (tb[DRBD2_A_NET_CONF_INTEGRITY_ALG])
+		s->integrity_alg_len = nla_strscpy(s->integrity_alg,
+						   tb[DRBD2_A_NET_CONF_INTEGRITY_ALG],
+						   sizeof(s->integrity_alg));
+	if (tb[DRBD2_A_NET_CONF_VERIFY_ALG])
+		s->verify_alg_len = nla_strscpy(s->verify_alg,
+						tb[DRBD2_A_NET_CONF_VERIFY_ALG],
+						sizeof(s->verify_alg));
+	if (tb[DRBD2_A_NET_CONF_CSUMS_ALG])
+		s->csums_alg_len = nla_strscpy(s->csums_alg, tb[DRBD2_A_NET_CONF_CSUMS_ALG],
+					       sizeof(s->csums_alg));
+	if (tb[DRBD2_A_NET_CONF_PROTOCOL])
+		s->wire_protocol = nla_get_u32(tb[DRBD2_A_NET_CONF_PROTOCOL]);
+	if (tb[DRBD2_A_NET_CONF_CONNECT_INT])
+		s->connect_int = nla_get_u32(tb[DRBD2_A_NET_CONF_CONNECT_INT]);
+	if (tb[DRBD2_A_NET_CONF_TIMEOUT])
+		s->timeout = nla_get_u32(tb[DRBD2_A_NET_CONF_TIMEOUT]);
+	if (tb[DRBD2_A_NET_CONF_PING_INT])
+		s->ping_int = nla_get_u32(tb[DRBD2_A_NET_CONF_PING_INT]);
+	if (tb[DRBD2_A_NET_CONF_PING_TIMEO])
+		s->ping_timeo = nla_get_u32(tb[DRBD2_A_NET_CONF_PING_TIMEO]);
+	if (tb[DRBD2_A_NET_CONF_SNDBUF_SIZE])
+		s->sndbuf_size = nla_get_u32(tb[DRBD2_A_NET_CONF_SNDBUF_SIZE]);
+	if (tb[DRBD2_A_NET_CONF_RCVBUF_SIZE])
+		s->rcvbuf_size = nla_get_u32(tb[DRBD2_A_NET_CONF_RCVBUF_SIZE]);
+	if (tb[DRBD2_A_NET_CONF_KO_COUNT])
+		s->ko_count = nla_get_u32(tb[DRBD2_A_NET_CONF_KO_COUNT]);
+	if (tb[DRBD2_A_NET_CONF_MAX_EPOCH_SIZE])
+		s->max_epoch_size = nla_get_u32(tb[DRBD2_A_NET_CONF_MAX_EPOCH_SIZE]);
+	if (tb[DRBD2_A_NET_CONF_AFTER_SB_0PRI])
+		s->after_sb_0p = nla_get_u32(tb[DRBD2_A_NET_CONF_AFTER_SB_0PRI]);
+	if (tb[DRBD2_A_NET_CONF_AFTER_SB_1PRI])
+		s->after_sb_1p = nla_get_u32(tb[DRBD2_A_NET_CONF_AFTER_SB_1PRI]);
+	if (tb[DRBD2_A_NET_CONF_AFTER_SB_2PRI])
+		s->after_sb_2p = nla_get_u32(tb[DRBD2_A_NET_CONF_AFTER_SB_2PRI]);
+	if (tb[DRBD2_A_NET_CONF_RR_CONFLICT])
+		s->rr_conflict = nla_get_u32(tb[DRBD2_A_NET_CONF_RR_CONFLICT]);
+	if (tb[DRBD2_A_NET_CONF_ON_CONGESTION])
+		s->on_congestion = nla_get_u32(tb[DRBD2_A_NET_CONF_ON_CONGESTION]);
+	if (tb[DRBD2_A_NET_CONF_CONG_FILL])
+		s->cong_fill = nla_get_u32(tb[DRBD2_A_NET_CONF_CONG_FILL]);
+	if (tb[DRBD2_A_NET_CONF_CONG_EXTENTS])
+		s->cong_extents = nla_get_u32(tb[DRBD2_A_NET_CONF_CONG_EXTENTS]);
+	if (tb[DRBD2_A_NET_CONF_TWO_PRIMARIES])
+		s->two_primaries = nla_get_u8(tb[DRBD2_A_NET_CONF_TWO_PRIMARIES]);
+	if (tb[DRBD2_A_NET_CONF_TCP_CORK])
+		s->tcp_cork = nla_get_u8(tb[DRBD2_A_NET_CONF_TCP_CORK]);
+	if (tb[DRBD2_A_NET_CONF_ALWAYS_ASBP])
+		s->always_asbp = nla_get_u8(tb[DRBD2_A_NET_CONF_ALWAYS_ASBP]);
+	if (tb[DRBD2_A_NET_CONF_USE_RLE])
+		s->use_rle = nla_get_u8(tb[DRBD2_A_NET_CONF_USE_RLE]);
+	if (tb[DRBD2_A_NET_CONF_FENCING])
+		s->fencing_policy = nla_get_u32(tb[DRBD2_A_NET_CONF_FENCING]);
+	if (tb[DRBD2_A_NET_CONF_CONNECTION_NAME])
+		s->name_len = nla_strscpy(s->name, tb[DRBD2_A_NET_CONF_CONNECTION_NAME],
+					  sizeof(s->name));
+	if (tb[DRBD2_A_NET_CONF_CSUMS_AFTER_CRASH_ONLY])
+		s->csums_after_crash_only =
+			nla_get_u8(tb[DRBD2_A_NET_CONF_CSUMS_AFTER_CRASH_ONLY]);
+	if (tb[DRBD2_A_NET_CONF_SOCK_CHECK_TIMEO])
+		s->sock_check_timeo = nla_get_u32(tb[DRBD2_A_NET_CONF_SOCK_CHECK_TIMEO]);
+	if (tb[DRBD2_A_NET_CONF_TRANSPORT_NAME])
+		s->transport_name_len = nla_strscpy(s->transport_name,
+						    tb[DRBD2_A_NET_CONF_TRANSPORT_NAME],
+						    sizeof(s->transport_name));
+	if (tb[DRBD2_A_NET_CONF_MAX_BUFFERS])
+		s->max_buffers = nla_get_u32(tb[DRBD2_A_NET_CONF_MAX_BUFFERS]);
+	if (tb[DRBD2_A_NET_CONF_ALLOW_REMOTE_READ])
+		s->allow_remote_read = nla_get_u8(tb[DRBD2_A_NET_CONF_ALLOW_REMOTE_READ]);
+	if (tb[DRBD2_A_NET_CONF_TLS])
+		s->tls = nla_get_u8(tb[DRBD2_A_NET_CONF_TLS]);
+	if (tb[DRBD2_A_NET_CONF_TLS_PRIVKEY])
+		s->tls_privkey = nla_get_s32(tb[DRBD2_A_NET_CONF_TLS_PRIVKEY]);
+	if (tb[DRBD2_A_NET_CONF_TLS_CERTIFICATE])
+		s->tls_certificate = nla_get_s32(tb[DRBD2_A_NET_CONF_TLS_CERTIFICATE]);
+	if (tb[DRBD2_A_NET_CONF_TLS_KEYRING])
+		s->tls_keyring = nla_get_s32(tb[DRBD2_A_NET_CONF_TLS_KEYRING]);
+	if (tb[DRBD2_A_NET_CONF_LOAD_BALANCE_PATHS])
+		s->load_balance_paths = nla_get_u8(tb[DRBD2_A_NET_CONF_LOAD_BALANCE_PATHS]);
+	if (tb[DRBD2_A_NET_CONF_RDMA_CTRL_RCVBUF_SIZE])
+		s->rdma_ctrl_rcvbuf_size =
+			nla_get_u32(tb[DRBD2_A_NET_CONF_RDMA_CTRL_RCVBUF_SIZE]);
+	if (tb[DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE])
+		s->rdma_ctrl_sndbuf_size =
+			nla_get_u32(tb[DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE]);
+	return 0;
+}
+
+static int drbd2_overlay_peer_device_conf(struct drbd_adm_ctx *ctx,
+					  struct drbd_peer_device_conf *s)
+{
+	struct nlattr *tb[DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, peer_device_conf, PEER_DEVICE_CONF, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_RESYNC_RATE])
+		s->resync_rate = nla_get_u32(tb[DRBD2_A_PEER_DEVICE_CONF_RESYNC_RATE]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_C_PLAN_AHEAD])
+		s->c_plan_ahead = nla_get_u32(tb[DRBD2_A_PEER_DEVICE_CONF_C_PLAN_AHEAD]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_C_DELAY_TARGET])
+		s->c_delay_target = nla_get_u32(tb[DRBD2_A_PEER_DEVICE_CONF_C_DELAY_TARGET]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_C_FILL_TARGET])
+		s->c_fill_target = nla_get_u32(tb[DRBD2_A_PEER_DEVICE_CONF_C_FILL_TARGET]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_C_MAX_RATE])
+		s->c_max_rate = nla_get_u32(tb[DRBD2_A_PEER_DEVICE_CONF_C_MAX_RATE]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_C_MIN_RATE])
+		s->c_min_rate = nla_get_u32(tb[DRBD2_A_PEER_DEVICE_CONF_C_MIN_RATE]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_BITMAP])
+		s->bitmap = nla_get_u8(tb[DRBD2_A_PEER_DEVICE_CONF_BITMAP]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_RESYNC_WITHOUT_REPLICATION])
+		s->resync_without_replication =
+			nla_get_u8(tb[DRBD2_A_PEER_DEVICE_CONF_RESYNC_WITHOUT_REPLICATION]);
+	if (tb[DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER])
+		s->peer_tiebreaker = nla_get_u8(tb[DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER]);
+	return 0;
+}
+
+static int drbd2_overlay_device_conf(struct drbd_adm_ctx *ctx, struct drbd_device_conf *s)
+{
+	struct nlattr *tb[DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, device_conf, DEVICE_CONF, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_DEVICE_CONF_MAX_BIO_SIZE])
+		s->max_bio_size = nla_get_u32(tb[DRBD2_A_DEVICE_CONF_MAX_BIO_SIZE]);
+	if (tb[DRBD2_A_DEVICE_CONF_INTENTIONAL_DISKLESS])
+		s->intentional_diskless =
+			nla_get_u8(tb[DRBD2_A_DEVICE_CONF_INTENTIONAL_DISKLESS]);
+	if (tb[DRBD2_A_DEVICE_CONF_BLOCK_SIZE])
+		s->block_size = nla_get_u32(tb[DRBD2_A_DEVICE_CONF_BLOCK_SIZE]);
+	if (tb[DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY])
+		s->discard_granularity =
+			nla_get_u32(tb[DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY]);
+	return 0;
+}
+
+static int drbd2_overlay_set_role_parms(struct drbd_adm_ctx *ctx, struct drbd_set_role_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_SET_ROLE_PARMS_FORCE + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, set_role_parms, SET_ROLE_PARMS, tb);
+	if (err)
+		return err;
+
+	s->force = !!tb[DRBD2_A_SET_ROLE_PARMS_FORCE];
+	return 0;
+}
+
+static int drbd2_overlay_resize_parms(struct drbd_adm_ctx *ctx, struct drbd_resize_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, resize_parms, RESIZE_PARMS, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_RESIZE_PARMS_SIZE])
+		s->resize_size = nla_get_u64(tb[DRBD2_A_RESIZE_PARMS_SIZE]);
+	s->resize_force = !!tb[DRBD2_A_RESIZE_PARMS_ASSUME_PEER_HAS_SPACE];
+	s->no_resync = !!tb[DRBD2_A_RESIZE_PARMS_ASSUME_CLEAN];
+	if (tb[DRBD2_A_RESIZE_PARMS_AL_STRIPES])
+		s->al_stripes = nla_get_u32(tb[DRBD2_A_RESIZE_PARMS_AL_STRIPES]);
+	if (tb[DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE])
+		s->al_stripe_size = nla_get_u32(tb[DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE]);
+	return 0;
+}
+
+static int drbd2_overlay_start_ov_parms(struct drbd_adm_ctx *ctx, struct drbd_start_ov_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_START_OV_PARMS_STOP_SECTOR + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, start_ov_parms, START_OV_PARMS, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_START_OV_PARMS_START_SECTOR])
+		s->ov_start_sector = nla_get_u64(tb[DRBD2_A_START_OV_PARMS_START_SECTOR]);
+	if (tb[DRBD2_A_START_OV_PARMS_STOP_SECTOR])
+		s->ov_stop_sector = nla_get_u64(tb[DRBD2_A_START_OV_PARMS_STOP_SECTOR]);
+	return 0;
+}
+
+static int drbd2_overlay_new_c_uuid_parms(struct drbd_adm_ctx *ctx,
+					  struct drbd_new_c_uuid_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_NEW_CURRENT_UUID_PARMS_FORCE_RESYNC + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, new_current_uuid_parms, NEW_CURRENT_UUID_PARMS, tb);
+	if (err)
+		return err;
+
+	s->clear_bm = !!tb[DRBD2_A_NEW_CURRENT_UUID_PARMS_CLEAR_BM];
+	s->force_resync = !!tb[DRBD2_A_NEW_CURRENT_UUID_PARMS_FORCE_RESYNC];
+	return 0;
+}
+
+static int drbd2_overlay_disconnect_parms(struct drbd_adm_ctx *ctx,
+					  struct drbd_disconnect_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_DISCONNECT_PARMS_FORCE + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, disconnect_parms, DISCONNECT_PARMS, tb);
+	if (err)
+		return err;
+
+	s->force_disconnect = !!tb[DRBD2_A_DISCONNECT_PARMS_FORCE];
+	return 0;
+}
+
+static int drbd2_overlay_detach_parms(struct drbd_adm_ctx *ctx, struct drbd_detach_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_DETACH_PARMS_INTENTIONAL_DISKLESS_DETACH + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, detach_parms, DETACH_PARMS, tb);
+	if (err)
+		return err;
+
+	s->force_detach = !!tb[DRBD2_A_DETACH_PARMS_FORCE];
+	s->intentional_diskless_detach =
+		!!tb[DRBD2_A_DETACH_PARMS_INTENTIONAL_DISKLESS_DETACH];
+	return 0;
+}
+
+static int drbd2_overlay_invalidate_parms(struct drbd_adm_ctx *ctx,
+					  struct drbd_invalidate_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, invalidate_parms, INVALIDATE_PARMS, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_INVALIDATE_PARMS_SYNC_FROM_PEER_NODE_ID])
+		s->sync_from_peer_node_id =
+			nla_get_u32(tb[DRBD2_A_INVALIDATE_PARMS_SYNC_FROM_PEER_NODE_ID]);
+	if (tb[DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP])
+		s->reset_bitmap = nla_get_u8(tb[DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP]);
+	return 0;
+}
+
+static int drbd2_overlay_invalidate_peer_parms(struct drbd_adm_ctx *ctx,
+					       struct drbd_invalidate_peer_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, invalidate_peer_parms, INVALIDATE_PEER_PARMS, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP])
+		s->p_reset_bitmap =
+			nla_get_u8(tb[DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP]);
+	return 0;
+}
+
+/*
+ * connection-forget names the peer in the context of the request, not in
+ * a parameter set of its own.
+ */
+static int drbd2_overlay_forget_peer_parms(struct drbd_adm_ctx *ctx,
+					   struct drbd_forget_peer_parms *s)
+{
+	if (ctx->peer_node_id == PEER_NODE_ID_UNSPECIFIED)
+		return -ENOMSG;
+	s->forget_peer_node_id = ctx->peer_node_id;
+	return 0;
+}
+
+static int drbd2_overlay_connect_parms(struct drbd_adm_ctx *ctx, struct drbd_connect_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_CONNECT_PARMS_DISCARD_MY_DATA + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, connect_parms, CONNECT_PARMS, tb);
+	if (err)
+		return err;
+
+	s->tentative = !!tb[DRBD2_A_CONNECT_PARMS_TENTATIVE];
+	s->discard_my_data = !!tb[DRBD2_A_CONNECT_PARMS_DISCARD_MY_DATA];
+	return 0;
+}
+
+/*
+ * A path is identified by the two addresses in the context of the
+ * request; both are required.
+ */
+static int drbd2_overlay_path_parms(struct drbd_adm_ctx *ctx, struct drbd_path_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_CONTEXT_PEER_ADDRESS + 1];
+	struct genl_info *info = drbd2_req(ctx)->info;
+	int err;
+
+	if (!info->attrs[DRBD2_A_CONTEXT])
+		return -ENOMSG;
+	err = nla_parse_nested(tb, DRBD2_A_CONTEXT_PEER_ADDRESS,
+			       info->attrs[DRBD2_A_CONTEXT],
+			       drbd2_context_nl_policy, info->extack);
+	if (err)
+		return err;
+	if (!tb[DRBD2_A_CONTEXT_MY_ADDRESS] || !tb[DRBD2_A_CONTEXT_PEER_ADDRESS])
+		return -ENOMSG;
+
+	err = drbd2_get_address(tb[DRBD2_A_CONTEXT_MY_ADDRESS], s->my_addr, &s->my_addr_len);
+	if (err)
+		return err;
+	return drbd2_get_address(tb[DRBD2_A_CONTEXT_PEER_ADDRESS],
+				 s->peer_addr, &s->peer_addr_len);
+}
+
+static int drbd2_overlay_rename_resource_parms(struct drbd_adm_ctx *ctx,
+					       struct drbd_rename_resource_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_RENAME_PARMS_NEW_NAME + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, rename_parms, RENAME_PARMS, tb);
+	if (err)
+		return err;
+	if (!tb[DRBD2_A_RENAME_PARMS_NEW_NAME])
+		return -ENOMSG;
+
+	s->new_resource_name_len = nla_strscpy(s->new_resource_name,
+					       tb[DRBD2_A_RENAME_PARMS_NEW_NAME],
+					       sizeof(s->new_resource_name));
+	return 0;
+}
+
+static int drbd2_overlay_suspend_io_parms(struct drbd_adm_ctx *ctx,
+					  struct drbd_suspend_io_parms *s)
+{
+	struct nlattr *tb[DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE + 1];
+	int err;
+
+	err = DRBD2_PARSE_SET(ctx, suspend_io_parms, SUSPEND_IO_PARMS, tb);
+	if (err)
+		return err;
+
+	if (tb[DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE])
+		s->bdev_freeze = nla_get_u8(tb[DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE]);
+	return 0;
+}
+
+static int drbd2_overlay(struct drbd_adm_ctx *ctx, enum drbd_nl_attr_set set, void *dst)
+{
+	switch (set) {
+	case DRBD_NL_SET_DISK_CONF:		return drbd2_overlay_disk_conf(ctx, dst);
+	case DRBD_NL_SET_NET_CONF:		return drbd2_overlay_net_conf(ctx, dst);
+	case DRBD_NL_SET_RES_OPTS:		return drbd2_overlay_res_opts(ctx, dst);
+	case DRBD_NL_SET_PEER_DEVICE_CONF:	return drbd2_overlay_peer_device_conf(ctx, dst);
+	case DRBD_NL_SET_DEVICE_CONF:		return drbd2_overlay_device_conf(ctx, dst);
+	case DRBD_NL_SET_SET_ROLE_PARMS:	return drbd2_overlay_set_role_parms(ctx, dst);
+	case DRBD_NL_SET_RESIZE_PARMS:		return drbd2_overlay_resize_parms(ctx, dst);
+	case DRBD_NL_SET_START_OV_PARMS:	return drbd2_overlay_start_ov_parms(ctx, dst);
+	case DRBD_NL_SET_NEW_C_UUID_PARMS:	return drbd2_overlay_new_c_uuid_parms(ctx, dst);
+	case DRBD_NL_SET_DISCONNECT_PARMS:	return drbd2_overlay_disconnect_parms(ctx, dst);
+	case DRBD_NL_SET_DETACH_PARMS:		return drbd2_overlay_detach_parms(ctx, dst);
+	case DRBD_NL_SET_INVALIDATE_PARMS:	return drbd2_overlay_invalidate_parms(ctx, dst);
+	case DRBD_NL_SET_INVALIDATE_PEER_PARMS:
+		return drbd2_overlay_invalidate_peer_parms(ctx, dst);
+	case DRBD_NL_SET_FORGET_PEER_PARMS:	return drbd2_overlay_forget_peer_parms(ctx, dst);
+	case DRBD_NL_SET_CONNECT_PARMS:		return drbd2_overlay_connect_parms(ctx, dst);
+	case DRBD_NL_SET_PATH_PARMS:		return drbd2_overlay_path_parms(ctx, dst);
+	case DRBD_NL_SET_RENAME_RESOURCE_PARMS:
+		return drbd2_overlay_rename_resource_parms(ctx, dst);
+	case DRBD_NL_SET_SUSPEND_IO_PARMS:	return drbd2_overlay_suspend_io_parms(ctx, dst);
+	case __DRBD_NL_SET_MAX:
+		break;
+	}
+	return -EINVAL;
+}
+
+/*
+ * The core asks about one invariant field at a time and stops at the
+ * first one that is present, so exactly one message is logged, for that
+ * field. Parsing the nest per query keeps that short-circuit intact.
+ */
+static bool drbd2_attr_present(struct drbd_adm_ctx *ctx, enum drbd_adm_field field)
+{
+	static const struct {
+		u16 tla;
+		u16 maxtype;
+		const struct nla_policy *policy;
+		u16 attr;
+		const char *name;
+	} invariant[] = {
+		[DRBD_ADM_F_DISK_BACKING_DEV] = { DRBD2_A_DISK_CONF,
+			DRBD2_A_DISK_CONF_BITMAP, drbd2_disk_conf_nl_policy,
+			DRBD2_A_DISK_CONF_BACKING_DEV, "disk-conf.backing-dev" },
+		[DRBD_ADM_F_DISK_META_DEV] = { DRBD2_A_DISK_CONF,
+			DRBD2_A_DISK_CONF_BITMAP, drbd2_disk_conf_nl_policy,
+			DRBD2_A_DISK_CONF_META_DEV, "disk-conf.meta-dev" },
+		[DRBD_ADM_F_DISK_META_DEV_IDX] = { DRBD2_A_DISK_CONF,
+			DRBD2_A_DISK_CONF_BITMAP, drbd2_disk_conf_nl_policy,
+			DRBD2_A_DISK_CONF_META_DEV_IDX, "disk-conf.meta-dev-idx" },
+		[DRBD_ADM_F_DISK_SIZE] = { DRBD2_A_DISK_CONF,
+			DRBD2_A_DISK_CONF_BITMAP, drbd2_disk_conf_nl_policy,
+			DRBD2_A_DISK_CONF_SIZE, "disk-conf.size" },
+		[DRBD_ADM_F_NET_TRANSPORT_NAME] = { DRBD2_A_NET_CONF,
+			DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE, drbd2_net_conf_nl_policy,
+			DRBD2_A_NET_CONF_TRANSPORT_NAME, "net-conf.transport-name" },
+		[DRBD_ADM_F_NET_LOAD_BALANCE_PATHS] = { DRBD2_A_NET_CONF,
+			DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE, drbd2_net_conf_nl_policy,
+			DRBD2_A_NET_CONF_LOAD_BALANCE_PATHS, "net-conf.load-balance-paths" },
+		[DRBD_ADM_F_RES_NODE_ID] = { DRBD2_A_RESOURCE_OPTS,
+			DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT,
+			drbd2_resource_opts_nl_policy,
+			DRBD2_A_RESOURCE_OPTS_NODE_ID, "resource-opts.node-id" },
+	};
+	struct genl_info *info = drbd2_req(ctx)->info;
+	struct nlattr **tb;
+	bool found;
+
+	if (!info->attrs[invariant[field].tla])
+		return false;
+
+	tb = kcalloc(invariant[field].maxtype + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return false;
+	found = !nla_parse_nested(tb, invariant[field].maxtype,
+				  info->attrs[invariant[field].tla],
+				  invariant[field].policy, NULL) &&
+		tb[invariant[field].attr];
+	kfree(tb);
+	if (found)
+		pr_info("must not change invariant attr: %s\n", invariant[field].name);
+	return found;
+}
+
+static int drbd2_put_timeout_type(struct drbd_adm_ctx *ctx, enum drbd_timeout_flag type)
+{
+	struct drbd2_req *req = drbd2_req(ctx);
+
+	if (nla_put_u32(req->reply_skb, DRBD2_A_TIMEOUT_TYPE, type)) {
+		nlmsg_free(req->reply_skb);
+		req->reply_skb = NULL;
+		return -EMSGSIZE;
+	}
+	req->payload_reply = true;
+	return NO_ERROR;
+}
+
+/*
+ * The generated entry points. Each runs the wire-format independent
+ * command implementation in drbd_nl.c and turns an ERR_* outcome into the
+ * errno and extended ACK this dialect reports errors with.
+ */
+static int drbd2_do(struct genl_info *info, int (*fn)(struct drbd_adm_ctx *ctx))
+{
+	struct drbd_adm_ctx *ctx = info->user_ptr[0];
+	struct drbd2_req *req = drbd2_req(ctx);
+	int err;
+
+	err = fn(ctx);
+	if (!err) {
+		if (drbd2_is_ret_code(ctx->result))
+			err = drbd2_errno(ctx->result);
+		else if (ctx->result < SS_AFTER_LAST_ERROR)
+			err = ctx->result;	/* a plain -errno */
+	}
+	if (err) {
+		drbd2_set_extack(info, ctx);
+		nlmsg_free(req->reply_skb);
+		req->reply_skb = NULL;
+	}
+	return err;
+}
+
+#define DRBD2_DOIT(cmd, fn)						\
+int drbd2_nl_##cmd##_doit(struct sk_buff *skb, struct genl_info *info)	\
+{									\
+	return drbd2_do(info, fn);					\
+}
+
+DRBD2_DOIT(resource_new, drbd_adm_new_resource)
+DRBD2_DOIT(resource_del, drbd_adm_del_resource)
+DRBD2_DOIT(resource_set, drbd_adm_resource_opts)
+DRBD2_DOIT(resource_rename, drbd_adm_rename_resource)
+DRBD2_DOIT(resource_down, drbd_adm_down)
+DRBD2_DOIT(resource_primary, drbd_adm_primary)
+DRBD2_DOIT(resource_secondary, drbd_adm_secondary)
+DRBD2_DOIT(resource_suspend_io, drbd_adm_suspend_io)
+DRBD2_DOIT(resource_resume_io, drbd_adm_resume_io)
+DRBD2_DOIT(device_new, drbd_adm_new_minor)
+DRBD2_DOIT(device_del, drbd_adm_del_minor)
+DRBD2_DOIT(device_attach, drbd_adm_attach)
+DRBD2_DOIT(device_detach, drbd_adm_detach)
+DRBD2_DOIT(disk_set, drbd_adm_disk_opts)
+DRBD2_DOIT(device_resize, drbd_adm_resize)
+DRBD2_DOIT(device_outdate, drbd_adm_outdate)
+DRBD2_DOIT(device_invalidate, drbd_adm_invalidate)
+DRBD2_DOIT(device_new_current_uuid, drbd_adm_new_c_uuid)
+DRBD2_DOIT(connection_new, drbd_adm_new_peer)
+DRBD2_DOIT(connection_del, drbd_adm_del_peer)
+DRBD2_DOIT(connection_connect, drbd_adm_connect)
+DRBD2_DOIT(connection_disconnect, drbd_adm_disconnect)
+DRBD2_DOIT(connection_set, drbd_adm_net_opts)
+DRBD2_DOIT(connection_forget, drbd_adm_forget_peer)
+DRBD2_DOIT(path_new, drbd_adm_new_path)
+DRBD2_DOIT(path_del, drbd_adm_del_path)
+DRBD2_DOIT(peer_device_set, drbd_adm_peer_device_opts)
+DRBD2_DOIT(peer_device_invalidate, drbd_adm_invalidate_peer)
+DRBD2_DOIT(peer_device_pause_sync, drbd_adm_pause_sync)
+DRBD2_DOIT(peer_device_resume_sync, drbd_adm_resume_sync)
+DRBD2_DOIT(peer_device_start_ov, drbd_adm_start_ov)
+DRBD2_DOIT(timeout_type_get, drbd_adm_get_timeout_type)
+
+/*
+ * Dumps.
+ *
+ * The core walks the objects; everything below turns one object into one
+ * message of this dialect. This dialect has no room for a result code in
+ * a dump message, so a "retcode" other than NO_ERROR aborts the dump with
+ * the matching errno instead.
+ */
+
+static void *drbd2_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd)
+{
+	return genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			   &drbd2_nl_family, NLM_F_MULTI, cmd);
+}
+
+static int drbd2_emit_resource(struct sk_buff *skb, struct netlink_callback *cb,
+			       struct drbd_resource *resource,
+			       struct drbd_resource_info *info,
+			       struct drbd_resource_statistics *statistics)
+{
+	void *dh = drbd2_dump_put(skb, cb, DRBD2_CMD_RESOURCE_GET);
+
+	if (!dh)
+		return -EMSGSIZE;
+	if (drbd2_put_resource(skb, DRBD2_A_RESOURCE, resource, &resource->res_opts,
+			       info, statistics, NULL)) {
+		genlmsg_cancel(skb, dh);
+		return -EMSGSIZE;
+	}
+	genlmsg_end(skb, dh);
+	return 0;
+}
+
+static int drbd2_emit_device(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+			     struct drbd_device *device, struct drbd_disk_conf *disk_conf,
+			     struct drbd_device_info *info,
+			     struct drbd_device_statistics *statistics)
+{
+	void *dh;
+
+	if (retcode != NO_ERROR)
+		return drbd2_errno(retcode);
+	dh = drbd2_dump_put(skb, cb, DRBD2_CMD_DEVICE_GET);
+	if (!dh)
+		return -EMSGSIZE;
+	if (drbd2_put_device(skb, DRBD2_A_DEVICE, device, disk_conf,
+			     &device->device_conf, info, statistics)) {
+		genlmsg_cancel(skb, dh);
+		return -EMSGSIZE;
+	}
+	genlmsg_end(skb, dh);
+	return 0;
+}
+
+static int drbd2_emit_connection(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+				 struct drbd_resource *resource,
+				 struct drbd_connection *connection,
+				 struct drbd_net_conf *net_conf,
+				 struct drbd_connection_info *info,
+				 struct drbd_connection_statistics *statistics)
+{
+	void *dh;
+
+	if (retcode != NO_ERROR)
+		return drbd2_errno(retcode);
+	dh = drbd2_dump_put(skb, cb, DRBD2_CMD_CONNECTION_GET);
+	if (!dh)
+		return -EMSGSIZE;
+	if (drbd2_put_connection(skb, DRBD2_A_CONNECTION, resource, connection,
+				 net_conf, info, statistics)) {
+		genlmsg_cancel(skb, dh);
+		return -EMSGSIZE;
+	}
+	genlmsg_end(skb, dh);
+	return 0;
+}
+
+static int drbd2_emit_peer_device(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+				  struct drbd_peer_device *peer_device, unsigned int minor,
+				  struct drbd_peer_device_info *info,
+				  struct drbd_peer_device_statistics *statistics,
+				  struct drbd_peer_device_conf *conf)
+{
+	void *dh;
+
+	if (retcode != NO_ERROR)
+		return drbd2_errno(retcode);
+	dh = drbd2_dump_put(skb, cb, DRBD2_CMD_PEER_DEVICE_GET);
+	if (!dh)
+		return -EMSGSIZE;
+	if (drbd2_put_peer_device(skb, DRBD2_A_PEER_DEVICE, peer_device, conf,
+				  info, statistics)) {
+		genlmsg_cancel(skb, dh);
+		return -EMSGSIZE;
+	}
+	genlmsg_end(skb, dh);
+	return 0;
+}
+
+static int drbd2_emit_path(struct sk_buff *skb, struct netlink_callback *cb, int retcode,
+			   struct drbd_resource *resource, struct drbd_connection *connection,
+			   struct drbd_path *path, struct drbd_nl_path_info *info)
+{
+	void *dh;
+
+	if (retcode != NO_ERROR)
+		return drbd2_errno(retcode);
+	dh = drbd2_dump_put(skb, cb, DRBD2_CMD_PATH_GET);
+	if (!dh)
+		return -EMSGSIZE;
+	if (drbd2_put_path(skb, DRBD2_A_PATH, resource, connection, path, info)) {
+		genlmsg_cancel(skb, dh);
+		return -EMSGSIZE;
+	}
+	genlmsg_end(skb, dh);
+	return 0;
+}
+
+/*
+ * The dump callbacks run outside the genl lock and get the request as a
+ * raw message, so the optional context nest is looked up by hand.
+ */
+static struct nlattr *drbd2_find_context_attr(const struct nlmsghdr *nlh, int attr)
+{
+	struct nlattr *nla;
+
+	nla = nla_find(nlmsg_attrdata(nlh, GENL_HDRLEN),
+		       nlmsg_attrlen(nlh, GENL_HDRLEN), DRBD2_A_CONTEXT);
+	if (!nla)
+		return NULL;
+	return nla_find_nested(nla, attr);
+}
+
+/*
+ * Resolve the optional resource-name filter of a dump on its first call.
+ * The core expects the resource in cb->args[0], with a reference that the
+ * matching _done callback drops again. Returns -ENOENT when the name does
+ * not name a resource, and 0 when there is nothing to filter by.
+ */
+static int drbd2_dump_filter(struct netlink_callback *cb, int holder_nr)
+{
+	struct drbd_resource *resource;
+	struct nlattr *filter;
+
+	filter = drbd2_find_context_attr(cb->nlh, DRBD2_A_CONTEXT_RESOURCE_NAME);
+	if (IS_ERR_OR_NULL(filter))
+		return 0;
+	resource = drbd_find_resource(nla_data(filter));
+	if (!resource)
+		return -ENOENT;
+	cb->args[0] = (long)resource;
+	return 0;
+}
+
+int drbd2_nl_resource_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return drbd_dump_resources(skb, cb, &drbd2_dialect);
+}
+
+int drbd2_nl_device_get_done(struct netlink_callback *cb)
+{
+	return drbd_dump_devices_done(cb);
+}
+
+int drbd2_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	if (!cb->args[0] && !cb->args[1]) {
+		int err = drbd2_dump_filter(cb, 7);
+
+		if (err)
+			return err;
+	}
+	return drbd_dump_devices(skb, cb, &drbd2_dialect);
+}
+
+int drbd2_nl_connection_get_done(struct netlink_callback *cb)
+{
+	return drbd_dump_connections_done(cb);
+}
+
+int drbd2_nl_connection_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	if (!cb->args[0]) {
+		int err = drbd2_dump_filter(cb, 6);
+
+		if (err)
+			return err;
+		if (cb->args[0])
+			cb->args[1] = DRBD_DUMP_SINGLE_RESOURCE;
+	}
+	return drbd_dump_connections(skb, cb, &drbd2_dialect);
+}
+
+int drbd2_nl_peer_device_get_done(struct netlink_callback *cb)
+{
+	return drbd_dump_peer_devices_done(cb);
+}
+
+int drbd2_nl_peer_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	if (!cb->args[0] && !cb->args[1]) {
+		int err = drbd2_dump_filter(cb, 9);
+
+		if (err)
+			return err;
+	}
+	return drbd_dump_peer_devices(skb, cb, &drbd2_dialect);
+}
+
+int drbd2_nl_path_get_done(struct netlink_callback *cb)
+{
+	return drbd_dump_paths_done(cb);
+}
+
+int drbd2_nl_path_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	if (!cb->args[0]) {
+		int err = drbd2_dump_filter(cb, 10);
+
+		if (err)
+			return err;
+		if (cb->args[0])
+			cb->args[1] = DRBD_DUMP_SINGLE_RESOURCE;
+	}
+	return drbd_dump_paths(skb, cb, &drbd2_dialect);
+}
+
+int drbd2_nl_state_get_done(struct netlink_callback *cb)
+{
+	return drbd_dump_initial_state_done(cb);
+}
+
+int drbd2_nl_state_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	/* the replayed state changes are sent under the sequence number of the dump */
+	return drbd_dump_initial_state(skb, cb, &drbd2_dialect, cb->nlh->nlmsg_seq);
+}
+
+/*
+ * Notifications.
+ *
+ * With an skb this is the initial state snapshot of the state-get dump:
+ * append the message to that skb. Without one, allocate a message and
+ * multicast it to the "events" group. Both carry the same attributes; the
+ * command tells them apart. The sequence number comes from the core; it
+ * is the same for every dialect describing the event.
+ */
+
+static u32 drbd2_state_change_action(enum drbd_notification_type type)
+{
+	switch (type & ~NOTIFY_FLAGS) {
+	case NOTIFY_CREATE:	return DRBD2_STATE_CHANGE_ACTION_CREATE;
+	case NOTIFY_CHANGE:	return DRBD2_STATE_CHANGE_ACTION_CHANGE;
+	case NOTIFY_DESTROY:	return DRBD2_STATE_CHANGE_ACTION_DESTROY;
+	case NOTIFY_RENAME:	return DRBD2_STATE_CHANGE_ACTION_RENAME;
+	default:		return DRBD2_STATE_CHANGE_ACTION_EXISTS;
+	}
+}
+
+static void *drbd2_state_change_put(struct sk_buff *skb, unsigned int seq, bool replay,
+				    enum drbd_notification_type type)
+{
+	void *dh = genlmsg_put(skb, 0, seq, &drbd2_nl_family,
+			       replay ? NLM_F_MULTI : 0,
+			       replay ? DRBD2_CMD_STATE_GET : DRBD2_CMD_STATE_CHANGE_NTF);
+
+	if (!dh)
+		return NULL;
+	if (nla_put_u32(skb, DRBD2_A_STATE_CHANGE_ACTION,
+			drbd2_state_change_action(type)))
+		goto fail;
+	if ((type & NOTIFY_CONTINUES) &&
+	    nla_put_flag(skb, DRBD2_A_STATE_CHANGE_MORE))
+		goto fail;
+	return dh;
+
+fail:
+	genlmsg_cancel(skb, dh);
+	return NULL;
+}
+
+static int drbd2_notify_resource_state(struct sk_buff *skb, unsigned int seq,
+				       struct drbd_resource *resource,
+				       struct drbd_resource_info *info,
+				       struct drbd_rename_resource_info *rename_info,
+				       enum drbd_notification_type type)
+{
+	struct drbd_resource_statistics statistics;
+	bool multicast = !skb;
+	void *dh;
+	int err;
+
+	if (multicast) {
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+	}
+
+	err = -EMSGSIZE;
+	dh = drbd2_state_change_put(skb, seq, !multicast, type);
+	if (!dh)
+		goto nla_put_failure;
+	resource_to_statistics(&statistics, resource);
+	if (drbd2_put_resource(skb, DRBD2_A_STATE_CHANGE_RESOURCE, resource, NULL,
+			       info, &statistics, rename_info))
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd2_genl_multicast_events(skb);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return 0;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n", err, seq);
+	return err;
+}
+
+static int drbd2_notify_device_state(struct sk_buff *skb, unsigned int seq,
+				     struct drbd_device *device,
+				     struct drbd_device_info *info,
+				     enum drbd_notification_type type)
+{
+	struct drbd_device_statistics statistics;
+	bool multicast = !skb;
+	void *dh;
+	int err;
+
+	if (multicast) {
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+	}
+
+	err = -EMSGSIZE;
+	dh = drbd2_state_change_put(skb, seq, !multicast, type);
+	if (!dh)
+		goto nla_put_failure;
+	device_to_statistics(&statistics, device);
+	if (drbd2_put_device(skb, DRBD2_A_STATE_CHANGE_DEVICE, device, NULL, NULL,
+			     (type & ~NOTIFY_FLAGS) == NOTIFY_DESTROY ? NULL : info,
+			     &statistics))
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd2_genl_multicast_events(skb);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return 0;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(device, "Error %d while broadcasting event. Event seq:%u\n", err, seq);
+	return err;
+}
+
+static int drbd2_notify_connection_state(struct sk_buff *skb, unsigned int seq,
+					 struct drbd_connection *connection,
+					 struct drbd_connection_info *info,
+					 enum drbd_notification_type type)
+{
+	struct drbd_connection_statistics statistics;
+	bool multicast = !skb;
+	void *dh;
+	int err;
+
+	if (multicast) {
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+	}
+
+	err = -EMSGSIZE;
+	dh = drbd2_state_change_put(skb, seq, !multicast, type);
+	if (!dh)
+		goto nla_put_failure;
+	connection_to_statistics(&statistics, connection);
+	if (drbd2_put_connection(skb, DRBD2_A_STATE_CHANGE_CONNECTION,
+				 connection->resource, connection, NULL,
+				 (type & ~NOTIFY_FLAGS) == NOTIFY_DESTROY ? NULL : info,
+				 &statistics))
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd2_genl_multicast_events(skb);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return 0;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(connection, "Error %d while broadcasting event. Event seq:%u\n", err, seq);
+	return err;
+}
+
+static int drbd2_notify_peer_device_state(struct sk_buff *skb, unsigned int seq,
+					  struct drbd_peer_device *peer_device,
+					  struct drbd_peer_device_info *info,
+					  enum drbd_notification_type type)
+{
+	struct drbd_peer_device_statistics statistics;
+	bool multicast = !skb;
+	void *dh;
+	int err;
+
+	if (multicast) {
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+	}
+
+	err = -EMSGSIZE;
+	dh = drbd2_state_change_put(skb, seq, !multicast, type);
+	if (!dh)
+		goto nla_put_failure;
+	peer_device_to_statistics(&statistics, peer_device);
+	if (drbd2_put_peer_device(skb, DRBD2_A_STATE_CHANGE_PEER_DEVICE, peer_device, NULL,
+				  (type & ~NOTIFY_FLAGS) == NOTIFY_DESTROY ? NULL : info,
+				  &statistics))
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd2_genl_multicast_events(skb);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return 0;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	drbd_err(peer_device, "Error %d while broadcasting event. Event seq:%u\n", err, seq);
+	return err;
+}
+
+static int drbd2_notify_path_state(struct sk_buff *skb, unsigned int seq,
+				   /* until we have a backpointer in drbd_path,
+				    * we need an explicit connection:
+				    */
+				   struct drbd_connection *connection,
+				   struct drbd_path *path,
+				   struct drbd_nl_path_info *info,
+				   enum drbd_notification_type type)
+{
+	bool multicast = !skb;
+	void *dh;
+	int err;
+
+	if (multicast) {
+		skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+		err = -ENOMEM;
+		if (!skb)
+			goto failed;
+	}
+
+	err = -EMSGSIZE;
+	dh = drbd2_state_change_put(skb, seq, !multicast, type);
+	if (!dh)
+		goto nla_put_failure;
+	if (drbd2_put_path(skb, DRBD2_A_STATE_CHANGE_PATH, connection->resource,
+			   connection, path, info))
+		goto nla_put_failure;
+	genlmsg_end(skb, dh);
+	if (multicast) {
+		err = drbd2_genl_multicast_events(skb);
+		/* skb has been consumed or freed in netlink_broadcast() */
+		if (err && err != -ESRCH)
+			goto failed;
+	}
+	return 0;
+
+nla_put_failure:
+	nlmsg_free(skb);
+failed:
+	/* FIXME add path specifics to our drbd_polymorph_printk.h */
+	drbd_err(connection, "path: Error %d while broadcasting event. Event seq:%u\n",
+		 err, seq);
+	return err;
+}
+
+/* Helper events are never replayed, so "skb" is always NULL here. */
+static int drbd2_notify_helper(struct sk_buff *skb, unsigned int seq,
+			       struct drbd_device *device, struct drbd_connection *connection,
+			       const char *name, int status,
+			       enum drbd_notification_type type)
+{
+	struct drbd_resource *resource = device ? device->resource : connection->resource;
+	struct nlattr *nla;
+	void *dh;
+	int err;
+
+	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
+	err = -ENOMEM;
+	if (!skb)
+		goto fail;
+
+	err = -EMSGSIZE;
+	dh = genlmsg_put(skb, 0, seq, &drbd2_nl_family, 0, DRBD2_CMD_HELPER_NTF);
+	if (!dh)
+		goto fail;
+	if (drbd2_put_context(skb, DRBD2_A_CONTEXT, resource, connection, device, NULL))
+		goto fail;
+	nla = nla_nest_start(skb, DRBD2_A_HELPER);
+	if (!nla)
+		goto fail;
+	if (nla_put_string(skb, DRBD2_A_HELPER_INFO_NAME, name) ||
+	    nla_put_u32(skb, DRBD2_A_HELPER_INFO_STATUS, status) ||
+	    nla_put_u32(skb, DRBD2_A_HELPER_INFO_PHASE,
+			(type & ~NOTIFY_FLAGS) == NOTIFY_RESPONSE ?
+			DRBD2_HELPER_PHASE_RESPONSE : DRBD2_HELPER_PHASE_CALL))
+		goto fail;
+	nla_nest_end(skb, nla);
+	genlmsg_end(skb, dh);
+	err = drbd2_genl_multicast_events(skb);
+	skb = NULL;
+	/* skb has been consumed or freed in netlink_broadcast() */
+	if (err && err != -ESRCH)
+		goto fail;
+	return 0;
+
+fail:
+	nlmsg_free(skb);
+	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n", err, seq);
+	return err;
+}
+
+/*
+ * The end of the state-get dump needs no message of its own: appending
+ * nothing ends the dump, and netlink terminates it with NLMSG_DONE.
+ */
+static int drbd2_notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
+{
+	return 0;
+}
+
+static const struct drbd_nl_dialect drbd2_dialect = {
+	.name = "drbd2",
+	.has_set = drbd2_has_set,
+	.overlay = drbd2_overlay,
+	.attr_present = drbd2_attr_present,
+	.put_timeout_type = drbd2_put_timeout_type,
+	.emit_resource = drbd2_emit_resource,
+	.emit_device = drbd2_emit_device,
+	.emit_connection = drbd2_emit_connection,
+	.emit_peer_device = drbd2_emit_peer_device,
+	.emit_path = drbd2_emit_path,
+	.notify_resource_state = drbd2_notify_resource_state,
+	.notify_device_state = drbd2_notify_device_state,
+	.notify_connection_state = drbd2_notify_connection_state,
+	.notify_peer_device_state = drbd2_notify_peer_device_state,
+	.notify_path_state = drbd2_notify_path_state,
+	.notify_helper = drbd2_notify_helper,
+	.notify_initial_state_done = drbd2_notify_initial_state_done,
+};
+
+int drbd_nl_drbd2_init(void)
+{
+	int err = genl_register_family(&drbd2_nl_family);
+
+	if (err)
+		return err;
+	err = drbd_nl_register_dialect(&drbd2_dialect);
+	if (err)
+		genl_unregister_family(&drbd2_nl_family);
+	return err;
+}
+
+void drbd_nl_drbd2_exit(void)
+{
+	genl_unregister_family(&drbd2_nl_family);
+}
diff --git a/include/uapi/linux/drbd2.h b/include/uapi/linux/drbd2.h
new file mode 100644
index 000000000000..d148779eae64
--- /dev/null
+++ b/include/uapi/linux/drbd2.h
@@ -0,0 +1,1012 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drbd2.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_DRBD2_H
+#define _UAPI_LINUX_DRBD2_H
+
+#define DRBD2_FAMILY_NAME	"drbd2"
+#define DRBD2_FAMILY_VERSION	1
+
+#define DRBD2_RESOURCE_NAME_MAX		128
+#define DRBD2_CONNECTION_NAME_MAX	64
+#define DRBD2_SHARED_SECRET_MAX		64
+#define DRBD2_ALG_NAME_MAX		64
+#define DRBD2_TRANSPORT_NAME_MAX	64
+#define DRBD2_DEVICE_PATH_MAX		128
+#define DRBD2_CPU_MASK_SIZE		256
+#define DRBD2_HELPER_NAME_MAX		32
+#define DRBD2_HISTORY_UUIDS_SIZE	256
+
+/**
+ * enum drbd2_io_error_policy - What to do when the backing device reports an
+ *   I/O error (on-io-error).
+ * @DRBD2_IO_ERROR_POLICY_PASS_ON: Mark the failed block out of sync, change
+ *   the disk state to inconsistent and retry the request on a peer.
+ * @DRBD2_IO_ERROR_POLICY_CALL_LOCAL_IO_ERROR: Call the local-io-error handler.
+ * @DRBD2_IO_ERROR_POLICY_DETACH: Detach the backing device and continue in
+ *   diskless mode.
+ */
+enum drbd2_io_error_policy {
+	DRBD2_IO_ERROR_POLICY_PASS_ON,
+	DRBD2_IO_ERROR_POLICY_CALL_LOCAL_IO_ERROR,
+	DRBD2_IO_ERROR_POLICY_DETACH,
+};
+
+/**
+ * enum drbd2_fencing_policy - Fencing policy (fencing).
+ * @DRBD2_FENCING_POLICY_DONT_CARE: Take no fencing action at all.
+ * @DRBD2_FENCING_POLICY_RESOURCE: A node that becomes a disconnected primary
+ *   calls the fence-peer handler to outdate the peer.
+ * @DRBD2_FENCING_POLICY_STONITH: A node that becomes a disconnected primary
+ *   freezes its I/O and calls the fence-peer handler, which may have to shoot
+ *   the peer.
+ */
+enum drbd2_fencing_policy {
+	DRBD2_FENCING_POLICY_DONT_CARE,
+	DRBD2_FENCING_POLICY_RESOURCE,
+	DRBD2_FENCING_POLICY_STONITH,
+};
+
+/**
+ * enum drbd2_after_sb_policy - Split-brain recovery policy (after-sb-0pri,
+ *   after-sb-1pri, after-sb-2pri, rr-conflict).
+ * @DRBD2_AFTER_SB_POLICY_DISCONNECT: Do not resynchronize automatically,
+ *   simply disconnect.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_YOUNGER_PRIMARY: Resynchronize from the node
+ *   that became primary first.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_OLDER_PRIMARY: Resynchronize from the node
+ *   that became primary last.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_ZERO_CHANGES: Resynchronize from the node
+ *   that wrote data since the split brain was detected, or disconnect if both
+ *   nodes wrote.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_LEAST_CHANGES: Resynchronize from the node
+ *   with more modified blocks.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_LOCAL: Discard the data on this node and
+ *   resynchronize it from the peer.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_REMOTE: Discard the data on the peer and
+ *   resynchronize it from this node.
+ * @DRBD2_AFTER_SB_POLICY_CONSENSUS: Discard the data on the secondary if the
+ *   after-sb-0pri policy would discard it as well, otherwise disconnect.
+ * @DRBD2_AFTER_SB_POLICY_DISCARD_SECONDARY: Discard the data on the secondary
+ *   node.
+ * @DRBD2_AFTER_SB_POLICY_CALL_PRI_LOST_AFTER_SB: Take the after-sb-0pri
+ *   decision and call the pri-lost-after-sb handler on the node that has to
+ *   give up its data.
+ * @DRBD2_AFTER_SB_POLICY_VIOLENTLY_AS0P: Always take the after-sb-0pri
+ *   decision, even if that changes the primary's view of the data; this can
+ *   crash the primary.
+ * @DRBD2_AFTER_SB_POLICY_RETRY_CONNECT: Disconnect now and immediately retry
+ *   to connect (rr-conflict only).
+ * @DRBD2_AFTER_SB_POLICY_AUTO_DISCARD: Reverse the resync direction so that
+ *   the current primary is resynchronized from the current secondary
+ *   (rr-conflict with protocol A only).
+ */
+enum drbd2_after_sb_policy {
+	DRBD2_AFTER_SB_POLICY_DISCONNECT,
+	DRBD2_AFTER_SB_POLICY_DISCARD_YOUNGER_PRIMARY,
+	DRBD2_AFTER_SB_POLICY_DISCARD_OLDER_PRIMARY,
+	DRBD2_AFTER_SB_POLICY_DISCARD_ZERO_CHANGES,
+	DRBD2_AFTER_SB_POLICY_DISCARD_LEAST_CHANGES,
+	DRBD2_AFTER_SB_POLICY_DISCARD_LOCAL,
+	DRBD2_AFTER_SB_POLICY_DISCARD_REMOTE,
+	DRBD2_AFTER_SB_POLICY_CONSENSUS,
+	DRBD2_AFTER_SB_POLICY_DISCARD_SECONDARY,
+	DRBD2_AFTER_SB_POLICY_CALL_PRI_LOST_AFTER_SB,
+	DRBD2_AFTER_SB_POLICY_VIOLENTLY_AS0P,
+	DRBD2_AFTER_SB_POLICY_RETRY_CONNECT,
+	DRBD2_AFTER_SB_POLICY_AUTO_DISCARD,
+};
+
+/**
+ * enum drbd2_on_no_data_policy - What to do when no data is accessible
+ *   (on-no-data-accessible).
+ * @DRBD2_ON_NO_DATA_POLICY_IO_ERROR: Complete the requests with an I/O error,
+ *   so that system calls fail with EIO.
+ * @DRBD2_ON_NO_DATA_POLICY_SUSPEND_IO: Suspend I/O until the data becomes
+ *   accessible again or the administrator forces I/O to resume.
+ */
+enum drbd2_on_no_data_policy {
+	DRBD2_ON_NO_DATA_POLICY_IO_ERROR,
+	DRBD2_ON_NO_DATA_POLICY_SUSPEND_IO,
+};
+
+/**
+ * enum drbd2_on_no_quorum_policy - What to do when quorum is lost
+ *   (on-no-quorum).
+ * @DRBD2_ON_NO_QUORUM_POLICY_IO_ERROR: Complete the requests with an I/O error
+ *   while the resource has no quorum.
+ * @DRBD2_ON_NO_QUORUM_POLICY_SUSPEND_IO: Freeze I/O while the resource has no
+ *   quorum.
+ */
+enum drbd2_on_no_quorum_policy {
+	DRBD2_ON_NO_QUORUM_POLICY_IO_ERROR,
+	DRBD2_ON_NO_QUORUM_POLICY_SUSPEND_IO,
+};
+
+/**
+ * enum drbd2_on_suspended_primary_outdated_policy - What to do with a
+ *   suspended primary that became outdated.
+ * @DRBD2_ON_SUSPENDED_PRIMARY_OUTDATED_POLICY_DISCONNECT: Reject connection
+ *   attempts and stay isolated.
+ * @DRBD2_ON_SUSPENDED_PRIMARY_OUTDATED_POLICY_FORCE_SECONDARY: Demote to
+ *   secondary immediately and fail all pending and new I/O requests.
+ */
+enum drbd2_on_suspended_primary_outdated_policy {
+	DRBD2_ON_SUSPENDED_PRIMARY_OUTDATED_POLICY_DISCONNECT,
+	DRBD2_ON_SUSPENDED_PRIMARY_OUTDATED_POLICY_FORCE_SECONDARY,
+};
+
+/**
+ * enum drbd2_on_congestion_policy - What to do when the replication link is
+ *   congested (on-congestion).
+ * @DRBD2_ON_CONGESTION_POLICY_BLOCK: Block application writes until the
+ *   transport's send queue drains.
+ * @DRBD2_ON_CONGESTION_POLICY_PULL_AHEAD: Switch into ahead/behind mode and
+ *   record further changes in the bitmap instead of replicating them.
+ * @DRBD2_ON_CONGESTION_POLICY_DISCONNECT: Disconnect from the peer instead of
+ *   blocking application writes.
+ */
+enum drbd2_on_congestion_policy {
+	DRBD2_ON_CONGESTION_POLICY_BLOCK,
+	DRBD2_ON_CONGESTION_POLICY_PULL_AHEAD,
+	DRBD2_ON_CONGESTION_POLICY_DISCONNECT,
+};
+
+/**
+ * enum drbd2_read_balancing_policy - Read balancing policy (read-balancing).
+ * @DRBD2_READ_BALANCING_POLICY_PREFER_LOCAL: Always read from the local disk.
+ * @DRBD2_READ_BALANCING_POLICY_PREFER_REMOTE: Always read from a peer's disk.
+ * @DRBD2_READ_BALANCING_POLICY_ROUND_ROBIN: Alternate between the local disk
+ *   and a peer for consecutive reads.
+ * @DRBD2_READ_BALANCING_POLICY_LEAST_PENDING: Read from the disk with the
+ *   fewest pending requests.
+ * @DRBD2_READ_BALANCING_POLICY_WHEN_CONGESTED_REMOTE: Read from a peer only
+ *   while the local disk is congested; deprecated since DRBD 9.1.12.
+ * @DRBD2_READ_BALANCING_POLICY_STRIPING_32K: Read alternating 32 KiB stripes
+ *   from the local disk and from a peer.
+ * @DRBD2_READ_BALANCING_POLICY_STRIPING_64K: Read alternating 64 KiB stripes
+ *   from the local disk and from a peer.
+ * @DRBD2_READ_BALANCING_POLICY_STRIPING_128K: Read alternating 128 KiB stripes
+ *   from the local disk and from a peer.
+ * @DRBD2_READ_BALANCING_POLICY_STRIPING_256K: Read alternating 256 KiB stripes
+ *   from the local disk and from a peer.
+ * @DRBD2_READ_BALANCING_POLICY_STRIPING_512K: Read alternating 512 KiB stripes
+ *   from the local disk and from a peer.
+ * @DRBD2_READ_BALANCING_POLICY_STRIPING_1M: Read alternating 1 MiB stripes
+ *   from the local disk and from a peer.
+ */
+enum drbd2_read_balancing_policy {
+	DRBD2_READ_BALANCING_POLICY_PREFER_LOCAL,
+	DRBD2_READ_BALANCING_POLICY_PREFER_REMOTE,
+	DRBD2_READ_BALANCING_POLICY_ROUND_ROBIN,
+	DRBD2_READ_BALANCING_POLICY_LEAST_PENDING,
+	DRBD2_READ_BALANCING_POLICY_WHEN_CONGESTED_REMOTE,
+	DRBD2_READ_BALANCING_POLICY_STRIPING_32K,
+	DRBD2_READ_BALANCING_POLICY_STRIPING_64K,
+	DRBD2_READ_BALANCING_POLICY_STRIPING_128K,
+	DRBD2_READ_BALANCING_POLICY_STRIPING_256K,
+	DRBD2_READ_BALANCING_POLICY_STRIPING_512K,
+	DRBD2_READ_BALANCING_POLICY_STRIPING_1M,
+};
+
+/**
+ * enum drbd2_wire_protocol - Replication protocol (protocol).
+ * @DRBD2_WIRE_PROTOCOL_A: Writes complete as soon as they reached the local
+ *   disk and the local send buffer.
+ * @DRBD2_WIRE_PROTOCOL_B: Writes complete as soon as they reached the local
+ *   disk and all peers acknowledged their receipt.
+ * @DRBD2_WIRE_PROTOCOL_C: Writes complete as soon as they reached the local
+ *   disk and all remote disks.
+ */
+enum drbd2_wire_protocol {
+	DRBD2_WIRE_PROTOCOL_A = 1,
+	DRBD2_WIRE_PROTOCOL_B,
+	DRBD2_WIRE_PROTOCOL_C,
+};
+
+/**
+ * enum drbd2_role - Role of a resource on a node. Values mirror enum drbd_role
+ *   in linux/drbd.h so both netlink dialects share one numbering.
+ * @DRBD2_ROLE_UNKNOWN: The role is not known, for example because the peer is
+ *   not connected.
+ * @DRBD2_ROLE_PRIMARY: The resource is primary; its devices may be opened for
+ *   writing.
+ * @DRBD2_ROLE_SECONDARY: The resource is secondary; its devices may not be
+ *   opened for writing.
+ */
+enum drbd2_role {
+	DRBD2_ROLE_UNKNOWN,
+	DRBD2_ROLE_PRIMARY,
+	DRBD2_ROLE_SECONDARY,
+};
+
+/**
+ * enum drbd2_connection_state - State of a connection to a peer. Values mirror
+ *   enum drbd_conn_state in linux/drbd.h so both netlink dialects share one
+ *   numbering.
+ * @DRBD2_CONNECTION_STATE_STANDALONE: No network configuration is in effect
+ *   and no connection is attempted.
+ * @DRBD2_CONNECTION_STATE_DISCONNECTING: Temporary state on the way to
+ *   standalone while the connection is torn down.
+ * @DRBD2_CONNECTION_STATE_UNCONNECTED: Temporary state before the next
+ *   connection attempt starts.
+ * @DRBD2_CONNECTION_STATE_TIMEOUT: The connection was dropped because the peer
+ *   did not answer in time.
+ * @DRBD2_CONNECTION_STATE_BROKEN_PIPE: The connection was dropped because the
+ *   transport reported a broken connection.
+ * @DRBD2_CONNECTION_STATE_NETWORK_FAILURE: The connection was dropped because
+ *   of a network failure.
+ * @DRBD2_CONNECTION_STATE_PROTOCOL_ERROR: The connection was dropped because
+ *   the peer violated the replication protocol.
+ * @DRBD2_CONNECTION_STATE_TEAR_DOWN: Temporary state while the peer closes the
+ *   connection.
+ * @DRBD2_CONNECTION_STATE_CONNECTING: Listening for the peer and trying to
+ *   establish a connection.
+ * @DRBD2_CONNECTION_STATE_CONNECTED: A connection to the peer is established.
+ */
+enum drbd2_connection_state {
+	DRBD2_CONNECTION_STATE_STANDALONE,
+	DRBD2_CONNECTION_STATE_DISCONNECTING,
+	DRBD2_CONNECTION_STATE_UNCONNECTED,
+	DRBD2_CONNECTION_STATE_TIMEOUT,
+	DRBD2_CONNECTION_STATE_BROKEN_PIPE,
+	DRBD2_CONNECTION_STATE_NETWORK_FAILURE,
+	DRBD2_CONNECTION_STATE_PROTOCOL_ERROR,
+	DRBD2_CONNECTION_STATE_TEAR_DOWN,
+	DRBD2_CONNECTION_STATE_CONNECTING,
+	DRBD2_CONNECTION_STATE_CONNECTED,
+};
+
+/**
+ * enum drbd2_repl_state - Replication state of a peer device. Values mirror
+ *   enum drbd_repl_state in linux/drbd.h so both netlink dialects share one
+ *   numbering.
+ * @DRBD2_REPL_STATE_OFF: The peer device does not replicate because the
+ *   connection is not established.
+ * @DRBD2_REPL_STATE_ESTABLISHED: The peer device is connected and replicating
+ *   normally.
+ * @DRBD2_REPL_STATE_STARTING_SYNC_S: A full resynchronization was requested by
+ *   the administrator and starts with this node as the source.
+ * @DRBD2_REPL_STATE_STARTING_SYNC_T: A full resynchronization was requested by
+ *   the administrator and starts with this node as the target.
+ * @DRBD2_REPL_STATE_WF_BITMAP_S: Waiting for the bitmap exchange to finish,
+ *   with this node as the prospective resync source.
+ * @DRBD2_REPL_STATE_WF_BITMAP_T: Waiting for the bitmap exchange to finish,
+ *   with this node as the prospective resync target.
+ * @DRBD2_REPL_STATE_WF_SYNC_UUID: Waiting for the resync source to create and
+ *   send the new resync UUID.
+ * @DRBD2_REPL_STATE_SYNC_SOURCE: Resynchronization is running with this node
+ *   as the source.
+ * @DRBD2_REPL_STATE_SYNC_TARGET: Resynchronization is running with this node
+ *   as the target.
+ * @DRBD2_REPL_STATE_VERIFY_S: Online verification is running with this node as
+ *   the initiator.
+ * @DRBD2_REPL_STATE_VERIFY_T: Online verification is running with this node as
+ *   the target.
+ * @DRBD2_REPL_STATE_PAUSED_SYNC_S: Resynchronization with this node as the
+ *   source is paused.
+ * @DRBD2_REPL_STATE_PAUSED_SYNC_T: Resynchronization with this node as the
+ *   target is paused.
+ * @DRBD2_REPL_STATE_AHEAD: Replication is suspended because the link is
+ *   congested; changes are only recorded in the bitmap.
+ * @DRBD2_REPL_STATE_BEHIND: The peer is ahead of this node, which will be
+ *   resynchronized once the congestion is over.
+ */
+enum drbd2_repl_state {
+	DRBD2_REPL_STATE_OFF = 9,
+	DRBD2_REPL_STATE_ESTABLISHED,
+	DRBD2_REPL_STATE_STARTING_SYNC_S,
+	DRBD2_REPL_STATE_STARTING_SYNC_T,
+	DRBD2_REPL_STATE_WF_BITMAP_S,
+	DRBD2_REPL_STATE_WF_BITMAP_T,
+	DRBD2_REPL_STATE_WF_SYNC_UUID,
+	DRBD2_REPL_STATE_SYNC_SOURCE,
+	DRBD2_REPL_STATE_SYNC_TARGET,
+	DRBD2_REPL_STATE_VERIFY_S,
+	DRBD2_REPL_STATE_VERIFY_T,
+	DRBD2_REPL_STATE_PAUSED_SYNC_S,
+	DRBD2_REPL_STATE_PAUSED_SYNC_T,
+	DRBD2_REPL_STATE_AHEAD,
+	DRBD2_REPL_STATE_BEHIND,
+};
+
+/**
+ * enum drbd2_disk_state - State of a backing disk. Values mirror enum
+ *   drbd_disk_state in linux/drbd.h so both netlink dialects share one
+ *   numbering.
+ * @DRBD2_DISK_STATE_DISKLESS: No backing device is attached.
+ * @DRBD2_DISK_STATE_ATTACHING: The backing device's metadata is being read.
+ * @DRBD2_DISK_STATE_DETACHING: The backing device is being detached while
+ *   pending I/O drains.
+ * @DRBD2_DISK_STATE_FAILED: The backing device failed; the disk becomes
+ *   diskless once the peers have been told.
+ * @DRBD2_DISK_STATE_NEGOTIATING: Attaching while connected, with the data
+ *   generation still being negotiated with the peers.
+ * @DRBD2_DISK_STATE_INCONSISTENT: The data is inconsistent, for example
+ *   because a resynchronization is in progress.
+ * @DRBD2_DISK_STATE_OUTDATED: The data is consistent but known to be stale
+ *   relative to a peer.
+ * @DRBD2_DISK_STATE_UNKNOWN: The disk state is not known; used only for a
+ *   peer's disk.
+ * @DRBD2_DISK_STATE_CONSISTENT: The data is consistent but it is not yet known
+ *   whether it is up to date.
+ * @DRBD2_DISK_STATE_UP_TO_DATE: The data is consistent and up to date; only
+ *   this state allows application I/O.
+ */
+enum drbd2_disk_state {
+	DRBD2_DISK_STATE_DISKLESS,
+	DRBD2_DISK_STATE_ATTACHING,
+	DRBD2_DISK_STATE_DETACHING,
+	DRBD2_DISK_STATE_FAILED,
+	DRBD2_DISK_STATE_NEGOTIATING,
+	DRBD2_DISK_STATE_INCONSISTENT,
+	DRBD2_DISK_STATE_OUTDATED,
+	DRBD2_DISK_STATE_UNKNOWN,
+	DRBD2_DISK_STATE_CONSISTENT,
+	DRBD2_DISK_STATE_UP_TO_DATE,
+};
+
+/**
+ * enum drbd2_write_ordering - Write ordering method in use for the backing
+ *   device.
+ * @DRBD2_WRITE_ORDERING_NONE: No ordering between dependent writes is enforced
+ *   on the backing device.
+ * @DRBD2_WRITE_ORDERING_DRAIN_IO: Dependent writes are ordered by draining the
+ *   backing device's request queue.
+ * @DRBD2_WRITE_ORDERING_BDEV_FLUSH: Dependent writes are ordered by issuing
+ *   flushes to the backing device.
+ * @DRBD2_WRITE_ORDERING_BIO_BARRIER: Dependent writes are ordered with block
+ *   device barriers, which the Linux block layer no longer provides.
+ */
+enum drbd2_write_ordering {
+	DRBD2_WRITE_ORDERING_NONE,
+	DRBD2_WRITE_ORDERING_DRAIN_IO,
+	DRBD2_WRITE_ORDERING_BDEV_FLUSH,
+	DRBD2_WRITE_ORDERING_BIO_BARRIER,
+};
+
+/**
+ * enum drbd2_timeout_type - Which wait-for-connection timeout applies
+ *   (timeout-type-get reply).
+ * @DRBD2_TIMEOUT_TYPE_DEFAULT: The regular wait-for-connection timeout
+ *   applies.
+ * @DRBD2_TIMEOUT_TYPE_DEGRADED: The degraded-cluster timeout applies because
+ *   the local data is not up to date.
+ * @DRBD2_TIMEOUT_TYPE_PEER_OUTDATED: The timeout for an outdated peer applies.
+ */
+enum drbd2_timeout_type {
+	DRBD2_TIMEOUT_TYPE_DEFAULT,
+	DRBD2_TIMEOUT_TYPE_DEGRADED,
+	DRBD2_TIMEOUT_TYPE_PEER_OUTDATED,
+};
+
+/**
+ * enum drbd2_helper_phase - Whether a helper notification announces the call
+ *   or reports its result.
+ * @DRBD2_HELPER_PHASE_CALL: The helper script is about to be called.
+ * @DRBD2_HELPER_PHASE_RESPONSE: The helper script has finished and its exit
+ *   status is reported.
+ */
+enum drbd2_helper_phase {
+	DRBD2_HELPER_PHASE_CALL,
+	DRBD2_HELPER_PHASE_RESPONSE,
+};
+
+/**
+ * enum drbd2_state_change_action - What a state-change message reports about
+ *   the object it carries. Values are assigned independently of the legacy
+ *   drbd_notification_type.
+ * @DRBD2_STATE_CHANGE_ACTION_EXISTS: The object already existed when the
+ *   notification stream was opened.
+ * @DRBD2_STATE_CHANGE_ACTION_CREATE: The object was just created.
+ * @DRBD2_STATE_CHANGE_ACTION_CHANGE: The state or statistics of the object
+ *   changed.
+ * @DRBD2_STATE_CHANGE_ACTION_DESTROY: The object was destroyed.
+ * @DRBD2_STATE_CHANGE_ACTION_RENAME: The resource was renamed; the new name is
+ *   carried in resource.new-name.
+ */
+enum drbd2_state_change_action {
+	DRBD2_STATE_CHANGE_ACTION_EXISTS,
+	DRBD2_STATE_CHANGE_ACTION_CREATE,
+	DRBD2_STATE_CHANGE_ACTION_CHANGE,
+	DRBD2_STATE_CHANGE_ACTION_DESTROY,
+	DRBD2_STATE_CHANGE_ACTION_RENAME,
+};
+
+/**
+ * enum drbd2_state_result - Outcome of a state change request. Error values
+ *   equal the negated kernel-internal SS_* codes (value 3 is unused); success
+ *   and the other non-error outcomes follow at 29 and above.
+ * @DRBD2_STATE_RESULT_UNKNOWN_ERROR: The state change failed for an
+ *   unspecified reason.
+ * @DRBD2_STATE_RESULT_TWO_PRIMARIES: Multiple primaries are not allowed by the
+ *   configuration.
+ * @DRBD2_STATE_RESULT_NO_UP_TO_DATE_DISK: The request needs access to
+ *   up-to-date data.
+ * @DRBD2_STATE_RESULT_NO_LOCAL_DISK: Cannot resynchronize without a local
+ *   disk.
+ * @DRBD2_STATE_RESULT_NO_REMOTE_DISK: Cannot resynchronize without a remote
+ *   disk.
+ * @DRBD2_STATE_RESULT_CONNECTED_OUTDATES: Refusing to become outdated while
+ *   connected.
+ * @DRBD2_STATE_RESULT_PRIMARY_NOP: Refusing to become primary while the peer
+ *   is not outdated.
+ * @DRBD2_STATE_RESULT_RESYNC_RUNNING: Cannot start online verify or
+ *   resynchronization because one is already active.
+ * @DRBD2_STATE_RESULT_ALREADY_STANDALONE: Cannot disconnect a connection that
+ *   is already standalone.
+ * @DRBD2_STATE_RESULT_CW_FAILED_BY_PEER: The cluster-wide state change was
+ *   refused by a peer node.
+ * @DRBD2_STATE_RESULT_IS_DISKLESS: The device is diskless but the requested
+ *   operation requires a disk.
+ * @DRBD2_STATE_RESULT_DEVICE_IN_USE: The device is held open by someone.
+ * @DRBD2_STATE_RESULT_NO_NET_CONFIG: There is no network configuration for
+ *   this connection.
+ * @DRBD2_STATE_RESULT_NO_VERIFY_ALG: Starting online verify requires a verify
+ *   algorithm to be configured.
+ * @DRBD2_STATE_RESULT_NEED_CONNECTION: The state change requires an
+ *   established connection.
+ * @DRBD2_STATE_RESULT_LOWER_THAN_OUTDATED: The disk state is lower than
+ *   outdated.
+ * @DRBD2_STATE_RESULT_NOT_SUPPORTED: The peer does not support the requested
+ *   protocol feature.
+ * @DRBD2_STATE_RESULT_IN_TRANSIENT_STATE: The object is in a transient state;
+ *   retry after the next state change.
+ * @DRBD2_STATE_RESULT_CONCURRENT_STATE_CHANGE: Concurrent state changes were
+ *   detected and this one was aborted.
+ * @DRBD2_STATE_RESULT_OTHER_VOLUME_PEER_PRIMARY: Another volume is primary on
+ *   the peer, which the configuration does not allow.
+ * @DRBD2_STATE_RESULT_INTERRUPTED: The state change was interrupted.
+ * @DRBD2_STATE_RESULT_PRIMARY_READER: The peer may not become primary while
+ *   the device is open for reading here.
+ * @DRBD2_STATE_RESULT_TIMEOUT: The state change timed out.
+ * @DRBD2_STATE_RESULT_WEAKLY_CONNECTED: Primary nodes must be strongly
+ *   connected among each other.
+ * @DRBD2_STATE_RESULT_NO_QUORUM: The resource does not have quorum.
+ * @DRBD2_STATE_RESULT_ATTACH_NO_BITMAP: An intentionally diskless peer may not
+ *   attach a disk.
+ * @DRBD2_STATE_RESULT_HANDSHAKE_DISCONNECT: Disconnect was chosen during the
+ *   connection handshake.
+ * @DRBD2_STATE_RESULT_HANDSHAKE_RETRY: Retry was chosen during the connection
+ *   handshake.
+ * @DRBD2_STATE_RESULT_SUCCESS: The state change succeeded.
+ * @DRBD2_STATE_RESULT_NOTHING_TO_DO: The requested state was already in
+ *   effect, so nothing had to be done.
+ * @DRBD2_STATE_RESULT_CW_SUCCESS: The cluster-wide state change succeeded.
+ * @DRBD2_STATE_RESULT_CW_NO_NEED: No cluster-wide state change was necessary.
+ */
+enum drbd2_state_result {
+	DRBD2_STATE_RESULT_UNKNOWN_ERROR,
+	DRBD2_STATE_RESULT_TWO_PRIMARIES,
+	DRBD2_STATE_RESULT_NO_UP_TO_DATE_DISK,
+	DRBD2_STATE_RESULT_NO_LOCAL_DISK = 4,
+	DRBD2_STATE_RESULT_NO_REMOTE_DISK,
+	DRBD2_STATE_RESULT_CONNECTED_OUTDATES,
+	DRBD2_STATE_RESULT_PRIMARY_NOP,
+	DRBD2_STATE_RESULT_RESYNC_RUNNING,
+	DRBD2_STATE_RESULT_ALREADY_STANDALONE,
+	DRBD2_STATE_RESULT_CW_FAILED_BY_PEER,
+	DRBD2_STATE_RESULT_IS_DISKLESS,
+	DRBD2_STATE_RESULT_DEVICE_IN_USE,
+	DRBD2_STATE_RESULT_NO_NET_CONFIG,
+	DRBD2_STATE_RESULT_NO_VERIFY_ALG,
+	DRBD2_STATE_RESULT_NEED_CONNECTION,
+	DRBD2_STATE_RESULT_LOWER_THAN_OUTDATED,
+	DRBD2_STATE_RESULT_NOT_SUPPORTED,
+	DRBD2_STATE_RESULT_IN_TRANSIENT_STATE,
+	DRBD2_STATE_RESULT_CONCURRENT_STATE_CHANGE,
+	DRBD2_STATE_RESULT_OTHER_VOLUME_PEER_PRIMARY,
+	DRBD2_STATE_RESULT_INTERRUPTED,
+	DRBD2_STATE_RESULT_PRIMARY_READER,
+	DRBD2_STATE_RESULT_TIMEOUT,
+	DRBD2_STATE_RESULT_WEAKLY_CONNECTED,
+	DRBD2_STATE_RESULT_NO_QUORUM,
+	DRBD2_STATE_RESULT_ATTACH_NO_BITMAP,
+	DRBD2_STATE_RESULT_HANDSHAKE_DISCONNECT,
+	DRBD2_STATE_RESULT_HANDSHAKE_RETRY,
+	DRBD2_STATE_RESULT_SUCCESS,
+	DRBD2_STATE_RESULT_NOTHING_TO_DO,
+	DRBD2_STATE_RESULT_CW_SUCCESS,
+	DRBD2_STATE_RESULT_CW_NO_NEED,
+};
+
+enum {
+	DRBD2_A_ADDRESS_FAMILY = 1,
+	DRBD2_A_ADDRESS_PORT,
+	DRBD2_A_ADDRESS_IPV4,
+	DRBD2_A_ADDRESS_IPV6,
+
+	__DRBD2_A_ADDRESS_MAX,
+	DRBD2_A_ADDRESS_MAX = (__DRBD2_A_ADDRESS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_CONTEXT_RESOURCE_NAME = 1,
+	DRBD2_A_CONTEXT_VOLUME,
+	DRBD2_A_CONTEXT_MINOR,
+	DRBD2_A_CONTEXT_PEER_NODE_ID,
+	DRBD2_A_CONTEXT_CONNECTION_NAME,
+	DRBD2_A_CONTEXT_MY_ADDRESS,
+	DRBD2_A_CONTEXT_PEER_ADDRESS,
+
+	__DRBD2_A_CONTEXT_MAX,
+	DRBD2_A_CONTEXT_MAX = (__DRBD2_A_CONTEXT_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DISK_CONF_BACKING_DEV = 1,
+	DRBD2_A_DISK_CONF_META_DEV,
+	DRBD2_A_DISK_CONF_META_DEV_IDX,
+	DRBD2_A_DISK_CONF_SIZE,
+	DRBD2_A_DISK_CONF_ON_IO_ERROR,
+	DRBD2_A_DISK_CONF_RESYNC_AFTER,
+	DRBD2_A_DISK_CONF_AL_EXTENTS,
+	DRBD2_A_DISK_CONF_DISK_BARRIER,
+	DRBD2_A_DISK_CONF_DISK_FLUSHES,
+	DRBD2_A_DISK_CONF_DISK_DRAIN,
+	DRBD2_A_DISK_CONF_MD_FLUSHES,
+	DRBD2_A_DISK_CONF_DISK_TIMEOUT,
+	DRBD2_A_DISK_CONF_READ_BALANCING,
+	DRBD2_A_DISK_CONF_UNPLUG_WATERMARK,
+	DRBD2_A_DISK_CONF_RS_DISCARD_GRANULARITY,
+	DRBD2_A_DISK_CONF_AL_UPDATES,
+	DRBD2_A_DISK_CONF_DISCARD_ZEROES_IF_ALIGNED,
+	DRBD2_A_DISK_CONF_DISABLE_WRITE_SAME,
+	DRBD2_A_DISK_CONF_BITMAP,
+
+	__DRBD2_A_DISK_CONF_MAX,
+	DRBD2_A_DISK_CONF_MAX = (__DRBD2_A_DISK_CONF_MAX - 1)
+};
+
+enum {
+	DRBD2_A_RESOURCE_OPTS_CPU_MASK = 1,
+	DRBD2_A_RESOURCE_OPTS_ON_NO_DATA_ACCESSIBLE,
+	DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE,
+	DRBD2_A_RESOURCE_OPTS_NODE_ID,
+	DRBD2_A_RESOURCE_OPTS_PEER_ACK_WINDOW,
+	DRBD2_A_RESOURCE_OPTS_TWOPC_TIMEOUT,
+	DRBD2_A_RESOURCE_OPTS_TWOPC_RETRY_TIMEOUT,
+	DRBD2_A_RESOURCE_OPTS_PEER_ACK_DELAY,
+	DRBD2_A_RESOURCE_OPTS_AUTO_PROMOTE_TIMEOUT,
+	DRBD2_A_RESOURCE_OPTS_MAX_IO_DEPTH,
+	DRBD2_A_RESOURCE_OPTS_QUORUM,
+	DRBD2_A_RESOURCE_OPTS_ON_NO_QUORUM,
+	DRBD2_A_RESOURCE_OPTS_QUORUM_MIN_REDUNDANCY,
+	DRBD2_A_RESOURCE_OPTS_ON_SUSPENDED_PRIMARY_OUTDATED,
+	DRBD2_A_RESOURCE_OPTS_DRBD8_COMPAT_MODE,
+	DRBD2_A_RESOURCE_OPTS_EXPLICIT_DRBD8_COMPAT,
+
+	__DRBD2_A_RESOURCE_OPTS_MAX,
+	DRBD2_A_RESOURCE_OPTS_MAX = (__DRBD2_A_RESOURCE_OPTS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_NET_CONF_SHARED_SECRET = 1,
+	DRBD2_A_NET_CONF_CRAM_HMAC_ALG,
+	DRBD2_A_NET_CONF_INTEGRITY_ALG,
+	DRBD2_A_NET_CONF_VERIFY_ALG,
+	DRBD2_A_NET_CONF_CSUMS_ALG,
+	DRBD2_A_NET_CONF_PROTOCOL,
+	DRBD2_A_NET_CONF_CONNECT_INT,
+	DRBD2_A_NET_CONF_TIMEOUT,
+	DRBD2_A_NET_CONF_PING_INT,
+	DRBD2_A_NET_CONF_PING_TIMEO,
+	DRBD2_A_NET_CONF_SNDBUF_SIZE,
+	DRBD2_A_NET_CONF_RCVBUF_SIZE,
+	DRBD2_A_NET_CONF_KO_COUNT,
+	DRBD2_A_NET_CONF_MAX_EPOCH_SIZE,
+	DRBD2_A_NET_CONF_AFTER_SB_0PRI,
+	DRBD2_A_NET_CONF_AFTER_SB_1PRI,
+	DRBD2_A_NET_CONF_AFTER_SB_2PRI,
+	DRBD2_A_NET_CONF_RR_CONFLICT,
+	DRBD2_A_NET_CONF_ON_CONGESTION,
+	DRBD2_A_NET_CONF_CONG_FILL,
+	DRBD2_A_NET_CONF_CONG_EXTENTS,
+	DRBD2_A_NET_CONF_TWO_PRIMARIES,
+	DRBD2_A_NET_CONF_TCP_CORK,
+	DRBD2_A_NET_CONF_ALWAYS_ASBP,
+	DRBD2_A_NET_CONF_USE_RLE,
+	DRBD2_A_NET_CONF_FENCING,
+	DRBD2_A_NET_CONF_CONNECTION_NAME,
+	DRBD2_A_NET_CONF_CSUMS_AFTER_CRASH_ONLY,
+	DRBD2_A_NET_CONF_SOCK_CHECK_TIMEO,
+	DRBD2_A_NET_CONF_TRANSPORT_NAME,
+	DRBD2_A_NET_CONF_MAX_BUFFERS,
+	DRBD2_A_NET_CONF_ALLOW_REMOTE_READ,
+	DRBD2_A_NET_CONF_TLS,
+	DRBD2_A_NET_CONF_TLS_PRIVKEY,
+	DRBD2_A_NET_CONF_TLS_CERTIFICATE,
+	DRBD2_A_NET_CONF_TLS_KEYRING,
+	DRBD2_A_NET_CONF_LOAD_BALANCE_PATHS,
+	DRBD2_A_NET_CONF_RDMA_CTRL_RCVBUF_SIZE,
+	DRBD2_A_NET_CONF_RDMA_CTRL_SNDBUF_SIZE,
+
+	__DRBD2_A_NET_CONF_MAX,
+	DRBD2_A_NET_CONF_MAX = (__DRBD2_A_NET_CONF_MAX - 1)
+};
+
+enum {
+	DRBD2_A_SET_ROLE_PARMS_FORCE = 1,
+
+	__DRBD2_A_SET_ROLE_PARMS_MAX,
+	DRBD2_A_SET_ROLE_PARMS_MAX = (__DRBD2_A_SET_ROLE_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_RESIZE_PARMS_SIZE = 1,
+	DRBD2_A_RESIZE_PARMS_ASSUME_PEER_HAS_SPACE,
+	DRBD2_A_RESIZE_PARMS_ASSUME_CLEAN,
+	DRBD2_A_RESIZE_PARMS_AL_STRIPES,
+	DRBD2_A_RESIZE_PARMS_AL_STRIPE_SIZE,
+
+	__DRBD2_A_RESIZE_PARMS_MAX,
+	DRBD2_A_RESIZE_PARMS_MAX = (__DRBD2_A_RESIZE_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_START_OV_PARMS_START_SECTOR = 1,
+	DRBD2_A_START_OV_PARMS_STOP_SECTOR,
+
+	__DRBD2_A_START_OV_PARMS_MAX,
+	DRBD2_A_START_OV_PARMS_MAX = (__DRBD2_A_START_OV_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_NEW_CURRENT_UUID_PARMS_CLEAR_BM = 1,
+	DRBD2_A_NEW_CURRENT_UUID_PARMS_FORCE_RESYNC,
+
+	__DRBD2_A_NEW_CURRENT_UUID_PARMS_MAX,
+	DRBD2_A_NEW_CURRENT_UUID_PARMS_MAX = (__DRBD2_A_NEW_CURRENT_UUID_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DISCONNECT_PARMS_FORCE = 1,
+
+	__DRBD2_A_DISCONNECT_PARMS_MAX,
+	DRBD2_A_DISCONNECT_PARMS_MAX = (__DRBD2_A_DISCONNECT_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DETACH_PARMS_FORCE = 1,
+	DRBD2_A_DETACH_PARMS_INTENTIONAL_DISKLESS_DETACH,
+
+	__DRBD2_A_DETACH_PARMS_MAX,
+	DRBD2_A_DETACH_PARMS_MAX = (__DRBD2_A_DETACH_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DEVICE_CONF_MAX_BIO_SIZE = 1,
+	DRBD2_A_DEVICE_CONF_INTENTIONAL_DISKLESS,
+	DRBD2_A_DEVICE_CONF_BLOCK_SIZE,
+	DRBD2_A_DEVICE_CONF_DISCARD_GRANULARITY,
+
+	__DRBD2_A_DEVICE_CONF_MAX,
+	DRBD2_A_DEVICE_CONF_MAX = (__DRBD2_A_DEVICE_CONF_MAX - 1)
+};
+
+enum {
+	DRBD2_A_RESOURCE_INFO_ROLE = 1,
+	DRBD2_A_RESOURCE_INFO_SUSP,
+	DRBD2_A_RESOURCE_INFO_SUSP_NOD,
+	DRBD2_A_RESOURCE_INFO_SUSP_FEN,
+	DRBD2_A_RESOURCE_INFO_SUSP_QUORUM,
+	DRBD2_A_RESOURCE_INFO_FAIL_IO,
+
+	__DRBD2_A_RESOURCE_INFO_MAX,
+	DRBD2_A_RESOURCE_INFO_MAX = (__DRBD2_A_RESOURCE_INFO_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DEVICE_INFO_DISK_STATE = 1,
+	DRBD2_A_DEVICE_INFO_IS_INTENTIONAL_DISKLESS,
+	DRBD2_A_DEVICE_INFO_HAS_QUORUM,
+	DRBD2_A_DEVICE_INFO_IS_OPEN,
+	DRBD2_A_DEVICE_INFO_BACKING_DEV_PATH,
+
+	__DRBD2_A_DEVICE_INFO_MAX,
+	DRBD2_A_DEVICE_INFO_MAX = (__DRBD2_A_DEVICE_INFO_MAX - 1)
+};
+
+enum {
+	DRBD2_A_CONNECTION_INFO_CONNECTION_STATE = 1,
+	DRBD2_A_CONNECTION_INFO_ROLE,
+
+	__DRBD2_A_CONNECTION_INFO_MAX,
+	DRBD2_A_CONNECTION_INFO_MAX = (__DRBD2_A_CONNECTION_INFO_MAX - 1)
+};
+
+enum {
+	DRBD2_A_PEER_DEVICE_INFO_REPL_STATE = 1,
+	DRBD2_A_PEER_DEVICE_INFO_DISK_STATE,
+	DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_USER,
+	DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_PEER,
+	DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_DEPENDENCY,
+	DRBD2_A_PEER_DEVICE_INFO_IS_INTENTIONAL_DISKLESS,
+	DRBD2_A_PEER_DEVICE_INFO_RESYNC_SUSP_MAX_PARALLEL,
+
+	__DRBD2_A_PEER_DEVICE_INFO_MAX,
+	DRBD2_A_PEER_DEVICE_INFO_MAX = (__DRBD2_A_PEER_DEVICE_INFO_MAX - 1)
+};
+
+enum {
+	DRBD2_A_RESOURCE_STATISTICS_WRITE_ORDERING = 1,
+
+	__DRBD2_A_RESOURCE_STATISTICS_MAX,
+	DRBD2_A_RESOURCE_STATISTICS_MAX = (__DRBD2_A_RESOURCE_STATISTICS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DEVICE_STATISTICS_SIZE = 1,
+	DRBD2_A_DEVICE_STATISTICS_READ,
+	DRBD2_A_DEVICE_STATISTICS_WRITE,
+	DRBD2_A_DEVICE_STATISTICS_AL_WRITES,
+	DRBD2_A_DEVICE_STATISTICS_BM_WRITES,
+	DRBD2_A_DEVICE_STATISTICS_UPPER_PENDING,
+	DRBD2_A_DEVICE_STATISTICS_LOWER_PENDING,
+	DRBD2_A_DEVICE_STATISTICS_UPPER_BLOCKED,
+	DRBD2_A_DEVICE_STATISTICS_LOWER_BLOCKED,
+	DRBD2_A_DEVICE_STATISTICS_AL_SUSPENDED,
+	DRBD2_A_DEVICE_STATISTICS_EXPOSED_DATA_UUID,
+	DRBD2_A_DEVICE_STATISTICS_CURRENT_UUID,
+	DRBD2_A_DEVICE_STATISTICS_DISK_FLAGS,
+	DRBD2_A_DEVICE_STATISTICS_HISTORY_UUIDS,
+
+	__DRBD2_A_DEVICE_STATISTICS_MAX,
+	DRBD2_A_DEVICE_STATISTICS_MAX = (__DRBD2_A_DEVICE_STATISTICS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_CONNECTION_STATISTICS_CONGESTED = 1,
+	DRBD2_A_CONNECTION_STATISTICS_AP_IN_FLIGHT,
+	DRBD2_A_CONNECTION_STATISTICS_RS_IN_FLIGHT,
+
+	__DRBD2_A_CONNECTION_STATISTICS_MAX,
+	DRBD2_A_CONNECTION_STATISTICS_MAX = (__DRBD2_A_CONNECTION_STATISTICS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_PEER_DEVICE_STATISTICS_RECEIVED = 1,
+	DRBD2_A_PEER_DEVICE_STATISTICS_SENT,
+	DRBD2_A_PEER_DEVICE_STATISTICS_PENDING,
+	DRBD2_A_PEER_DEVICE_STATISTICS_UNACKED,
+	DRBD2_A_PEER_DEVICE_STATISTICS_OUT_OF_SYNC,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RESYNC_FAILED,
+	DRBD2_A_PEER_DEVICE_STATISTICS_BITMAP_UUID,
+	DRBD2_A_PEER_DEVICE_STATISTICS_FLAGS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_TOTAL,
+	DRBD2_A_PEER_DEVICE_STATISTICS_OV_START_SECTOR,
+	DRBD2_A_PEER_DEVICE_STATISTICS_OV_STOP_SECTOR,
+	DRBD2_A_PEER_DEVICE_STATISTICS_OV_POSITION,
+	DRBD2_A_PEER_DEVICE_STATISTICS_OV_LEFT,
+	DRBD2_A_PEER_DEVICE_STATISTICS_OV_SKIPPED,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_SAME_CSUM,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_DT_START_MS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_PAUSED_MS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_DT0_MS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_DB0_SECTORS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_DT1_MS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_DB1_SECTORS,
+	DRBD2_A_PEER_DEVICE_STATISTICS_RS_C_SYNC_RATE,
+	DRBD2_A_PEER_DEVICE_STATISTICS_UUID_FLAGS,
+
+	__DRBD2_A_PEER_DEVICE_STATISTICS_MAX,
+	DRBD2_A_PEER_DEVICE_STATISTICS_MAX = (__DRBD2_A_PEER_DEVICE_STATISTICS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_HELPER_INFO_NAME = 1,
+	DRBD2_A_HELPER_INFO_STATUS,
+	DRBD2_A_HELPER_INFO_PHASE,
+
+	__DRBD2_A_HELPER_INFO_MAX,
+	DRBD2_A_HELPER_INFO_MAX = (__DRBD2_A_HELPER_INFO_MAX - 1)
+};
+
+enum {
+	DRBD2_A_INVALIDATE_PARMS_SYNC_FROM_PEER_NODE_ID = 1,
+	DRBD2_A_INVALIDATE_PARMS_RESET_BITMAP,
+
+	__DRBD2_A_INVALIDATE_PARMS_MAX,
+	DRBD2_A_INVALIDATE_PARMS_MAX = (__DRBD2_A_INVALIDATE_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_PEER_DEVICE_CONF_RESYNC_RATE = 1,
+	DRBD2_A_PEER_DEVICE_CONF_C_PLAN_AHEAD,
+	DRBD2_A_PEER_DEVICE_CONF_C_DELAY_TARGET,
+	DRBD2_A_PEER_DEVICE_CONF_C_FILL_TARGET,
+	DRBD2_A_PEER_DEVICE_CONF_C_MAX_RATE,
+	DRBD2_A_PEER_DEVICE_CONF_C_MIN_RATE,
+	DRBD2_A_PEER_DEVICE_CONF_BITMAP,
+	DRBD2_A_PEER_DEVICE_CONF_RESYNC_WITHOUT_REPLICATION,
+	DRBD2_A_PEER_DEVICE_CONF_PEER_TIEBREAKER,
+
+	__DRBD2_A_PEER_DEVICE_CONF_MAX,
+	DRBD2_A_PEER_DEVICE_CONF_MAX = (__DRBD2_A_PEER_DEVICE_CONF_MAX - 1)
+};
+
+enum {
+	DRBD2_A_CONNECT_PARMS_TENTATIVE = 1,
+	DRBD2_A_CONNECT_PARMS_DISCARD_MY_DATA,
+
+	__DRBD2_A_CONNECT_PARMS_MAX,
+	DRBD2_A_CONNECT_PARMS_MAX = (__DRBD2_A_CONNECT_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_PATH_INFO_ESTABLISHED = 1,
+
+	__DRBD2_A_PATH_INFO_MAX,
+	DRBD2_A_PATH_INFO_MAX = (__DRBD2_A_PATH_INFO_MAX - 1)
+};
+
+enum {
+	DRBD2_A_RENAME_PARMS_NEW_NAME = 1,
+
+	__DRBD2_A_RENAME_PARMS_MAX,
+	DRBD2_A_RENAME_PARMS_MAX = (__DRBD2_A_RENAME_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_INVALIDATE_PEER_PARMS_RESET_BITMAP = 1,
+
+	__DRBD2_A_INVALIDATE_PEER_PARMS_MAX,
+	DRBD2_A_INVALIDATE_PEER_PARMS_MAX = (__DRBD2_A_INVALIDATE_PEER_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_SUSPEND_IO_PARMS_BDEV_FREEZE = 1,
+
+	__DRBD2_A_SUSPEND_IO_PARMS_MAX,
+	DRBD2_A_SUSPEND_IO_PARMS_MAX = (__DRBD2_A_SUSPEND_IO_PARMS_MAX - 1)
+};
+
+enum {
+	DRBD2_A_RESOURCE_CONTEXT = 1,
+	DRBD2_A_RESOURCE_INFO,
+	DRBD2_A_RESOURCE_STATISTICS,
+	DRBD2_A_RESOURCE_NEW_NAME,
+	DRBD2_A_RESOURCE_RESOURCE_OPTS,
+
+	__DRBD2_A_RESOURCE_MAX,
+	DRBD2_A_RESOURCE_MAX = (__DRBD2_A_RESOURCE_MAX - 1)
+};
+
+enum {
+	DRBD2_A_DEVICE_CONTEXT = 1,
+	DRBD2_A_DEVICE_INFO,
+	DRBD2_A_DEVICE_STATISTICS,
+	DRBD2_A_DEVICE_DISK_CONF,
+	DRBD2_A_DEVICE_DEVICE_CONF,
+
+	__DRBD2_A_DEVICE_MAX,
+	DRBD2_A_DEVICE_MAX = (__DRBD2_A_DEVICE_MAX - 1)
+};
+
+enum {
+	DRBD2_A_CONNECTION_CONTEXT = 1,
+	DRBD2_A_CONNECTION_INFO,
+	DRBD2_A_CONNECTION_STATISTICS,
+	DRBD2_A_CONNECTION_NET_CONF,
+	DRBD2_A_CONNECTION_PATH,
+
+	__DRBD2_A_CONNECTION_MAX,
+	DRBD2_A_CONNECTION_MAX = (__DRBD2_A_CONNECTION_MAX - 1)
+};
+
+enum {
+	DRBD2_A_PEER_DEVICE_CONTEXT = 1,
+	DRBD2_A_PEER_DEVICE_INFO,
+	DRBD2_A_PEER_DEVICE_STATISTICS,
+	DRBD2_A_PEER_DEVICE_PEER_DEVICE_CONF,
+
+	__DRBD2_A_PEER_DEVICE_MAX,
+	DRBD2_A_PEER_DEVICE_MAX = (__DRBD2_A_PEER_DEVICE_MAX - 1)
+};
+
+enum {
+	DRBD2_A_PATH_CONTEXT = 1,
+	DRBD2_A_PATH_INFO,
+
+	__DRBD2_A_PATH_MAX,
+	DRBD2_A_PATH_MAX = (__DRBD2_A_PATH_MAX - 1)
+};
+
+enum {
+	DRBD2_A_CONTEXT = 1,
+	DRBD2_A_SET_DEFAULTS,
+	DRBD2_A_STATE_RESULT,
+	DRBD2_A_MESSAGE,
+	DRBD2_A_TIMEOUT_TYPE,
+	DRBD2_A_DISK_CONF,
+	DRBD2_A_RESOURCE_OPTS,
+	DRBD2_A_NET_CONF,
+	DRBD2_A_SET_ROLE_PARMS,
+	DRBD2_A_RESIZE_PARMS,
+	DRBD2_A_START_OV_PARMS,
+	DRBD2_A_NEW_CURRENT_UUID_PARMS,
+	DRBD2_A_DISCONNECT_PARMS,
+	DRBD2_A_DETACH_PARMS,
+	DRBD2_A_DEVICE_CONF,
+	DRBD2_A_HELPER,
+	DRBD2_A_INVALIDATE_PARMS,
+	DRBD2_A_PEER_DEVICE_CONF,
+	DRBD2_A_CONNECT_PARMS,
+	DRBD2_A_RENAME_PARMS,
+	DRBD2_A_INVALIDATE_PEER_PARMS,
+	DRBD2_A_SUSPEND_IO_PARMS,
+	DRBD2_A_RESOURCE,
+	DRBD2_A_DEVICE,
+	DRBD2_A_CONNECTION,
+	DRBD2_A_PEER_DEVICE,
+	DRBD2_A_PATH,
+
+	__DRBD2_A_MAX,
+	DRBD2_A_MAX = (__DRBD2_A_MAX - 1)
+};
+
+enum {
+	DRBD2_A_STATE_CHANGE_ACTION = 1,
+	DRBD2_A_STATE_CHANGE_MORE,
+	DRBD2_A_STATE_CHANGE_RESOURCE,
+	DRBD2_A_STATE_CHANGE_DEVICE,
+	DRBD2_A_STATE_CHANGE_CONNECTION,
+	DRBD2_A_STATE_CHANGE_PEER_DEVICE,
+	DRBD2_A_STATE_CHANGE_PATH,
+
+	__DRBD2_A_STATE_CHANGE_MAX,
+	DRBD2_A_STATE_CHANGE_MAX = (__DRBD2_A_STATE_CHANGE_MAX - 1)
+};
+
+enum {
+	DRBD2_CMD_RESOURCE_NEW = 1,
+	DRBD2_CMD_RESOURCE_DEL,
+	DRBD2_CMD_RESOURCE_SET,
+	DRBD2_CMD_RESOURCE_RENAME,
+	DRBD2_CMD_RESOURCE_DOWN,
+	DRBD2_CMD_RESOURCE_PRIMARY,
+	DRBD2_CMD_RESOURCE_SECONDARY,
+	DRBD2_CMD_RESOURCE_SUSPEND_IO,
+	DRBD2_CMD_RESOURCE_RESUME_IO,
+	DRBD2_CMD_DEVICE_NEW,
+	DRBD2_CMD_DEVICE_DEL,
+	DRBD2_CMD_DEVICE_ATTACH,
+	DRBD2_CMD_DEVICE_DETACH,
+	DRBD2_CMD_DISK_SET,
+	DRBD2_CMD_DEVICE_RESIZE,
+	DRBD2_CMD_DEVICE_OUTDATE,
+	DRBD2_CMD_DEVICE_INVALIDATE,
+	DRBD2_CMD_DEVICE_NEW_CURRENT_UUID,
+	DRBD2_CMD_CONNECTION_NEW,
+	DRBD2_CMD_CONNECTION_DEL,
+	DRBD2_CMD_CONNECTION_CONNECT,
+	DRBD2_CMD_CONNECTION_DISCONNECT,
+	DRBD2_CMD_CONNECTION_SET,
+	DRBD2_CMD_CONNECTION_FORGET,
+	DRBD2_CMD_PATH_NEW,
+	DRBD2_CMD_PATH_DEL,
+	DRBD2_CMD_PEER_DEVICE_SET,
+	DRBD2_CMD_PEER_DEVICE_INVALIDATE,
+	DRBD2_CMD_PEER_DEVICE_PAUSE_SYNC,
+	DRBD2_CMD_PEER_DEVICE_RESUME_SYNC,
+	DRBD2_CMD_PEER_DEVICE_START_OV,
+	DRBD2_CMD_TIMEOUT_TYPE_GET,
+	DRBD2_CMD_RESOURCE_GET,
+	DRBD2_CMD_DEVICE_GET,
+	DRBD2_CMD_CONNECTION_GET,
+	DRBD2_CMD_PEER_DEVICE_GET,
+	DRBD2_CMD_PATH_GET,
+	DRBD2_CMD_STATE_GET,
+	DRBD2_CMD_STATE_CHANGE_NTF,
+	DRBD2_CMD_HELPER_NTF,
+
+	__DRBD2_CMD_MAX,
+	DRBD2_CMD_MAX = (__DRBD2_CMD_MAX - 1)
+};
+
+#define DRBD2_MCGRP_EVENTS	"events"
+
+#endif /* _UAPI_LINUX_DRBD2_H */
-- 
2.55.0

