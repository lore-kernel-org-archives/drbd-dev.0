Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A68FA2CFF8BB
	for <drbd-dev@lists.linbit.com>; Mon,  8 Jan 2007 14:58:18 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Node state stuck in :WFBitMapT on both node.
Date: Mon, 8 Jan 2007 14:58:18 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C8B3@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C8B3@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701081458.18513.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 5. Januar 2007 21:33 schrieb Montrose, Ernest:
> Under a xen migration test with moderate I/O we easily get into this
> state where both nodes enters: WFBitMapT.
> We can recover from this by rebooting one node.  This is broken by som
> recent changes.  I can say that it worked
> Before  these changes:

Hi Ernest,

I very carefully reproduced your test here in my UML setup,
and fixed one remaining bug.

http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001423.html

Last week I did some changes in that area (mdev->p_uuid is now
longer available). I guess that all the problems are now solved 
in this area of the code.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
