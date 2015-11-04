Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0079.outbound.protection.outlook.com [65.55.169.79])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B614D1056180
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 23:44:12 +0100 (CET)
To: device-mapper development <dm-devel@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>
References: <1446674909-5371-1-git-send-email-mchristi@redhat.com>
	<1446674909-5371-20-git-send-email-mchristi@redhat.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <563A8A33.3000002@sandisk.com>
Date: Wed, 4 Nov 2015 14:44:03 -0800
MIME-Version: 1.0
In-Reply-To: <1446674909-5371-20-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Christie <mchristi@redhat.com>
Subject: Re: [Drbd-dev] [dm-devel] [PATCH 19/32] block: add helper to get
 data dir from op
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

On 11/04/2015 02:08 PM, mchristi@redhat.com wrote:
> From: Mike Christie <mchristi@redhat.com>
>
> In later patches the op will no longer be a bitmap, so we will
> not have REQ_WRITE set for all non reads like discard, flush,
> and write same. Drivers will still want to treat them as writes
> for accounting reasons, so this patch adds a helper to translate
> a op to a data direction.
>
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>   include/linux/blkdev.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 19c2e94..cf5f518 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -586,6 +586,18 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
>
>   #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
>
> +/*
> + * Non REQ_OP_WRITE requests like discard, write same, etc, are
> + * considered WRITEs.
> + */
> +static inline int op_to_data_dir(int op)
> +{
> +	if (op == REQ_OP_READ)
> +		return READ;
> +	else
> +		return WRITE;
> +}
> +
>   #define rq_data_dir(rq)		((int)((rq)->cmd_flags & 1))
>
>   /*
>

How about introducing two functions - op_is_write() and op_is_read() ? I 
think that approach will result in shorter and easier to read code in 
the contexts where these functions are used.

Bart.
