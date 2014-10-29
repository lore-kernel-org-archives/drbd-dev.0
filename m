Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 633BA101AC7E
	for <drbd-dev@lists.linbit.com>; Wed, 29 Oct 2014 17:25:24 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jan Kara <jack@suse.cz>
Date: Wed, 29 Oct 2014 17:25:23 +0100
Message-ID: <3062677.eVKfvK0gZD@fat-tyre>
In-Reply-To: <20141021141226.GA9223@quack.suse.cz>
References: <20141021141226.GA9223@quack.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Bug in drbd_adm_attach()
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

Am Dienstag, 21. Oktober 2014, 16:12:26 schrieb Jan Kara:
>   Hello,
> 
>   Coverity has spotted a problem in drbd_adm_attach() which does:
> 
>         connection = peer_device ? peer_device->connection : NULL;
>         conn_reconfig_start(connection);
> 
> and conn_reconfig_start() just blindly dereferences 'connection'. So either
> peer_device cannot be NULL (and then the test is superfluous) or there's a
> bug...
> 
> 								Honza


Thanks for pointing out.
http://git.drbd.org/gitweb.cgi?p=drbd-8.4.git;a=commitdiff;h=8d7d18b40dbe006a3ca25d560e42617a04c68e1f;hp=1564eb39534debeead593f597c5c951c588ecf8b

Best,
 Phil
