Return-Path: <lists@alteeve.ca>
Received: from mail.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BCBD8101AC67
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 17:17:11 +0200 (CEST)
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
References: <225e8fd1-fc2e-287a-63cb-00ce31fa79b5@alteeve.ca>
	<20180724080806.nbfo3akwtxdx5qsi@rck.sh>
From: Digimer <lists@alteeve.ca>
Message-ID: <fa2eeac3-6d32-c78e-d6d1-96f33cbcd903@alteeve.ca>
Date: Tue, 24 Jul 2018 11:17:09 -0400
MIME-Version: 1.0
In-Reply-To: <20180724080806.nbfo3akwtxdx5qsi@rck.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] BuildRequires for drbd-utils
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

On 2018-07-24 04:08 AM, Roland Kammerer wrote:
> On Mon, Jul 23, 2018 at 07:19:38PM -0400, Digimer wrote:
>> Hi all,
>>
>>   I'm working on RPMs for Fedora, and noticed two missing build
>> dependencies in drbd-utils-9.5.0;
>>
>> BuildRequires: automake
>> BuildRequires: libxslt
> 
> Hi Digimer,
> 
> I will look into it (and if RHEL/SLES name them differently and what
> not).
> 
> Same for the kernel part you mentioned in the other thread. Others might
> be faster, currently can't promise anything, a bit too busy at the
> moment.
> 
> In general I think that is more appropriate for drbd-user, drbd-dev is
> basically "kernel patch coordination only", drbd-user is "everything
> else".
> 
> Thanks, rck

Thanks for the reply.

  I've got drbd-utils building fine now
(https://www.alteeve.com/an-repo/f28/SRPMS/drbd-9.5.0-2.fc28.src.rpm).
My issue is being unable to build drbd-kernel.

  Let me reply to that thread to keep it more on topic for the archives. :)

-- 
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein’s brain than in the near certainty that people of equal talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
