Return-Path: <dongsheng.yang@easystack.cn>
Received: from mail-m254100.xmail.ntesmail.com
	(mail-m254100.xmail.ntesmail.com [103.129.254.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E5AC74202E7
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2024 07:14:02 +0200 (CEST)
Subject: Re: [PATCH 03/11] drbd_transport_rdma: put kref for cm in
	dtr_path_established in error path
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	"zhengbing.huang" <zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-3-zhengbing.huang@easystack.cn>
	<CADGDV=V4kpNPAWf6MsdswhbMqKPe5=qEMXkF_KBqXVM7W+aUhQ@mail.gmail.com>
	<f368f323-140c-9995-63b7-ec8ada21a7f0@easystack.cn>
Message-ID: <73f04036-5bb3-9ad5-bfe1-ea4d26817ceb@easystack.cn>
Date: Mon, 1 Jul 2024 10:48:22 +0800
MIME-Version: 1.0
In-Reply-To: <f368f323-140c-9995-63b7-ec8ada21a7f0@easystack.cn>
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



在 2024/7/1 星期一 上午 10:07, Dongsheng Yang 写道:
> 
> 
> 在 2024/6/28 星期五 下午 5:40, Philipp Reisner 写道:
>> Hello Dongsheng,
>>
>> Please add more information why you think this change fixes a bug.
>> Have you experienced a leak of cm structs?
>> We got a RDMA_CM_EVENT_ESTABLISHED event. Even if DRBD does not do
>> anything with this cm, we sill expect a RDMA_CM_EVENT_DISCONNECTED in
>> the future. Is a problem in the handling of the disconnect?
> 
> If dtr_path_established() go into this branch, it will not 
> schedule_work(&cm->establish_work);
> 
> That means path->cm->state = DSM_CONNECTED; will not be done in 
> dtr_path_established_work_fn(), so __dtr_disconnect_path() will not call 
> rdma_disconnect(). That means this reference will never be put.

let me consider this  example:
a) rdma_connect() called and RDMA_CM_EVENT_ESTABLISHED received.

b) network failure and dtr_path_established() go into error path.

c) establish_work will not be scheduled.

d) drbdadm down test will hang because cm ref is not put.
>>
>> best regards,
>>   Philipp
>>
>> On Mon, Jun 24, 2024 at 9:28 AM zhengbing.huang
>> <zhengbing.huang@easystack.cn> wrote:
>>>
>>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>>
>>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>> ---
>>>   drbd/drbd_transport_rdma.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
>>> index cfbae0e78..eccd0c6ce 100644
>>> --- a/drbd/drbd_transport_rdma.c
>>> +++ b/drbd/drbd_transport_rdma.c
>>> @@ -922,6 +922,7 @@ static void dtr_path_established(struct dtr_cm *cm)
>>>                          atomic_set(&cs->active_state, PCS_INACTIVE);
>>>                          wake_up(&cs->wq);
>>>                  }
>>> +               kref_put(&cm->kref, dtr_destroy_cm);
>>>                  return;
>>>          }
>>>
>>> -- 
>>> 2.27.0
>>>
