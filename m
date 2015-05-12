Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 48808100EBF0
	for <drbd-dev@lists.linbit.com>; Tue, 12 May 2015 06:36:18 +0200 (CEST)
Date: Tue, 12 May 2015 06:36:16 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Message-ID: <882854472.8.1431405376885.JavaMail.open-xchange@ronja.mits.lan>
In-Reply-To: <20150511100735.GY1968@rck.sh>
References: <1945028087.159.1431334443252.JavaMail.open-xchange@ronja.mits.lan>
	<20150511092206.GX1968@rck.sh> <20150511100735.GY1968@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] drbdmanage lintian warnings
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

> See attached patch. It fixes the bulk of the lintian warnings. There are
> still some other unrelated manpage errors left that would need a closer
> look (e.g. command string too long).

Many thanks, that fixes almost all warnings. 

