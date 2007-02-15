Return-Path: <brederlo@informatik.uni-tuebingen.de>
Received: from mx1.informatik.uni-tuebingen.de
	(mx1.Informatik.Uni-Tuebingen.De [134.2.12.5])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D176E2E05EA2
	for <drbd-dev@lists.linbit.com>; Thu, 15 Feb 2007 17:02:15 +0100 (CET)
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] drbd 8.0.0 over IP over infiniband crashes
References: <874ppnhgq3.fsf@informatik.uni-tuebingen.de>
	<200702151631.08429.philipp.reisner@linbit.com>
Date: Thu, 15 Feb 2007 17:02:09 +0100
In-Reply-To: <200702151631.08429.philipp.reisner@linbit.com> (Philipp
	Reisner's message of "Thu, 15 Feb 2007 16:31:08 +0100")
Message-ID: <87d54bflz2.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Philipp Reisner <philipp.reisner@linbit.com> writes:

>> The drbd comes up and starts to sync the 6 devices and then after a
>> short while I get a kernel oops.
>
> It would be really helpfull if you would include the OOPS in
> such a post...
>
> -Phil

Sorry for that. I didn't capture it at that time and then the system
was running a stress test on the disk locally to see if the disk
driver is flaky. So I couldn't quite crash the system.

I restarted the resync now with both nodes logging the serial console
output. I should have a crash dump in the morning.

As a side note it seems to work fine with drbd over ethernet
(1GBit). I managed to sync the two nodes completly without crash. So
it looks like something infiniband related.

MfG
        Goswin
