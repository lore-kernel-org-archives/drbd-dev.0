Return-Path: <eslam.medhat1993@gmail.com>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 142B1160645
	for <drbd-dev@lists.linbit.com>; Sun, 27 Jul 2025 21:00:49 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
	ffacd0b85a97d-3b78294a233so706260f8f.3
	for <drbd-dev@lists.linbit.com>; Sun, 27 Jul 2025 12:00:49 -0700 (PDT)
Message-ID: <6e1b72fa-900b-45b8-8b89-37cd84cad779@gmail.com>
Date: Sun, 27 Jul 2025 22:00:46 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2] DRBD: replace strcpy with strscpy
References: <20250704175018.333165-1-eslam.medhat1993@gmail.com>
	<20250705173248.59003-1-eslam.medhat1993@gmail.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <20250705173248.59003-1-eslam.medhat1993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, skhan@linuxfoundation.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

Hi,

kind reminder about this patch change.
I appreciate your time reviewing this.

Regards,
Eslam Khafagy



On 7/5/25 20:32, Eslam Khafagy wrote:
> strcpy is deprecated due to lack of bounds checking. This patch replaces
> strcpy with strscpy, the recommended alternative for null terminated
> strings, to follow best practices.
>
> I had to do a small refactor for __drbd_send_protocol since it uses
> strlen anyways. so why not use that for strscpy.
>
> V2:
>   - I forgot about null termination so i fixed it.
>
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>   drivers/block/drbd/drbd_main.c     | 17 +++++++++--------
>   drivers/block/drbd/drbd_receiver.c |  4 ++--
>   2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 52724b79be30..028a5cf41d7f 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -742,9 +742,9 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
>   	}
>   
>   	if (apv >= 88)
> -		strcpy(p->verify_alg, nc->verify_alg);
> +		strscpy(p->verify_alg, nc->verify_alg);
>   	if (apv >= 89)
> -		strcpy(p->csums_alg, nc->csums_alg);
> +		strscpy(p->csums_alg, nc->csums_alg);
>   	rcu_read_unlock();
>   
>   	return drbd_send_command(peer_device, sock, cmd, size, NULL, 0);
> @@ -771,10 +771,6 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
>   		return -EOPNOTSUPP;
>   	}
>   
> -	size = sizeof(*p);
> -	if (connection->agreed_pro_version >= 87)
> -		size += strlen(nc->integrity_alg) + 1;
> -
>   	p->protocol      = cpu_to_be32(nc->wire_protocol);
>   	p->after_sb_0p   = cpu_to_be32(nc->after_sb_0p);
>   	p->after_sb_1p   = cpu_to_be32(nc->after_sb_1p);
> @@ -787,8 +783,13 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
>   		cf |= CF_DRY_RUN;
>   	p->conn_flags    = cpu_to_be32(cf);
>   
> -	if (connection->agreed_pro_version >= 87)
> -		strcpy(p->integrity_alg, nc->integrity_alg);
> +	size = sizeof(*p);
> +	if (connection->agreed_pro_version >= 87) {
> +		int integrity_len = strlen(nc->integrity_alg) + 1;
> +		size += integrity_len;
> +		strscpy(p->integrity_alg, nc->integrity_alg, integrity_len);
> +	}
> +
>   	rcu_read_unlock();
>   
>   	return __conn_send_command(connection, sock, cmd, size, NULL, 0);
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index e5a2e5f7887b..9c2d439f26e8 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3985,14 +3985,14 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
>   			*new_net_conf = *old_net_conf;
>   
>   			if (verify_tfm) {
> -				strcpy(new_net_conf->verify_alg, p->verify_alg);
> +				strscpy(new_net_conf->verify_alg, p->verify_alg);
>   				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
>   				crypto_free_shash(peer_device->connection->verify_tfm);
>   				peer_device->connection->verify_tfm = verify_tfm;
>   				drbd_info(device, "using verify-alg: \"%s\"\n", p->verify_alg);
>   			}
>   			if (csums_tfm) {
> -				strcpy(new_net_conf->csums_alg, p->csums_alg);
> +				strscpy(new_net_conf->csums_alg, p->csums_alg);
>   				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
>   				crypto_free_shash(peer_device->connection->csums_tfm);
>   				peer_device->connection->csums_tfm = csums_tfm;
