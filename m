Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2006 08:14:54 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C81A@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: outdate-peer trigger scrip getting called twice??
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hi all,
In drbd.conf I set outdate-peer to "echo /dev/drbd0: hello world
>>/tmp/drbd.log"
I then do an ifdown on the Interface for the heartbeat for drbd.
On one node I get two "hello world" lines for drbd0
On the other I get one line.  I don't suspect that's normal, is it?

Thanks,
EM--
