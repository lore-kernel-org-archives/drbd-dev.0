Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B7C5D142F3
	for <drbd-dev@lists.linbit.com>; Tue,  7 Sep 2004 14:54:32 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Date: Tue, 7 Sep 2004 14:54:31 +0200
References: <20040906135609.GT11820@marowsky-bree.de>
	<200409071143.01189.philipp.reisner@linbit.com>
	<20040907104926.GA7387@nudl>
In-Reply-To: <20040907104926.GA7387@nudl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409071454.31957.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 07 September 2004 12:49, Lars Ellenberg wrote:
> On Tue, Sep 07, 2004 at 11:43:01AM +0200, Philipp Reisner wrote:
> > > the point was to have an easy way to _read_ all available information
> > > in a well defined way in one chunk. and having it in k=v form makes it
> > > direktly useable by bash, and easily useable by perl:
> >
> > Is it worth the trouble to maintain two interfaces in drbdadm ?
> >
> > Is it less rouble to maintain the
> >
> > CSTATE=$(drbdadm cstate r0)
> > LOCAL_STATE=$( $DRBDADM state $RES 2> /dev/null )
> > LOCAL_STATE=${LOCAL_STATE%/*}
> > LOCAL_STORAGE= $(drbdadm sh-ll-dev r0)
> > ...
> >
> > lines in the bash script you do ?
>
> the drbdsetup code needs a cleanup anyways, we really need to
> restructure what part ends up in some "public" header file, and what
> part really still belongs to drbd_int.h ...
>
> it is more clean to have one ioctl, get the full info, and output that.

Hmmm, the thing is, it is one ioctl. It is the DRBD_IOCTL_GET_CONFIG
ioctl. Only drbdsetup shows not show all the information in one call...

> I feel uneasy about introducing additional races by using several ioctls
> in a row (even if they all finish within one second). of course, once we
> have that info it could be stale already, but at least we have the
> guarantee that at some point in time it was correct.

This is of course an argument.

> btw, one more reason to have some kind of "suspend", ask about
> information, go figure, do some things, and only then "resume" to allow
> changes to take effect... (due in 0.8)
>
> as soon as we have a sane interface, I don't expect the internals to
> change so often, so the "maintenance trouble" is very low, either way.
>

I just not want to have two interfaces to get to the same stuff.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
