Return-Path: <lmb@suse.de>
Date: Fri, 30 Jul 2004 00:32:53 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <20040729223253.GD3794@marowsky-bree.de>
References: <20040728080645.GB7918@tmathiasen> <200407281655.18277.philipp.reisner@linbit.com> <20040728153314.GW26564@marowsky-bree.de> <200407281956.10022.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407281956.10022.philipp.reisner@linbit.com>
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

On 2004-07-28T19:56:09,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> > This is _not_ a change we can push out. The major number _might_ be
> > changed, but the device path absolutely has to stay stable.
> 
> Maybe 
> for ((i=0;i<16;i++)); do mknod /dev/nb$i b 147 $i; done

No. Because the user might have the RPM installed (thus the post-install
would get triggered on update), but may in fact be using nbd.

We'll have to make the drbd we ship default to the old major/minor and
also keep the examples consistent with that.

However, we can advise them use the different major in the future, but
for a GA'ed product, we cannot break what is essentially the ABI to
userspace.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

