Return-Path: <dongsheng.yang@easystack.cn>
Received: from mail-m6027.netease.com (mail-m6027.netease.com [210.79.60.27])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 230EA420653
	for <drbd-dev@lists.linbit.com>;
	Mon,  1 Jul 2024 09:19:02 +0200 (CEST)
Subject: Re: [PATCH 05/11] drbd_transport_rdma: dont break in
	dtr_tx_cq_event_handler if (cm->state != DSM_CONNECTED)
To: Philipp Reisner <philipp.reisner@linbit.com>,
	"zhengbing.huang" <zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-5-zhengbing.huang@easystack.cn>
	<CADGDV=XCh8QLqYZ0-zddu6nwdJJor9UGb960K-CmN5yLB58XzA@mail.gmail.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <5de313a6-8b0a-36c4-4b76-307ee1ab3477@easystack.cn>
Date: Mon, 1 Jul 2024 10:23:14 +0800
MIME-Version: 1.0
In-Reply-To: <CADGDV=XCh8QLqYZ0-zddu6nwdJJor9UGb960K-CmN5yLB58XzA@mail.gmail.com>
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



在 2024/6/28 星期五 下午 8:07, Philipp Reisner 写道:
> Hello Dongsheng,
> 
> It appears that you are trying to fix a leak of cm structures. Is that correct?

Yes, in our network faulure testing, we found drbdadm down command hang 
at dtr_free() to 
wait_event(rdma_transport->cm_count_wait,!atomic_read(&rdma_transport->cm_count));, 


we can find out the leak cm in memory and found the tx_descs_posted is 
not 0. then we did more hacking and found this problem in [05/11]

let's say this case:

a) post two tx_desc and tx_desc_posted to 2.

b) first tx_desc complete and call dtr_tx_cq_event_handler and into 
dtr_handle_tx_cq_event().

c) network failure and dtr_tx_timeout_work_fn() clear CONNECTED.

d) dtr_handle_tx_cq_event() returns, at this time , the second tx_desc 
is already complete, we expect rc = ib_req_notify_cq(cq, IB_CQ_NEXT_COMP 
| IB_CQ_REPORT_MISSED_EVENTS); to return 1 in rc and continue to call 
dtr_handle_tx_cq_event() in next while loop.

d) but it check cm->state is not CONNECTED, and break the outer while 
loop, so the second tx_desc will never be handled.

> Do you the reference on cm that is held because of the timer?
> Please describe what the problem is, and how you are improving the situation.
> 
> In case this approach is the right solution, the patch should also change the
> dtr_handle_tx_cq_event() function to type void.
> 
> best regards,
>   Philipp
> 
> On Mon, Jun 24, 2024 at 8:22 AM zhengbing.huang
> <zhengbing.huang@easystack.cn> wrote:
>>
>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>
>> We need to drain all tx in disconnect to put all kref for cm
>>
>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>> ---
>>   drbd/drbd_transport_rdma.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
>> index b7ccb15d4..9a6d15b78 100644
>> --- a/drbd/drbd_transport_rdma.c
>> +++ b/drbd/drbd_transport_rdma.c
>> @@ -1956,9 +1956,6 @@ static void dtr_tx_cq_event_handler(struct ib_cq *cq, void *ctx)
>>                          err = dtr_handle_tx_cq_event(cq, cm);
>>                  } while (!err);
>>
>> -               if (cm->state != DSM_CONNECTED)
>> -                       break;
>> -
>>                  rc = ib_req_notify_cq(cq, IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
>>                  if (unlikely(rc < 0)) {
>>                          struct drbd_transport *transport = cm->path->path.transport;
>> --
>> 2.27.0
>>
> .
> 
