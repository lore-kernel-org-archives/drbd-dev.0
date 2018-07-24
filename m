Return-Path: <lists@alteeve.ca>
Received: from mail.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0BCB3101AC7B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 20:52:26 +0200 (CEST)
To: Sarah Newman <srn@prgmr.com>, Nick Bebout <nb@prgmr.com>,
	drbd-dev@lists.linbit.com
References: <cb6d86c4-acbb-f299-00fe-e83f6c4e69ba@alteeve.ca>
	<58525792-e53d-55a6-379e-5afe963cbae7@alteeve.ca>
	<26442f3d-0a5c-cea3-3d8b-e4d888ebffd3@alteeve.ca>
	<437fd238-e310-80a1-22af-04d3a8783981@alteeve.ca>
	<a48cbd5f-1030-4449-3603-9716ae38cb3b@prgmr.com>
From: Digimer <lists@alteeve.ca>
Message-ID: <3bbddc4f-6337-594b-9fcc-eec9b6e5de4d@alteeve.ca>
Date: Tue, 24 Jul 2018 14:52:25 -0400
MIME-Version: 1.0
In-Reply-To: <a48cbd5f-1030-4449-3603-9716ae38cb3b@prgmr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] DRBD 9 on Fedora 28
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

On 2018-07-24 02:01 PM, Sarah Newman wrote:
> On 07/24/2018 08:55 AM, Digimer wrote:
>> On 2018-07-24 11:31 AM, Digimer wrote:
>>> On 2018-07-24 11:23 AM, Digimer wrote:
>>>> On 2018-07-24 12:40 AM, Digimer wrote:
>>>>> Hi all,
>>>>>
>>>>>   I'm trying to get DRBD 9 on Fedora 28 (which I'm using as a dev
>>>>> platform ahead of RHEL 8 beta). The DRBD that ships with the kernel is
>>>>> 8.4.10.
>>>>>
>>>>>   I've been struggling to build the 9.0.15rc1 RPM without luck. I've
>>>>> made a few progressions (ie: added kernel-rpm-macros, kernel-devel and
>>>>> elfutils-devel to BuildRequires).
>>>>>
>>>>>   Has anyone managed to build DRBD9 on Fedora 27+? If so, would you mind
>>>>> sharing the src.rpm or .spec?
>>>>>
>>>>> Thanks!
>>>>>
>>>>> digimer
>>>>
>>>> Following up with additional info;
>>>>
>>>> The problem is in this loop;
>>>>
>>>> https://github.com/LINBIT/drbd-9.0/blob/master/drbd-kernel.spec#L84
>>>>
>>>> It causes the arch to be appended twice;
>>>>
>>>> ====
>>>> + for flavor in default
>>>> ++ '[' default = default ']'
>>>> + make -C /usr/src/kernels/4.17.7-200.fc28.x86_64.x86_64 modules_install
>>>> M=/home/digimer/rpmbuild/BUILD/drbd-9.0.15rc1/obj/default
>>>> make: *** /usr/src/kernels/4.17.7-200.fc28.x86_64.x86_64: No such file
>>>> or directory.  Stop.
>>>> ====
>>>>
>>>> I've been trying to figure out how to fix it, but it seems my ignorance
>>>> of RPM .spec is getting the better of me...
>>>
>>> I should mention; This same src.rpm builds fine on RHEL 7.5. So it seems
>>> to be specifically a Fedora issue (tried on 27 and 28).
> 
> Digimer, you might be better off asking the Fedora folks rather than the DRBD folks, since they may have had to fix similar issues in other packages.
> 
> Nick, since you're a Fedora ambassador do you have any suggestions on where or who to ask? I don't know if
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/ is appropriate unless Digimer is planning on submitting his work to Fedora.
> 
> Thanks, Sarah

Thanks Sarah!

  I asked on the #fedora IRC channel and a few folks did help (that's
how I narrows it down to that loop), the general feeling was to talk to
LINBIT folks. Personally, I am happy working with either, though I want
to admit straight up that I am fairly new to RPM packaging.

  If Nick has advice, I'll be happy to follow it, too. :)

digimer

-- 
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein’s brain than in the near certainty that people of equal talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
