Return-Path: <baijiaju1990@gmail.com>
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
	[209.85.210.182])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5CF9E4202FF
	for <drbd-dev@lists.linbit.com>; Thu, 19 Aug 2021 11:31:10 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id m26so4934677pff.3
	for <drbd-dev@lists.linbit.com>; Thu, 19 Aug 2021 02:31:10 -0700 (PDT)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	Jens Axboe <axboe@kernel.dk>
Message-ID: <f425ae14-8857-28d7-a27a-d25da83e1bd6@gmail.com>
Date: Thu, 19 Aug 2021 17:31:04 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [BUG] block: drbd: four possible ABBA deadlocks
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

Hello,

My static analysis tool reports four possible ABBA deadlocks in the drbd 
drivers in Linux 5.10:

### Deadlock A ###
w_after_conn_state_ch()
   mutex_lock(&connection->resource->conf_update); --> line 2065
   conn_free_crypto()
     drbd_free_sock()
       drbd_free_one_sock(&connection->data)
         mutex_lock(&ds->mutex); --> line 2967

drbd_adm_net_opts()
   mutex_lock(&connection->data.mutex); --> line 2445
   mutex_lock(&connection->resource->conf_update); --> line 2446

When w_after_conn_state_ch() and drbd_adm_net_opts() are concurrently 
executed, the deadlock can occur.

### Deadlock B ###
drbd_adm_connect()
   mutex_lock(&adm_ctx.resource->conf_update); --> line 2644
   conn_free_crypto()
     drbd_free_one_sock(&connection->data)
       mutex_lock(&ds->mutex); --> line 2967

drbd_adm_net_opts()
   mutex_lock(&connection->data.mutex); --> line 2445
   mutex_lock(&connection->resource->conf_update); --> line 2446

When drbd_adm_connect() and drbd_adm_net_opts() are concurrently 
executed, the deadlock can occur.

### Deadlock C ###
w_after_conn_state_ch()
   mutex_lock(&connection->resource->conf_update); --> line 2065
   conn_free_crypto()
     drbd_free_sock()
       drbd_free_one_sock(&connection->data)
         mutex_lock(&ds->mutex); --> line 2967

receive_protocol()
   mutex_lock(&connection->data.mutex); --> line 3778
   mutex_lock(&connection->resource->conf_update); --> line 3779

When w_after_conn_state_ch() and receive_protocol() are concurrently 
executed, the deadlock can occur.

### Deadlock D ###
drbd_adm_connect()
   mutex_lock(&adm_ctx.resource->conf_update); --> line 2644
   conn_free_crypto()
     drbd_free_one_sock(&connection->data)
       mutex_lock(&ds->mutex); --> line 2967

receive_protocol()
   mutex_lock(&connection->data.mutex); --> line 3778
   mutex_lock(&connection->resource->conf_update); --> line 3779

When drbd_adm_connect() and receive_protocol() are concurrently 
executed, the deadlock can occur.

I am not quite sure whether these possible deadlocks are real and how to 
fix them if they are real.
Any feedback would be appreciated, thanks

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
