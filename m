Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C296F10556DB
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B79072EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id IOviwPIJdDEc for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9744D2EBE2B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X1Sh9NyMzunQ for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2016 15:11:46 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 709A52EBE29
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2016 15:11:46 +0200 (CEST)
Resent-Message-ID: <20160912131146.GA14595@soda.linbit>
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6149C105646A
	for <drbd-dev@lists.linbit.com>; Sat, 10 Sep 2016 22:33:23 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:20:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [Drbd-dev] [PATCH 00/13] DRBD-receiver: Fine-tuning for six
 function implementations
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Sep 2016 22:13:22 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (13):
  Use kmalloc_array() in receive_uuids()
  Delete an error message for a failed kmalloc_array() call
  Move an assignment in receive_uuids()
  Improve a size determination in drbd_do_features()
  Delete an unnecessary initialisation in receive_sizes()
  Improve a size determination in receive_sizes()
  Delete an error message for a failed kzalloc() call in receive_sizes()
  Move an assignment in receive_sizes()
  Improve determination of sizes in receive_SyncParam()
  Delete error messages for failed resource allocations in receive_SyncParam()
  Improve a size determination in receive_protocol()
  Delete error messages for failed resource allocations in receive_protocol()
  Improve determination of sizes in receive_Barrier()

 drivers/block/drbd/drbd_receiver.c | 45 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

-- 
2.10.0

