Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8617A2E07860
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jun 2007 16:18:09 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd0: [drbd0_receiver/5740] sock_sendmsg time expired,
	ko = 4294967294
Date: Tue, 12 Jun 2007 16:14:42 +0200
References: <BD7042533C2F8943A6A4257A9E31C4543D15A9@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C4543D15A9@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706121614.42579.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 11 June 2007 03:39:47 Montrose, Ernest wrote:
> Hi all,
> It seems that the mdev->ko_count counter is going negative as evidenced by
> the following message: drbd0: [drbd0_receiver/5740] sock_sendmsg time
> expired, ko = 4294967294
>

This is intended this way. If you configure ko_count to zero it becomes
that very large integer with the first expiration of the timeout. I.e.
no drop of connection.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
