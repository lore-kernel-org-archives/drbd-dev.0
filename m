Return-Path: <syrius.ml@no-log.org>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C9DD92E20AC9
	for <drbd-dev@lists.linbit.com>; Tue,  5 Aug 2008 19:15:23 +0200 (CEST)
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] too small timeout in drbdsetup
References: <87hcastmig.87fxqctmig@87ej5wtmig.message.id>
	<87y73cochw.87wsiwochw@87vdygochw.message.id>
	<200808051335.15444.philipp.reisner@linbit.com>
From: syrius.ml@no-log.org
Message-ID: <873aljpey0.871w13pey0@87zlnro0dk.message.id>
Date: Tue, 05 Aug 2008 19:15:20 +0200
In-Reply-To: <200808051335.15444.philipp.reisner@linbit.com> (Philipp
	Reisner's message of "Tue\, 5 Aug 2008 13\:35\:15 +0200")
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

> We do not experience any issue with the 500ms in our setups, as are reports
> about such an issue rather rare. Could you give a more details description
> about the conditions you trigger can trigger this ?

I have several drbd devices (4 atm).
Most of the time it is triggered by heartbeat RA scripts when the
device are setup one after the other.
could also happen if i do "echo r1 r2 r3 r4 | xargs -n 1 drbdadm
primary" for example.

> I guess we will add an option to drbdsetup then, and have it is setting
> in the globals section of drbd.conf. 

sounds good.

> I do not want to inrecase it for all users, since is seems to affect only
> a very small part of our user base.

ok.

-- 
