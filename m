Return-Path: <raulhp@ugr.es>
Received: from mail1.ugr.es (mail1.ugr.es [150.214.35.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 17D90101AC75
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 12:14:31 +0200 (CEST)
Received: from rc.ugr.es (rc10.ugr.es [150.214.220.90])
	by mail1.ugr.es (Postfix) with ESMTP id 3A9A6379
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 12:14:30 +0200 (CEST)
Received: from webmail.ugr.es (localhost [127.0.0.1])
	by rc.ugr.es (Postfix) with ESMTP id 946B122411
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 12:14:30 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 28 May 2014 12:14:30 +0200
From: raulhp <raulhp@ugr.es>
To: <drbd-dev@lists.linbit.com>
In-Reply-To: <20140527224053.GD17111@soda.linbit>
References: <065690d908f4c5aaeba8d8763c41a764@ugr.es>
	<20140527224053.GD17111@soda.linbit>
Message-ID: <85bebd869def7c9ebf198ee72baef5ba@ugr.es>
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

Hi Lars,

I´m trying to understand how ACK´s works en Protocol C to try to use it 
in Reliable Multicast in each receiver, I´m using a Reliable Multicast 
with NACK (Negative-ACKnowledgment) only in each loss packet.

Regards,
Ra

El 2014-05-28 00:40, Lars Ellenberg escribió:
> On Tue, May 27, 2014 at 05:33:53PM +0200, raulhp wrote:
>> Hi all,
>>
>> Can someone explain me how the Protocol C operate?, if the receiver
>> send an ACK for every block or how ACK works.
>
> It basically goes like this:
>
> local:
>   submit to disk
> + send the data,
> 			remote: receive the data
> disk completion			submit to disk
> 				disk completion
> 				send ack back
> receive ack
>
> complete to upper layers,
> once both local disk completion
> and remote ack have been seen.
>
> With some more housekeeping to be able to detect failures,
> and recover from them as gracefully as possible.
>
>> which exactly is the source code?
>
> exactly "most of it" ;-) sorry.
> there is a lot going on, and all those various stages cannot be 
> covered
> with "look there, these six lines of code do it".
>
> What are you trying to do?

