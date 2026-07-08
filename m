Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45841409291
	for <drbd-dev@lists.linux.dev>; Wed,  8 Jul 2026 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525572; cv=none; b=RqldlCf6zufPtHDgCFPzcBz9B6v8+ezZmDrYdXDavruv1TS4+1galLLIIvEhzr5wPWSg3xcDtdOtqWVCk8cnso1587OJRWJucXZeqYMFVEiDd0NJXiXq3jQTtThTHwsc0DAXp5JjpJ/x1ZX/RsB6jXCETnkFeUB2ZP2EMPXswP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525572; c=relaxed/simple;
	bh=6o/Os/YHoHLpbGBJ/Oz87lOS4kylKBP062qGBWElKsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvHE2zanww49mcXyGxkLT90YXvv9dng/ST4qh/7XrPQh5GEaaF8z4xL6nTW3yak1+vM8sGKTWnyeLzrudxcRM6i9ZT86WAoZvcCLfHOGSJKJjaFwYu30IoSCycvoF2+F63tHIyubyOy1CWarjTBQIxTeB6UZ2ga3Ry0PXxeW0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BGxHDi56; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BGxHDi56"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de0093c42so881837f8f.3
        for <drbd-dev@lists.linux.dev>; Wed, 08 Jul 2026 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525566; x=1784130366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=BGxHDi56uTJ4WVBwebGp4VVqM161q8XbA8wHR/YzAuXa7l980VUumdHnrR7DUdfNBg
         3+QGlGbY0qtbNHQgG2IalS+xxjLKMaCVXiP0s+5HN2OD5Zc3pPOCQ9Vu4XPubZUzdtZh
         zlx+gRIulUMw7EV5I4o3z3btyELbB3hoi+pK+AvLZHSS3wcgfOKQB4FHiFB4Z9g71FOr
         bkoN2oPevt2hoybmLgif6DV4FK5HFRNZtvyUGvml6z6AwC0bJEjru8wz2OAmnudkcjrz
         qU3MpE1SB9iCBlyseg0nn6QZx+WASOzFkl5liXihOgWRUOEmYIWmDXeU1v6vvqx+zl7G
         9Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525566; x=1784130366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=i7iCsfdmFangYV6is8g5LaAtkv91dC5L+b/eoUlAbfppAYP7ezMrqpu1D1qc4IXshP
         fa6bsXtjP4WSes4wABEw2xImZpJhB+vO00LJ+362V+gX8I5WgtiClpxK7dMBjGoc0H+F
         cs5TCJYq6KYDOgYW516cdyzLkHaNe/h4qKspEiEBS2J6q0amgVzpSGBOHxK9QJ36HjFu
         mRI93Y5Ep/4IeACoLPNM4ZkG02LDekVFvvtLMz2qhNs/ioo0sl3oDpSv++DD3wE5OcVK
         4N7lVkrO9mmDJ6Kdk7b1xCqa7oLyz9fuNkn78A3ZSuRQOIdzXTrmJ7UAnP2awS+N0gX8
         OheQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq99hrc42N+xC0WISuH8X0cGHKYF1vsSPzFIZsnGf51DYTLJbtPA5PZYlIuGL/jy1hWbUHQaGybOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpFr5Alq65a1u1IF1O+ZU+qWS2pyS4X+7qIX/bfnLNOxh2LmLu
	HwHoPfudMYf195XgOrUjGcCZa95NbbtrMS0LmorLt0Hj+lAogddKvku3+2ZAoe5jrzY=
X-Gm-Gg: AfdE7cld/SaK26YMaxw9kMC+h9hxF22WJugQTt5F3pLBQFL3zZEukBT6O7DPGTDXFBb
	GeEWKylq99uu9ujmlq15ajTci4OOcCOzIGfWXUk6Aq242Tcr9dYQI/O2zZOFJ0Z1dwQJlpgAr/f
	tt8BZF4p1k1DrSLbqTwiXQ2C402A0SAz3Tbu9G2YQr/MR6APjBqy7O2kO3iP5zUFC7Lf7wEfJq2
	ajXNw59hkuJTdD40WsBXoDnj8Xoot6ayodRNZkdpiXD9poOtLCRCpLO3VlsqUvOLwof1NmAdquI
	exJ4JuDKxENtsliWZMkMcf4myVT0lQErmen+TBMZlt/3EfcxZLYBeq6y6FD880uSGtAso6owjYX
	b0DXHLpbXroxdd9TLHbJJOgXttGxXAyrbjiUYqiHYiZvKjeuO3k4gHYjWiSWx2/HJrb8WSMm3N3
	otsViPWucxpksgEnaqu+Cv9LRRqpsWFg==
X-Received: by 2002:a05:6000:26d0:b0:473:673e:3836 with SMTP id ffacd0b85a97d-47df078bb73mr3861713f8f.28.1783525565920;
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
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
Subject: [PATCH 2/2] module: Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:30 +0200
Message-ID: <20260708154510.6794-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708154510.6794-1-petr.pavlu@suse.com>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
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

