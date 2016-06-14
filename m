Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D88E11056447
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:11:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CC0194220C6
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:11:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1APHv49HDAIq for <drbd-dev@lists.linbit.com>;
	Tue, 14 Jun 2016 13:11:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AE74B4220D6
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:11:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6A7MUIkV9xGl for <drbd-dev@lists.linbit.com>;
	Tue, 14 Jun 2016 13:11:45 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 883714220C6
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 13:11:45 +0200 (CEST)
Date: Tue, 14 Jun 2016 13:11:44 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160614111144.GF1338@rck.sh>
References: <28ca5937-746a-731a-9b7b-84d7b12cbba3@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ca5937-746a-731a-9b7b-84d7b12cbba3@sandisk.com>
Subject: Re: [Drbd-dev] [PATCH for drbd-utils] drbd.spec.in: Make DRBD
 activation during startup optional
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

On Mon, Jun 13, 2016 at 07:29:22PM +0200, Bart Van Assche wrote:
> If DRBD resources are controlled by Pacemaker the startup script
> must *not* be run during boot. Hence make it possible to leave
> out activation of DRBD during boot.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> ---
>  configure.ac        |  4 ++--
>  drbd.spec.in        | 11 ++++++++---
>  scripts/Makefile.in |  8 ++++----
>  3 files changed, 14 insertions(+), 9 deletions(-)

Thank you, applied with minor modifications.

Regards, rck
