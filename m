Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 748DC2E0B3C0
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jan 2008 10:04:18 +0100 (CET)
Date: Mon, 14 Jan 2008 10:04:18 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD-8.0 PATCH] Revert some changes that cause resync
	to stall
Message-ID: <20080114090418.GG5715@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107C5AF60@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AF60@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jan 11, 2008 at 10:23:37AM -0500, Graham, Simon wrote:
> The attached patches revert a couple of changes made in DRBD-8.0 that can cause
> resync to stall if it is pasued/resumed quickly (as can happen if you have a
> lot of devices all releated with sync-after settings).

I don't think these should be reverted,
I believe these changes are "correct".
If they cause resync to be stalled, then there is an other problem
which should be tracked down and fixed.


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
