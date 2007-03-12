Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Split-brain if primary and syncTarget
Date: Mon, 12 Mar 2007 15:28:20 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C91C@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C91C@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703121528.20523.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 8. M=E4rz 2007 23:21 schrieb Montrose, Ernest:
> Hi all,
>
> We are seeing an issue with split brain if one node is syncing as
> syncTarget while being Primary.
> two node A and B.
> * make B primary and the syncTarget
> * Start a sync.
> * ifdown eth1 to break communication
> * ifup eth1.
> * then on the node in standalone "drbdadm connect"
> We get a split-brain.
>
> I think the  problem is that if we are primary and we lose contact from
> the other side we generate a new current UUID which causes a Split-Brain
> next time we connect.
> This only happens if we are the sync target and we are primary. Perhaps
> we should not generate a UUID if we were syncing when the disconnect
> happen. Below is a possible patch for this in after_state_ch():

Hi Ernest,

I think the current behaviour is correct.

* When a node is SyncTarget it actually exposes the data of the sync
  source node to its applications. (And the applications can potentially=20
  see the data when the SyncTarget node is primary.)

* When you disconnect such a node, it has to fall back to its local
  data set. =3D=3D suddenly the applications see a different data set,
  and of course the apps might continue to modify this data set...

* Wen you reconnect this, you have a split brain situation. But you=20
  might let the automatic-split-brain resolving handler solve the
  situation. Use some after-sb-?pri settings, and an rr-conflict of
  "violently" E.g.:

  after-sb-0pri discard-least-changes
  after-sb-1pri violently-as0p
  after-sb-2pri violently-as0p
  rr-conflict   violently

  Then the resync should continue. Since the "violently" allows DRBD
  to change the data set again, that is seen on the Primary node.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
