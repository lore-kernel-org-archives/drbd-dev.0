Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] [DRBD 8.0 PATCH] Update state processing so that
	after-state-change is always done in worker thread
Date: Tue, 15 Jan 2008 08:50:11 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5B34A@EXNA.corp.stratus.com>
In-Reply-To: 200801151014.07561.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B3767107C5AF5E@EXNA.corp.stratus.com>
	200801151014.07561.philipp.reisner@linbit.com
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,

> It is not allowed to call drbd_thread_start() while we are in
> _drbd_set_state(),
> because drbd_thread_start() uses a sleeping function
> (wait_for_completion()).
> And _drbd_set_state() is running with the req_lock hold.
>=20
> But I think that can be easily took out of _drbd_set_state(), and done
> in the
> context of the netlink connector callbacks.
>=20

Whilst this is definitely a good idea, I convinced myself this would not
be a problem because we should never actually have to start the thread
in the context of a call from drbd_set_state - it should already be
running in this case in which case drbd_start_thread is a NOP.

Simon

