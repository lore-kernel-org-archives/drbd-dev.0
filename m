Return-Path: <joel@joelfernandes.org>
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
	[209.85.219.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 75D624202F2
	for <drbd-dev@lists.linbit.com>; Sun, 26 Mar 2023 14:27:21 +0200 (CEST)
Received: by mail-yb1-f174.google.com with SMTP id i7so7304695ybt.0
	for <drbd-dev@lists.linbit.com>; Sun, 26 Mar 2023 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 26 Mar 2023 08:27:10 -0400
Message-ID: <CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-block@vger.kernel.org, "Uladzislau Rezki \(Sony\)" <urezki@gmail.com>,
	linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 01/14] drbd: Rename kvfree_rcu() to
	kvfree_rcu_mightsleep()
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

On Wed, Mar 15, 2023 at 2:19=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>
> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> avoid accidental use of the single-argument forms, which can introduce
> functionality bugs in atomic contexts and latency bugs in non-atomic
> contexts.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>

Jens/Others, any chance for an Ack here?

 - Joel

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/block/drbd/drbd_nl.c       | 6 +++---
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  drivers/block/drbd/drbd_state.c    | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 60757ac31701..f49f2a5282e1 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1615,7 +1615,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct =
genl_info *info)
>                         drbd_send_sync_param(peer_device);
>         }
>
> -       kvfree_rcu(old_disk_conf);
> +       kvfree_rcu_mightsleep(old_disk_conf);
>         kfree(old_plan);
>         mod_timer(&device->request_timer, jiffies + HZ);
>         goto success;
> @@ -2446,7 +2446,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct g=
enl_info *info)
>
>         mutex_unlock(&connection->resource->conf_update);
>         mutex_unlock(&connection->data.mutex);
> -       kvfree_rcu(old_net_conf);
> +       kvfree_rcu_mightsleep(old_net_conf);
>
>         if (connection->cstate >=3D C_WF_REPORT_PARAMS) {
>                 struct drbd_peer_device *peer_device;
> @@ -2860,7 +2860,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct gen=
l_info *info)
>                 new_disk_conf->disk_size =3D (sector_t)rs.resize_size;
>                 rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf=
);
>                 mutex_unlock(&device->resource->conf_update);
> -               kvfree_rcu(old_disk_conf);
> +               kvfree_rcu_mightsleep(old_disk_conf);
>                 new_disk_conf =3D NULL;
>         }
>
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
> index 757f4692b5bd..e197b2a465d2 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3759,7 +3759,7 @@ static int receive_protocol(struct drbd_connection =
*connection, struct packet_in
>                 drbd_info(connection, "peer data-integrity-alg: %s\n",
>                           integrity_alg[0] ? integrity_alg : "(none)");
>
> -       kvfree_rcu(old_net_conf);
> +       kvfree_rcu_mightsleep(old_net_conf);
>         return 0;
>
>  disconnect_rcu_unlock:
> @@ -4127,7 +4127,7 @@ static int receive_sizes(struct drbd_connection *co=
nnection, struct packet_info
>
>                         rcu_assign_pointer(device->ldev->disk_conf, new_d=
isk_conf);
>                         mutex_unlock(&connection->resource->conf_update);
> -                       kvfree_rcu(old_disk_conf);
> +                       kvfree_rcu_mightsleep(old_disk_conf);
>
>                         drbd_info(device, "Peer sets u_size to %lu sector=
s (old: %lu)\n",
>                                  (unsigned long)p_usize, (unsigned long)m=
y_usize);
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
> index 75d13ea0024f..2aeea295fa28 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -2071,7 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *=
w, int unused)
>                 conn_free_crypto(connection);
>                 mutex_unlock(&connection->resource->conf_update);
>
> -               kvfree_rcu(old_conf);
> +               kvfree_rcu_mightsleep(old_conf);
>         }
>
>         if (ns_max.susp_fen) {
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
