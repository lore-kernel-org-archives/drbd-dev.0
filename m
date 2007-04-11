Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AF0702E2716C
	for <drbd-dev@lists.linbit.com>; Wed, 11 Apr 2007 15:43:18 +0200 (CEST)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:55324)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1Hbd6U-0007G5-4I
	for drbd-dev@lists.linbit.com; Wed, 11 Apr 2007 14:43:18 +0100
Message-ID: <461CE69A.5020604@dcs.gla.ac.uk>
Date: Wed, 11 Apr 2007 14:46:02 +0100
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] switching between protocols A and C
References: <461CD0EC.4040402@dcs.gla.ac.uk>
	<20070411125716.GC27110@barkeeper1.linbit>
In-Reply-To: <20070411125716.GC27110@barkeeper1.linbit>
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
> On Wed, Apr 11, 2007 at 01:13:32PM +0100, Cristian Zamfir wrote:
>> Hi,
>>
>> Would it be possible to switch from protocol A to C and vice versa 
>> without disconnecting (for instance detach, switch protocol and re-attach)?
>>
>> This would be useful when alternating between two primaries (only 
>> protocol C can be used) and a primary/secondary configuration where 
>> protocol A may increase write throughput on the primary node.
> 
> protocol A does _NOT_ increase throughput at all.
> it _MAY_ reduce latency somewhat sometimes.

I am testing with the bonnie++ benchmark over a 100Mbps link and I get a 
substantial increase for output in the case of protocol A at the expense 
of higher CPU ratio. From what I understand, it would make sense to get 
better throughput from the asynchronous protocol over low quality links. 
Or am I doing something wrong?



drbd connected protocol C

Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP 
/sec %CP
raoul          464M 12764  52 13525   4  8401   0 18724  39 27174   0 
198.4   0
                     ------Sequential Create------ --------Random 
Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
/sec %CP
                  16 27245  94 +++++ +++ 27305  99 26368  98 +++++ +++ 
22775  95
raoul,464M,12764,52,13525,4,8401,0,18724,39,27174,0,198.4,0,16,27245,94,+++++,+++,27305,99,26368,98,+++++,+++,22775,95


drbd connected protocol A

Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP 
/sec %CP
raoul          464M 27292  90 33632  10 11140   0 19785  46 28524   0 
218.0   0
                     ------Sequential Create------ --------Random 
Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP 
/sec %CP
                  16 27136  97 +++++ +++ 26985 100 26775  98 +++++ +++ 
23972 100
raoul,464M,27292,90,33632,10,11140,0,19785,46,28524,0,218.0,0,16,27136,97,+++++,+++,26985,100,26775,98,+++++,+++,23972,100 


> 
>> Right now this behaviour does not seem to be supported but I am 
>> interested if you consider it could be implemented easily.
> 
> no. and it does not make much sense for me, either.
> 

Cristian
