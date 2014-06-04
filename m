Return-Path: <raulhp@ugr.es>
Received: from mail1.ugr.es (mail1.ugr.es [150.214.35.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7BA0A101AC76
	for <drbd-dev@lists.linbit.com>; Wed,  4 Jun 2014 12:21:40 +0200 (CEST)
Received: from rc.ugr.es (rc1.ugr.es [150.214.220.81])
	by mail1.ugr.es (Postfix) with ESMTP id B3E9B450
	for <drbd-dev@lists.linbit.com>; Wed,  4 Jun 2014 12:21:40 +0200 (CEST)
Received: from webmail.ugr.es (localhost [127.0.0.1])
	by rc.ugr.es (Postfix) with ESMTP id C982E2265C
	for <drbd-dev@lists.linbit.com>; Wed,  4 Jun 2014 12:21:39 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 04 Jun 2014 12:21:39 +0200
From: raulhp <raulhp@ugr.es>
To: <drbd-dev@lists.linbit.com>
In-Reply-To: <20140530131752.GC12754@soda.linbit>
References: <20140527224053.GD17111@soda.linbit>
	<85bebd869def7c9ebf198ee72baef5ba@ugr.es>
	<20140528115654.GH17111@soda.linbit>
	<41bcdaf0897e6ebd1d919e7675c7f385@ugr.es>
	<20140528124957.GI17111@soda.linbit>
	<fb84d1d109a3575156acc44b4e6d1d00@ugr.es>
	<20140528183616.GJ17111@soda.linbit>
	<9eb0a7ed7c21820d13febc89c63dc340@ugr.es>
	<20140529212917.GC6434@soda.linbit>
	<94c262ac1c1dd4603894b6594b03208a@ugr.es>
	<20140530131752.GC12754@soda.linbit>
Message-ID: <eda7b0a7aee164c000e21bc0ff82ec64@ugr.es>
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

It´s correct, Thanks Lars,

Regards,
Ra

El 2014-05-30 15:17, Lars Ellenberg escribió:
> On Fri, May 30, 2014 at 12:28:19PM +0200, raulhp wrote:
>> >>>Am I misunderstanding your question?
>> >>You understand my question :-) only y want to understand how to 
>> use
>> >>existing code of ACK for multicast
>> >
>> >I don't think it works that way.
>>
>> Now, What do you think?
>
> I think, amoung other things, we have some a nice language barrier 
> here.
>
> I think, as I tried to explain,
> that you need to distinguish between what happens
> on the DRBD protocol level, and what happens
> on the communication transport level.
> The latter is what you are working on.
> You can do almost whatever you want there.
>
> But it should be obvious that you cannot re-use the
> DRBD protocol level "my-disk-has-failed-I-am-so-sorry" message
> to mean, on the transport layer,
> "please-resend-all-requests-I-did-miss", just because both
> concepts use the term "nack" somewhere in the description.
>
> Different things.
> Both needed.
> Not directly related.

