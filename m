Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (c-134-76-199.b.dial.de.ignite.net [62.134.76.199])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 361F0142FF
	for <drbd-dev@lists.linbit.com>; Wed, 29 Sep 2004 17:55:16 +0200 (CEST)
Date: Wed, 29 Sep 2004 17:55:34 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.5 release tomorrow...
Message-ID: <y4BX8+JjBHbS2KXtt1iG1jA=lge@web.de>
References: <200409291054.13765.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409291054.13765.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-29 10:54:13 +0200
\ Philipp Reisner:
> Hi,
> 
> I will create the 0.7.5 tarball tomorrow (as long as nobody objects)

hm. how about first
 svn remove benchmark doc/{HOWTO,ja,pt_BR}
?

none of them applies anymore.  adding a note to NFS-Server-README.txt as
done in trunk already won't hurt either.


	lge
