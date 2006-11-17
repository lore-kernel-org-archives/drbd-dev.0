Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F1AAF2D9E384
	for <drbd-dev@lists.linbit.com>; Fri, 17 Nov 2006 15:12:32 +0100 (CET)
Date: Fri, 17 Nov 2006 15:12:32 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Fencing and outdate-peer handler getting called
	multiple times
Message-ID: <20061117141232.GG16440@barkeeper1.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C836@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C836@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-11-16 08:10:56 -0500
\ Montrose, Ernest:
> Phil,
> My outdate-peer handler simply says "echo /deve/drbd0: Running handler for outdate-peer >>/tmp/drbdio.log"
> And that log file is populated and created so I can only assume that did indicate success.
> In this case success being an exit status of 0.

and exactly that assumption is wrong.

in your kernel log you should find messages like
"outdate-peer helper broken, returned 0" 

>   If the disk state of the peer is unknown, drbd calls this 
>   handler (yes a call to userspace from kernel space). The handler's
>   returncodes are:
> 
>   3 -> peer is inconsistent 
>   4 -> peer is outdated (this handler outdated it) [ resource fencing ]
>   5 -> peer was down / unreachable
>   6 -> peer is primary
>   7 -> peer got stonithed [ node fencing ]

these are the only valid return codes.

"success" being defined as 
  "was able to outdate the peer" respective
  "peer need not to be outdated"

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
