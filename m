Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E23D42CF7728
	for <drbd-dev@lists.linbit.com>; Wed, 13 Sep 2006 16:10:11 +0200 (CEST)
Date: Wed, 13 Sep 2006 16:10:11 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20060913141011.GD1387@barkeeper1.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] it is (mostly) working again (for me)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

ok, fixed a few stupid things now.

at least it is "working" again, meaning
 it survived a few disconnect/reconnect cycles
 while resyncing _and_ writing data at the same time,
 without triggering any asserts or suspicous kernel messages.

I hit a "hang" once (probably a race related to the "inc_net" stuff)
when reconnecting (got stuck in the bitmap exchange).
recoverd with no problem when I disconnected the secondary again.
reconnected again, no problem this time.

so, I guess we are back on track again,
to go for the real bugs :)

(like all those unconditional dereferencing of mdev->bc)

cheers,

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
