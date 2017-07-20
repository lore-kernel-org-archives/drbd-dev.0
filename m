Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1810E1057FE7
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jul 2017 13:35:05 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id g127so24201885wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jul 2017 04:35:05 -0700 (PDT)
Received: from localhost (213-47-144-126.static.upcbusiness.at.
	[213.47.144.126]) by smtp.gmail.com with ESMTPSA id
	g18sm11029633wrg.69.2017.07.20.04.27.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Jul 2017 04:27:51 -0700 (PDT)
From: Shaobo <roland.kammerer@linbit.com>
Resent-Message-ID: <20170720112751.GS1453@rck.sh>
Received: from mail-svr1.cs.utah.edu (rio.cs.utah.edu [155.98.64.241])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8EB651057FE2
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jul 2017 06:57:50 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2017 22:50:47 -0600
To: drbd-dev@lists.linbit.com
Message-ID: <6863677bb21b5adb672d850983d5f8d1@cs.utah.edu>
Cc: lars.ellenberg@linbit.com, philipp.reisner@linbit.com
Subject: [Drbd-dev] Potentially invalid memory accesses in file
 drivers/block/drbd/drbd_worker.c
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

Hi there,

My name is Shaobo He and I am a graduate student at University of Utah. 
I am using a static analysis tool to search for null pointer 
dereferences and came across a couple of potentially invalid memory 
accesses in the file drivers/block/drbd/drbd_worker.c: in function 
`drbd_start_resync`, pointer variable `connection` in line 1727 can be 
NULL while is dereferenced at line 1767 (```if (current == 
connection->worker.task) {```).

Please let me know if it makes sense. I am looking forward to your 
reply.

Best,
Shaobo
