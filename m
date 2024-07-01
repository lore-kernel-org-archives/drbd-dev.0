Return-Path: <dongsheng.yang@easystack.cn>
Received: from mail-m1026.netease.com (mail-m1026.netease.com [154.81.10.26])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1B197420471
	for <drbd-dev@lists.linbit.com>;
	Mon,  1 Jul 2024 04:19:02 +0200 (CEST)
Subject: Re: [PATCH 04/11] drbd_transport_rdma: dont schedule
	retry_connect_work in active is false
To: Philipp Reisner <philipp.reisner@linbit.com>,
	"zhengbing.huang" <zhengbing.huang@easystack.cn>
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-4-zhengbing.huang@easystack.cn>
	<CADGDV=XEoNE6r_Q+R3agyytF-AhqduKdwM87FRsRC9axF8P5PQ@mail.gmail.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <7f88de47-ac10-0b31-5a15-04f0106c7d4e@easystack.cn>
Date: Mon, 1 Jul 2024 10:11:27 +0800
MIME-Version: 1.0
In-Reply-To: <CADGDV=XEoNE6r_Q+R3agyytF-AhqduKdwM87FRsRC9axF8P5PQ@mail.gmail.com>
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



在 2024/6/28 星期五 下午 7:51, Philipp Reisner 写道:
> Hello Dongsheng,
> 
> Please explain what problem you are fixing with this change. Do you
> have a log that shows a problem in this area? Please describe why your
> proposed change improves DRBD's behavior.

retry_connect_work can be flushed in dtr_free, that's correct. but if we 
schedule new work after that, there is a NULL pointer dereference in our 
testing. So dont schedule new retry_connect_work when 
rdma_transport->active is false. it is set to false in dtr_free before 
flushing retry_connect_work.
> 
> best regards,
>   Philipp
> 
> On Mon, Jun 24, 2024 at 9:28 AM zhengbing.huang
> <zhengbing.huang@easystack.cn> wrote:
>>
>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>
>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>> ---
>>   drbd/drbd_transport_rdma.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
>> index eccd0c6ce..b7ccb15d4 100644
>> --- a/drbd/drbd_transport_rdma.c
>> +++ b/drbd/drbd_transport_rdma.c
>> @@ -1089,9 +1089,13 @@ static void dtr_cma_retry_connect_work_fn(struct work_struct *work)
>>          if (err) {
>>                  struct dtr_path *path = container_of(cs, struct dtr_path, cs);
>>                  struct drbd_transport *transport = path->path.transport;
>> +               struct dtr_transport *rdma_transport =
>> +                       container_of(transport, struct dtr_transport, transport);
>>
>>                  tr_err(transport, "dtr_start_try_connect failed  %d\n", err);
>> -               schedule_delayed_work(&cs->retry_connect_work, HZ);
>> +               if (rdma_transport->active) {
>> +                       schedule_delayed_work(&cs->retry_connect_work, HZ);
>> +               }
>>          }
>>   }
>>
>> @@ -1116,6 +1120,8 @@ static void dtr_remove_cm_from_path(struct dtr_path *path, struct dtr_cm *failed
>>   static void dtr_cma_retry_connect(struct dtr_path *path, struct dtr_cm *failed_cm)
>>   {
>>          struct drbd_transport *transport = path->path.transport;
>> +       struct dtr_transport *rdma_transport =
>> +               container_of(transport, struct dtr_transport, transport);
>>          struct dtr_connect_state *cs = &path->cs;
>>          long connect_int = 10 * HZ;
>>          struct net_conf *nc;
>> @@ -1128,7 +1134,9 @@ static void dtr_cma_retry_connect(struct dtr_path *path, struct dtr_cm *failed_c
>>                  connect_int = nc->connect_int * HZ;
>>          rcu_read_unlock();
>>
>> -       schedule_delayed_work(&cs->retry_connect_work, connect_int);
>> +       if (rdma_transport->active) {
>> +               schedule_delayed_work(&cs->retry_connect_work, connect_int);
>> +       }
>>   }
>>
>>   static void dtr_cma_connect_work_fn(struct work_struct *work)
>> --
>> 2.27.0
>>
> .
> 
