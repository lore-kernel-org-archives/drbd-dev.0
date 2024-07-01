Return-Path: <dongsheng.yang@easystack.cn>
Received: from mail-m12826.netease.com (mail-m12826.netease.com
	[103.209.128.26])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CED75420304
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2024 04:34:02 +0200 (CEST)
Subject: Re: [PATCH 07/11] drbd_transport_rdma: put kref in dtr_remap_tx_desc
	error
To: Philipp Reisner <philipp.reisner@linbit.com>,
	"zhengbing.huang" <zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-7-zhengbing.huang@easystack.cn>
	<CADGDV=U1EG9Zd22ujB=fUGCoExMhCLF6fYGj171MVKxabxz=iA@mail.gmail.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <ad51fcd4-9dfe-4421-b250-a0aed42f1cb9@easystack.cn>
Date: Mon, 1 Jul 2024 10:28:31 +0800
MIME-Version: 1.0
In-Reply-To: <CADGDV=U1EG9Zd22ujB=fUGCoExMhCLF6fYGj171MVKxabxz=iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
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



在 2024/6/28 星期五 下午 8:19, Philipp Reisner 写道:
> Hello Dongsheng,
> 
> This looks wrong. In this loop, we are trying to find a path on which
> to repost this tx_desc. When the remapping fails, there is no reason
> to drop the drop a ref on the cm.

But dtr_select_and_get_cm_for_tx() get a ref, if we dont put it before 
continue, who will put this ref?
> 
> So, please provide a description what you are intending here with this change?
> 
> best regards,
>   Philipp
> 
> On Mon, Jun 24, 2024 at 9:27 AM zhengbing.huang
> <zhengbing.huang@easystack.cn> wrote:
>>
>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>
>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>> ---
>>   drbd/drbd_transport_rdma.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
>> index c7adc87e3..77ff0055e 100644
>> --- a/drbd/drbd_transport_rdma.c
>> +++ b/drbd/drbd_transport_rdma.c
>> @@ -2355,8 +2355,11 @@ static int dtr_repost_tx_desc(struct dtr_cm *old_cm, struct dtr_tx_desc *tx_desc
>>                          return -ECONNRESET;
>>
>>                  err = dtr_remap_tx_desc(old_cm, cm, tx_desc);
>> -               if (err)
>> +               if (err) {
>> +                       pr_err("dtr_remap_tx_desc failed cm : %px\n", cm);
>> +                       kref_put(&cm->kref, dtr_destroy_cm);
>>                          continue;
>> +               }
>>
>>                  err = __dtr_post_tx_desc(cm, tx_desc);
>>                  if (!err) {
>> --
>> 2.27.0
>>
> .
> 
