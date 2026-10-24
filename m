Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.177.71.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858281;
	b=qoz7PlnjAoDoS6rEI/aHQu9fqBLngZu0ijigmCqjXUGLCCagpZHLpLjyJtC7mMfax7lN
	 H2EpCo2HeEadPU4V2I4UiHKuWHplzYaFks1UswTm8FMQxwI9wCAo+PAr4VM3WdlsanujK
	 wm9lSXLUQqQIYloLmp8DnoQo2i81vqlKyA6RT29+CnGcT4J+ShjvhnoCdDrnYDAsaDo2Q
	 SkqFUbU2EyibX0F4s6AT+TTSEI362BqPvIEeEaDr1i080ojAZ30VUP8iD0CUesOrJUqss
	 Drz9nSltawbc4vVnwF6icDdybGzLu5ExB9q9kFQQT4XiwsgHQlU9Nd2rucfhiCM/LUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858281;
	h=DMARC-Filter:Received:X-Virus-Scanned:X-Spam-Relay-Country:Received:
	 DKIM-Signature:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=0lRjAoHt5fBxyQQfenUWdsuajKJQVfENZtzAqzEJQ3w=;
	b=2d0RApc+MXnp/5RowdZFjitNxdcIgoQxDrMAyuhiPkkXEaiOxfcWSD3Z3hgM+eE55/CU
	 SkQNWbCNytRmdTkSCd7ch9XO1xrp0oZ3VkoU3aCVkkbKTcU6gv2RLMVUdXGwe6ZiGHq0u
	 7Ul3al757PkVLzhVIUZHNxjdWvkqoxixubXB6fJGlKHZLzbQQlXeYY29AEuk/HZzxrZMv
	 Llam/pCaL238+0kW0w8GwjK+WoQJ6GUpdyG/+es96mBlBq7iCgJn+poZZ65GEnkn22/Br
	 8/Yn+WbNqfgmHhaIFp1LK6cxjPM8qbuRqoCGD2xHdY2iOgwTMuMXojOJphQN5V8UkNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=let2.com;
	spf=pass smtp.mailfrom=let2.com;
	dkim=pass header.d=let2.com header.i=@let2.com header.a=rsa-sha256 header.s=mail header.b=DBdLc3dy;
	arc=none smtp.remote-ip=80.177.71.131
Received: from static-80-177-71-131.vodafonexdsl.co.uk (static-80-177-71-131.vodafonexdsl.co.uk [80.177.71.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE894606A31B
	for <drbd-dev@lists.linux.dev>; Sat, 24 Oct 2026 16:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE894606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=let2.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=let2.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=let2.com header.i=@let2.com header.a=rsa-sha256 header.s=mail header.b=DBdLc3dy
Received: from localhost (localhost [127.0.0.1])
	by static-80-177-71-131.vodafonexdsl.co.uk (Postfix) with ESMTP id A82B12357E;
	Sat, 24 Oct 2026 17:11:08 +0100 (BST)
X-Virus-Scanned: amavis at let2.com
X-Spam-Relay-Country: 
Received: from static-80-177-71-131.vodafonexdsl.co.uk ([127.0.0.1])
 by localhost (let2.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQHgB-OLN1WU; Sat, 24 Oct 2026 17:11:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=let2.com; s=mail;
	t=1792858268; bh=0lRjAoHt5fBxyQQfenUWdsuajKJQVfENZtzAqzEJQ3w=;
	h=Date:From:To:Subject:From;
	b=DBdLc3dy4Hak3/xeDrtQmWLrQrxlO3Xs2HyQUr10+ZMmug1NMSTp2n/iBmPHpk49C
	 Qw8kRWwC4MlIoc0xoehYwWNQi+kjBD0XlNBl/QM+TM3Yk5KiGkrLxQdnNTKqsyQAYL
	 Gj850ZsfkQwrcD8IASdPSBRLx1hIElAnsWwFfZRk=
Received: by static-80-177-71-131.vodafonexdsl.co.uk (Postfix, from userid 1000)
	id 24A1C23564; Sat, 24 Oct 2026 17:11:08 +0100 (BST)
Date: Sat, 24 Oct 2026 17:11:08 +0100
From: Dominic Ferard <dominic@let2.com>
To: drbd-dev@lists.linux.dev
Subject: [BUG] 9.3.4: resync between two Secondaries stuck at 100% - flush
 request never acked (2 volumes, new-peer before attach)
Message-ID: <atzYnDQ-IN0yi3vx@let2.com>
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

On a two-volume resource, a resync between two Secondaries reaches
100% (out-of-sync 0) and never completes: the target stays
Inconsistent/SyncTarget on both volumes indefinitely. It happens when
the source was brought up with a plain "drbdadm up" and its second
volume's peer bitmap_dagtag is higher than its first volume's. We hit
it in production (two standby hosts, both Secondary while the Primary
OS is down) and have reproduced it in two VMs. Details, debugfs output
and our reading of the source are below. Please correct the analysis
if we have it wrong.


Environment
-----------

- drbd-dkms 9.3.4-1ppa1~resolute1 (GIT-hash
  e59b287b199f7224468af85b68a10e83c68213f5), drbd-utils
  9.35.0-1ppa1~resolute1, LINBIT PPA
- Ubuntu 26.04, kernel 7.0.0-38-generic
- 2 nodes, protocol C, 1 resource with 2 volumes, external metadata,
  auto-promote no

    resource r0 {
        options { auto-promote no; }
        net { protocol C; }
        on pm1 {
            node-id 0;
            address 10.10.10.1:7799;
            volume 0 { device /dev/drbd0; disk /dev/disk/by-partlabel/drbd-r0; meta-disk /dev/disk/by-partlabel/drbd-r0-md; }
            volume 1 { device /dev/drbd1; disk /dev/disk/by-partlabel/drbd-r1; meta-disk /dev/disk/by-partlabel/drbd-r1-md; }
        }
        on pm2 {
            node-id 1;
            address 10.10.10.2:7799;
            volume 0 { device /dev/drbd0; disk /dev/disk/by-partlabel/drbd-r0; meta-disk /dev/disk/by-partlabel/drbd-r0-md; }
            volume 1 { device /dev/drbd1; disk /dev/disk/by-partlabel/drbd-r1; meta-disk /dev/disk/by-partlabel/drbd-r1-md; }
        }
    }

(Production also has al-extents 6433 and resync-controller settings;
they are not needed to reproduce.)


Reproduction
------------

Start with both nodes connected and UpToDate.

    pm1: make the resource dagtag non-zero
      pm1# drbdadm primary r0
      pm1# dd if=/dev/urandom of=/dev/drbd0 bs=1M count=10 oflag=direct
      pm1# dd if=/dev/urandom of=/dev/drbd1 bs=1M count=10 oflag=direct

    pm2 goes away
      pm2# drbdadm down r0

    pm1 writes vol0 FIRST, then vol1, so vol1's peer bitmap_dagtag
    ends up higher
      pm1# dd if=/dev/urandom of=/dev/drbd0 bs=1M count=20 oflag=direct
      pm1# dd if=/dev/urandom of=/dev/drbd1 bs=1M count=20 oflag=direct
      pm1# drbdadm secondary r0 && drbdadm down r0

    both come back as Secondary with a plain "up" (new-peer before
    attach)
      pm1# drbdadm up r0
      pm2# drbdadm up r0

Peer slot 1 in pm1's metadata before the "up" (after apply-al):

    vol0 peer[1]  bitmap-dagtag 0x000000000002D000
    vol1 peer[1]  bitmap-dagtag 0x0000000000037000

Result: pm2 is SyncTarget on both volumes with out-of-sync 0 and stays
there (we watched for several minutes; in production it stayed for
about 15 minutes until we intervened).

debugfs, /sys/kernel/debug/drbd/resources/r0/connections/<peer>/debug:

    pm1 (SyncSource), connection pm2:
     resource->dagtag_sector: 225280      (0x37000, from vol1's metadata)
    last_peer_ack_dagtag_seen: 0
       flush_requests_dagtag: 184320      (0x2D000 = vol0's dagtag = dagtag_before_attach)
              flush_sequence: 1
     flush_forward_sent_mask:             (empty: never acked)

    pm2 (SyncTarget), connection pm1:
          pending_flush_mask: pm1,

"drbdadm disconnect r0; drbdadm connect r0" on pm2 starts a 0 KB
resync that also never finishes. pm1 afterwards still shows
last_peer_ack_dagtag_seen: 0 and flush_requests_dagtag: 184320, now
with flush_sequence: 2.

"drbdadm primary r0" on pm1 plus a single 4 KiB write moves
last_peer_ack_dagtag_seen to 225288, and the resync finishes at once.

Controls (same VMs):

- Vol0 written last (so vol0's peer bitmap_dagtag is higher), plain
  "up": the resync finishes. flush_requests_dagtag = 0, while
  last_peer_ack_dagtag_seen is also 0.
- Equal or zero bitmap dagtags (the peer left before any writes):
  finishes.
- Original order, but pm1 brought up with "drbdadm adjust --skip-net
  r0" and then "drbdadm adjust r0" (attach before new-peer): finishes
  in 1 s. last_peer_ack_dagtag_seen = 307208 >= flush_requests_dagtag
  = 266248.


Analysis (from reading the 9.3.4 source)
----------------------------------------

1. "drbdadm up" issues new-resource, new-minor, new-peer, new-path,
   peer-device-options, attach, connect (per "drbdadm -d up"), so
   new-peer runs before any attach.

2. new-peer (drbd_nl.c ~5118) initialises
   connection->last_peer_ack_dagtag_seen = resource->dagtag_sector,
   "so that flushes can be acked even if no further writes occur". At
   that point the dagtag is still 0.

3. Each attach calls update_resource_dagtag() (drbd_nl.c ~2843). The
   first volume raises dagtag_sector from 0 to its max peer
   bitmap_dagtag (dagtag_before_attach = 0). If the second volume's
   bitmap_dagtag is higher, it sets dagtag_before_attach to the first
   volume's (non-zero) value and dagtag_from_backing_dev to its own.

4. When the SyncTarget sends P_FLUSH_REQUESTS, receive_flush_requests()
   (drbd_receiver.c ~5176) sees dagtag_sector ==
   dagtag_from_backing_dev, so it uses dagtag_before_attach (the
   non-zero vol0 value) as flush_requests_dagtag.

5. drbd_check_flush_dagtag_reached() (drbd_receiver.c ~12408) acks
   only when last_peer_ack_dagtag_seen >= flush_requests_dagtag. With
   no Primary anywhere, last_peer_ack_dagtag_seen never moves from 0,
   so the ack never comes.

6. On the target, drbd_resync_check_finished() (drbd_sender.c ~1078)
   waits on drbd_any_flush_pending(), which is resource-wide, so both
   volumes stay SyncTarget. (In production, one volume had already
   enabled peer replication and the other had not.)

With one volume, dagtag_before_attach stays 0 and the ack always
passes, which is why we only started seeing this after moving from
one volume to two.

Possible fixes (your call): when an attach raises dagtag_sector, also
bring last_peer_ack_dagtag_seen up on existing connections that have no
Primary peer; or clamp the flush target in receive_flush_requests() so
it cannot exceed what this node could ever see acked when it has no
Primary peers.


Workaround
----------

On the standby nodes we attach before creating the peer: an
ExecStartPre= for drbd@r0.service runs "drbdadm adjust --skip-net r0"
ahead of its normal "adjust".

Happy to test patches or gather more data; the VM reproduction takes
about two minutes.

Thanks,
Dominic Ferard
