Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id BF1692D9DC61
	for <drbd-dev@lists.linbit.com>; Thu,  7 Dec 2006 14:52:08 +0100 (CET)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:58445)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1GsJfT-0007Ug-WC
	for drbd-dev@lists.linbit.com; Thu, 07 Dec 2006 13:52:08 +0000
Message-ID: <45781C8F.1080400@dcs.gla.ac.uk>
Date: Thu, 07 Dec 2006 13:52:15 +0000
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] lock for reading device state
References: <4576FC63.704@dcs.gla.ac.uk> <20061207130920.GD7521@soda.linbit>
In-Reply-To: <20061207130920.GD7521@soda.linbit>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>



Lars Ellenberg wrote:
> / 2006-12-06 17:22:43 +0000
> \ Cristian Zamfir:
>>
>> Hi,
>>
>> I am using drbd to implement xen block device migration.  Right now I
>> am parsing /proc/drbd to find out if the drives are synchronized and I
>> can migrate them.
> 
> you talk about drbd state "Connected, Consistent",
> or what exactly are you parsing?

Yes, indeed, I am parsing these values: "cs:Connected 
st:Secondary/Primary ld:Consistent"


> 
>> Is there a way to obtain a lock while reading and processing this
>> information and prevent other writes to the primary device?
> 
> no. why?
> 

I wrote a script that parses /proc/drbd on the primary node. While I am 
running this script, writes to the primary device are still allowed. If 
I find that the ld state is "Consistent" then I will make this node 
secondary and the peer will become primary.
The problem is when writes happen while my script is making the peer 
node primary.

A race situation would be the following:
At moment X, I read /proc/drbd and see the ld state is consistent.
At moment X+1 a write arrives at /dev/drbd1 and the devices are not 
consistent any more. They start syncing but this may last longer, for 
instance until moment X+5.
Now, at moment X+2, I wrongly believe that the state is still 
consistentand I decide to make the peer node primary and thus loose the 
write at moment X+1.

Are my assumptions correct so far?


I'm thinking that there are two solutions: One would be to prevent any 
writes from Xen's domUs by modifying Xen.
The other would be to be able to hold a lock that prevents writes from 
reaching /dev/drbdX and release it after the processing within the 
script finishes (that is while I switch the peer device from secondary 
to primary).

I haven't looked at drbd's source yet ( I am using 0.7.22 now) but I am 
considering implementing this lock within drbd if there is no other 
solution available.

As a future project, I am also interested if there is anyone working on 
implementing multiple secondary devices. I am interested in having 
multiple replicas of the primary node.

I hope this explains more my question.
Thank you very much for your help.

Cristian


>> I need to be able to prevent writes while reading the state of
>> the device from a script external to drbd.
> 
> does not make sense to me yet?
> 
>> In case there is no existing solution, can you please give me a few
>> tips on how to start developing such a locking mechanism?
> 
> please give more details about your assumptions and reasoning,
> maybe its just that you have wrong expectations?
> 
> could also be that I'm just mentally block right now...
> 
> 	:)
> 

