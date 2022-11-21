Return-Path: <bobo.shaobowang@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B1F14205C8
	for <drbd-dev@lists.linbit.com>;
	Mon, 21 Nov 2022 12:58:01 +0100 (CET)
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20221121111138.3665586-1-bobo.shaobowang@huawei.com>
	<3603e71c-cd9d-fd27-7c52-1eed263e8717@linbit.com>
From: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <ff347eb2-d36a-480c-8de7-cb01a2ee35e0@huawei.com>
Date: Mon, 21 Nov 2022 19:57:53 +0800
MIME-Version: 1.0
In-Reply-To: <3603e71c-cd9d-fd27-7c52-1eed263e8717@linbit.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, liwei391@huawei.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: destroy workqueue when drbd device was
	freed
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


在 2022/11/21 19:51, Christoph Böhmwalder 写道:
> Am 21.11.22 um 12:11 schrieb Wang ShaoBo:
>> A submitter workqueue is dynamically allocated by init_submitter()
>> called by drbd_create_device(), we should destroy it when this
>> device was not needed or destroyed.
>>
>> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>   drivers/block/drbd/drbd_main.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
>> index 8532b839a343..467c498e3add 100644
>> --- a/drivers/block/drbd/drbd_main.c
>> +++ b/drivers/block/drbd/drbd_main.c
>> @@ -2218,6 +2218,9 @@ void drbd_destroy_device(struct kref *kref)
>>   		kfree(peer_device);
>>   	}
>>   	memset(device, 0xfd, sizeof(*device));
>> +
>> +	if (device->submit.wq)
>> +		destroy_workqueue(device->submit.wq);
>>   	kfree(device);
>>   	kref_put(&resource->kref, drbd_destroy_resource);
>>   }
>> @@ -2810,6 +2813,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>>   	put_disk(disk);
>>   out_no_disk:
>>   	kref_put(&resource->kref, drbd_destroy_resource);
>> +	if (device->submit.wq)
>> +		destroy_workqueue(device->submit.wq);
>>   	kfree(device);
>>   	return err;
>>   }
> Thanks for the patch.
>
> Unfortunately, (at least) the first hunk is buggy: we memset() the
> device to all 0xfd, and try to access it immediately afterwards.
>
> This obviously leads to invalid memory access.

Hi Christoph,

I found that error, so I have sent a RESEND version, i would be appreciated

if you could help check my patch.^-^

-- Wang ShaoBo

>
