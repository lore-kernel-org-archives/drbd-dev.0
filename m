Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3A1BB2CFAE50
	for <drbd-dev@lists.linbit.com>; Sat, 23 Sep 2006 13:43:43 +0200 (CEST)
Date: Sat, 23 Sep 2006 13:43:43 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 causes a panic in kernel proper.
Message-ID: <20060923114343.GC31468@barkeeper1.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C7D5@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C7D5@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-09-22 17:15:59 -0400
\ Montrose, Ernest:
> Hi all,
> As of the changes from Wednesday Sep 20, 2006, I see a panic in kernel
> proper with the drbd driver loaded and io attempted. 
> I am investigating but I am hoping that some lights might go on and a
> quick fix provided.   Thanks.  Below is the stack trace.

sorry, I did not notice this post...
just cleared your "moderated flag", though.

this got introduced by a broken "optimization" in r2433.
was fixed (I think) with r2451.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
