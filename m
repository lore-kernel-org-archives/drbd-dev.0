Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9B7881028A61
	for <drbd-dev@lists.linbit.com>; Mon, 27 May 2019 17:45:25 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id r7so17268705wrr.13
	for <drbd-dev@lists.linbit.com>; Mon, 27 May 2019 08:45:25 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	205sm17039527wmd.43.2019.05.27.08.45.23
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 08:45:24 -0700 (PDT)
Resent-Message-ID: <20190527154522.GB5803@soda.linbit>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AD56E101AC67
	for <drbd-dev@lists.linbit.com>;
	Thu, 23 May 2019 03:46:37 +0200 (CEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 22 May 2019 19:38:54 -0500
Message-Id: <20190523003916.20726-5-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arch@vger.kernel.org,
	Linux Containers <containers@lists.linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [REVIEW][PATCH 04/26] signal/drbd: Use send_sig not
	force_sig
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

The drbd module exclusively sends signals to kernel threads it creates with
kthread_create.  These kernel threads do not block or ignore signals (only
flush signals after they have been delivered), nor can drbd threads
possibly be pid namespace init processes so the extra work that force_sig
performs that send_sig does not is unnecessary.

Further force_sig is for delivering synchronous signals (aka exceptions).
The locking in force_sig is not prepared to deal with running processes, as
tsk->sighand may change during exec for a running process.

In short it is not only unnecessary for drbd to use force_sig it is
semantically wrong.

With drbd using send_sig it becomes easier to maintain force_sig as only
synchronous signals need to be considered.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/block/drbd/drbd_int.h  | 2 +-
 drivers/block/drbd/drbd_main.c | 2 +-
 drivers/block/drbd/drbd_nl.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 549c64df9708..035829435710 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1972,7 +1972,7 @@ static inline void wake_ack_receiver(struct drbd_connection *connection)
 {
 	struct task_struct *task = connection->ack_receiver.task;
 	if (task && get_t_state(&connection->ack_receiver) == RUNNING)
-		force_sig(SIGXCPU, task);
+		send_sig(SIGXCPU, task, 1);
 }
 
 static inline void request_ping(struct drbd_connection *connection)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 714eb64fabfd..8597aefe027b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -477,7 +477,7 @@ void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait)
 		smp_mb();
 		init_completion(&thi->stop);
 		if (thi->task != current)
-			force_sig(DRBD_SIGKILL, thi->task);
+			send_sig(DRBD_SIGKILL, thi->task, 1);
 	}
 
 	spin_unlock_irqrestore(&thi->t_lock, flags);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1cb5a0b85fd9..638b3ba9b976 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -611,7 +611,7 @@ void conn_try_outdate_peer_async(struct drbd_connection *connection)
 	struct task_struct *opa;
 
 	kref_get(&connection->kref);
-	/* We may just have force_sig()'ed this thread
+	/* We may have just sent a signal to this thread
 	 * to get it out of some blocking network function.
 	 * Clear signals; otherwise kthread_run(), which internally uses
 	 * wait_on_completion_killable(), will mistake our pending signal
-- 
2.21.0

