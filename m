Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 712012D99B58
	for <drbd-dev@lists.linbit.com>; Tue,  8 Aug 2006 17:17:02 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD 8 rejects some state changes that it shouldn't
Date: Tue, 8 Aug 2006 17:17:01 +0200
References: <342BAC0A5467384983B586A6B0B37671034711CD@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671034711CD@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608081717.02142.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 7. August 2006 15:12 schrieb Graham, Simon:
> In general, the state change code does the right thing in refusing
> invalid state changes, however there are some cases where it rejects a
> change that cannot really be rejected - for example, if the peer tells
> you that it has gone diskless, it's really not possible to refuse the
> state change - here's an example:
>
> drbd15: State change failed: Refusing to be inconsistent on both
> nodesdrbd15:   state =3D { cs:SyncTarget st:Secondary/Primary
> ds:Inconsistent/UpToDate r--- }drbd15:  wanted =3D { cs:SyncTarget
> st:Secondary/Primary ds:Inconsistent/Diskless r--- }

> I'm not sure how important this is but it definitely results in the
> local state being incorrect. I'm not totally sure but I suspect you
> should always let the peer state change by setting the ChgStateHard flag
> in the call to drbd_change_state in receive_req_state?

The idea is to know the correct state of the peer.

In case the peer's disk failes, it (should) origin in
drbd_io_error() -> drbd_send_state()  =3D=3D=3Dnetwork=3D=3D>>=20
receive_state() /* Hmm, here is ChgStateHard missing!!! */

If the user at the peer node wants to detach, it should go
through _drbd_request_state() -> drbd_send_state_req()
=3D=3Dnetwork=3D=3D>>  receive_req_state() ...

if the state change failes there, it should fail the
state change on the peer node as well...


I think you the bug you mean is the missing ChgStateHard in
receive_state(). But before patching it in there, I wait for your
reply.

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
