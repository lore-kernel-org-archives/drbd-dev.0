Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6F1122E03786
	for <drbd-dev@lists.linbit.com>; Fri,  1 Jun 2007 16:17:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 Patch: dont bail at startup if errors occur
Date: Fri, 1 Jun 2007 16:17:14 +0200
References: <92ae63eb0706010525h8a5389bie68847f0e9f46413@mail.gmail.com>
In-Reply-To: <92ae63eb0706010525h8a5389bie68847f0e9f46413@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706011617.14368.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Friday 01 June 2007 14:25:06 Simon Graham wrote:
> The checked in version of the drbd init script will bail if any errors are
> encountered - this means, for example, that if you experience a disk
> failure (or removal), then reboot the system, NO DRBD devices will come up
> because the startup will bail as soon as it encounters the problem with the
> failed disk - what should happen is the bringup should continue and the
> DRBD devices using the failed disk should end up Diskless - this is pretty
> important in an HA environment.
>
> The attached patch changes the startup script to continue when an error is
> found.
>
> Simon


Ack, and applied.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
