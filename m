Return-Path: <Peter.Petrakis@stratus.com>
Received: from mailhub5.stratus.com (mailhub5.stratus.com [134.111.1.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E2E041069125
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jan 2010 15:51:36 +0100 (CET)
Received: from EXHQ.corp.stratus.com (exhq.corp.stratus.com [134.111.201.100])
	by mailhub5.stratus.com (8.12.11/8.12.11) with ESMTP id
	o06EpDxV024903
	for <drbd-dev@lists.linbit.com>; Wed, 6 Jan 2010 09:51:13 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 6 Jan 2010 09:51:23 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C969FBF3@EXHQ.corp.stratus.com>
In-Reply-To: 20100106113556.GZ23877@barkeeper1-xen.linbit
From: "Petrakis, Peter" <Peter.Petrakis@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] syncsource -> sync completed ack lost
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

> 8.2 is obsolete.
> it has been superseeded by 8.3

I know we're behind, such is the life of a vendor branch :)
=20
> if you can reproduce with 8.3,
> we will certainly look into this.

I can re-run the tests but in general we have a difficult time
reproducing these bugs. Do you know of a way I could "stage" the
state transitions so to make it more reproducable?
=20
> but I think we fix a few things that would match your symptoms in 8.3.
>=20
> we are currently (well, tomorrow) at 8.3.7 rc2

That's promising.
=20
> > Jan  5 14:36:18 node1 kernel: drbd5: helper command:
> > /usr/lib/spine/bin/avance_drbd_helper after-resync-target minor-5
>=20
> I'd be interessted in this /usr/lib/spine/bin/avance_drbd_helper.
> what does it do, compared with drbdadm?

Sure, we wrote our own drbd management daemon which is part of our
cluster manager. The DRBD resources are constructed as a consequence=20
of VM provisioning, using drbdsetup. So we already have a config to=20
reference, however to make use of the fencing handler we would also
have maintain the drbd.conf file, which after much consideration it was
determined as being too fragile for our environment: Should one part of
the config file become inconsistent then all resources are affected.

avance_drbd_helper will dispatch only the events we care to handle to
our other custom handlers which will communicate to our management
daemon
directly using XML-RPC. So I have access to not only what would
be found normally in the drbd.conf to make decisions, but the entire
state
of the cluster.

$cat avance_drbd_helper

#!/usr/lib/spine/bin/ruby


$:.unshift('/usr/lib/spine')
$0 =3D 'avance_drbd_helper'

require 'base/extensions'
require 'syslog'

$syslog =3D Syslog.open($0, Syslog::LOG_NDELAY, Syslog::LOG_DAEMON)
$syslog.notice "invoking #{$0}"

usage =3D <<-EOF
    Description:
        This is a pass-thru helper for drbd. We execute processes on
it's
        behalf and return the exit status back to the khelper.
    Usage:
        avance_drbd_helper  <action> <arguments>
    EOF

puts usage unless ARGV.length > 0

# see drbd_khelper for argument list passed to userspace
khelper  =3D ARGV[0] # 'outdate-peer'
resource =3D ARGV[1] # 'minor-5'

# the config file is no longer necessary, add all calls to
# khelpers here instead.
if khelper =3D=3D 'outdate-peer' || khelper =3D=3D 'fence-peer'
    resource.match(/minor-(\d+)/)
    %x{/usr/lib/spine/bin/drbd_outdate_peer drbd#{$1}}
    exit $?.exitstatus
end

if $DEBUG
    ARGV.each_with_index do |arg, idx|
        $syslog.notice "arg[#{idx}]=3D'#{arg}'"
    end
end

# safe default value for the rest of the handlers e.g.
before-resync-target
exit 0
##
# vim: ts=3D4:sw=3D4:ai:expandtab

Should anyone else want to use this, just remove any references to
"spine"
and "require 'base/extensions'". We override the default implementation
of
%x.

Peter

> --
> : Lars Ellenberg
> : LINBIT | Your Way to High Availability
> : DRBD/HA support and consulting http://www.linbit.com
>=20
> DRBD(r) and LINBIT(r) are registered trademarks of LINBIT, Austria.
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>=20
