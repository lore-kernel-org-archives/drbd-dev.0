Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213144;
	b=XKqOR0YlURXIZeI8/lOJvOFbdoVevn47peTZrJYAqZO82sQBHmqoiItWc6lxUEaGcOz+
	 PSUSWt+ZlVJYfCjFTM0/ehKNI17gL0XAm6Gamvo4Mit+Pk5KMa5yREJZJZ3HcLYQc/D6C
	 cGpo5DbKIgSLPsGxm7dGhKdYryrGvgKk/ND0aa09VgTn9hQPeQxmznqnpX4oUR6uT1Vjw
	 Vro980vIdzJqHRyXlsue8c//0F6/TMbi0jiAOFQy8ExgGxFvuir2iXjHTKg5GPy3QByFU
	 kUfHXZTXZ2bDzp2GdHUFw8MGxLaitgytxhsozJJ8SushKMYP1qMQYUwUK0vR0SwYlcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213144;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=AZ1ijHGpTXh30OItCNfKlPH6RB5OO9sbPMydXQ1yVKY=;
	b=Sx4ftpra/YXNI9X4MR56CQxLPmjL7o57PMxem++W88ceQZf1rnzAdJ1nargRax4zWktM
	 RmDR/5XYMO7SPdlOGV0CQtnq/xQHiVNHTPOZ3OMn2ChUnTzwQTyNuUdAawMg7Tqy/yf6i
	 Jl81cSRIAwc84R5C+y1e/1qSCHoz8HVqpKeqkahQvF3J6QjbhdPooj3H+8CzvGU7xmkbE
	 qpmM4Ewi4AIF/uVRKt5UxArDNeJ4quppMs40sn/zzAkVx7gqikPxoXd+zeunGtBfwkxFx
	 /XuFz+2Skf8r/YXZT9YbBvxQnFrSmpLVhXr+9El6SPiHzKQm+oxNPWlR8wo/2K805BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0Hg0LouJ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHuKSdPQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0Hg0LouJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHuKSdPQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B277606A331
	for <drbd-dev@lists.linux.dev>; Mon,  9 Nov 2026 08:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B277606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0Hg0LouJ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHuKSdPQ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0Hg0LouJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHuKSdPQ
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	by smtp-out2.suse.de (Postfix) with ESMTP id 64B9C1F834;
	Mon,  9 Nov 2026 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794213141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZ1ijHGpTXh30OItCNfKlPH6RB5OO9sbPMydXQ1yVKY=;
	b=0Hg0LouJjKmcRyniduU4XEvfzE3Vj7Mg45qwg3uJ9+CK5+J8Lv0bB8lW/0corSK7b25AiU
	zQRUiH75T37ol3Sxhn1kq1/JSOkw48yTxUMNyonPR8HfIU84VzXDIf22sslO8aDKC9sDSl
	dfWvBc2ki2Lg/olXmvJd9R1QEZ6dujs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794213141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZ1ijHGpTXh30OItCNfKlPH6RB5OO9sbPMydXQ1yVKY=;
	b=uHuKSdPQxyx+N7BnNEwcM/xQM699H4zdEFSY2Uri0IT53tvX1O2kD9vtpso+mkSUiU0eJ8
	QFmAVQIHgqK0DVDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Hg0LouJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uHuKSdPQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794213141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZ1ijHGpTXh30OItCNfKlPH6RB5OO9sbPMydXQ1yVKY=;
	b=0Hg0LouJjKmcRyniduU4XEvfzE3Vj7Mg45qwg3uJ9+CK5+J8Lv0bB8lW/0corSK7b25AiU
	zQRUiH75T37ol3Sxhn1kq1/JSOkw48yTxUMNyonPR8HfIU84VzXDIf22sslO8aDKC9sDSl
	dfWvBc2ki2Lg/olXmvJd9R1QEZ6dujs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794213141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZ1ijHGpTXh30OItCNfKlPH6RB5OO9sbPMydXQ1yVKY=;
	b=uHuKSdPQxyx+N7BnNEwcM/xQM699H4zdEFSY2Uri0IT53tvX1O2kD9vtpso+mkSUiU0eJ8
	QFmAVQIHgqK0DVDQ==
From: Jiri Slaby <jslaby@suse.cz>
To: drbd-dev@lists.linux.dev
Cc: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] drbd/drbd_nl: include umh.h for call_usermodehelper()
Date: Mon,  9 Nov 2026 09:32:21 +0100
Message-ID: <20261109083221.27965-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64B9C1F834
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.13 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	NEURAL_SPAM_SHORT(1.89)[0.631];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	RDNS_NONE(1.00)[];
	NEURAL_HAM_LONG(-0.71)[-0.712];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	DIRECT_TO_MX(0.00)[git-send-email 2.56.0];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.13

To fix build against 7.4:
drbd_nl.c: In function ‘drbd_khelper’:
drbd_nl.c:701:15: error: implicit declaration of function ‘call_usermodehelper’ [-Wimplicit-function-declaration]
  701 |         ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
      |               ^~~~~~~~~~~~~~~~~~~
drbd_nl.c:701:69: error: ‘UMH_WAIT_PROC’ undeclared (first use in this function)
  701 |         ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
      |                                                                     ^~~~~~~~~~~~~
drbd_nl.c:701:69: note: each undeclared identifier is reported only once for each function it appears in

In 7.4, commit d6bfb4a05aff ("module: Bring includes in linux/kmod.h up
to date") removed umh.h include from kmod.h.
---
 drbd/drbd_nl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index ec9027e973e9..340b7025e148 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -22,6 +22,7 @@
 #include <linux/blkpg.h>
 #include <linux/cpumask.h>
 #include <linux/random.h>
+#include <linux/umh.h>
 #include "drbd_int.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
-- 
2.56.0

