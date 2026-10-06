Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984C4A263B
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301602; cv=none; b=prd91eZe5APovWFmryqmAt2NIJLEcxy0s/8ZryfGB2VRSYBgmtwrlOdpM/XkGkbtaf+lAZuZI52nhC6q6qc1nQ3Rj+zn9PXJKPEHb7I/gn22HJS7W7nv9bD/+6UzqLDgBINVe0qZHhGuaZHXsf/SDFu2BhzIg+aZrbr90Fv2RCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301602; c=relaxed/simple;
	bh=UFC+q0G9NWUiS9Vfcy9VlIlsJvd2Zf0ewddFLRKIFBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OH4NcTT+cDciLrKJVWkCrMqdoiH++qkZx3Gxd8sVob1kbsePWhJPKCr3p/cgCx35aWBxmkwMmNbCFM+kYlPFm/+NbLQ2TAbesKwOQWBFGDSryEMC4V88s2u6x+8Odi9Y9CZmX9BhOOmY/Ok/E3yaagr1g+KPWZvLNv8gsA09+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=XbYvByUL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="XbYvByUL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so8453005e9.3
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301595; x=1791906395; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WxFYBksOA78q1M4xyztdXdP4j3rMP5cE0pNGI1EMuXk=;
        b=XbYvByUL49WSdI/bcZ5ON49xM+IAg8ue6DZ1nFRqGrJP0II5PBHrTh9caVTOfWfdRd
         GNjE8Af9qrn7susEHJ1kOD4Bm2CxSsoRtBGteL47AJZFSENpHgWc7lan1fRdpVOOsi9t
         KVzWHpxKZxaBk5zZRlX9aZr9SZl2GeEh/6zPyBLEPqCwoKxzlImwnZ3/9x6R/rw9rBte
         i8VHjs7ptR4XkTtMacB8MXl7OR3vyatYvKkAY5cgqfBmwE2fQS1dvyzceg9l+vjee9Ps
         KL4G7Ff29U4uWxdlLwriFjOhb/jECulKUyKCjCCuAzviehwU/wMZrbwpLA4LqWNwVnVK
         JbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301595; x=1791906395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxFYBksOA78q1M4xyztdXdP4j3rMP5cE0pNGI1EMuXk=;
        b=o7tVLY8XKyl1uxRKTlvv5JEZzfCTXUot1r+u2MR1cJ9QZQGNVHAzFWbxQYjOpHy7/4
         1s2AZhbLPvIRefLg8bxH0pXEsDICUwVboLaiFziWGhb3JJ+s35P6JD5z4ZWq+v+jnZhn
         vlyNZyq53vXq+EQBk/Irx93OHa8+dy15i5SkKAOBMKahXqT8baszgHqZHY+Y5TZ+9M/4
         dJsTWE//TwPBehBhB86OIfK1DKktbvA8NzCtPaHtTLVjUiYyd1vN/jj5c06ov77pBkQW
         nHvYGy3ymVAtf/y6hAB092Jr2z1VjbgDTKgQ90dPwGVNo697JIZ5mpSXyDPPOJyOgQsT
         8NDw==
X-Forwarded-Encrypted: i=1; AKwUvBzqa5XPTBbAP8FqaCXaMIwt8HLeAggP7WpYuKXmyBrhhasTw+60PesItTAx1Rnn6Wfbbzc+n849mw==@lists.linux.dev
X-Gm-Message-State: AFuF++lZgkQ+NWfwc8QIXx8iPCS9ApZVwISzV6fcQj1th8C61eHddCPO
	AJncTiJbBN8qa7x/6nUV/Jmj46FIHK9NMPl6JkcpFui0jzg/6sQCbpnBiTLkX4LICIQ=
X-Gm-Gg: AYBFou1ptLO+lgumSto1DkFUma9d+eZ8qh6oprchz3odeZl0Hl2zeCD95krcou2zlvY
	j6NiyFAXKCL+erhkSYkF68SzFlmKG+fA0T7VkOEcDZmbXvaGDt8OYB261p7P3n0YS7xR91LyIKT
	3mi7huNhvbmY+o+7dtBVe4jy0IjiK7zizmZOTHdB9S8TRGxRc//Ok+peuWFGetYFK10YjT/6qip
	8sh6ECuxFZ8eNFNZFpEViBRpVHglbNIZVD45pKv/NvpFFQBr/P3Lz4SXIIFBm1QgJ4uF9+kWkLg
	vr7dxf66NV3zpUDuZnodZc2bWNRRjQkj/D2u6rck01V8LBXgjGjaUNyPYbyzvi57MFUtqRrnmpt
	y7lK0lNCSa11nPy8a6YR/s/lwffuSfaiXRmoYZk2mWEieVsI0zFO4t+aizCpn4XZkm1LWiXcDYX
	Lvi1sTwrgKV1vu7iRAYTbzVqF7oIgnNrpMDmlV7uQffLbS18ksMyXOhQxnOznCiyeuRSPyP6txd
	1fHPbhEicQvlJjnKLnio/4Qh94dM0yD
X-Received: by 2002:a05:600c:548f:b0:49e:6683:d23c with SMTP id 5b1f17b1804b1-4a17b4b6bfbmr31639045e9.0.1791301595021;
        Tue, 06 Oct 2026 08:46:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:34 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH v2 08/20] drbd: add application/resync IO synchronization documentation
Date: Tue,  6 Oct 2026 17:45:55 +0200
Message-ID: <20261006154607.3936501-9-christoph.boehmwalder@linbit.com>
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

Add documentation describing how DRBD synchronizes application and
resync IO, including the dagtag-based locking scheme introduced with
the DRBD_FF_RESYNC_DAGTAG feature flag.

Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 .../application-resync-synchronization.rst    | 208 ++++++++++++++++++
 .../admin-guide/blockdev/drbd/index.rst       |   1 +
 2 files changed, 209 insertions(+)
 create mode 100644 Documentation/admin-guide/blockdev/drbd/application-resync-synchronization.rst

diff --git a/Documentation/admin-guide/blockdev/drbd/application-resync-synchronization.rst b/Documentation/admin-guide/blockdev/drbd/application-resync-synchronization.rst
new file mode 100644
index 000000000000..895312453229
--- /dev/null
+++ b/Documentation/admin-guide/blockdev/drbd/application-resync-synchronization.rst
@@ -0,0 +1,208 @@
+=========================================
+Application and Resync IO Synchronization
+=========================================
+
+This summary describes one aspect of the Distributed Replicated Block Device
+(DRBD) protocol. For a full definition of the protocol see the DRBD code.
+
+IO operations to the DRBD backing device can originate from 2 sources. Normal
+operations from a filesystem or other user of DRBD are called application IO.
+Resync operations in DRBD also perform reads and writes. These operations must
+be synchronized to ensure that the data on the backing device is correct.
+
+For instance, the following must be prevented:
+
+* Resync read obtains block version v1 on some node
+* Application writes block version v2 on all nodes
+* Resync write overwrites block version v2 with version v1
+
+In addition, care must be taken to ensure that bitmap bits are only cleared
+when this block is genuinely in sync between these nodes.
+
+Synchronization with resync extents
+===================================
+
+Older versions of DRBD without the feature flag ``DRBD_FF_RESYNC_DAGTAG``
+perform synchronization using "resync extents". These are also known as "bitmap
+extents". They are stored in an LRU cache. These extents are exclusive with the
+activity log extents.
+
+Synchronization with data generation tags
+=========================================
+
+When the feature flag ``DRBD_FF_RESYNC_DAGTAG`` is present, DRBD synchronizes
+resync and application IO using the concept of the "data generation tag"
+(dagtag). This is coupled with fine-grained locking of the request intervals,
+implemented internally using an interval tree.
+
+For a given node, the dagtag is the number of sectors written by the
+application on that node. The dagtag is used to determine which node has newer
+data in certain scenarios. DRBD keeps track of the dagtags of its peers.
+
+Whenever a resync request is made, the ``L_SYNC_TARGET`` node making the
+request sends the dagtag from the current Primary node, if any. The
+``L_SYNC_SOURCE`` node must wait until it has received the data corresponding
+to this dagtag before responding to the resync request. This is important for
+preventing the resync from writing older data over newer data.
+
+In addition, the request intervals are locked according to the following
+scheme:
+
+* Primary: The application IO interval is locked while the data is being
+  written to the backing disk. In addition, conflicting application IO is
+  prevented until the epoch containing the request is complete. However, this
+  is effectively a separate lock. Resync IO is not blocked while this lock is
+  held.
+* Secondary: The application IO interval is locked while the data is being
+  written to the backing disk.
+* Sync target: The ``P_RS_DATA_REQUEST`` interval is locked. The lock is taken
+  in two phases. Before sending the request, the interval is locked for
+  conflicts with other peers. Then the dagtag is recorded and the request is
+  sent. When the reply is received, the interval is additionally locked for
+  conflicts with ongoing IO, in particular writes from the same peer. The lock
+  is released when the reply has been received and the data written to the
+  backing disk.
+* Sync source: The ``P_RS_DATA_REQUEST`` interval is locked. The lock is taken
+  when the dagtag for the request is reached. It is released when the
+  ``P_RS_WRITE_ACK`` is received. This lock is a read lock; it is exclusive
+  with write locks, but not with other read locks.
+* Verify source: The online verify interval is marked but does not block any
+  other requests. The mark is set then the dagtag is recorded and the request
+  is sent. The mark is removed when the ``P_OV_REPLY`` has been received, the
+  dagtag from the reply has been reached and the data read. If any conflicting
+  writes occur while the mark is set, the sectors are skipped.
+* Verify target: The online verify interval is marked but does not block any
+  other requests. The mark is set when the dagtag for the request has been
+  reached. It is removed after reading the data. The latest dagtag received by
+  this node is sent with the ``P_OV_REPLY``. If any conflicting writes occur
+  while the mark is set, the sectors are skipped.
+* Sending ``P_PEERS_IN_SYNC``: Intervals are briefly locked while sending
+  ``P_PEERS_IN_SYNC`` to ensure that the bits remain in sync until the packet
+  has been sent.
+
+If a conflict occurs when an interval should be locked, the request is delayed
+until the conflict resolves. Internally this is implemented by storing the
+interval in the tree in an unlocked form. When an interval is removed from the
+tree, the tree is searched for any intervals which can now be released.
+
+Application IO defers to resync IO. That is, application IO is blocked by
+resync IO even when that resync IO has not yet obtained the lock for its
+interval. This is important for ensuring progress. In the normal case, resyncs
+only make one pass through the data. Hence they will eventually terminate.
+Application IO, on the other hand, can keep a given region busy for an
+arbitrary length of time. So resync IO must not wait indefinitely for
+application IO.
+
+Correctness of data
+-------------------
+
+We only consider the synchronization between application and resync IO here.
+
+The locking scheme prevents any writes from other peers to the resync request
+interval from when the request is initiated until the received data is written.
+After the lock is taken on the target, the dagtag is recorded and the request
+is sent to the source. The source then waits until it has reached this dagtag
+before reading. This ensures that the resync data is at least as new as the
+data on the target when the request was made.
+
+Conflicting application writes that reach the target while the resync request
+is in progress are held until the resync data has been written. Hence they
+overwrite the resync data. In the case where the source had already received
+this application write when it performed the resync read, the application write
+will overwrite the resync write on the target with identical data. This is
+harmless.
+
+Resync requests sent from the target are not exclusive with application writes
+from the same peer. However, since the resync and application data originate
+from the same node, they are transmitted in the correct order in the data
+stream. Application IO defers to received resync IO, ensuring that a resync
+write received before an application write is also submitted first.
+
+Correctness of bitmap bits
+--------------------------
+
+DRBD guarantees that bitmap bits are set, or the corresponding activity log
+extent is active, on at least one peer whenever 2 nodes are out of sync with
+each other. A resync is called "stable" when the target is a neighbor of the
+Primary node, if there is one. After a stable resync, all bitmap bits should be
+clear. In other situations, DRBD makes a best effort attempt to clear bits when
+appropriate.
+
+Hence we need to ensure that:
+
+1. Bits are set when out of sync
+2. Bits are only cleared when in sync
+3. Bits are cleared in a stable resync
+
+We are only considering the synchronization of application and resync IO here,
+so we only need to consider interactions between the 2 types. Requirement (1)
+holds due to the general design for how writes work in DRBD. Requirement (3)
+holds because there is no operation that sets bits in a stable resync. The
+potential issues with these interactions arise with requirement (2). We need to
+ensure that bits are never cleared that have become out of sync during the
+operation.
+
+On a Primary node, writes cause bits to be set and cleared when the
+corresponding ``P_BARRIER_ACK`` packets are received. On a Secondary node,
+writes cause bits to be set and cleared when the corresponding ``P_PEER_ACK``
+is received. On a sync target, bits are cleared when the resync data has been
+written. On a sync source, bits are cleared when ``P_RS_WRITE_ACK`` is
+received.
+
+The bits cleared by writes must always be in sync because the corresponding
+nodes have received the write. As demonstrated in the section "correctness of
+data", they cannot lose this data due to a resync.
+
+For a stable resync, bits will not become out of sync for the peer device on
+either side during the resync operation because both peers receive the
+application writes.
+
+On a sync target for an unstable resync, no application writes are received, so
+there will be no bits set that could be incorrectly cleared.
+
+On a sync source for an unstable resync, the interval is locked until
+``P_RS_WRITE_ACK`` is received. Hence, when the bit is cleared, the target has
+the same data for the interval as the source. That is, they are still in sync.
+
+For ``P_PEERS_IN_SYNC`` we consider only the 3 node case. There is only one
+configuration with an unstable resync with 3 nodes. That is a chain
+A - B - C with A being Primary and a sync from B to C. The only
+``P_PEERS_IN_SYNC`` packets that have an effect in this configuration are those
+from B to A indicating that C is in sync for some interval. B only sends this
+packet when no bitmap bits are set towards C for the interval. In addition,
+B must ensure that no application write causes bits to be incorrectly cleared
+on A towards C. This could occur when B has sent ``P_BARRIER_ACK`` for a write
+which is not yet represented in its bitmap towards C. So B must not send
+``P_PEERS_IN_SYNC`` for an interval where this may be the case. To do this, it
+checks that there is no activity in the activity log that overlaps with this
+interval. To ensure that no writes occur between this check and sending
+``P_PEERS_IN_SYNC``, it locks the interval temporarily.
+
+Deadlock safety
+---------------
+
+We can ignore the locking of application IO until the containing epoch is
+complete. No other lock acquisition depends on it. To put it another way, it
+operates on a level above the rest of the locking.
+
+The locking on Primary and Secondary while application IO is being written to
+the backing disk does not depend on any other lock acquisition. So it is
+guaranteed that a locked interval of this type will eventually be unlocked.
+
+Online verify does not block any other operations, so cannot be involved in
+causing a deadlock.
+
+Sending ``P_PEERS_IN_SYNC`` also cannot be involved in causing a deadlock
+because it does not depend on any other lock acquisition.
+
+Resync requests depend on the corresponding peer. If the connection is lost,
+the operation is aborted, so no deadlock will occur as a result of
+non-responsive peers.
+
+A node cannot be both sync source and sync target simultaneously. Hence there
+are no locks in the scheme which can block sync source reads indefinitely. So
+a resync request from a sync target will always eventually receive a reply,
+which allows it to perform the write and unlock its interval. This in turn
+guarantees that the sync source will receive an ack and unlock its interval.
+
+Hence the locking scheme itself is free from distributed deadlocks.
diff --git a/Documentation/admin-guide/blockdev/drbd/index.rst b/Documentation/admin-guide/blockdev/drbd/index.rst
index 561fd1e35917..5d8d6707e4f4 100644
--- a/Documentation/admin-guide/blockdev/drbd/index.rst
+++ b/Documentation/admin-guide/blockdev/drbd/index.rst
@@ -15,5 +15,6 @@ Description
 .. toctree::
    :maxdepth: 1
 
+   application-resync-synchronization
    data-structure-v9
    figures
-- 
2.55.0

