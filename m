Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0736A377
	for <drbd-dev@lists.linux.dev>; Fri, 11 Sep 2026 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138032; cv=none; b=eQaM4F21yRm13m9nezdWVwjmdT0Vih+ImfYjOnG00YsuHUCaOUjbgSGeK51dudFaiydIX/A5w4IaQz0RcWNueqTrj/F6NTwmeN3auOUX4n9WLV7kEqpXIWLzxKfg7ffkxtLj0oOIwcGWBlHkGFJbMI+2SJfE1m2K6vmGkmhavRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138032; c=relaxed/simple;
	bh=6qK7Y4OCyC5WsOE2SJMQ4fti6jzNs1Pji9/QbACrVAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psVjou6gc3vE9IQ3Izl2ozSBoZudRqeMZoJySuwOmouDjlEJpMW9/4gs74Cd2wdsdUXr/OPxXFtw/MtttLIo2zHNsHlIHJ04B0ebfd//wiAOIVukZXytQqvu67vfIRwF/rxPKvn45Air/AkbxiLLa9xA7r7bqPs9aVWDTNdrJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cny1MnC2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cny1MnC2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso713069f8f.1
        for <drbd-dev@lists.linux.dev>; Fri, 11 Sep 2026 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138023; x=1789742823; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
        b=cny1MnC2ym62qSCqjDcHXDr1B3cphkDjNNRt1/zNpEfA0/xNuUjJbNX0ftwlaU30j5
         wMhhm6PrcTc7wnJFrSpTIWo3QKMpCTo427WRQUsqTJIOHd9A+lr4iN1W+AK1tH/ivCvb
         oVsg+t3jjzYUcb4J4jAUhIsxyrf3j/fRpKhGyNvjYz5zYgNhQe7vVRtX/l6YL347yWa4
         6GbJec+r8VeJeLal/sbpw3JaypHwXT/VO3L+IaLgX/stFtPWbDvHVreh0aG5VbYMxrL4
         zzDHrBx1zuCzaQu+PmIxOlMgpszTcsvz81g57NDiM0+ZlDkRLlKkYyRMW2gziPjdfT7D
         iS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138023; x=1789742823;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
        b=apxXuleHaFqqQ5NqQq+qdSpinPbJ2a0P2pDqM84an+EXjACwftwvrcIEf9V8LExiI+
         MuiA+3kYmiYHkrLX2PQKWJTjl8ex2/vUhY4Eqg98P08nA6rJbd6C3lGnXFyRWR2zrUPA
         JLAiKtezxyNDUgFPkOrSx55U9at5AUdvDhp8olFeTWd+sLk25DgID1xuG9XVcoXEOIlh
         g4FMFeSuADreyoa1PGxaA/DRQZ0y7VtEPOOypTecknwE+M/wA9fVnLdUY3KnlmgIi52/
         33M8pxMBo4lZtjGBb++oqwxsYTIu5p49xoU3hhj7e0nUgBPQqFrY+Tm/EX1lcVP0TJVW
         v1hA==
X-Forwarded-Encrypted: i=1; AKwUvBzIocV18HP0SOwSx61Mv2EclN1Bf8HJaKOqIobLlSjjYN+8SbA6VK/EyThl2eQMYDUXlezq1A7SnA==@lists.linux.dev
X-Gm-Message-State: AFuF++kYWlkE7oCJP9IOjhxzydK/nN7dH3oAqsrQFdOc5h/aW7NcdHS4
	o7K0ZR8AlFhJlp/+LhnFWQ+C4Comgh/ylu5/vtJNi+IDqJjCMEa7K/KSYuj+a/WT9OY=
X-Gm-Gg: AYBFou2v0AJs+IMyvq94IMCWoaBcdWxOj+u9iHnjvH/05QMT6K/hRwR2DaxBz54VqZx
	eZooxSYbEDq8E0I9XE3JTc0u8O5biK4+yXX2SzzNl82y8yIgJnUumZOhzIX2cPmgdNBs6ZYVL/1
	AKlkAfWCyq9BrDVByYDivBTZYMAoHjBnYaeFNyXhtiTndjZHmStBSlO5dEsZrXPbW/9z9tqsjYi
	wDMF3Zqnu7e11GUQXRsQvt/ma57yRz0O8c+YM12P70I+evX7q+fvXPp/j4ESOWmVCZTmtUIRK52
	QJ3OgSZzTgca66Ah3seny79hCET+IhlcoveSUTF1YcLlnBhTyyR8T4MJzCfmBmJnIrkpuSZGQRz
	vuzl7BYRIGfx3zda39ky2A6RDYsgdVBSJvwawCLHPoUgirbgybJLz+u2s8EM6zHbypIkdcXNbK/
	c+s2OhUqWx6UeeDHlWr1w/lvOmcvrtkOUWRhmFF8rWLtcjGhJ+l6Mm0L82YyNWeHHEQDzvHC1ge
	OczNQ==
X-Received: by 2002:a5d:5e08:0:b0:486:e81b:842a with SMTP id ffacd0b85a97d-486eb358ab6mr5259626f8f.48.1789138022582;
        Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
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
Subject: [PATCH v3 2/3] time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
Date: Fri, 11 Sep 2026 14:46:15 +0000
Message-ID: <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
which are declared in linux/sysctl.h. It currently gets that header
indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
needs to include linux/sysctl.h.

Include linux/sysctl.h directly in jiffies.c ahead of removing the
unnecessary include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Thomas Gleixner <tglx@kernel.org>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 213ae1d6a014..9231fea557ce 100644
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
2.55.0
