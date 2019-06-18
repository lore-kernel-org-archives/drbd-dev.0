Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 55E781019AC6
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 19:58:57 +0200 (CEST)
Received: by mail-io1-f65.google.com with SMTP id r185so25943102iod.6
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 10:58:57 -0700 (PDT)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>
References: <28397d5c-72ca-e4b5-fb00-7b55466e7441@gmail.com>
	<20190612142612.GB5803@soda.linbit>
From: David Butterfield <dab21774@gmail.com>
Message-ID: <c60379e8-7117-0c80-3371-2a6f0e93fd41@gmail.com>
Date: Tue, 18 Jun 2019 11:58:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190612142612.GB5803@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] main.c comments
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

>> (1) Isn't the third argument to module_param_named() supposed to be the type of
>>     the second argument?  (But seems to require it as a single token??)
> 
> Yes and no ;-)
> the type of the second argument in this case is a drbd_protocol_version,
> so by naming that as third argument, we point to the "conversion and
> validation functions" for that type.

Aha!  Thanks.  All I was doing was comparing the types at compile-time
and not finding a match.

> again, "details depend on the kernel version"...

Yeah, I'm pretending to be 2.6.32, the minimum supported by DRBD's kernel
compatibility, to minimize the amount of kernel function I have to emulate.

>> (2) The cast avoids a compiler warning about signed/unsigned comparison.
> 
> As long as our kernel compiles complete without warnings, "boring".

OK, I'll set my own warnings back down to the same ones the kernel enables.

For warnings that happen a lot I already disabled them, but there were
three warnings that each was reported only once in 51,444 lines of DRBD
code -- I had figured those conditions were being maintained and not
supposed to be there, so those are the ones I mentioned.

David Butterfield
