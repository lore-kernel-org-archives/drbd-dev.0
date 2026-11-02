Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793612785;
	b=Sal+A6FVTVmkG/R3grgGGdyjlfZndOfGyiQNEWUXUXSp9hkrrW2eV7dyT0ioJGZgy9gz
	 NOH7AijT+SAAv96Z103wUozE3CaKkzhlQymMoO6lCIy5JzP1HostQ4akE1LmTHayjG23w
	 uF6Pw1KWYTv+PopPFokGO0rX6BmKrJZDELMPI4DyIBtFzPbangaXweKNm4rdxacDZwkoc
	 EvjQ04Lnjn5RH/2/ZAYvKICZ2co/yXfOgM7skOpgQd87vLrbEMMH+m9cPxiMjbOY/jRDT
	 cv5RnNdDmg0bWmnG4IHM+yhK7pXqEBZVGWGjv2lBOD0ORTnAfiuWwbI53fEQTeyh2rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jolDB8RXzCYtilq18SVlF5r1ecpdP3ef0f8rt4Nb41U=;
	b=AOCriYo2r+kGSM+OuXu+f8Dg0ZL1yXXQVivBGo4HR+j+le7/MUDHTC6il9BGvMgZJuFD
	 gEBjWUZd6HqqxPoxvNFZ04+g1vtZ6ska0vBBylso+qwUU+B+LR3tb5qsekdgdhPVW+Hst
	 o6tB4IDUlDy/I+ydDI7Guu09m488SFmLsQZdQWlr2ykt6OImhrbDuiGEd9GN5UAczBIQy
	 BRhWxelHPhXNqtLXg/lDegse/sy67pU86cC0QFE82ElWEUpkW//bFNKldbM4qXah73okV
	 U4dTaMe9CW0ePHOQz7hFIFEx4TSoVYFUdoRb3llKplsYx85KnyHHfbLPo8Jakg0nqAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=wa7EcP3b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2F606A327
	for <drbd-dev@lists.linux.dev>; Mon,  2 Nov 2026 09:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D2F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=wa7EcP3b
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so3596953a12.1
        for <drbd-dev@lists.linux.dev>; Mon, 02 Nov 2026 01:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793612783; cv=none;
        d=google.com; s=arc-20260327;
        b=HINbMi8pAg+yqfMSnQiJ3b1vbmKdufzSEuzaGH9Ak3Zxh69aaYn8aNZ/Hmb2gFLVep
         bLtW3PeRlBY01F+ulbrHbPHHHhboKEUwrYob6Rf5rZNwaFqoLwZW/FCK1mcm+/k1t2zT
         cObj9PlUbQJLbpEVtSEVjJU0sfYi9/1ZTcLWtzVN54pZrpD9IYG0WXwMJgshfmJfpoD8
         qtMeGHy+w+8SEHF2YongAkenQ0B8aB7XPPp6i5h2pp4zsM8CtV3HdDgK0+O5LK4dQ9B/
         XanfPdr0jc4hMwL28yQeWJPvIi9pIepi3sg7zokk6+8gLLiiPKuvM1NSJHqhCDBPucaz
         LQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jolDB8RXzCYtilq18SVlF5r1ecpdP3ef0f8rt4Nb41U=;
        fh=wG0PYym8oGoBiHud5ImS5fC727iOo5ArTRCLCMF6YJE=;
        b=cu4uV+PEXNLW+bEmyFmOJ4JJV9VEVQ04XD6yM/wl5cY5SsOgGySYvsN4q4yqzZtciy
         J4IHC/wVApGpoGxZtlbRpgKsaG07YUMPrPYucS7J8iojiRH1DAcfCoY2vpt5haWKOH5i
         Q2tyfCIPNgEOm+lP+PI0iiBg7wjFRA3bUB/MC2fEK0WQqHw19jAkt+UzauIBUdZmqLTT
         Nrim+D/ZOo17B48fmy++5hrCR1nOPtmB5lzZPgB0IFxrlMM1t2V0h26FMwnoIgONOErO
         Vai0Qsa+c6X0yLeE1IsqSYqw8arew9jZxmGqdGPfceUvUUCCS3AN91Ho40sQKrIo5N11
         kAuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1793612783; x=1794217583; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jolDB8RXzCYtilq18SVlF5r1ecpdP3ef0f8rt4Nb41U=;
        b=wa7EcP3bGoBwrorIiTN5zmZMTMDIyEVMVY3kliQZhuoiCnHgTtUEOTjjH627rTYkkx
         wlwGfsd1w/Qkxd2Lyz2xl3ck7835ssTSC0Hva+Pazl3OfmtLLkieS5XBJnk8l/ZRrNKM
         Y669RGbbPZHQOhD63rjfQN4fmbvvIPmyOeHMgYJd4Dxhtylh0XgLPDoklp4t9uIUMeLY
         dIPouzFIWJxwdjRggRTHsaoxt2DMRIKXgGmi6cPbRRVV3kOXL8rJ690ikgntaWQkj8cM
         MKrOUJfP9mil4kr0Imi5TQMDxhnn/D+2FpTzbaUv8o37LRx0hnHyITC5/r4TwqjAVouk
         unxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612783; x=1794217583;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jolDB8RXzCYtilq18SVlF5r1ecpdP3ef0f8rt4Nb41U=;
        b=Aye+Nv6Fb+9hFxhJxg6r1LsC+EgdhbueU806zgRb0LXrtN9HUCjFczJ9ftW9ADCsoj
         DO/K0ePmMxxIAqT6Qmp9Js8cDMdolKGHxQ374Th/WExP5SA9OdRBncCtyhr9NO3zmJZf
         8dziB7SOS9l+QUBu2e9x7/SeRC2E8nlxP/+9SKgif+NirM9vH/eCY+cPVCN5eBKDtGEG
         /DQu1sl8e6vZjo6JeqLZYaDOwfoJQhlbvCsi4I4rHsGwobfZAlVgRtjndbmtutGMwHeP
         p9zTvYnOLMnKhQE8phYBstw4Aza6rW5kX4v5H0WeOF3diuyxJLiV1XsMEcoOFgJwOktx
         fXaw==
X-Gm-Message-State: APuU4Z8KomLom6lYIntYgYhOhwCGOnPARfct6aqynezAgy42c/5pwsSR
	f5sP73l7olBDK8MyT5jFd/ED4fkDyfbVkZ/NKqaEdXlp6AlLK5rsk164OJfpdufTsnh3u/wAglc
	bpqmt4hg+U59a2i8jH7JAmKWNJlMwKM/+X5iPsm/XEdNaPfxjjZwyfY4=
X-Gm-Gg: AYBFou3TBxGvUxdFKVENAarc/aXoxVk/LBHanlF3PHWySqLSrbxmsQRtq7L/qsA0OOK
	g4PY8jHmz/v6iL8KyTIBuwArwFBjMvXcPy3QNfd7x+ouZNiKt1RLdRveYP4jKl2sX3d5RXDR6Lo
	5dlnz1o9dvPSIC9ALodAo2jjtdi6QltwdjcsACe4RDG0IcIwvWANeTYGxUzPDgNfo+H1NhFVJY8
	TB/MQoVd07vSMHJfJlaF8YvJceznOFuWCQfI9iz9ZLDAVRIhm8f0hgvze/uAH0uoa43Q7RCr50q
	HiMDMy02Tebcr1GnrM8hMaduhsooBH3KdaCoMtjD6D9texB4UHOVp9HRXP8CFHkPU5pDM6jXnlj
	gSjPVriCyeeG8lVzXEgeGuFlc7QCjggWPGmNN1w==
X-Received: by 2002:a05:6402:1cc4:b0:6b1:c774:58c0 with SMTP id
 4fb4d7f45d1cf-6b4d4d812f1mr6763831a12.31.1793612783278; Mon, 02 Nov 2026
 01:46:23 -0800 (PST)
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <auBG6pq0aKXwupY9@let2.com>
In-Reply-To: <auBG6pq0aKXwupY9@let2.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Mon, 2 Nov 2026 10:46:11 +0100
X-Gm-Features: AclHuK_c2FZlGPQdokWdYxGlGrDjgpfwT9eWTFVIY6rxZ7-HjDmhq8JDtjKKlZE
Message-ID: <CADGDV=VOZfZY0X0wMc6vWBBsnfTQQNxhRxAa_s=6phsrH1fXOQ@mail.gmail.com>
Subject: Re: 9.3.4: resync after a crashed Primary misses blocks (silent
 divergence) if that node was promoted in place after being Secondary under
 another Primary
To: dominic@let2.com
Cc: drbd-dev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dominic,

thank you for the detailed report. Your analysis of the mechanism is
correct, and the bug is already fixed in git. The fix is not in a
release yet.

In a two-node setup, a Secondary whose peer is Primary stops writing
activity log transactions ("Disabling local AL-updates
(optimization)"). The Primary has those extents in its own on-disk AL,
so a crash of the Primary is covered. The Secondary still tracks the
active extents in its in-memory AL.

The fix is on drbd-9.2 and on master (9.3):

  drbd-9.2: 2529ec433ac0 drbd: write the in-core activity log when AL...
            afd879ce60e7 drbd: write the superblock before AL updates go of=
f
  master:   39d0a42c51a1, cabad431fc02 (merges of the two commits)

Your workaround (down/up before an in-place promotion) avoids the bug.
Setting max-peers to 2 or more in the resource configuration also
avoids it, because the two-node optimization then never turns AL
updates off. This setting takes effect only with newly created
metadata.

You offered to re-run your scripts. A run with current master on your
VMs would confirm the fix for your exact sequence, which differs from
the one in our test.

Best regards,
Phil


On Tue, Oct 27, 2026 at 7:38=E2=80=AFAM Dominic <dominic@let2.com> wrote:
>
> Hello,
>
> Last week I reported the two-volume flush stall (thank you for the quick
> confirmation). While testing our failover design, we found another
> problem on 9.3.4. This one is a silent divergence, so I wanted you to
> know about it.
>
> SUMMARY
>
> Node A has been Secondary while node B was Primary. A is then promoted
> in place, with no down/attach in between. A writes after a disconnect
> and goes down without demoting (as a root-on-DRBD Primary does at
> shutdown). When A comes back, it is SyncSource and the resync completes
> normally. But some blocks that A wrote after the disconnect are not
> resynced, so the two disks then differ while both report UpToDate.
>
> If A is taken down and up (detach/attach) before the in-place
> promotion, the resync is correct.
>
> ENVIRONMENT
>
> - drbd-dkms 9.3.4-1ppa1~resolute1 (GIT-hash e59b287b199f), drbd-utils
>   9.35.0-1ppa1~resolute1 (LINBIT PPA)
> - Ubuntu 26.04, kernel 7.0.0-38-generic, two VirtualBox VMs
> - 2 nodes, protocol C, one resource with 2 volumes, external metadata,
>   auto-promote no, no fencing. al-extents 6433. Same r0.res as in my
>   24 Oct report.
> - The Ubuntu drbd-utils units drbd-graceful-disconnect.service (active)
>   and drbd-graceful-down.service (masked on A, to mimic a root-on-DRBD
>   Primary that can't demote) are in use.
> - Every "up" is attach first (adjust --skip-net, then adjust), to avoid
>   the bug from my last report.
> - Not tried on git master.
>
> REPRODUCTION (A =3D pm1, node-id 0; B =3D pm2, node-id 1; ext4 on volume =
0)
>
> 1. Connected, both UpToDate, both Secondary.
> 2. On B: drbdadm primary r0; mount /dev/drbd0; write a file; umount;
>    drbdadm secondary r0. (Still connected throughout; A stays up.)
> 3. On A, with no down/up: drbdadm primary r0; mount /dev/drbd0; write
>    10 MiB to a file; sync.
> 4. On A: systemctl reboot. drbd-graceful-disconnect disconnects first
>    (B goes Outdated). The ext4 unmount then writes the superblock etc.
>    after the disconnect. A never demotes (graceful-down is masked).
> 5. A boots; drbdadm adjust --skip-net r0; drbdadm adjust r0.
>    A reports "Marked additional 0 KB as out-of-sync based on AL", is
>    SyncSource and resyncs; both volumes end UpToDate.
> 6. Compare the backing devices: volume 0 differs.
>
> Reproduced 3 times out of 3 (two scripted runs and one first sighting).
>
> RESULTS
>
> Failing run (with step 2), volume 0:
>
>   pm1 kernel: drbd r0/0 drbd0 pm2: self B83C73CDF184048C:74B0ADF14B06F564=
:DA5CAA724336D98E:A923FA7E7C56E246 bits:3072 flags:2022
>   pm1 kernel: drbd r0/0 drbd0 pm2: peer 74B0ADF14B06F564:0000000000000000=
:A923FA7E7C56E246:D8B36CA284BD34EA bits:0 flags:120
>   pm1 kernel: drbd r0/0 drbd0 pm2: uuid_compare()=3Dsource-use-bitmap by =
rule=3Dbitmap-self
>   pm1 kernel: drbd r0/0 drbd0 pm2: Began resync as SyncSource (will sync =
12288 KB [3072 bits set]).
>   after resync: md5 of the volume 0 backing device differs between the
>   nodes; the differing 4 KiB blocks are block 0 (4 MiB extent 0, the ext4
>   superblock) and block 65536 (offset 256 MiB, extent 64). Volume 1
>   matches.
>
> Control without step 2 (A was never Secondary under a Primary B):
> same sequence otherwise, "will sync 24576 KB [6144 bits set]", and the
> checksums match afterwards.
>
> Control with step 2 plus "drbdadm down r0; adjust --skip-net; adjust"
> on A before step 3: 6144 bits, checksums match.
>
> So the bitmap A brings back covers 3072 bits instead of 6144, and the
> missing part includes blocks A wrote after the disconnect.
>
> OUR GUESS AT THE MECHANISM (not verified in the code)
>
> While B was Primary, we see "Disabling local AL-updates (optimization)"
> and later "Enabling local AL-updates" in the logs. We suspect that
> extents made active in A's in-memory activity log while it was
> Secondary (from B's replicated writes) stay "hot" after A is promoted.
> A's own later writes to those extents then cause no on-disk AL
> transaction. A never demotes, so its in-memory bitmap is never written
> out. After the crash, applying the on-disk AL doesn't cover those
> extents, so their blocks are never resynced. The affected extents
> (0 and 64) are exactly the ones B wrote while it was Primary, which
> fits this. The detach/attach control also fits it.
>
> IMPACT AND OUR WORKAROUND
>
> The disks diverge silently: both sides report UpToDate after a
> "successful" resync. Our production design promotes only from a fresh
> initramfs (attach, then primary), so we are not exposed. Anyone who
> promotes a long-running Secondary in place and later loses that Primary
> without a clean demote could be. We worked around it by always doing
> down/up before a promotion. We repaired the test VMs with
> "drbdadm invalidate-remote" and confirmed with checksums.
>
> We have the full kernel logs from both nodes, the scripts, and the VMs
> (powered off), and can re-run anything you'd like, including a build
> from git.
>
> Best regards,
> Dominic
