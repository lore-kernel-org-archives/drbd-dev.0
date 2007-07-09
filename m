Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: An attach after a disk fault on the sync
	targetcauses a deadlock in WFBitMapT
Date: Mon, 9 Jul 2007 13:04:18 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47974@EXNA.corp.stratus.com>
In-Reply-To: BD7042533C2F8943A6A4257A9E31C454F47973@EXNA.corp.stratus.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Actually I uncover a problem with the patch I attached.  I am getting an
"unexpected Cstate" if I simply detach and attach.

EM--

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Montrose, Ernest
Sent: Monday, July 09, 2007 11:25 AM
To: Philipp Reisner; drbd-dev@linbit.com
Subject: [Drbd-dev] DRBD8: An attach after a disk fault on the sync
targetcauses a deadlock in WFBitMapT


Hi all,
We are seeing a problem where while syncing if the sync target detaches
then attempts to attach, both nodes end up in cs:WABitMapT state.  This
happens if both nodes where in Secondary/Secondary state and the dettach
happened on the SyncTarget.

I think what's happening is that the syncsource is losing the fact that
the synctarget is out of date.  After_state_ch() clears that fact out. I
am not  sure that the included patch is the proper fix for this but it
will illustrates the issue.=20

Thanks,

EM--
