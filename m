Return-Path: <raulhp@ugr.es>
Received: from mail1.ugr.es (mail3.ugr.es [150.214.35.31])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7062F101AC79
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:44:01 +0200 (CEST)
Received: from rc.ugr.es (rc2.ugr.es [150.214.220.82])
	by mail1.ugr.es (Postfix) with ESMTP id 6BE99321
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:44:00 +0200 (CEST)
Received: from webmail.ugr.es (localhost [127.0.0.1])
	by rc.ugr.es (Postfix) with ESMTP id AA8F62268A
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 16:44:01 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 07 Apr 2014 16:44:01 +0200
From: raulhp <raulhp@ugr.es>
To: <drbd-dev@lists.linbit.com>
In-Reply-To: <20140407143320.GH2209@soda.linbit>
References: <bd4dca3f93ea0361c978541eb47ff5c1@ugr.es>
	<5302c0939964d7f19bec260413f4c90c@ugr.es>
	<20140407143320.GH2209@soda.linbit>
Message-ID: <7d816ba83fe590c23f80011bc225fb31@ugr.es>
Subject: Re: [Drbd-dev] obtain addr
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

Hi, Only I´m trying to understand how DRBD obtain the IP address from 
drbd.conf, but I have seen the drbdsetup.c file

Thanks!

El 2014-04-07 16:33, Lars Ellenberg escribió:
> On Thu, Apr 03, 2014 at 12:35:36PM +0200, raulhp wrote:
>> Sorry, I accidentally sent email, then...
>>
>>
>>  Where is the seccion in source code that obtain the IP address from
>> drbd.conf file?
>
> What is it you are trying to do?
>
>>  The follow code in drbd_int.h -> struct drbd_connection
>>
>>  struct sockaddr_storage my_addr;
>>  int my_addr_len;
>>  struct sockaddr_storage peer_addr;
>>  int peer_addr_len;
>>
>>
>> Best Regards,
>> Ra

