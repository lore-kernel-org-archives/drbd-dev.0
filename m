Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 63093105631C
	for <drbd-dev@lists.linbit.com>; Thu,  9 Mar 2017 11:30:13 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id v186so135742824wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 09 Mar 2017 02:30:13 -0800 (PST)
Received: from localhost (213-47-144-126.static.upcbusiness.at.
	[213.47.144.126]) by smtp.gmail.com with ESMTPSA id
	k76sm7647724wrc.12.2017.03.09.02.22.31
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 Mar 2017 02:22:31 -0800 (PST)
Date: Thu, 9 Mar 2017 11:22:30 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170309102230.GA18615@rck.sh>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
Subject: Re: [Drbd-dev] [Patch v0 0/8] Patches for compat drbd9 to kernel
 v4.10
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

On Tue, Mar 07, 2017 at 11:27:51AM +0800, Nick Wang wrote:
> Patches for drbd9 compatible to kernel4.10, including drbd,
> drbd-kernel-compat and drbd-headers repos. Ordered as 
> functionality, so may mix the three repos in one patch set.

Hi Nick,

thanks again for the time spent, it's highly appreciated.

There are some things that need to change before I can apply the series.
I will answer to some patch mails (2 and 5) that exemplify how we do
compat work.

It would then be great if you resend your series. If not, just let
me know, then I will do the compat work.

Regards, rck
