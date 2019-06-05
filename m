Return-Path: <dab21774@gmail.com>
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com
	[209.85.166.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 141CA1028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 17:59:34 +0200 (CEST)
Received: by mail-it1-f180.google.com with SMTP id w190so2863245itc.5
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 08:59:34 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	j23sm9009813itk.30.2019.06.05.08.59.31
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 08:59:33 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <59aa5c8c-7369-e987-4b7c-63490498570e@gmail.com>
Date: Wed, 5 Jun 2019 09:59:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] schedule_timeout() called without setting task state
	first
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

The logic in new_or_recycle_send_buffer_page() calls schedule_timeout() without first setting
the task state.  This will merely yield the processor but not actually wait.  Is that intended?

In drbd_main.c:
968 static void new_or_recycle_send_buffer_page(struct drbd_send_buffer *sbuf)
969 {
970         while (1) {
971                 struct page *page;
972                 int count = page_count(sbuf->page);
973
974                 BUG_ON(count == 0);
975                 if (count == 1)
976                         goto have_page;
977
978                 page = alloc_page(GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN);
979                 if (page) {
980                         put_page(sbuf->page);
981                         sbuf->page = page;
982                         goto have_page;
983                 }
984
985                 //XXX Don't you need to set something like TASK_*INTERRUPTIBLE first?
986                 //XXX I think this just yields the processor but the thread remains runnable(?)
987                 schedule_timeout(HZ / 10);
988         }
989 have_page:
990         sbuf->unsent =
991         sbuf->pos = page_address(sbuf->page);
992 }
