Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Jun 2007 18:50:03 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47921@EXNA.corp.stratus.com>
In-Reply-To: 200705181005.09112.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Resync Stalls at 100% patch problem
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Unfortunately it seems like the patch for receive_state() in
drbd_receive.c has a problem.  Acquiring the req_lock at the top of this
routine causes the cstate machine to get confused.  To reproduce this
just do:
Drbdadm detach d0;sleep 3;drbdadm attach d0 for instance. One side ends
up WBTmpT and the other WbitmapS and deadlock.  I am researching more
but wanted to let you.  If I just remove the early lock then things are
OK..:(

EM--
