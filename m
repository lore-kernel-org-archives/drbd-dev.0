Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 26 Feb 2014 17:30:36 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, xen-devel@lists.xenproject.org,
	drbd-user@lists.linbit.com
Message-ID: <20140226163036.GE3154@soda.linbit>
References: <1392911976-37506-1-git-send-email-roger.pau@citrix.com>
	<530E05DA.6070500@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <530E05DA.6070500@citrix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH] block-drbd: type is "phy" for drbd backends
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

On Wed, Feb 26, 2014 at 04:18:50PM +0100, Roger Pau Monn=E9 wrote:
>=20
> I've realized I haven't Cc'ed the drbd developers lists, so adding it n=
ow.

We do read the user's list just as well.
Our -dev is actually mainly intended for "coordination".

> On 20/02/14 16:59, Roger Pau Monne wrote:
> > The type written to xenstore by libxl when attaching a drbd backend i=
s
> > "phy", not "drbd", so handle this case also.

If you say so; you should know ;-)
Did this change at some point?
I personally have not used this script in a long while...

Do you ("citrix") have this in some
regression/integration testing yourself?

> > Signed-off-by: Roger Pau Monn=E9 <roger.pau@citrix.com>
> > ---
> >  scripts/block-drbd |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/block-drbd b/scripts/block-drbd
> > index 5563ccb..975802b 100755
> > --- a/scripts/block-drbd
> > +++ b/scripts/block-drbd
> > @@ -250,7 +250,7 @@ case "$command" in
> >      fi
> > =20
> >      case $t in=20
> > -      drbd)
> > +      drbd|phy)
> >          drbd_resource=3D$p
> >          drbd_role=3D"$(drbdadm role $drbd_resource)"
> >          drbd_lrole=3D"${drbd_role%%/*}"
> > @@ -278,7 +278,7 @@ case "$command" in
> > =20
> >    remove)
> >      case $t in=20
> > -      drbd)
> > +      drbd|phy)
> >          p=3D$(xenstore_read "$XENBUS_PATH/params")
> >          drbd_resource=3D$p
> >          drbd_role=3D"$(drbdadm role $drbd_resource)"

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
