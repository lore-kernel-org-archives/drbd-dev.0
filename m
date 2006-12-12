Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 141B72D9DE0B
	for <drbd-dev@lists.linbit.com>; Tue, 12 Dec 2006 20:11:17 +0100 (CET)
Date: Tue, 12 Dec 2006 20:11:18 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] modprobe error
Message-ID: <20061212191118.GG7967@soda.linbit>
References: <457EFB5D.2080500@dcs.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457EFB5D.2080500@dcs.gla.ac.uk>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-12 18:56:29 +0000
\ Cristian Zamfir:
> 
> I just tried drbd8.0pre6 with the 2.6.16.29 xen kernel.
> Compilation goes without errors: make clean all, make tools, make install ...
> However, I am getting this oops when doing "modprobe drbd":
> Can you please tell help me find out why is this happening?

use current drbd svn trunk.
make sure your xen kernel has its "CONFIG_CONNECTOR" enabled.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
