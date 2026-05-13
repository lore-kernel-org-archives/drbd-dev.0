Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02539F172
	for <drbd-dev@lists.linux.dev>; Wed, 13 May 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670242; cv=none; b=dpwIfu+hvR5roZ/tIMqbXI7TqPg9pdIuvRl9Wg9JeN8zQk4ImL8pm+bMIY6ieGx4JqKekvoBS8uP9g+3uCl/okgZKzRdITMquvQ/Rnod/YrOaA73Bc9zqby6VUz7Aq7ApTe5nnrI/J+w2/YR9jLIpQCfeID99y3u68up/e1xHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670242; c=relaxed/simple;
	bh=K7BijF+4pvSiGwWbTjUVNO5a0o+ZiWOZ+bBEO/RlWLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PvZNoOvNpQ5e+pypLF1NVKzMIzxDaposK4sGM5AOsOQAI99sTyyoGs4KVOQkmBHPyVbBHcB+aoK2nisPugkgTeFK+45nGXLNg04eRE6PKiuaUZS5MO+2TPUxpMXEHvtgvQJH9W2widWi+QJKtxND5ejQk9L4jEjYmi1TsadMtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=tzJZBSsa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="tzJZBSsa"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-449de065cb3so6028818f8f.2
        for <drbd-dev@lists.linux.dev>; Wed, 13 May 2026 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778670239; x=1779275039; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPoijdvfyfbhp5R8nin4PeEtMV5ISfc/KYpiYJU2YHg=;
        b=tzJZBSsaQi5pCF+98ra1ReULDycdM3SBMH7HVKoDnD2SnJ+IneovxdrxXchkk1WcTX
         XCPGCpY0QFR7C58lJzDCGNeDSv1kg47aWehooD/fbIrjXwaFRkk3lh4njWsx0R899B3o
         TokCK6rlQcYaOC1rxiWu96Db0mGVzRBZ0GzvUptgC7DqXxw3OozbHph2X4Bmyajcfz+W
         /xRTzavuNJ26pg5vHYN3qqd9xcg9T05JreaB5KQt2y+lzV/ZDnZIpgMD/p0D7GR7ipq3
         +bQkERfRr5NbvquB1NiKBl6E1dWMAdb5qZ7+GieCFtRrvaUVaqBXGiFu7NSMd/9PW4iJ
         F7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670239; x=1779275039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPoijdvfyfbhp5R8nin4PeEtMV5ISfc/KYpiYJU2YHg=;
        b=sSgjWyb6h9zXjCQ8jDKiAdyRUFq6vzT3KFhnwks7t/vn/XpxTAJUmG+4qP01QNd/5j
         NX2lfdQgYkVsDIUJTm4bUms2VJRGoJx+mphciWiga36c8lkvjau7CAN+KXaTLjv/DhWh
         /J2poRCwm1ioPS4gnYQdPR+zB5TexHk1PTAy5hKAPeqVc7kDf2RqGnKZ5dGcUr6AeGmp
         fHKFgpoLftreOMAgoq9sc70yG8r9kbsFHvTC0rP8ggz/Fo3zyBf63ilf2bPPgV883vda
         xGVTekeAAby6UZjeAQ/SMR6N4BtqJGP6H9RXz5R+8+GAwOiUPvx4mminTQLpihzBOEty
         TabQ==
X-Gm-Message-State: AOJu0YzGF9+2eHL8TWsSPDJi5W3/fftQNGNEUOmVF/xH1/v1PA/R0Qkn
	AEPhIRVOvAB0aRDj38bXy66N8fhSQWUeEjn+IEgJcFyJVOVq0+123KOrUPZUJHJzBJw=
X-Gm-Gg: Acq92OHKw7BanhnWYwVo8cIGjX27nonx6ffaKBfo1vitvtfFNAFqMRlKkkoqZ70ghMR
	7KvY7MJAkau/Z85cXUJwlzy/tv2DBVXmyR7pngMxmIdeH0eVaCl6W9jrWvFViJPf1iCw+RH5805
	KlgPBfFiAN4HbBCautLHu3dQmIbNyg34vHJCV3yzx+YvWC4wP0w+qRy7fVfIOQeVfehDCZTCIaB
	fveFtjQhDLwC0oJPdpGrRjNVRxmTw1vAICVywd/XTiTFQ07km//xLN4iHBjKJUper4nYI7w6mFT
	/I+VYfHFj5lmtbQnBE0Gvx7yzwh3yfeW6dp4pawo9/nF4Yi7sGQoD0JYK/tSsmBMD8WpZcf2Zl9
	XHCH7yY8tv6dEr+NjLTofi6vyeD/6XQv+khT4KMQzCMXfp6Gl5Z+H7gB67gizotkACqFp3NbMl7
	NXO/4QPnAgDGaRNBwy9ltO1MThD8WVciPpQQvEiPbr8t9+hegMdDRvaW4w0HtuBPjN+/A28jYZ/
	CpW/M12HOQ0mVX+7sroBg==
X-Received: by 2002:a05:6000:220b:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45c79586f68mr4008555f8f.17.1778670238975;
        Wed, 13 May 2026 04:03:58 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm38469217f8f.29.2026.05.13.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:03:58 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] drbd: clean up UAPI headers
Date: Wed, 13 May 2026 13:03:42 +0200
Message-ID: <20260513110343.3170338-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b1798910fc7f ("drbd: move UAPI headers to include/uapi/linux/")
broke compilation on targets without a hosted libc:

  ./usr/include/linux/drbd.h:18:10: fatal error: sys/types.h: No such
  file or directory

The underlying issue is that there were some constructs left over in
those headers that don't belong in uapi.

Drop the __KERNEL__-gated split in drbd.h. The !__KERNEL__ branch pulls
in <sys/types.h>, <sys/wait.h> and <limits.h> for symbols that the
header does not actually reference; they were carried over from when
this lived in include/linux/.
Replace <asm/types.h> and the entire #ifdef block with the standard
UAPI combo <linux/types.h> + <asm/byteorder.h>, which provides
__u32/__u64/__s32 and __{LITTLE,BIG}_ENDIAN_BITFIELD in both kernel
and userspace contexts.

drbd_limits.h references some enum values and the DRBD_PROT_C define
from drbd.h, but does not include it. Add the missing include while
we're here.

Drop the unprefixed DEBUG_RANGE_CHECK from drbd_limits.h. It has no
in-kernel users and pollutes the userspace namespace.

Switch the drbd.h and drbd_limits.h include guards to the _UAPI_LINUX_*
convention already used by drbd_genl.h.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605101346.V2wwJqv1-lkp@intel.com/
Fixes: b1798910fc7f ("drbd: move UAPI headers to include/uapi/linux/")
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/uapi/linux/drbd.h        | 28 +++-------------------------
 include/uapi/linux/drbd_limits.h |  8 ++++----
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/include/uapi/linux/drbd.h b/include/uapi/linux/drbd.h
index 5d4d677cf1ad..cf1ec3eb872f 100644
--- a/include/uapi/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -11,32 +11,10 @@
 
 
 */
-#ifndef DRBD_H
-#define DRBD_H
-#include <asm/types.h>
-
-#ifdef __KERNEL__
+#ifndef _UAPI_LINUX_DRBD_H
+#define _UAPI_LINUX_DRBD_H
 #include <linux/types.h>
 #include <asm/byteorder.h>
-#else
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <limits.h>
-
-/* Although the Linux source code makes a difference between
-   generic endianness and the bitfields' endianness, there is no
-   architecture as of Linux-2.6.24-rc4 where the bitfields' endianness
-   does not match the generic endianness. */
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define __LITTLE_ENDIAN_BITFIELD
-#elif __BYTE_ORDER == __BIG_ENDIAN
-#define __BIG_ENDIAN_BITFIELD
-#else
-# error "sorry, weird endianness on this box"
-#endif
-
-#endif
 
 enum drbd_io_error_p {
 	EP_PASS_ON, /* FIXME should the better be named "Ignore"? */
@@ -432,4 +410,4 @@ enum drbd_state_info_bcast_reason {
 	SIB_SYNC_PROGRESS = 5,
 };
 
-#endif
+#endif /* _UAPI_LINUX_DRBD_H */
diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index a72a102d1ca7..acefe84bc602 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -11,10 +11,10 @@
  * feedback about nonsense settings for certain configurable values.
  */
 
-#ifndef DRBD_LIMITS_H
-#define DRBD_LIMITS_H 1
+#ifndef _UAPI_LINUX_DRBD_LIMITS_H
+#define _UAPI_LINUX_DRBD_LIMITS_H
 
-#define DEBUG_RANGE_CHECK 0
+#include <linux/drbd.h>
 
 #define DRBD_MINOR_COUNT_MIN 1U
 #define DRBD_MINOR_COUNT_MAX 255U
@@ -248,4 +248,4 @@
 #define DRBD_RS_DISCARD_GRANULARITY_DEF 0U     /* disabled by default */
 #define DRBD_RS_DISCARD_GRANULARITY_SCALE '1' /* bytes */
 
-#endif
+#endif /* _UAPI_LINUX_DRBD_LIMITS_H */

base-commit: 8098eeb693c4cc4e774c62fbd4875197cb5578ce
-- 
2.53.0

