Return-Path: <milind.dumbare@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 35E752D99836
	for <drbd-dev@lists.linbit.com>; Tue, 25 Jul 2006 11:08:53 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id i75so408116pye
	for <drbd-dev@lists.linbit.com>; Tue, 25 Jul 2006 02:08:47 -0700 (PDT)
Message-ID: <44C5E049.1030606@gmail.com>
Date: Tue, 25 Jul 2006 14:41:37 +0530
From: Milind Dumbare <milind.dumbare@gmail.com>
MIME-Version: 1.0
To: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [Drbd-dev] Bug?
References: <44C4E271.3080607@gmail.com> <20060725015703.GG4596@soda.linbit>
In-Reply-To: <20060725015703.GG4596@soda.linbit>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:

>/ 2006-07-24 20:38:33 +0530
>\ Milind Dumbare:
>  
>
>>Hi,
>>First of all to tell I am working on x86_64 machine.
>>
>>The structure ioctl_get_config has size 576(bytes) and its padded with
>>int (4byte) so it makes 580 (bytes). And compiler will align it to 584
>>(bytes), as 580 is not completely divisible by 8 while 584 is.
>>
>>So don't you think drbd_sizeof_sanity_check.c:21 should be
>>
>>       SZO(struct ioctl_get_config,    576)
>>rather than
>>       SZO(struct ioctl_get_config,    580)
>>    
>>
>
>when filing bugs, please state against which version you complain.
>(in this case, I guess 8-pre something tarball).
>when it is not the latest version, check whether it has already been
>fixed, as I think for this issue recent versions (svn) are fixed, and
>we now have compile time asserts instead of runtime asserts in place.
>
>yes, we probably should upload some new 8pre-something tarballs.
>
>thanks,
>
>  
>
Where can we access SVN from? Do everybody has access to it? What do I 
have to do if I want to have access if its resticted?
-Milind
