Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.177.71.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083134;
	b=1o5oJfK/4Eem0gIzZa22rRAS3EzlgSkckJogKYoCW4HRLNc7z6BK0dzp51bftzl/pWu1
	 FuIeJPMxIDq8zPsX4gi9BvazOAynlFtcQ7yZBdUNQ9L4ZNJQtlHemkxNEBREXHJEMifLL
	 aa3FG6sxWWpzmVIqrITPsYq17QUQwejTSRuz8Kac6TOO34lKZrgbuP+RkMq1pt0YQUpZz
	 viJiXYE8YxnphCZci0yRi37Z0jCyo4Dxci/vBd444PM5ZElZffki2SmBYkBEm7M2reUOJ
	 cfQoixlwG3Xdhhm2o1JavRkKW3KtwpSYp3P3O33hz+OtPzWKw3t9b9YLVWQJDTyFGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083134;
	h=DMARC-Filter:Received:X-Virus-Scanned:X-Spam-Relay-Country:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=ERiBQUjHN6CAtGxymTpjMANU4U9+04xbfEP7Gz+8k9I=;
	b=zfi5CkAPjxiVfuZcU5gC5PP1wOQJZEyFNAPrTltzKeZhlK4SD0eFkImH2RHdBtz+tgOi
	 PKRMp7F3GHhfg5ORMkp/eNGrf3I7ugpd7wWfiZLQu22mo1E7r7RmNH8cg1mqT4dvkp8fv
	 Cefi/LcFp8oIm1Xg27OStoIhSXPA/W+VkTCJM45huC6GzQbQbRyirlcKnoNGMIvNFN83O
	 Pmewc/+rq2XZjthkMcf47GV/tXDGbtdyfpw4IAqTok3adcNh2B7+6AB7KHlW9Xe/ygBvz
	 VUWx9z5WXwZNSvSk8tv9iorF9C2IIxM2cSZMa3Phjeo0icDlNmic1kXj89oDt2V63XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=let2.com;
	spf=pass smtp.mailfrom=let2.com;
	dkim=pass header.d=let2.com header.i=@let2.com header.a=rsa-sha256 header.s=mail header.b=ZcGXiTCO;
	arc=none smtp.remote-ip=80.177.71.131
Received: from static-80-177-71-131.vodafonexdsl.co.uk (static-80-177-71-131.vodafonexdsl.co.uk [80.177.71.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799A606A31A
	for <drbd-dev@lists.linux.dev>; Tue, 27 Oct 2026 06:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A799A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=let2.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=let2.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=let2.com header.i=@let2.com header.a=rsa-sha256 header.s=mail header.b=ZcGXiTCO
Received: from localhost (localhost [127.0.0.1])
	by static-80-177-71-131.vodafonexdsl.co.uk (Postfix) with ESMTP id 139BB23710;
	Tue, 27 Oct 2026 06:38:35 +0000 (GMT)
X-Virus-Scanned: amavis at let2.com
X-Spam-Relay-Country: 
Received: from static-80-177-71-131.vodafonexdsl.co.uk ([127.0.0.1])
 by localhost (let2.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gl3o421RBkgW; Tue, 27 Oct 2026 06:38:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=let2.com; s=mail;
	t=1793083114; bh=ERiBQUjHN6CAtGxymTpjMANU4U9+04xbfEP7Gz+8k9I=;
	h=Date:From:To:Cc:Subject:From;
	b=ZcGXiTCOBZID42gii4z7+Gkgp/4h7yUUiIDu9GbpGTb06TL1is2TQNvUY+XBUGDY3
	 K2oYYWsmNfpZxUgzgGEHYrKONIyfX99GrcnBNpMLCObjK763J75VSCmLp5YmBxuUTe
	 U5v1VvtSQVlJEEPFvLGPKEfGtVDWp4GqmlhoxE0k=
Received: by static-80-177-71-131.vodafonexdsl.co.uk (Postfix, from userid 1000)
	id 8A45A2370F; Tue, 27 Oct 2026 06:38:34 +0000 (GMT)
Date: Tue, 27 Oct 2026 06:38:34 +0000
From: Dominic <dominic@let2.com>
To: drbd-dev@lists.linux.dev
Cc: philipp.reisner@linbit.com
Subject: 9.3.4: resync after a crashed Primary misses blocks (silent
 divergence) if that node was promoted in place after being Secondary under
 another Primary
Message-ID: <auBG6pq0aKXwupY9@let2.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Last week I reported the two-volume flush stall (thank you for the quick
confirmation). While testing our failover design, we found another
problem on 9.3.4. This one is a silent divergence, so I wanted you to
know about it.

SUMMARY

Node A has been Secondary while node B was Primary. A is then promoted
in place, with no down/attach in between. A writes after a disconnect
and goes down without demoting (as a root-on-DRBD Primary does at
shutdown). When A comes back, it is SyncSource and the resync completes
normally. But some blocks that A wrote after the disconnect are not
resynced, so the two disks then differ while both report UpToDate.

If A is taken down and up (detach/attach) before the in-place
promotion, the resync is correct.

ENVIRONMENT

- drbd-dkms 9.3.4-1ppa1~resolute1 (GIT-hash e59b287b199f), drbd-utils
  9.35.0-1ppa1~resolute1 (LINBIT PPA)
- Ubuntu 26.04, kernel 7.0.0-38-generic, two VirtualBox VMs
- 2 nodes, protocol C, one resource with 2 volumes, external metadata,
  auto-promote no, no fencing. al-extents 6433. Same r0.res as in my
  24 Oct report.
- The Ubuntu drbd-utils units drbd-graceful-disconnect.service (active)
  and drbd-graceful-down.service (masked on A, to mimic a root-on-DRBD
  Primary that can't demote) are in use.
- Every "up" is attach first (adjust --skip-net, then adjust), to avoid
  the bug from my last report.
- Not tried on git master.

REPRODUCTION (A = pm1, node-id 0; B = pm2, node-id 1; ext4 on volume 0)

1. Connected, both UpToDate, both Secondary.
2. On B: drbdadm primary r0; mount /dev/drbd0; write a file; umount;
   drbdadm secondary r0. (Still connected throughout; A stays up.)
3. On A, with no down/up: drbdadm primary r0; mount /dev/drbd0; write
   10 MiB to a file; sync.
4. On A: systemctl reboot. drbd-graceful-disconnect disconnects first
   (B goes Outdated). The ext4 unmount then writes the superblock etc.
   after the disconnect. A never demotes (graceful-down is masked).
5. A boots; drbdadm adjust --skip-net r0; drbdadm adjust r0.
   A reports "Marked additional 0 KB as out-of-sync based on AL", is
   SyncSource and resyncs; both volumes end UpToDate.
6. Compare the backing devices: volume 0 differs.

Reproduced 3 times out of 3 (two scripted runs and one first sighting).

RESULTS

Failing run (with step 2), volume 0:

  pm1 kernel: drbd r0/0 drbd0 pm2: self B83C73CDF184048C:74B0ADF14B06F564:DA5CAA724336D98E:A923FA7E7C56E246 bits:3072 flags:2022
  pm1 kernel: drbd r0/0 drbd0 pm2: peer 74B0ADF14B06F564:0000000000000000:A923FA7E7C56E246:D8B36CA284BD34EA bits:0 flags:120
  pm1 kernel: drbd r0/0 drbd0 pm2: uuid_compare()=source-use-bitmap by rule=bitmap-self
  pm1 kernel: drbd r0/0 drbd0 pm2: Began resync as SyncSource (will sync 12288 KB [3072 bits set]).
  after resync: md5 of the volume 0 backing device differs between the
  nodes; the differing 4 KiB blocks are block 0 (4 MiB extent 0, the ext4
  superblock) and block 65536 (offset 256 MiB, extent 64). Volume 1
  matches.

Control without step 2 (A was never Secondary under a Primary B):
same sequence otherwise, "will sync 24576 KB [6144 bits set]", and the
checksums match afterwards.

Control with step 2 plus "drbdadm down r0; adjust --skip-net; adjust"
on A before step 3: 6144 bits, checksums match.

So the bitmap A brings back covers 3072 bits instead of 6144, and the
missing part includes blocks A wrote after the disconnect.

OUR GUESS AT THE MECHANISM (not verified in the code)

While B was Primary, we see "Disabling local AL-updates (optimization)"
and later "Enabling local AL-updates" in the logs. We suspect that
extents made active in A's in-memory activity log while it was
Secondary (from B's replicated writes) stay "hot" after A is promoted.
A's own later writes to those extents then cause no on-disk AL
transaction. A never demotes, so its in-memory bitmap is never written
out. After the crash, applying the on-disk AL doesn't cover those
extents, so their blocks are never resynced. The affected extents
(0 and 64) are exactly the ones B wrote while it was Primary, which
fits this. The detach/attach control also fits it.

IMPACT AND OUR WORKAROUND

The disks diverge silently: both sides report UpToDate after a
"successful" resync. Our production design promotes only from a fresh
initramfs (attach, then primary), so we are not exposed. Anyone who
promotes a long-running Secondary in place and later loses that Primary
without a clean demote could be. We worked around it by always doing
down/up before a promotion. We repaired the test VMs with
"drbdadm invalidate-remote" and confirmed with checksums.

We have the full kernel logs from both nodes, the scripts, and the VMs
(powered off), and can re-run anything you'd like, including a build
from git.

Best regards,
Dominic
