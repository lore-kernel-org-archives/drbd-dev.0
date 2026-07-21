Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262C364952
	for <drbd-dev@lists.linux.dev>; Tue, 21 Jul 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639574; cv=none; b=sU2DUd18ci2wv3R2otlFkhHbMLm0aPRXD2mvucTyamz0fowhOkmoIIR+lTdk+SNFTcx0sf9uJvFpSDErW8pvnE72ER5hk5tepxNZcLpxju36ao3GWtC09IpFb5YxtsD2Sxx+wKmMcoL2We1brPDEyTDky2Ji3BpgbH/K9zrrXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639574; c=relaxed/simple;
	bh=roviBJb1B7iQhUITwXosnTCAe4xvx3i/dIY5PCDwenw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi7aCzLfyDTGxB7PQLKsEdj7ejnuoA1wpWN1mSZJkn29nuwQ/0pgq6Y+tvVlCwjJANUWs6M4lIBwCd0QMOF3hSEjfXZLxem8VODUsrt56KkV8hmDOhw190TeyD8KMZZ9Lztsy8U3umbQ+cwtU7s5eq8WX2WUG0cW40tv8BJNDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LGM6ll/W; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LGM6ll/W"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4798bea72f9so5952094f8f.1
        for <drbd-dev@lists.linux.dev>; Tue, 21 Jul 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639565; x=1785244365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=LGM6ll/Wh4lIJUwOqgwKbUCVQylYTzKBQ2OXvgscW/HhlhYxIkZScfZkw72N8cNwS9
         JlBND410MFe8MEfq3j2km1F9fEIcsDllrWj1+0UwH6wsNh2sFP3robrOXxhSNMB7EEKd
         cYTwdTcPRfI2o20dblftTUG5x4qhqVc2fRoZY7T5qwkQvlczHkyeCVg0ZnEfi+S0AmV7
         9f9CJyxslY2zMvN7Xf2HnFgyCx4TWBVah22U2Lw3tDoDdgrOdh4m07hNrzzm3gQhMEE2
         J47aagdYoR5BTa54fPcfTe9AmATFDIUTUEW80Zyzt96CDLcakdS80U/xd/odOQUPLBYt
         eVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639565; x=1785244365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=S7bgVtsn6XEkNLcuuY6ymM833Npg8+02A6ptYcbflvLtHWmNcfvA5IN9QHc5Uz+mpZ
         139n712SgubHlVec/5fjCLFmlxQgCG91DHwS5K71zCI68A+nI+q6B6NpfBTaCmKiTyKa
         JV5lw7w7wmh1fQn4ZmH8BMCLi/a/qWYjJqKB+Q9nBqcC7OM+bFMaaPSWBmXjhr5DWk5h
         60GJF9DmpRUM13cVhe5H4R7INmLJJwx0ppFg2bWeIMnqY5kyTNif8wpTyXPm/Y5h601i
         K58MWCGdOJbewuwBXNOXTvcQBSIYHUVmdSAHVJdUy6hQW5Ed1Q7cVHf+SyLK68yK6ItG
         lCnw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3aL1OK1YTCH0OrbokOvWI44AH3bH/uYrE9C8eN9nakfSw3W6uy2pQ6ZZALBaBA5lYoTVwzeGU0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDINLOiNPC0IIfAStvHDUuQz+mxKK1kUbhOiDtn2gOhV/XNfs6
	CrFfmBueznH1eSvKHH2hVGrFHnOsVEsSeKfHkcjVpNfKhgz9TR/UFbYwgc9nqDrPHXw=
X-Gm-Gg: AR+sD132zuWapAqDe+iw8FKR+dOyQzeIOM/jsPRiW9iLuBKZwGDD680jUqV/Q2FXfy/
	zH+r+ETQrsAIf2JUV9ft6ICIPneplpbF1aM8ofEx2ivzd/pz8zZfGjdumTzu979g1beFIH3dVxW
	1e8w0MpArjC0dDDqgF5bhFzIBvOI3ufGKfWKxnhK7iCB+U7rS6K8fjuzIVO24v/2SQlw37gOZfE
	GAZXsRSNMELIH9UOanfmQuePQ2hvcBIyB6VriouWzk9ee5G5p69JV5JnvYcoq8ai6au08mJBGvt
	Vs17CcGQrKXjvsyRV9ho5tvTovWpKetCCnthyn2tYEa6svTVEMgx7mBRQTCAEO7v4h82E1mJ2GT
	fb1fx+UG9+b83QcUvlCm8LbH1jibJxE4inMvPe3notUVLSTCbUm4Wl7pBvT7VVrRKpo6z91AG9Q
	==
X-Received: by 2002:a5d:64e8:0:b0:47f:6fbd:8a17 with SMTP id ffacd0b85a97d-47f6fbd8e65mr15616435f8f.59.1784639564680;
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/3] module: Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:27 +0200
Message-ID: <20260721131207.803760-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value
-- 
2.54.0

