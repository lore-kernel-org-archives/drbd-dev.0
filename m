Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D3DC01050584
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:54:57 +0200 (CEST)
Date: Wed, 20 May 2015 14:54:54 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Message-ID: <2051305130.123.1432126495128.JavaMail.open-xchange@ronja.mits.lan>
In-Reply-To: <20150520124010.GW1968@rck.sh>
References: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
	<20150520115527.GU1968@rck.sh>
	<1438073088.99.1432123743344.JavaMail.open-xchange@ronja.mits.lan>
	<20150520124010.GW1968@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] cluster initialization with drbdmanage
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
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

> In that case it is exactly as drbdmanage told you:
> 
> CAUTION! Note that:
> * Any previous drbdmanage cluster information may be removed
> * Any remaining resources managed by a previous drbdmanage installation
> that still exist on this system will no longer be managed by drbdmanage
> 
> The control volume gets overwritten, the old information is lost.

But what if I want to add additional nodes to a cluster later?

