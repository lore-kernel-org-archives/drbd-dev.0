Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
	[209.85.166.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 94DC61028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:05:32 +0200 (CEST)
Received: by mail-io1-f47.google.com with SMTP id e5so1639262iok.4
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:05:32 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	e130sm4865273ita.2.2019.06.05.09.05.30
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:05:31 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <9ddd5d91-affe-4a82-b563-45ea6082f5df@gmail.com>
Date: Wed, 5 Jun 2019 10:05:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] avoid compiler warning about redefined macro
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In drbd_dax_pmem.h:35:
-#define arch_wb_cache_pmem(A, L) do { } while (0)
+#define arch_wb_cache_pmem(A, S) do { } while (0)

Avoid compiler warning by making the macro definition exactly match the one in
linux/libnvdimm.h:
    drbd_dax_pmem.h:35: warning: "arch_wb_cache_pmem" redefined
