Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6692C1056312
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 11:35:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 31 Mar 2016 11:35:01 +0200
Message-ID: <2184748.mO7jUMzmKV@fat-tyre>
In-Reply-To: <CAF6H8oHdbhM3x160NjnCLb=-GfKvNeXkh5M0-T_0Zs17fFVq1A@mail.gmail.com>
References: <CAF6H8oHdbhM3x160NjnCLb=-GfKvNeXkh5M0-T_0Zs17fFVq1A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Drbd-dev] [CASE-27] please check trivial code cleanup
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

Hi Jaeheon,

Yes, you are right. Thanks for pointing this out.

PS: Do you want to send such patches created with git format-patch
    in the future?
    They would carry the correct author information. 

Best regards,
 Phil

> Hi,
> 
> Please check your macro in drbd/drbd_int.h
> 
>     #define for_each_peer_device_ref(peer_device, m, resource) \
>          for (peer_device = __drbd_next_peer_device_ref(&m, NULL,
> resource); \
>               peer_device; \
>               peer_device = __drbd_next_peer_device_ref(&m, peer_device,
> resource))
> 
> We think the "resource" should be changed to "device".
> 
> Thanks.

