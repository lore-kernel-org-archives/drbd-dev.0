Return-Path: <brederlo@informatik.uni-tuebingen.de>
Received: from mx1.informatik.uni-tuebingen.de
	(mx1.informatik.uni-tuebingen.de [134.2.12.5])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1F2C52E05E88
	for <drbd-dev@lists.linbit.com>; Mon, 12 Mar 2007 15:02:50 +0100 (CET)
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
To: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
Subject: Re: [Drbd-dev] DRBD8: Split-brain if primary and syncTarget
References: <BD7042533C2F8943A6A4257A9E31C45439C91C@EXNA.corp.stratus.com>
Date: Mon, 12 Mar 2007 15:02:08 +0100
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C91C@EXNA.corp.stratus.com>
	(Ernest Montrose's message of "Thu, 8 Mar 2007 17:21:41 -0500")
Message-ID: <87tzwqo90f.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

"Montrose, Ernest" <Ernest.Montrose@stratus.com> writes:

> :o="urn:schemas-microsoft-com:office:office"
> xmlns:w="urn:schemas-microsoft-com:office:word"
> xmlns="http://www.w3.org/TR/REC-html40">
>
> Hi all,:p>
>
> :p> 
>
> We are seeing an issue with split brain if one node is syncing as syncTarget
> while being Primary.:p>
>
> two node A and B.
> * make B primary and the syncTarget
> * Start a sync.
> * ifdown eth1 to break communication
> * ifup eth1.
> * then on the node in standalone "drbdadm connect":p>
>
> We get a split-brain.:p>
>
> :p> 
>
> I think the  problem is that if we are primary and we lose contact from the
> other side
> we generate a new current UUID which causes a Split-Brain next time we
> connect.
> This only happens if we are the sync target and we are primary. Perhaps we
> should not generate a UUID if we were syncing when the disconnect happen.
> Below is a possible patch for this in after_state_ch()::p>

I think the new UUID should be generated the first time there is a
write but not before.

MfG
        Goswin
