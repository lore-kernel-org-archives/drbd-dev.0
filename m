Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B9BE0160996
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2025 12:08:44 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
	ffacd0b85a97d-3a4db4d1bd7so466902f8f.3
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2025 03:08:44 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
	by smtp.gmail.com with ESMTPSA id
	41be03b00d2f7-b2d99e1e78asm837158a12.30.2025.05.28.03.08.42
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Wed, 28 May 2025 03:08:42 -0700 (PDT)
Message-ID: <b4759d0b-3d65-4a87-99e3-a12882749218@suse.com>
Date: Wed, 28 May 2025 18:08:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] build: changing SUSE release file
To: drbd-dev@lists.linbit.com
References: <20250515024817.25717-1-heming.zhao@suse.com>
	<20250515024817.25717-2-heming.zhao@suse.com> <aDbDWc6dB05icJgO@arm64>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <aDbDWc6dB05icJgO@arm64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 5/28/25 16:03, Roland Kammerer wrote:
> On Thu, May 15, 2025 at 10:48:14AM +0800, Heming Zhao wrote:
>> This commit changes /etc/SuSe-release to /etc/os-release.
>> The SuSe-release file disappeared a long time ago.
>>
>> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
>> ---
>>   configure.ac | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 282fdf1584e3..883fe3e5cdb3 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -402,7 +402,7 @@ else
>>      if test -z $DISTRO; then
>>         AC_CHECK_FILE(/etc/redhat-release, [DISTRO="redhat"])
>>         AC_CHECK_FILE(/etc/debian_version, [DISTRO="debian"])
>> -      AC_CHECK_FILE(/etc/SuSE-release, [DISTRO="suse"])
>> +      AC_CHECK_FILE(/etc/os-release, [DISTRO="suse"])
> 
> Hi,
> 
> everything that has a /etc/os-release (which by now is basically every
> distribution on this planet) is suse? No.
> 
> This (not only this) part of the automagic in drbd-utils is a mess and
> I'm currently in the process of cleaning that up a bit. I will not take
> this patch as is, IMO it is just wrong, please just wait, this should
> improve in a week or two.
> 
> Regards, rck

Thanks for the explanation.
Indeed, I didn't check other distribution styles. Let's wait for your
fix for this build issue.

- Heming
