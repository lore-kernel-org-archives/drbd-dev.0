Return-Path: <lars@linbit.com>
Date: Tue, 7 Sep 2004 12:49:26 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Message-ID: <20040907104926.GA7387@nudl>
References: <20040906135609.GT11820@marowsky-bree.de>
	<200409070957.57371.philipp.reisner@linbit.com>
	<20040907091507.GA3257@nudl>
	<200409071143.01189.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409071143.01189.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 07, 2004 at 11:43:01AM +0200, Philipp Reisner wrote:
> >
> > the point was to have an easy way to _read_ all available information in
> > a well defined way in one chunk. and having it in k=v form makes it
> > direktly useable by bash, and easily useable by perl:
> >
> 
> Is it worth the trouble to maintain two interfaces in drbdadm ?
> 
> Is it less rouble to maintain the 
> 
> CSTATE=$(drbdadm cstate r0)
> LOCAL_STATE=$( $DRBDADM state $RES 2> /dev/null )
> LOCAL_STATE=${LOCAL_STATE%/*}
> LOCAL_STORAGE= $(drbdadm sh-ll-dev r0)
> ...
> 
> lines in the bash script you do ?

the drbdsetup code needs a cleanup anyways, we really need to
restructure what part ends up in some "public" header file, and what
part really still belongs to drbd_int.h ...

it is more clean to have one ioctl, get the full info, and output that.
I feel uneasy about introducing additional races by using several ioctls
in a row (even if they all finish within one second). of course, once we
have that info it could be stale already, but at least we have the
guarantee that at some point in time it was correct.
btw, one more reason to have some kind of "suspend", ask about
information, go figure, do some things, and only then "resume" to allow
changes to take effect... (due in 0.8)

as soon as we have a sane interface, I don't expect the internals to
change so often, so the "maintenance trouble" is very low, either way.

	lge
