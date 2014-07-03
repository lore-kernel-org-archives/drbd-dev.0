Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 65625101AC71
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:44:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5ADC8390B9B
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:44:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id TU_zhhWdxi1U for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 15:44:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3F8AC390D5F
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:44:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gM_2RE6XzduQ for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 15:44:17 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 26C34390B9B
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:44:17 +0200 (CEST)
Date: Thu, 3 Jul 2014 15:44:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140703134417.GI11700@soda.linbit>
References: <201407031507.18336.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <201407031507.18336.mmazur@kernel.pl>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] stonith-related regression introduced around kernel
 3.13, with 3.15.3 still affected
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

On Thu, Jul 03, 2014 at 03:07:18PM +0200, Mariusz Mazur wrote:
> My setup is two nodes with drbd double master, corosync, pacemaker, clv=
md, xen=20
> 4.4.0.
>=20
> Here's what happens when I reboot -f one of the nodes and the surviving=
 node=20
> is kernel 3.12.23 or earlier (oldest tested was 3.6.something):

Yep, someone changed the in kernel kthread api
to use wait_for_completion_killable()
where it used to be wait_for_completion().

Which has some bad interactions with how DRBD handles things.
This is being fixed.

	Lars

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
