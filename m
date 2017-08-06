Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 76FA41057FF5
	for <drbd-dev@lists.linbit.com>; Mon,  7 Aug 2017 14:38:38 +0200 (CEST)
Received: by mail-wr0-f179.google.com with SMTP id f21so1252335wrf.5
	for <drbd-dev@lists.linbit.com>; Mon, 07 Aug 2017 05:38:38 -0700 (PDT)
Received: from localhost (213-47-144-126.static.upcbusiness.at.
	[213.47.144.126]) by smtp.gmail.com with ESMTPSA id
	l1sm10559391wmb.18.2017.08.07.05.38.37
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Aug 2017 05:38:37 -0700 (PDT)
From: SF Markus Elfring <roland.kammerer@linbit.com>
Resent-Message-ID: <20170807123836.GT15992@rck.sh>
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 71097105647D
	for <drbd-dev@lists.linbit.com>; Sun,  6 Aug 2017 12:23:33 +0200 (CEST)
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Message-ID: <25b445bb-22b4-fb77-83c2-d33009e7c9cd@users.sourceforge.net>
Date: Sun, 6 Aug 2017 12:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Drbd-dev] [PATCH 00/13] DRBD-receiver: Fine-tuning for six
 function implementations
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

> Date: Sat, 10 Sep 2016 22:13:22 +0200
> 
> Several update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (13):
>   Use kmalloc_array() in receive_uuids()
>   Delete an error message for a failed kmalloc_array() call
>   Move an assignment in receive_uuids()
>   Improve a size determination in drbd_do_features()
>   Delete an unnecessary initialisation in receive_sizes()
>   Improve a size determination in receive_sizes()
>   Delete an error message for a failed kzalloc() call in receive_sizes()
>   Move an assignment in receive_sizes()
>   Improve determination of sizes in receive_SyncParam()
>   Delete error messages for failed resource allocations in receive_SyncParam()
>   Improve a size determination in receive_protocol()
>   Delete error messages for failed resource allocations in receive_protocol()
>   Improve determination of sizes in receive_Barrier()
> 
>  drivers/block/drbd/drbd_receiver.c | 45 ++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)

Would you like to take another look at change possibilities
for this software module?

Regards,
Markus
