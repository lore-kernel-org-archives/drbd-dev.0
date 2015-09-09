Return-Path: <lists@alteeve.ca>
Received: from vm08-mail01.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B941510518BD
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 17:31:12 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
References: <55EF7BEA.5060409@alteeve.ca> <55EFD2FD.6010500@alteeve.ca>
	<20150909082106.GB1313@rck.sh> <20150909083737.GC1313@rck.sh>
From: Digimer <lists@alteeve.ca>
Message-ID: <55F050BE.3090405@alteeve.ca>
Date: Wed, 9 Sep 2015 11:31:10 -0400
MIME-Version: 1.0
In-Reply-To: <20150909083737.GC1313@rck.sh>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] rhcs_fence
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

On 09/09/15 04:37 AM, Roland Kammerer wrote:
> On Wed, Sep 09, 2015 at 10:21:07AM +0200, Roland Kammerer wrote:
>> On Wed, Sep 09, 2015 at 02:34:37AM -0400, Digimer wrote:
>>> On 08/09/15 08:23 PM, Digimer wrote:
>>>> Is rhcs_fence not shipped with drbd 8.4?
>>>
>>> If not (it appears not), and if there is interest in adding it, I've
>>> moved it's development into the main striker repo:
>>>
>>> https://github.com/digimer/striker/blob/master/tools/rhcs_fence
>>>
>>
>> Mind the repo-split... There is one in drbd-utils/scripts
>>
> 
> Oh, ours is the bash version Lars wrote, yours is the one in perl.
> 
> It's neither my expertise nor my decision, but FWIW: My (evil) plan is
> to get rid of the existing perl code (AFAIK drbd-overview.pl), so
> personally I am not a fan of merging perl code. I would like to drop the
> perl dependency. For example RHEL7 does not ship perl in its minimal setup
> configuration if I remember correctly.
> 
> Regards, rck

Well, cman+rgmanager is gone entirely in EL7, so this is really for EL6
users.

What is the bash version called? The only other one I knew of the cman
was obliterate-peer.sh, which Lon wrote ages ago. I created rhcs_fence
to improve on his agent.

-- 
Digimer
Papers and Projects: https://alteeve.ca/w/
What if the cure for cancer is trapped in the mind of a person without
access to education?
