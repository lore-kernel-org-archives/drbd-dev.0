Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011E3403FC
	for <drbd-dev@lists.linux.dev>; Tue, 21 Jul 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639570; cv=none; b=BO78NR3MBDuXWWAfGy/RHBeC8Di+OQDiFwDZRcmHfdfl6M3PCDOd0BFpZQhKeNqrhzEo/ahTHiKFupr1p9Tvnj8P0KdjKTszFqZuFmv5CU2i5lqTUwR4FnwjrlFT60IVenaw8zsCqqz+R+Bkh5l/A6FTwBIZFB1UD1Hr7184w6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639570; c=relaxed/simple;
	bh=8s6UjPPxUC+WU+GOlooynAFJu683hzUfQZ1dycjQ1Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+dG2W/GLnRgZf4eLnQBA7ITM9ufjAESzdmmqlkIG5wfknOaiDoxhp9KhL2ankXo6cRiej0PK+vH5dS3gWwUJsPTFiQWzo54ljQbZnEWwnrgInjq7sJbc69mjMmZQ4H5V7vdVFN+pjk0bzcHaFeMUPar7yIVveWMjqkirXNB4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEX09Mee; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEX09Mee"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso938019f8f.0
        for <drbd-dev@lists.linux.dev>; Tue, 21 Jul 2026 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639563; x=1785244363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
        b=LEX09MeeDKnCCU8NH/muVmkNAW8O4ABwIyAZBaT1EKUeErQr/r8D6pwq24rCPYctjp
         ICTxj45ID6vk5qOBr5sVwiTOLCwA1hh8NTVhxi9etzptSdXoct2pC1d5JQslGZ3FYmif
         NVN+vxPyW6KVVFsLxYBjhhXACqaczJuEQRkGMm5VblOpOAukd1fb7elp6lSPwuoxfdmK
         DPHYPj50WVVh+pghEI7mXfoCqrrZ+IG+/KmP+zQ4APoF0404+wOWEXcAjsc9VfUoGLK1
         HuPOgSrn1im9U5xmUHwGhQiPJltz90KfMR8ZnirfaSNBHBByVuHebpmaRO7fW5ppwkKL
         oE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639563; x=1785244363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
        b=HvG4f+wfOzDVvIFm96OQxicw772GByiwFcP0Jjc/Zf7n3xes7XJe2tIuyrxJhU8bmH
         IvZRD+zjXQV8gn1bPk5xMX25qPAYhoQhTGXIIG5p9ItXzu84wtAsKn+jcJq/sr1LEYoX
         eHO3htQ8qAmfKOySHO7EhJbz6//tmRTJE+30pYqE75SA5WvYEDBxdoOmOAae0kbs7vjP
         5wEiEs7VxN0ucRKZXGAWH519+pNCXogYBznR2vLXz88iPpCoa0LbCSmbS42YWaikg7h2
         /W0HdcUiUVAB3kpy72oPQrFO45hagrQLV67far0jzvJNCDv9zjKQ61Psq4NiS2LVoLzL
         cpCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3mLX5GVpAmpEuaXxZyUcqnqdDBrkCRiJKZmCclxvkEaEAL76dsUR3SrDeOisXW/kaxb88eDNwQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzm/FKKZJTV8WWDpQTJTU/Wq8zAEaJulSjQlb665lLGHjFvGwux
	bVk8mDbB79GU9j9dEtJq/KhMa586v/iHSqH4uBpV+HpYlqzQhRQtE6MuqqFr3ritnws=
X-Gm-Gg: AR+sD13knacw3IiC3ybUnq8YwrKU/MCH67FSXPtwNyoS2NCRnnhCyShRNv1i25BcBqJ
	6KS3q+jn5sGGcZTmTk2cZXZHxI5odOTb2+XUF1cE2ByMeGsTjbUnwQLpbSCG0k4c2DgTNB1QciE
	pA32V2zPyMmVwKvWaaRPqy2VUXltgOYBvKb6gfP8ZmHre6ExZqe+x5/sQcfxdeKh1IX4xKg4JzY
	J0tKiSoOVT6k6lJ4DlEYgvq68vBstMRk40eqeGsx1qIvVyo7dlVBuJg3GysiYsRPrDfIfW0pKhr
	HzPMy28JZ1+jvtJNSOMBy0M/yrKGMrzW3zRwZAH9baM4v97q43mlni5TXKxWBvK54rpQRfa2YV7
	pRUPQBF8hteH33rHfmmhTubA8BtVHVVLBLlww3tus574/QiYs0BAWA37+OaIXgtOqNtkvALz2wQ
	==
X-Received: by 2002:a05:6000:4023:b0:47f:81fe:12fb with SMTP id ffacd0b85a97d-47f81fe1712mr2452175f8f.47.1784639562827;
        Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
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
Subject: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
Date: Tue, 21 Jul 2026 15:11:26 +0200
Message-ID: <20260721131207.803760-3-petr.pavlu@suse.com>
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

The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
currently relies on this header being included indirectly through
linux/module.h -> linux/kmod.h. Add the missing include in preparation for
removing the linux/sysctl.h include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d51428867a33..17cdb5ef8893 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sysctl.h>
 
 #include "timekeeping.h"
 #include "tick-internal.h"
-- 
2.54.0

