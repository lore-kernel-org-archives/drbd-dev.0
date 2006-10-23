Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BFDC2D9E069
	for <drbd-dev@lists.linbit.com>; Mon, 23 Oct 2006 10:22:41 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: drbd.conf after-sb-2pri panic ??
Date: Mon, 23 Oct 2006 10:22:37 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C80E@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C80E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231022.37814.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 19. Oktober 2006 21:49 schrieb Montrose, Ernest:
> Hi all,
> In /etc/drbd.conf I am setting the NET parameter after-sb-2-pri to
> "panic".  But this is not implemented by drbdsetup(1).
> Drbdsetup returns "Handler not known".  Is this superceded by
> "call-pri-lost-after-sb"?
>

Yes, right. In the example config I have set that handler to 
halt the machine:

pri-lost-after-sb "echo O > /proc/sysrq-trigger ; halt -f";


-Phil
