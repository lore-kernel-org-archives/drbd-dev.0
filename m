Return-Path: <urezki@gmail.com>
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
	[209.85.167.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0F9A6420954
	for <drbd-dev@lists.linbit.com>; Wed, 15 Dec 2021 20:38:49 +0100 (CET)
Received: by mail-lf1-f45.google.com with SMTP id d10so45194752lfg.6
	for <drbd-dev@lists.linbit.com>; Wed, 15 Dec 2021 11:38:49 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
Date: Wed, 15 Dec 2021 20:38:46 +0100
To: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	Jason Gunthorpe <jgg@nvidia.com>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Message-ID: <YbpERiPKO4ufe1hf@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-1-urezki@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, "Theodore Y . Ts'o" <tytso@mit.edu>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neeraj Upadhyay <neeraju@codeaurora.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Axtens <dja@axtens.net>
Subject: Re: [Drbd-dev] [PATCH] drdb: Switch to kvfree_rcu() API
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

On Wed, Dec 15, 2021 at 12:18:37PM +0100, Uladzislau Rezki (Sony) wrote:
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> TO: Jens Axboe <axboe@kernel.dk>
> TO: Philipp Reisner <philipp.reisner@linbit.com>
> TO: Jason Gunthorpe <jgg@nvidia.com>
> TO: drbd-dev@lists.linbit.com
> TO: linux-block@vger.kernel.org
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/block/drbd/drbd_nl.c       | 9 +++------
>  drivers/block/drbd/drbd_receiver.c | 6 ++----
>  drivers/block/drbd/drbd_state.c    | 3 +--
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 44ccf8b4f4b2..28f4d84945fd 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1679,8 +1679,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
>  			drbd_send_sync_param(peer_device);
>  	}
>  
> -	synchronize_rcu();
> -	kfree(old_disk_conf);
> +	kvfree_rcu(old_disk_conf);
>  	kfree(old_plan);
>  	mod_timer(&device->request_timer, jiffies + HZ);
>  	goto success;
> @@ -2511,8 +2510,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
>  
>  	mutex_unlock(&connection->resource->conf_update);
>  	mutex_unlock(&connection->data.mutex);
> -	synchronize_rcu();
> -	kfree(old_net_conf);
> +	kvfree_rcu(old_net_conf);
>  
>  	if (connection->cstate >= C_WF_REPORT_PARAMS) {
>  		struct drbd_peer_device *peer_device;
> @@ -2925,8 +2923,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
>  		new_disk_conf->disk_size = (sector_t)rs.resize_size;
>  		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
>  		mutex_unlock(&device->resource->conf_update);
> -		synchronize_rcu();
> -		kfree(old_disk_conf);
> +		kvfree_rcu(old_disk_conf);
>  		new_disk_conf = NULL;
>  	}
>  
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 1f740e42e457..d73a53242a75 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3799,8 +3799,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
>  		drbd_info(connection, "peer data-integrity-alg: %s\n",
>  			  integrity_alg[0] ? integrity_alg : "(none)");
>  
> -	synchronize_rcu();
> -	kfree(old_net_conf);
> +	kvfree_rcu(old_net_conf);
>  	return 0;
>  
>  disconnect_rcu_unlock:
> @@ -4168,8 +4167,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
>  
>  			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
>  			mutex_unlock(&connection->resource->conf_update);
> -			synchronize_rcu();
> -			kfree(old_disk_conf);
> +			kvfree_rcu(old_disk_conf);
>  
>  			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
>  				 (unsigned long)p_usize, (unsigned long)my_usize);
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index b8a27818ab3f..826e496821c7 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -2071,8 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
>  		conn_free_crypto(connection);
>  		mutex_unlock(&connection->resource->conf_update);
>  
> -		synchronize_rcu();
> -		kfree(old_conf);
> +		kvfree_rcu(old_conf);
>  	}
>  
>  	if (ns_max.susp_fen) {
> -- 
> 2.30.2
> 
+ Jens Axboe <axboe@kernel.dk>
+ Philipp Reisner <philipp.reisner@linbit.com>
+ Jason Gunthorpe <jgg@nvidia.com>
+ drbd-dev@lists.linbit.com
+ linux-block@vger.kernel.org

--
Vlad Rezki
