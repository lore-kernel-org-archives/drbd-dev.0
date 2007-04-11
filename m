Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 00F992E29485
	for <drbd-dev@lists.linbit.com>; Wed, 11 Apr 2007 17:01:49 +0200 (CEST)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:58214)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1HbeKT-00022e-6l
	for drbd-dev@lists.linbit.com; Wed, 11 Apr 2007 16:01:49 +0100
Message-ID: <461CF901.70008@dcs.gla.ac.uk>
Date: Wed, 11 Apr 2007 16:04:33 +0100
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] switching between protocols A and C
References: <461CD0EC.4040402@dcs.gla.ac.uk>	<20070411125716.GC27110@barkeeper1.linbit>	<461CE69A.5020604@dcs.gla.ac.uk>
	<20070411145140.GA4659@barkeeper1.linbit>
In-Reply-To: <20070411145140.GA4659@barkeeper1.linbit>
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
> On Wed, Apr 11, 2007 at 02:46:02PM +0100, Cristian Zamfir wrote:
>> Lars Ellenberg wrote:
>>> On Wed, Apr 11, 2007 at 01:13:32PM +0100, Cristian Zamfir wrote:
>>>> Hi,
>>>>
>>>> Would it be possible to switch from protocol A to C and vice versa 
>>>> without disconnecting (for instance detach, switch protocol and 
>>>> re-attach)?
>>>>
>>>> This would be useful when alternating between two primaries (only 
>>>> protocol C can be used) and a primary/secondary configuration where 
>>>> protocol A may increase write throughput on the primary node.
>>> protocol A does _NOT_ increase throughput at all.
>>> it _MAY_ reduce latency somewhat sometimes.
>> I am testing with the bonnie++ benchmark over a 100Mbps link and I get a 
>> substantial increase for output in the case of protocol A at the expense 
>> of higher CPU ratio. From what I understand, it would make sense to get 
>> better throughput from the asynchronous protocol over low quality links. 
>> Or am I doing something wrong?
> 
> and your exact bonnie++ command line is:
> 
Bonnie++ is run with the default parameters:
bonnie++ -u zamf -d bonnie/

I have results from ./tiobench, with shows a 2.4x increase in 
performance in favour of protocol A:

/usr/bin/tiotest -t 8 -f 60 -r 500 -b 4096 -d . -T-T

Protocol A
Sequential Writes
                               File  Blk   Num                   Avg 
   Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency 
  Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- 
-----------  -------- -------- -----
2.6.18-xenU                   480   4096    1   24.27 11.73%     0.126 
     724.87   0.00000  0.00000   207
2.6.18-xenU                   480   4096    2   20.32 10.07%     0.312 
    1002.72   0.00000  0.00000   202
2.6.18-xenU                   480   4096    4   16.57 7.733%     0.648 
    4505.20   0.00570  0.00000   214
2.6.18-xenU                   480   4096    8   15.96 7.445%     1.107 
    6598.77   0.02279  0.00000   214


Protocol C

Sequential Writes
                               File  Blk   Num                   Avg 
   Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency 
  Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- 
-----------  -------- -------- -----
2.6.18-xenU                   480   4096    1   10.46 5.032%     0.301 
    1232.91   0.00000  0.00000   208
2.6.18-xenU                   480   4096    2   10.74 5.032%     0.581 
    1981.85   0.00000  0.00000   213
2.6.18-xenU                   480   4096    4   10.55 5.009%     0.849 
    3782.22   0.01302  0.00000   211
2.6.18-xenU                   480   4096    8   10.32 4.923%     1.841 
    8250.74   0.03581  0.00000   210

