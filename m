Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 Nov 2006 18:16:51 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C825@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Fencing and outdate-peer handler getting called
	multiple times
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,
I have submitted this issue before, sorry for resubmit.  Essentially, on
the primary node if I do an ifdown on the heartbeat interface and I have
fencing enable to say "resource-only" then on the primary node the
outdate-peer script gets called twice.  Once for state Disconnecting,
and the other for state Networkfailure.

I also notice that if on a node that is primary, I issue a "drbdadm
secondary r0" the outdate-peer script gets called again from
drbd_set_role() this time.=20

What is the exact policy for the outdate-peer script?

Thanks,
EM--
