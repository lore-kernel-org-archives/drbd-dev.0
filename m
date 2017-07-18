Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 845AD105647D
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 09:59:04 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 5D4DFAD8A
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 07:59:04 +0000 (UTC)
To: drbd-dev@lists.linbit.com
References: <20170717192930.21694-1-bwiedemann@suse.de>
	<20170718072001.GA1453@rck.sh>
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Message-ID: <ea09d434-d7c5-5ec2-7183-1808aebdb2a6@suse.de>
Date: Tue, 18 Jul 2017 09:59:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170718072001.GA1453@rck.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH] drbd: sort file list
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

On 2017-07-18 09:20, Roland Kammerer wrote:
> On Mon, Jul 17, 2017 at 09:29:30PM +0200, Bernhard M. Wiedemann wrote:
>> because it influences the ordering of entries in compat.h
>> which influences srcversion= checksum
> 
> "srcversion" is for in tree drbd.
> 
>> which prevents drbd.ko from building reproducibly.
>>
>> See https://reproducible-builds.org/ for why this matters.
>> ---
>>  drbd/Kbuild | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drbd/Kbuild b/drbd/Kbuild
>> index 2d1b4d0..c5787a6 100644
>> --- a/drbd/Kbuild
>> +++ b/drbd/Kbuild
>> @@ -70,7 +70,7 @@ COMPAT_FORCE := FORCE
>>  endif
>>  
>>  ifneq ($(KBUILD_STAGE),modpost)
>> -TEST_C := $(wildcard $(src)/drbd-kernel-compat/tests/*.c)
>> +TEST_C := $(sort $(wildcard $(src)/drbd-kernel-compat/tests/*.c))
>>  TEST_R := $(TEST_C:$(src)/drbd-kernel-compat/tests/%.c=$(obj)/.compat_test.%.result)
>>  $(obj)/.compat_test.%.result: $(src)/drbd-kernel-compat/tests/%.c $(COMPAT_FORCE)
>>  	$(call cmd,compat_test_result)
> 
> which is for out of tree drbd, like the whole compat checks and compat.h.
> 
> so what are you actually talking about?

I'm trying to build openSUSE drbd packages twice and get such diffs:
http://rb.zq1.de/compare.factory-20170713/drbd-compare.out

Our kmp packages are for out-of-tree modules, so it seems the kernel's
/usr/src/linux-4.12.0-1/scripts/mod/modpost.c get_src_version
/usr/src/linux-4.12.0-1/scripts/mod/sumversion.c
codepath is also taken for out-of-tree modules.

Ciao
Bernhard M.
