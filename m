Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8F35614306
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jul 2004 11:56:18 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Date: Fri, 30 Jul 2004 11:56:18 +0200
References: <20040728080645.GB7918@tmathiasen> <200407281956.10022.philipp.reisner@linbit.com> <20040729223253.GD3794@marowsky-bree.de>
In-Reply-To: <20040729223253.GD3794@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407301156.18099.philipp.reisner@linbit.com>
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

On Friday 30 July 2004 00:32, Lars Marowsky-Bree wrote:
> On 2004-07-28T19:56:09,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> > > This is _not_ a change we can push out. The major number _might_ be
> > > changed, but the device path absolutely has to stay stable.
> >
> > Maybe
> > for ((i=0;i<16;i++)); do mknod /dev/nb$i b 147 $i; done
>
> No. Because the user might have the RPM installed (thus the post-install
> would get triggered on update), but may in fact be using nbd.
>
> We'll have to make the drbd we ship default to the old major/minor and
> also keep the examples consistent with that.
>
> However, we can advise them use the different major in the future, but
> for a GA'ed product, we cannot break what is essentially the ABI to
> userspace.
>
>

So then, we will reenable the major_nr module parameter. 
Then SuSE only needs to patch the init script to pass the module parameter..

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
