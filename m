Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E872C101AC7C
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:22:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DFA192A58C8
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:22:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id v15CBfj0joZ9 for <drbd-dev@lists.linbit.com>;
	Wed,  7 May 2014 12:22:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C47842A5E6F
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:22:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yO5wWWrM7RM6 for <drbd-dev@lists.linbit.com>;
	Wed,  7 May 2014 12:22:19 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A92D72A58C8
	for <drbd-dev@lists.linbit.com>; Wed,  7 May 2014 12:22:19 +0200 (CEST)
Date: Wed, 7 May 2014 12:22:19 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140507102219.GE32422@soda.linbit>
References: <20140506112832.GA25561@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140506112832.GA25561@mwanda>
Subject: Re: [Drbd-dev] [patch] drbd: silence underflow warning in
 read_in_block()
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

On Tue, May 06, 2014 at 02:28:32PM +0300, Dan Carpenter wrote:
> My static checker warns that "data_size" could be negative and underflow
> the limit check.  The code looks suspicious but I don't know if it is a
> real bug.

"real life" bug only if you manage to receive corrupted data.
The maximum sent payload is DRBD_BIO_MAX_SIZE
which is an architecture independend constant (1U << 20).

Patch is correct, but while at it, we should revisit all "int data_size",
and make them all unsigned int...

	Lars

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index b6c8aaf..15daf86d 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -1528,7 +1528,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
>  	struct drbd_peer_request *peer_req;
>  	struct page *page;
>  	int dgs, ds, err;
> -	int data_size = pi->size;
> +	unsigned int data_size = pi->size;
>  	void *dig_in = peer_device->connection->int_dig_in;
>  	void *dig_vv = peer_device->connection->int_dig_vv;
>  	unsigned long *data;
