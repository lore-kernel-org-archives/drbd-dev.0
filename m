Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B72F16091D
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2025 09:58:53 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
	ffacd0b85a97d-3a4ef892ab2so51095f8f.3
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2025 00:58:53 -0700 (PDT)
Message-ID: <da45db79-5b36-486f-9af4-df8a2971e39b@suse.com>
Date: Thu, 29 May 2025 15:57:25 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] remove lock file after using it
From: Heming Zhao <heming.zhao@suse.com>
To: drbd-dev@lists.linbit.com, roland.kammerer@linbit.com
References: <20250515024817.25717-1-heming.zhao@suse.com>
	<20250515024817.25717-3-heming.zhao@suse.com> <aDbFRcFQpEbhG9E1@arm64>
	<6f471202-c821-4d73-ac3c-96b07f605cf1@suse.com>
Content-Language: en-US
In-Reply-To: <6f471202-c821-4d73-ac3c-96b07f605cf1@suse.com>
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

On 5/29/25 14:59, Heming Zhao wrote:
> Hello,
> 
> On 5/28/25 16:11, Roland Kammerer wrote:
>> On Thu, May 15, 2025 at 10:48:15AM +0800, Heming Zhao wrote:
>>> In a SELinux env, if a user runs as root to set up a DRBD device,
>>> it will leave a lock file in "/var/run/drbd/lock/". Then HA pacemaker
>>> will fail to set up DRBD because of a permission issue.
>>
>> ... ...
> 
> 
> ---- following are the reproducible steps -----
> 
> ## setup vm
> 
> create two VMs:
> - 4 VCPU, 4G mem, one 100M *shared* disk for sbd, one 1G disk for drbd.
> - the sbd is using scsi bus type, drbd disk is using virtio bus type
> 
> 

I forgot to mention that to reproduce this issue, please make sure SELinux
is enabled (default configuration) and the port 7799 is open (or disable firewalld).

- Heming
