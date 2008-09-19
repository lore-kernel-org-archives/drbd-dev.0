Return-Path: <moreyroof@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C7A992E2E574
	for <drbd-dev@lists.linbit.com>; Sat, 20 Sep 2008 00:28:23 +0200 (CEST)
Received: by yw-out-2324.google.com with SMTP id 2so113964ywt.33
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2008 15:28:23 -0700 (PDT)
Message-ID: <48D42783.1050403@gmail.com>
Date: Fri, 19 Sep 2008 16:28:19 -0600
From: Morey Roof <moreyroof@gmail.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] New Features
References: <48D3378E.3020201@gmail.com>
	<20080919155343.GD9779@soda.linbit>	<91a37e890809190919g5a746367g54e76d36e1a825f6@mail.gmail.com>
	<20080919221339.GB15916@soda.linbit>
In-Reply-To: <20080919221339.GB15916@soda.linbit>
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
> On Fri, Sep 19, 2008 at 10:19:03AM -0600, Morey Roof wrote:
>   
>> I have been programming professionally for about 12 years with C/C++
>> in various system.  I have worked on various parts of Linux for
>> companies but I never submitted work to be included until recently.
>> So I am a bit new to the get stuff out there model, but I am quite
>> experienced working on very large and complex projects.
>>
>> What has allowed me to start working on some open source projects
>> recently is the move to a job for a college where such work is
>> welcomed and encouraged instead of the traditional business models
>> where everything is a closely guarded secret.  We have been using DRBD
>> for a while and I have found that there are several itches I would
>> like to scratch, so to speak.
>>
>> Let me know if you need more information.
>>     
>
> sounds promising.
>
> do you want to discuss some of the itches?
>
> 	Lars
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>   

The first item on the list is a write back cache.  Now don't run 
screaming to hills yet.  In our setup we have the two nodes in two 
different buildings which are feed by different power supplies from the 
city grid.  The machines themselves have dual power supplies which each 
power supply going to it's own UPS and circuit.  So, we have a good 
redundant power supply setup.  So, I was thinking about creating a 
caching system in DRBD to allow for dedicating some of the server's RAM 
to a large read/write-back cache.  In the event of communication failure 
between the peers I wanted it to flush the entire cache and then run in 
write-through mode and move back to write-back mode after communication 
is present again and the resync is finished.

So that is the basic idea.  I was thinking about having it use the 
ramdisk system so that you can specify a device that is used as the 
cache.  The reason I was thinking about this is that if you happen to 
purchase one of those Gigabyte ram HDD that is just like a large battery 
backed write cache you could set it as the cache device as well.

What are your thought?

-Morey
