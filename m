Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A3622D9DE11
	for <drbd-dev@lists.linbit.com>; Mon,  4 Dec 2006 11:28:28 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: rr-conflict violently breaks sync states.
Date: Mon, 4 Dec 2006 11:28:30 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C854@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C854@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612041128.30285.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 1. Dezember 2006 23:10 schrieb Montrose, Ernest:
> If "rr-conflict vilently;" is present in /etc/drbd.conf then the drbd
> volumes will not sync completely. Some of them ends up in :
> cs: Connected:St: secondary/Secondary:ds: Inconsistent/Inconsistent
>
> These states are on both nodes.
>
> It seems like this rr-conflict violently is not fully implemented.


Hi Ernest,

Actually it is. Could you grep in the kernel-logfile for all messages of
the devices that ended up in that state. Preferrable from both nodes.

Thanks!

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
