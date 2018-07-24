Return-Path: <lists@alteeve.ca>
Received: from mail.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D344A1012A37
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 17:31:33 +0200 (CEST)
Received: from pulsar.alteeve.com (ip-104-193-58-76.user.start.ca
	[104.193.58.76])
	by mail.alteeve.ca (Postfix) with ESMTPSA id 34058E00C7
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 11:31:32 -0400 (EDT)
From: Digimer <lists@alteeve.ca>
To: drbd-dev@lists.linbit.com
References: <cb6d86c4-acbb-f299-00fe-e83f6c4e69ba@alteeve.ca>
	<58525792-e53d-55a6-379e-5afe963cbae7@alteeve.ca>
Message-ID: <26442f3d-0a5c-cea3-3d8b-e4d888ebffd3@alteeve.ca>
Date: Tue, 24 Jul 2018 11:31:31 -0400
MIME-Version: 1.0
In-Reply-To: <58525792-e53d-55a6-379e-5afe963cbae7@alteeve.ca>
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

On 2018-07-24 11:23 AM, Digimer wrote:
> On 2018-07-24 12:40 AM, Digimer wrote:
>> Hi all,
>>
>>   I'm trying to get DRBD 9 on Fedora 28 (which I'm using as a dev
>> platform ahead of RHEL 8 beta). The DRBD that ships with the kernel is
>> 8.4.10.
>>
>>   I've been struggling to build the 9.0.15rc1 RPM without luck. I've
>> made a few progressions (ie: added kernel-rpm-macros, kernel-devel and
>> elfutils-devel to BuildRequires).
>>
>>   Has anyone managed to build DRBD9 on Fedora 27+? If so, would you mind
>> sharing the src.rpm or .spec?
>>
>> Thanks!
>>
>> digimer
> 
> Following up with additional info;
> 
> The problem is in this loop;
> 
> https://github.com/LINBIT/drbd-9.0/blob/master/drbd-kernel.spec#L84
> 
> It causes the arch to be appended twice;
> 
> ====
> + for flavor in default
> ++ '[' default = default ']'
> + make -C /usr/src/kernels/4.17.7-200.fc28.x86_64.x86_64 modules_install
> M=/home/digimer/rpmbuild/BUILD/drbd-9.0.15rc1/obj/default
> make: *** /usr/src/kernels/4.17.7-200.fc28.x86_64.x86_64: No such file
> or directory.  Stop.
> ====
> 
> I've been trying to figure out how to fix it, but it seems my ignorance
> of RPM .spec is getting the better of me...

I should mention; This same src.rpm builds fine on RHEL 7.5. So it seems
to be specifically a Fedora issue (tried on 27 and 28).

-- 
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein’s brain than in the near certainty that people of equal talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
