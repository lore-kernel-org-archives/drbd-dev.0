Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2F2481013804
	for <drbd-dev@lists.linbit.com>; Mon, 29 Oct 2012 11:29:18 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jing Wang <windsdaemon@gmail.com>
Date: Mon, 29 Oct 2012 11:26:27 +0100
Message-ID: <5124709.NeBDm9xAYE@fat-tyre>
In-Reply-To: <1351148456-11129-1-git-send-email-windsdaemon@gmail.com>
References: <1351148456-11129-1-git-send-email-windsdaemon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/1] drbd: check return of kmalloc in
	receive_uuids
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

Thanks for pointint this out. I fixed your patch for the drbd-8.3
context and applied it. See:
http://git.drbd.org/gitweb.cgi?p=drbd-8.3.git;a=commit;h=371289b8b632e8b4e364563faa430ff3b6d7d1d9

best,
 Phil

> Signed-off-by: Jing Wang <windsdaemon@gmail.com>
> ---
>  drivers/block/drbd/drbd_receiver.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c
> b/drivers/block/drbd/drbd_receiver.c index c74ca2d..4227f38 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3076,10 +3076,14 @@ static int receive_sizes(struct drbd_conf *mdev,
> enum drbd_packets cmd, unsigned static int receive_uuids(struct drbd_conf
> *mdev, enum drbd_packets cmd, unsigned int data_size) {
>  	struct p_uuids *p = &mdev->data.rbuf.uuids;
> -	u64 *p_uuid;
> +	u64 *p_uuid = NULL;
>  	int i, updated_uuids = 0;
> 
>  	p_uuid = kmalloc(sizeof(u64)*UI_EXTENDED_SIZE, GFP_NOIO);
> +	if (!p_uuid) {
> +		dev_err(DEV, "kmalloc of p_uuid failed\n");
> +		return -ENOMEM;
> +	}
> 
>  	for (i = UI_CURRENT; i < UI_EXTENDED_SIZE; i++)
>  		p_uuid[i] = be64_to_cpu(p->uuid[i]);
