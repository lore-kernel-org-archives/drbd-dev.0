Return-Path: <raulhp@ugr.es>
Received: from mail4.ugr.es (mail4.ugr.es [150.214.35.27])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 218E3101AC75
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 17:25:28 +0200 (CEST)
Received: from rc.ugr.es (rc10.ugr.es [150.214.220.90])
	by mail4.ugr.es (Postfix) with ESMTP id A636C646
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 17:25:28 +0200 (CEST)
Received: from webmail.ugr.es (localhost [127.0.0.1])
	by rc.ugr.es (Postfix) with ESMTP id 063DC22411
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 17:25:28 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 28 May 2014 17:25:28 +0200
From: raulhp <raulhp@ugr.es>
To: <drbd-dev@lists.linbit.com>
In-Reply-To: <20140528124957.GI17111@soda.linbit>
References: <065690d908f4c5aaeba8d8763c41a764@ugr.es>
	<20140527224053.GD17111@soda.linbit>
	<85bebd869def7c9ebf198ee72baef5ba@ugr.es>
	<20140528115654.GH17111@soda.linbit>
	<41bcdaf0897e6ebd1d919e7675c7f385@ugr.es>
	<20140528124957.GI17111@soda.linbit>
Message-ID: <fb84d1d109a3575156acc44b4e6d1d00@ugr.es>
Subject: Re: [Drbd-dev] Protocol C
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



El 2014-05-28 14:49, Lars Ellenberg escribió:
> On Wed, May 28, 2014 at 02:32:05PM +0200, raulhp wrote:
>> Hi Lars,
>>
>> Thanks so much, I focus only the replication link, the first develop
>> is implement the replication to n servers with reliable multicast,
>> ensuring the write in the remote disk.
>>
>> Can you explain me this ? Where? ---> You would need to find the
>> "relevant" requests on the resource->transfer_log()
>
> See in drbd_send_and_submit(), and helpers, e.g.
> drbd_process_write_request,
> where the requests are put on the transfer log in incoming order.
>
> The drbd sender threads (wait_for_sender_todo, process_one_request)
> find them there, and send them.
>
> The drbd asender thread receives the acks (or, in your case
> the retransmit requests), needs to validate thes acks (or neg acks,
> or retrsnamit requests), and change the state of the respective 
> request
> object.
>
> That's what happens in got_BlockAck and friends.
All this it´s ok!

> Now you want to implement some mcast.
> I don't know what information you envison to have,
> what would make you ask for retransmit,
> what exactly you would ask for,
> what information you could use in your got_retransmit_request 
> function.
>
I want to implement a mcast with NACK, where the receiver send NACK 
message to the sender when the receiver detects a loss packet, and the 
sender send the packet in question, with this is possible guarantee all 
writes in the remote node and reduce the traffic in the network.

> But the drbd_request will stay linked on the resource->transfer_log
> until it is "acked", or "cleaned up" due to connection loss.

It´s ok

> Depending on the information you have in that restransmit request,
> you will be able to find the relevant requests on that transfer log.
> I don't know what information you have, so I cannot tell how to best
> find them.
>
> Non-relevant are:
>   those that have not been sent yet (to that peer)
>   those that have already been ACKed (by that peer)
> Which means that relevant are
>   those that have been sent, but not acked,
>   and fall in whatever "range" you request to be restransmitted.
This is ok, but with Multicast communication is necesary to use UDP 
Protocol with Reliability.

Can you understand me?

Regards,
Ra

> Maybe you need to add your own lookup struct,
> and trigger selective retransmit from there.
>
> Worst case, you do a full list walk as PoC.
>
> Give me something more specific than "how do I do multicast",
> because if I answer that unspecific question, I already
> implemented^Wdesigned it myself ;-)
>
> Cheers,
> 	Lars
>
>> Regards,
>> Ra
>>
>> El 2014-05-28 13:56, Lars Ellenberg escribió:
>> >On Wed, May 28, 2014 at 12:14:30PM +0200, raulhp wrote:
>> >>Hi Lars,
>> >>
>> >>I´m trying to understand how ACK´s works en Protocol C to try to 
>> use
>> >>it in Reliable Multicast in each receiver, I´m using a Reliable
>> >>Multicast with NACK (Negative-ACKnowledgment) only in each loss
>> >>packet.
>> >
>> >Ok.
>> >
>> >The entry point for requests from "upper layers" is
>> >drbd_make_request
>> >  __drbd_make_request
>> >    drbd_request_prepare()
>> >    drbd_send_and_submit(),
>> >    which is in drbd_req.c
>> >
>> >Everything "interesting" that happens to such a struct drbd_request
>> >object is handled with req_mod(req, event, peer_device)
>> >(or _req_mod ...) which are both a wrapper around
>> >__req_mod(),
>> >which calls into mod_rq_state();
>> >
>> >"events" are drbd_req_events,
>> >drbd requests state flags are from drbd_req_state_bits (__RQ_*)
>> >(or the corresponding RQ_* defines).
>> >
>> >grep for req_mod should be useful.
>> >
>> >If you consider only the replication link(s),
>> >the interesting functions are likely
>> >drbd_sender.c,
>> >  drbd_sender()
>> >    wait_for_sender_todo()
>> >    process_sender_todo()
>> >      process_one_request()
>> >
>> >drbd_receiver.c
>> >  drbd_asender()
>> >     ... lots of other stuff ...
>> >     cmd = &asender_tbl[pi.cmd];
>> >     ...
>> >     cmd->fn(connection, &pi);
>> >with fn (see asender_tbl) being
>> >  got_BlockAck()
>> >  got_NegAck()
>> >
>> >Where you would probabaly need a "got_mcast_neg_ack()",
>> >which could maybe better be re-labeled as
>> >"got_mcast_retransmit_request()".
>> >
>> >You would need to find the "relevant" requests on the
>> >  resource->transfer_log(), and queue them for resend.
>> >(Or abstract out your own primitives from the existing stuff,
>> > and implement both the existing TCP links and the new mcast
>> > with some additional auxiliary functions as needed).
>> >
>> >Does that help?

