Return-Path: <Peter.Petrakis@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Nov 2009 13:51:02 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C90ADFA2@EXHQ.corp.stratus.com>
From: "Petrakis, Peter" <Peter.Petrakis@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] changing the fencing policy on the fly
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi All,
=20
I have a challenge with the use of fencing and the state of flux in our
cluster. The system=20
will setup drbd devices in advance and use them independent of it's
peer, which will mirror
it's config once it joins the cluster. Since the fencing helper makes
use of drbdadm and thus
the config file we have a problem. If fencing were to be triggered, it
would immediately fail
with a bad exit status because the config file is inconsistent. We use a
naming convention
for the disks in our cluster so the only piece of information I don't
know at this time is my
peers ip address.

To work around this bug I set the fencing policy to 'dont-care' and then
once the resource
is connected and uptodate, detach the backing store and then reattach it
with the desired
fencing policy. This leaves us vulnerable however, should the link go
down for any reason we're
in big trouble.

I'm trying to eliminate this hole without detaching the backing store. I
can't play tricks with
aliasing the eth interface to some address because I'm not physically in
control of the box and don't
want to ruin someone's network in case they hook up the wires
incorrectly. DRBD doesn't seem to support
IPV6 link local addressing which would help in this case because the
nodes are directly attached.

What I'd like to do is to change the fencing policy on demand and the
mechanism I wish to use is sysfs.
Do you guys see any pitfalls with this approach, locking especially? The
reason I want to use sysfs is two
fold. I want to get away from using drbdadm for the userspace helper and
it'll make writing software to
manage drbd more straight forward. Thanks in advance.

Peter
