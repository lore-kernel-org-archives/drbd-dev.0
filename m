Return-Path: <bobo.shaobowang@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 11D0D4210CC
	for <drbd-dev@lists.linbit.com>;
	Tue, 22 Nov 2022 04:08:02 +0100 (CET)
To: Jens Axboe <axboe@kernel.dk>
References: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
	<c0e639ea-caa0-f76c-c369-0d22a49047ca@kernel.dk>
From: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <5b3ff507-7cc7-cb9d-1c9c-f497cb19cafb@huawei.com>
Date: Tue, 22 Nov 2022 11:08:00 +0800
MIME-Version: 1.0
In-Reply-To: <c0e639ea-caa0-f76c-c369-0d22a49047ca@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RESEND PATCH] drbd: destroy workqueue when drbd
	device was freed
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


在 2022/11/21 22:30, Jens Axboe 写道:
> On 11/21/22 4:50 AM, Wang ShaoBo wrote:
>> A submitter workqueue is dynamically allocated by init_submitter()
>> called by drbd_create_device(), we should destroy it when this
>> device is not needed or destroyed.
>>
>> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>
>> Changes in RESEND:
>>    put destroy_workqueue() before memset(device, ...)
>>
>>   drivers/block/drbd/drbd_main.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
>> index 8532b839a343..082bc34cd317 100644
>> --- a/drivers/block/drbd/drbd_main.c
>> +++ b/drivers/block/drbd/drbd_main.c
>> @@ -2217,7 +2217,12 @@ void drbd_destroy_device(struct kref *kref)
>>   		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>>   		kfree(peer_device);
>>   	}
>> +
>> +	if (device->submit.wq)
>> +		destroy_workqueue(device->submit.wq);
>> +
>>   	memset(device, 0xfd, sizeof(*device));
>> +
>>   	kfree(device);
> Maybe you can send a separate patch killing that very odd (and useless)
> memset as well?

I have sent v2 version adding a new patch for killing that memset.^-^

-- Wang ShaoBo

