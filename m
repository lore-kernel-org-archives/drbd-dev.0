Return-Path: <philipp.marek@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 90EF21028A43
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 10:24:04 +0200 (CEST)
Date: Fri, 8 May 2015 10:24:02 +0200
From: Philipp Marek <philipp.marek@linbit.com>
To: Justin Pryzby <pryzby@telsasoft.com>
Message-ID: <20150508082402.GF7534@cacao.linbit>
References: <20150421161439.GA23797@telsasoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150421161439.GA23797@telsasoft.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd guide 8.4: /outdate-peer/
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

Hi Justin,

> https://drbd.linbit.com/users-guide/ch-ocfs2.html
> 
> handlers {
>         outdate-peer "/sbin/kill-other-node.sh";
> 
> Should probably use the new name, "fence-peer".
thanks, being pushed to our documentation.

Are you reading all of the documentation, or really trying to run
a cluster filesystem?


Regards,

Phil
