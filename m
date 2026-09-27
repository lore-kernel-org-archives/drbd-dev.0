Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D512E737B
	for <drbd-dev@lists.linux.dev>; Sun, 27 Sep 2026 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790490193; cv=pass; b=XNXkyawLvyfQ9u0oneAYRsLgoScBM/utXTkSfu9qgVQCcYC/FCiyYB7VUbJ84DHfZFegWSa4ek7m4MORAog3TSpK6qhQA38bTa4Ux4GFbNf2nrcf8CH4p7B30M49uq3F7LEaBicaJ7/toB4gQ4AFajwXu9rZXmzAc/EhYCt/1fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790490193; c=relaxed/simple;
	bh=gIvlD0gz3hkTIxBGnokXc4xg9nZ9go4ziwQSBUbKWtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rIX5AgK8NBRNn+qJyo404GjzHVtGbr2auyhJrVW6aF4xdGVfFga1IfdZ/jnXZHk6qUV+KquX6N+stnnxXK2jaB+FU8bEMKzsA6nYopgQkWUomFTD0maC3UKv+FHiTMVN3nff3dQoPe1CzHHhlVW2/TwByMkLBAOCyKMpz7O6WjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITkqNCnS; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITkqNCnS"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344447f9c3dso184949eec.0
        for <drbd-dev@lists.linux.dev>; Sat, 26 Sep 2026 23:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790490191; cv=none;
        d=google.com; s=arc-20260327;
        b=Su/8piXV4BxCf/leas54UlFBk6I8XIBx3Tsz+99rxU7Kpt7T2GHdI4LMY3qct8s2UY
         xA2sawvgKHs6XOd8ogJZuJIum+71vdE8j+4n1oOV8fv0Hk4F3bm4Uxdlp+JZz+0I30Ie
         XK7T2hkvs3SfaA5huRZhnLO8anGx4KE5HGbNsI6m4q8QVUKiQ/D6PNFAYwTzq2hDSrwm
         3R60TDu8Uj68FhwQEZ1OWv2tljDoQ7L3Y6gRzH85W0+LFs7CIZUGu+SUx6zMlpnpnuB6
         ALRDdKoGexHGAWanXej7u26q2X2gcFrPRf1ZEVVvcR1rtLZ/8s9KdMRMoHwBkabkf/DL
         CEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YRMI1jtGqRUR9RvQo/pyHvvmNu36Mq9jOUQYaLWxIp0=;
        fh=eZkLs/QEdDeUk1gXgXHGHrvPk+gXk74pFQE1zYZT7FQ=;
        b=O2TTamBPAXhcjclgsUcbOJZBeQQXNBoHyVQrr4qawxc7uNIZqVFBkvB4zwwqlyX1cn
         ZR2ceJut9OWnYX7hI/8xjIMwXP57YtGq4hzKryxcMj4CErepNwFilLcVB3SVif1SgfqP
         OS1tr/9aGC6GDRYMGCOXhZ9fgUgIjW1Cxkomi4CxcFDiqug2kPGhZnHxjGFImCpSZBrT
         EEkXUTUuvCXXWkqhIsUEADjREm8SQZjxXt+6haGobaHqcDrG20hSXwCUfreg7Jx9wSpK
         G2Z1wsbN/5GT52OlBNzlP/+10wMnB7wlF9JgaBWRwps7EbwpOFvV12vrVVu6JEtd//iS
         k7mQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790490191; x=1791094991; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YRMI1jtGqRUR9RvQo/pyHvvmNu36Mq9jOUQYaLWxIp0=;
        b=ITkqNCnSYEGwKx70LusoJrQigkDEK5fKDjMs64M4WX0WWQl4Cnj+LEsOGczZjPjICd
         z/Jb74O2v2Zxs5/CHSb+iSYbuE9P4bvhljrfwpOy8JUyB+cYhH+zfOKAFlKU2608yrmR
         wWBJMrQMkLq0qISqM1Hfp9bftKRKrO4rSTlXmeDgIrCL5bUFAnQtpfDnBajfiXNy6NEa
         L7g9VYmhSsT+5B6NuUfP7zW8ezCqMnge4F6QHCQP4O0dxH/IWx/b2ewDY4WqhGiayhSI
         sJ2iGEVWemT2X4wNOfBiVf25BvUKxVzBtv0QSQvfH9+GJW/88ZzqUw/nqBAWYFWX4COE
         3Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790490191; x=1791094991;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRMI1jtGqRUR9RvQo/pyHvvmNu36Mq9jOUQYaLWxIp0=;
        b=E7Rt4Hu0Y2ROuPiiTT8XaE2Jbb4SJrgEZCheb/LeSNnLTcy8lQHjKB1qq+lbkkOwMV
         lxS34eY8TE27zcbs6GlD6GVQMOQNinp2z5Lp9JEGkWNMHIeeK5/9bCsNcE7fNZiwMiJK
         Vl7/2+YktT5/woxPu7ip1veW9Ft7sUi/ClVAdK8QvGUjp77/UE+10H3yc4Kj8aJWp88K
         DUDUKP1xzRlzrn+CLqnkkLfW2B1yCICGhqoD9V7ggwkQwWCiMkxJoDbO1dTTROP+BLs4
         BA0bxStN8PqMXXKciPtjqp4e1bSRABJnWa9CwJzGd100V2JIFKQGZVFihtkriLg1kBL+
         7dcQ==
X-Gm-Message-State: AFuF++k3BgSMxj+FLL6Sx+SPXdbKm1TGN7LtcOZVgfizNF9UKlCHN0AA
	7ajqnVpkyuMCpk1wZ4ZcMWmdmMc6v5EcZivPFrAuelMdPy3BHwBFwYLBlgeJCYq5+oPp0h6nXxH
	n06qMISFVbfE6X4ce23qoQ5B80vbjRtGEcbma5ltmng==
X-Gm-Gg: AYBFou1tccMJg4gJiDCimvpwJTksJlWYnOFJsfge+MjxT/cGlv+YFjAIradngyiO7Di
	39tR4v6I4TVIhhdZ1fOCtDhPrWSyjTaQSC7ZLs6SUDzUKn+OPBD0zHOhWp7kx+5xJ87ACIAgKI1
	uKhOqLwt4qurBvfJuSWYWX8KA7mMC9EHeEvi5EBdc1iE2MhJEs+S/CrbKIPkxwDXyOWCNvjsmyJ
	5fIKvpAAW83/fJ9oGmEAeYm9LSahxJdH31xTg1dRU4wzLaNjnYBVMyTHBHTMdcxyt6cS1tlbqop
	VuFQAXxdgzuOyG9yjkJcO4ltv8OKhlT44RdAMJp4o70WHxUp6I3ItdXu
X-Received: by 2002:a05:7301:310:b0:341:bd7e:da35 with SMTP id
 5a478bee46e88-342702bf0e8mr5481548eec.11.1790490190601; Sat, 26 Sep 2026
 23:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Amirhossein Rahimi <amh.rhimi@gmail.com>
Date: Sun, 27 Sep 2026 09:52:57 +0330
X-Gm-Features: AclHuK_aqlhocqjePrGnJni6wRuAmp8reLbvMeGnhKPgfYFNvmIX2eDgn9N77Ig
Message-ID: <CAFQ+Lwv41X=4BFLeWEdacOHowB5M6KojJ8fG90-U+sCNhLkWZg@mail.gmail.com>
Subject: [BUG] DRBD 9.3.4: acknowledgement counter rewind and stalled resync
 after failover
To: drbd-dev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm reporting a recovery stall observed in a three-node DRBD 9.3.4 lab.
After a partition and failover, the returning former primary's
acknowledgement tracking moved backwards. A subsequent replica recovery
then remained stuck, although offline comparison showed identical data
on all three copies.

An experimental patch avoided the failure in one focused comparison.
Could you review the finding and advise whether there is an existing
fix or a preferred correction?

Environment
-----------
- DRBD 9.3.4, upstream revision:
  e59b287b199f7224468af85b68a10e83c68213f5
- Ubuntu, kernel 7.0.0-34-generic.
- Three diskful nodes, referred to here as A, B and C.
- Protocol A, majority quorum, suspended I/O on quorum loss, and native
  demotion of an outdated primary.
- Separate 32 MiB scratch LV on each node. No filesystem, applications
  or DRBD Reactor were involved in this reproducer.

Reproduction sequence
---------------------
1. C was Primary and completed synthetic synchronous 4 KiB writes.
2. A timed 75-second replication-only partition isolated C. A and B
   retained quorum; A promoted normally and accepted another write.
3. After connectivity returned, C demoted as obsolete. Its local write
   watermark remained 2704, but acknowledgement watermarks dropped
   from 2704 to 0.
4. B was taken offline. A accepted another 4 KiB write and demoted.
   B was then brought back.
5. B transferred the required data but remained Inconsistent/SyncTarget,
   with zero blocks outstanding against A. Its alternate path to C
   retained a 4 KiB out-of-sync indication.

At the stalled state, C was waiting for acknowledgement progress 2704
while recording 0; B was waiting for that flush acknowledgement before
completing resync. The peer connections were up and I/O queues were clear.

The stalled target and both sources were then stopped before recovery.
All 33,513,472 logical data bytes, excluding internal DRBD metadata,
matched by SHA256 across all three copies. In this reproduction, the
4 KiB indication was not a difference in stored data, but resync really
was unable to complete.

Suspected cause and experimental patch
-------------------------------------
A postponed write appears able to reach bitmap/peer-acknowledgement
cleanup before drbd_send_and_submit assigns its change tag. The request's
zero-initialized tag can then move acknowledgement tracking backwards,
leaving a wait for an earlier, higher watermark unsatisfied.

The attached experimental patch adds a dagtag_assigned flag, sets it at
actual tag assignment, and gates the relevant bitmap and peer-ack effects
on that flag. It does not simply reject numeric tag zero, which could be
valid after counter wrap. The patch retains the diagnostic and module
identification markers used during the lab comparison.

Only C temporarily ran the patched module; A and B retained their stock
builds. Those builds reported the same upstream revision, but B had a
different pre-existing srcversion, so these were not identical binaries.

In the patched run, the diagnostic caught an unsubmitted 4096-byte write
with tag=0 and state=110000. C's acknowledgement watermark stayed at 4080.
Repeating B's offline/write/return stage then completed recovery in about
seven seconds. All peers reached UpToDate/Established, bitmap counters
were zero, and offline full-data hashes matched again.

This was one focused stock-versus-patch comparison, with different write
counts but the same failure transition and follow-on recovery sequence.
It is not a full regression test. The patched module has been removed;
the lab was restored to stock and the patch has not been deployed in
production.

Could you confirm whether this diagnosis is consistent with the intended
request lifecycle, especially retry/reuse and acknowledgement ordering?
Is there already an upstream fix or supported workaround? Please also
advise what additional targeted diagnostics would be useful.

Thanks.
