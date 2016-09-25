Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 238991056499
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 01:47:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id DD1DAA0C51
	for <drbd-dev@lists.linbit.com>; Sun, 25 Sep 2016 16:47:49 -0700 (PDT)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lxjcxl5D0nVP for <drbd-dev@lists.linbit.com>;
	Sun, 25 Sep 2016 16:47:49 -0700 (PDT)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 57842A0C50
	for <drbd-dev@lists.linbit.com>; Sun, 25 Sep 2016 16:47:49 -0700 (PDT)
Date: Sun, 25 Sep 2016 16:47:49 -0700 (PDT)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LRH.2.11.1609251548430.29933@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] drbd threads and workqueues: For what is each
	responsible?
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

Hello all,

Would someone kindly point me at documentation or help me summarize the 
kernel thread and workqueues used by each DRBD resource?

These are the ones I've found, please correct or add to my annotations as 
necessary to get a better understanding of the internal data flow:

drbd_submit (workqueue, device->submit.wq):
  The workqueue that handles new read/write requests from the block layer, 
  updates the AL as necessary, sends IO to the peer (or remote-reads if 
  diskless).  Does this thread write blocklayer-submitted IO to the 
  backing device, too, or just metadata writes?


drbd_receiver (thread, connection->receiver):
  The connection handling thread.  Does this thread do anything besides 
  make sure the connection is up and handle cleanup on disconnect?
  
  It looks like drbd_submit_peer_request is called several times from 
  drbd_receiver.c, but is any disk IO performed by this thread?


drbd_worker (thread, connection->worker):
  The thread that does drbd work which is not directly related to IO 
  passed in by the block layer; action based on the work bits from 
  device->flags such as:
	do_md_sync, update_on_disk_bitmap, go_diskless, drbd_ldev_destroy, do_start_resync 
  Do metadata updates happen through this thread via 
  do_md_sync/update_on_disk_bitmap, or are they passed off to another 
  thread for writes?  Is any blocklayer-submitted IO submitted by this 
  thread?


drbd_ack_receiver (thread, connection->ack_receiver):
  Thread that receives all ACK types from the peer node.  
  Does this thread perform any disk IO?  What kind?


drbd_ack_sender (workqueue, connection->ack_sender):
  Thread that sends ACKs to the peer node.
  Does this thread perform any disk IO?  What kind?

Thank you for your help!
  

--
Eric Wheeler
