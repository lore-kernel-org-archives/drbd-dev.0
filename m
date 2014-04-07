Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 7 Apr 2014 16:31:32 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, xen-devel@lists.xenproject.org,
	drbd-user@lists.linbit.com
Message-ID: <20140407143132.GG2209@soda.linbit>
References: <1392911976-37506-1-git-send-email-roger.pau@citrix.com>
	<530E05DA.6070500@citrix.com> <20140226163036.GE3154@soda.linbit>
	<530E1E07.4090007@citrix.com> <533A66D5.1020103@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <533A66D5.1020103@citrix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [Xen-devel] [PATCH] block-drbd: type is "phy" for
 drbd backends
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Apr 01, 2014 at 09:12:21AM +0200, Roger Pau Monn=E9 wrote:
> Ping?

Has been committed to our internal repositories,
will find its way to the public git and
into the tarballs and packages "soon".

>=20
> On 26/02/14 18:01, Roger Pau Monn=E9 wrote:
> > On 26/02/14 17:30, Lars Ellenberg wrote:
> >> On Wed, Feb 26, 2014 at 04:18:50PM +0100, Roger Pau Monn=E9 wrote:
> >>>
> >>> I've realized I haven't Cc'ed the drbd developers lists, so adding =
it now.
> >>
> >> We do read the user's list just as well.
> >> Our -dev is actually mainly intended for "coordination".
> >>
> >>> On 20/02/14 16:59, Roger Pau Monne wrote:
> >>>> The type written to xenstore by libxl when attaching a drbd backen=
d is
> >>>> "phy", not "drbd", so handle this case also.
> >>
> >> If you say so; you should know ;-)
> >> Did this change at some point?
> >=20
> > I'm sure libxl (the new Xen toolstack) uses "phy" and not "drbd" as
> > type. Probably the old xend toolstack was setting type to "drbd", and
> > that's why the script checked for drbd.
> >=20
> > IMHO, setting the type to phy is the right thing to do, since drbd en=
ds
> > up presenting a block device which is handled by blkback.
> >=20
> >> I personally have not used this script in a long while...
> >>
> >> Do you ("citrix") have this in some
> >> regression/integration testing yourself?
> >=20
> > Not in Xen OSS Test suite [0], although I have no idea if other produ=
cts
> > based on Xen perform any kind of tests with drbd.
> >=20
> > [0] http://xenbits.xen.org/gitweb/?p=3Dosstest.git;a=3Dsummary

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
