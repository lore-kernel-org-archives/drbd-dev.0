Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com
	[209.85.166.45])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3494F103B4B8
	for <drbd-dev@lists.linbit.com>; Mon,  8 Jul 2019 20:09:53 +0200 (CEST)
Received: by mail-io1-f45.google.com with SMTP id j5so17996859ioj.8
	for <drbd-dev@lists.linbit.com>; Mon, 08 Jul 2019 11:09:53 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191])
	by smtp.gmail.com with ESMTPSA id v3sm9027145iom.53.2019.07.08.11.09.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Jul 2019 11:09:51 -0700 (PDT)
From: David Butterfield <dab21774@gmail.com>
To: drbd-dev@lists.linbit.com
Message-ID: <d3164ad9-e05e-5c46-aa91-9166ebe732e2@gmail.com>
Date: Mon, 8 Jul 2019 12:09:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] left shift of negative value in dcbp_set_pad_bits()
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

This fixes a C undefined-behavior runtime error encountered by libubsan after gcc -fsanitize=undefined:
left shift of negative value in dcbp_set_pad_bits()

I mentioned this one before, but in the context of a boring compiler warning.
The runtime undefined-behavior may make it more interesting.


diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 062c5ca1..16b4f02d 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -1832,7 +1840,7 @@ static void dcbp_set_start(struct p_compressed_bm *p, int set)
 static void dcbp_set_pad_bits(struct p_compressed_bm *p, int n)
 {
	BUG_ON(n & ~0x7);
-	p->encoding = (p->encoding & (~0x7 << 4)) | (n << 4);
+	p->encoding = (p->encoding & (~0x7u << 4)) | (n << 4);
 }
 
 static int fill_bitmap_rle_bits(struct drbd_peer_device *peer_device,
