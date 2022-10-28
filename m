Return-Path: <groeck7@gmail.com>
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
	[209.85.167.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1859542037C
	for <drbd-dev@lists.linbit.com>; Fri, 28 Oct 2022 17:11:54 +0200 (CEST)
Received: by mail-oi1-f171.google.com with SMTP id l5so6434382oif.7
	for <drbd-dev@lists.linbit.com>; Fri, 28 Oct 2022 08:11:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f04aec5-bbff-6154-a0b1-8ad0aec97ec5@roeck-us.net>
Date: Fri, 28 Oct 2022 08:11:50 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
	<20221027150925.819019339@goodmis.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027150925.819019339@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC][PATCH v2 04/31] timers: block: Use
 del_timer_shutdown() before freeing timer
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 10/27/22 08:05, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
> 

I also had to add the following, as you had already suggested.

Just changing blk_sync_queue() was insufficient; I had to add the call from
blk_release_queue() because otherwise blk_sync_queue() was not always called.

Thanks,
Guenter

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e..69b1daa2e91a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -227,7 +227,7 @@ const char *blk_status_to_str(blk_status_t status)
   */
  void blk_sync_queue(struct request_queue *q)
  {
-       del_timer_sync(&q->timeout);
+       del_timer_shutdown(&q->timeout);
         cancel_work_sync(&q->timeout_work);
  }
  EXPORT_SYMBOL(blk_sync_queue);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..12a1e46536ed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -769,6 +769,8 @@ static void blk_release_queue(struct kobject *kobj)

         percpu_ref_exit(&q->q_usage_counter);

+       blk_sync_queue(q);
+
         if (q->poll_stat)
                 blk_stat_remove_callback(q, q->poll_cb);
         blk_stat_free_callback(q->poll_cb);

