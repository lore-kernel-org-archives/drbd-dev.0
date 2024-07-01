Return-Path: <dongsheng.yang@easystack.cn>
Received: from mail-m127103.qiye.163.com (mail-m127103.qiye.163.com
	[115.236.127.103])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3B178420304
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2024 04:59:02 +0200 (CEST)
Subject: Re: [PATCH 08/11] drbd_transport_rdma: fix a race between dtr_connect
	and drbd_thread_stop
To: Philipp Reisner <philipp.reisner@linbit.com>,
	"zhengbing.huang" <zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-8-zhengbing.huang@easystack.cn>
	<CADGDV=X9Ev4Z6x-FnE2J6zdLe5DyVsEwX4Zg3E8=XR=CP+synw@mail.gmail.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <cabafa53-4da2-e49f-c28a-ae6f7029d035@easystack.cn>
Date: Mon, 1 Jul 2024 10:30:16 +0800
MIME-Version: 1.0
In-Reply-To: <CADGDV=X9Ev4Z6x-FnE2J6zdLe5DyVsEwX4Zg3E8=XR=CP+synw@mail.gmail.com>
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



在 2024/6/28 星期五 下午 8:36, Philipp Reisner 写道:
> Hello Dongsheng,
> 
> I am repeating your description in my own words so that you can verify
> I got it right:
> 
> CPU 0 executes dtr_connect() and is still before the
> wait_for_completion_interruptible().
> CPU 1 executes send_sig() in drbd_thread_stop().
> 
> Then you conclude that wait_for_completion_interruptible() will not
> abort, because the signal
> was raised before CPU 0 reached wait_for_completion_interruptible().

The problem is dtr_prepare_connect() calles flush_signals(), so the 
signal from drbd_thread_stop() can be flushed by dtr_prepare_connect().
> 
> If that is your description, then it is wrong.
> This is not how signals and the wait_event() macros work.
> 
> best regards,
>   Philipp
> 
> On Mon, Jun 24, 2024 at 9:27 AM zhengbing.huang
> <zhengbing.huang@easystack.cn> wrote:
>>
>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>
>> If the send_sig() in drbd_thread_stop before wait_for_completion_interruptible() in dtr_connect(),
>> it can't return from dtr_connect in network failure.
>>
>> So replace wait_for_completion_interruptible with wait_for_completion_interruptible_timeout, and
>> check status by dtr_connect() itself.
>>
>> This behavior is similar with tcp transport
>>
>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>> ---
>>   drbd/drbd_transport_rdma.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
>> index 77ff0055e..c47b344f8 100644
>> --- a/drbd/drbd_transport_rdma.c
>> +++ b/drbd/drbd_transport_rdma.c
>> @@ -2996,12 +2996,21 @@ static int dtr_connect(struct drbd_transport *transport)
>>   {
>>          struct dtr_transport *rdma_transport =
>>                  container_of(transport, struct dtr_transport, transport);
>> -       int i, err = -ENOMEM;
>> +       int i, err;
>>
>> -       err = wait_for_completion_interruptible(&rdma_transport->connected);
>> -       if (err) {
>> +again:
>> +       if (drbd_should_abort_listening(transport)) {
>> +               err = -EAGAIN;
>> +               goto abort;
>> +       }
>> +
>> +       err = wait_for_completion_interruptible_timeout(&rdma_transport->connected, HZ);
>> +       if (err < 0) {
>>                  flush_signals(current);
>>                  goto abort;
>> +       } else if (err == 0) {
>> +               /* timed out */
>> +               goto again;
>>          }
>>
>>          err = atomic_read(&rdma_transport->first_path_connect_err);
>> --
>> 2.27.0
>>
