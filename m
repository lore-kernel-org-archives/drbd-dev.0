Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust198.tnt1.ber2.deu.da.uu.net [149.225.52.198])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 054AF142FB
	for <drbd-dev@lists.linbit.com>; Wed,  4 Aug 2004 14:47:25 +0200 (CEST)
Date: Wed, 4 Aug 2004 14:36:14 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-latest introduces new build dependency on subversion
Message-ID: <XAeNNKkfuKjjJkgs/KaQR70=lge@web.de>
References: <20040804112739.GA4411@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804112739.GA4411@marowsky-bree.de>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

/ 2004-08-04 13:27:39 +0200
\ Lars Marowsky-Bree:
> Is that really necessary just for calling svnversion?

not exactly. if you get the tgz,
svnversion should never be called,
I checked that.
(well, as long as you don't rm drbd_buildtag.c)

if you don't get the tgz, you obviously have svn.

ok?

	lge
