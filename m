Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [81.16.158.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 592D42DF6259
	for <drbd-dev@lists.linbit.com>; Thu, 25 Oct 2007 12:16:22 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: unconfigured devices and scheduling
	after_state_ch problem
Date: Thu, 25 Oct 2007 12:16:21 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F47A11@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A11@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710251216.21633.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 16 October 2007 23:55:49 Montrose, Ernest wrote:
> Hi all,
> We have been seeing a problem where "unconfigured" devices e.g devices
> that are Standalone and Diskless with sequential sync order schedule
> after_state_ch().  The problem is that there isn't a worker thread in
> this case.  So we observed two side effects. One all these queued work
> make shutting down the node take a long time as unloading the driver
> takes time to clean up. Two we can potentially have a memory exhaustion
> issue.
>
> Included here is a patch to help fix the problem.
>

Right, I applied this...

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
