Return-Path: <lists@beekhof.net>
In-Reply-To: <20040924211133.GC3927@marowsky-bree.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<20040924211133.GC3927@marowsky-bree.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8E6E7736-0FEB-11D9-88B9-000A95B71D78@beekhof.net>
Content-Transfer-Encoding: 7bit
From: Andrew Beekhof <lists@beekhof.net>
Date: Sun, 26 Sep 2004 20:40:36 +0200
To: High-Availability Linux Development List <linux-ha-dev@lists.linux-ha.org>
Cc: drbd-dev@linbit.com
Subject: [Drbd-dev] Re: [Linux-ha-dev] [RFC] (CRM and) DRBD (0.8) states and
	transistions, recovery strategies
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


On Sep 24, 2004, at 11:11 PM, Lars Marowsky-Bree wrote:

> On 2004-09-24T16:29:25,
>    Lars Ellenberg <Lars.Ellenberg@linbit.com> said:
>
>> some of this applies to replicated resources in general,
>> so Andrew may have some ideas to generalize it...
>
> I think the modelling we have so far (with the recent addendum) 
> captures
> this quite nicely for the time being. But of course, it'll help us to
> verify this.

right.  i also be thinking more about this in the coming days when I 
start on the incarnations.

>
>>     Some of the attributes depend on others, and the information 
>> about the
>>     node status could be easily encoded in one single letter.
>>
>>     But since HA is all about redundancy, we will encode the node 
>> status
>>     redundantly in *four* letters, to make it more obvious to human 
>> readers.
>>
>>      _        down,
>>      S        up, standby (non-active, but ready to become active)
>>      s        up, not-active, but target of sync
>>      i        up, not-active, unconnected, inconsistent
>>      o        up, not-active, unconnected, outdated
>>      d        up, not-active, diskless
>>      A        up, active
>>      a        up, active, but target of sync
>>      b        up, blocking, because unconnected active and 
>> inconsistent
>>                             (no valid data available)
>>      B        up, blocking, because unconnected active and diskless
>>                             (no valid data available)
>>      D        up, active, but diskless (implies connection to good 
>> data)
>>       M       meta-data storage available
>>       _       meta-data storage unavailable
>>        *      backing storage available
>>        o      backing storage consistent but outdated
>>               (refuses to become active)
>>        i      backing storage inconsistent (unfinished sync)
>>        _      diskless
>>         :     unconnected, stand alone
>>         ?     unconnected, looking for peer
>>         -     connected
>>>     connected, sync source
>>         <     connected, sync target
>
> I'd structure this somewhat differently into the node states (Up, 
> Down),
> our assumption about the other node (up, down, fenced), Backing Store
> states (available, outdated, inconsistent, unavailable), the connection
> (up or down) and the relationship between the GCs (higher, lower,
> equal).
>
> (Whether we are syncing and in what direction seems to be a function of
> that, same whether or not we are blocking or not.)
>
> It's essentially the same as your list, but it seems to be more
> accessible to me. But, it's late ;-)

I agree here... restricting the attributes to true inputs (rather than 
derived values) helps stop my brain going into meltdown trying to 
absorb the matrix :)  I could also imagine that it makes your life 
easier if you decide to change how you decide something like syncing 
direction later on.



-- 
Andrew Beekhof

"Ooo Ahhh, Glenn McRath" - TISM

