Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Fencing and outdate-peer handler getting called
	multiple times
Date: Thu, 16 Nov 2006 08:10:56 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C836@EXNA.corp.stratus.com>
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

Phil,
My outdate-peer handler simply says "echo /deve/drbd0: Running handler =
for outdate-peer >>/tmp/drbdio.log"
And that log file is populated and created so I can only assume that did =
indicate success.  In this case success being an exit status of 0.

Thanks,

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Thursday, November 16, 2006 3:54 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: Fencing and outdate-peer handler getting =
called multiple times

Am Dienstag, 7. November 2006 00:16 schrieb Montrose, Ernest:
> Hi all,
> I have submitted this issue before, sorry for resubmit.  Essentially, =
on
> the primary node if I do an ifdown on the heartbeat interface and I =
have
> fencing enable to say "resource-only" then on the primary node the
> outdate-peer script gets called twice.  Once for state Disconnecting,
> and the other for state Networkfailure.

Maybe the return code of the outdate-peer handler did not indicated
success.

>
> I also notice that if on a node that is primary, I issue a "drbdadm
> secondary r0" the outdate-peer script gets called again from
> drbd_set_role() this time.

Maybe the return code of the outdate-peer handler did not indicated
success.

> What is the exact policy for the outdate-peer script?

This is the section of the ROADMAP file, that describes how it *should*
work:

7 Handle split brain situations; Support IO fencing;=20
 =20
  New commands:
    drbdadm outdate r0

    When the device is configured this works via an ioctl() call.
    In the other case it modifies the meta data directly by=20
    calling drbdmeta.

  remove option: on-disconnect

  New meta-data flag: "Outdated"

  introduce:
  disk {
    fencing [ dont-care | resource-only | resource-and-stonith ];
  }

  handlers {
    outdate-peer "some script";
  }

  If the disk state of the peer is unknown, drbd calls this=20
  handler (yes a call to userspace from kernel space). The handler's
  returncodes are:

  3 -> peer is inconsistent=20
  4 -> peer is outdated (this handler outdated it) [ resource fencing ]
  5 -> peer was down / unreachable
  6 -> peer is primary
  7 -> peer got stonithed [ node fencing ]

  Let us assume that we have two boxes (N1 and N2) and that these
  two boxes are connected by two networks (net and cnet [ clinets'-net =
]).

  Net is used by DRBD, while heartbeat uses both, net and cnet

  I know that you are talking about fencing by STONITH, but DRBD is
  not limited to that. Here comes my understanding of how resource =
fencing
  should works with DRBDv8 :

   N1  net   N2
   P/S ---  S/P     everything up and running.
   P/? - -  S/?     network breaks ; N1 freezes IO
   P/? - -  S/?     N1 fences N2:
                    In the STONITH case: turn off N2.
                    In the resource fencing case:=20
                    N1 asks N2 to fence itself from the storage via =
cnet.
                    HB calls "drbdadm outdate r0" on N2.
                    N2 replies to N1 that fencing is done via cnet.
                    The outdate-peer script on N1 returns sucess to =
DRBD.
   P/D - -  S/?     N1 thaws IO

  N2 got the the "Outdated" flag set in its meta-data, by the outdate=20
  command.=20

  The fencing is set to resource-only enables this behaviour. In the=20
  resource-only case the outdate-peer handler should have a return
  value of 3, 4, 5 or 6, but should not return 7.

  In case "fencing" is set to "resource-and-stonith", all IO operations
  get immediately frozen (even all currently outstanding IO operations
  will not finish) upon loss of connection.

  Then the "outdate-peer" handler is started. In this configuration
  the outdate peer handler might return any of the documented return
  values.

  When the outdate-peer handler returns IO is resumed.

  Notes:=20
  * Why do we need to freeze IO in the "resource-and-stonith" case:
      Stonith protects you when all communication pathes fail. In
      that case both (isolated) nodes try to stonith each other.
      If the current primary would continue to allow IO it could
      accept transactions, but could get stonithed by the=20
      currently secondary node.=20
      -> Therefore others could see commited transactions that
         would be gone after the successfull stonith operation.

  * The outedate peer handler also gets called if an unconnected
    secondary wants to become primary.
    In other words it only may become primary when it knows that
    the peer is outdated/inconsistent.

  * We need to store the fact that the peer is outdated/inconsistent
    in the meta-data. To allow an stand allone primary to be rebooted.


Does this answer your question ?

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
