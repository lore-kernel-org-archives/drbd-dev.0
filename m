Return-Path: <philipp.marek@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5061F10556A0
	for <drbd-dev@lists.linbit.com>; Mon, 27 Apr 2015 08:22:41 +0200 (CEST)
Date: Mon, 27 Apr 2015 08:22:39 +0200
From: Philipp Marek <philipp.marek@linbit.com>
To: Justin Pryzby <pryzby@telsasoft.com>
Message-ID: <20150427062238.GC7282@cacao.linbit>
References: <20150425134957.GA11224@telsasoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150425134957.GA11224@telsasoft.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] ocfs2 doc missing score
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

> Missing "INF:"
> 
> http://drbd.linbit.com/users-guide-8.4/s-ocfs2-pacemaker.html
> order o_ocfs2 ms_drbd_ocfs2:promote cl_ocfs2mgmt:start cl_fs_ocfs2:start
> colocation c_ocfs2 cl_fs_ocfs2 cl_ocfs2mgmt ms_drbd_ocfs2:Master
Thanks, I'll fix that.

Please note that (because of spam) our lists are moderated, so it might 
take quite a bit of time until first-time posts get through.


Regards,

Phil
