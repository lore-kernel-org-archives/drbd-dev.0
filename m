Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 -trunk/drbd-
	The fix forthe "both nodes in WFBitMaps" issue, Ernest
Date: Fri, 22 Dec 2006 08:52:47 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8A3@EXNA.corp.stratus.com>
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
Thanks for the update.  But I think I may have been trying to recover
from problem by issuing the "--discard-my-data".  What I mean is that,
it was already in that state when I issued the connect with --discard...

Thank you for the quick fix!! I will test hopefully before Xmas :)

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Friday, December 22, 2006 8:45 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607
-trunk/drbd- The fix forthe "both nodes in WFBitMaps" issue, Ernest

Am Donnerstag, 21. Dezember 2006 19:19 schrieben Sie:
> Phil,
> Thanks for looking at this.  I was just trying to remove all the
cluter
> To help you out.  I include a tar ball here with the full messages
file
> for both nodes. Search for "Split" as a starting point since the issue
> seems
> to occur after a split brian. There are two files in the tar ball:
> addams/Gomez/var/log/messages
> addams/morticia/var/log/messages
>
> Thanks!!
>

Hi Ernest,

With the full log, I got pointed to the bug rather quickly.

Dec 19 11:56:35 morticia kernel: drbd0: Handshake successful: DRBD
Network Protocol version 85
Dec 19 11:56:35 morticia kernel: drbd0: drbd_sync_handshake:
Dec 19 11:56:35 morticia kernel: drbd0: self
B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
Dec 19 11:56:35 morticia kernel: drbd0: peer
EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
Dec 19 11:56:35 morticia kernel: drbd0: uuid_compare()=3D100
Dec 19 11:56:35 morticia kernel: drbd0: Split-Brain detected, manually
solved. Sync from this node
Dec 19 11:56:35 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )


Dec 19 11:56:35 gomez kernel: drbd0: Handshake successful: DRBD Network
Protocol version 85
Dec 19 11:56:35 gomez kernel: drbd0: drbd_sync_handshake:
Dec 19 11:56:35 gomez kernel: drbd0: self
EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
Dec 19 11:56:35 gomez kernel: drbd0: peer
B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
Dec 19 11:56:35 gomez kernel: drbd0: uuid_compare()=3D100
Dec 19 11:56:35 gomez kernel: drbd0: Split-Brain detected, manually
solved. Sync from this node
Dec 19 11:56:35 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )

Here are the lines that gave the hint.
It looks like you passed on both sides the option "--discard-my-data".

Now I fixed this. In the future it should disconnect if you pass
the "--discard-my-data" on both sides to the the net command.

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
