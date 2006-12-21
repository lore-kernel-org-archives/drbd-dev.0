Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 -
	trunk/drbd- The fix forthe "both nodes in WFBitMaps" issue, Ernest
Date: Thu, 21 Dec 2006 10:05:45 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C89C@EXNA.corp.stratus.com>
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
Thanks, I have to wait for another occurrence for the drbdadm show-gi
output. But I have the kernel messages below for both nodes in the
cluster:

*****Split brain messages*******
I think this case May be another Split-Brain manifestation...But the
states are not right for manual sync. In both cases eth1 was previously
down:
Here are some data:
Dec 19 11:56:35 morticia kernel: drbd0: self
B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
Dec 19 11:56:35 morticia kernel: drbd0: peer
EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
Dec 19 11:56:35 morticia kernel: drbd0: uuid_compare()=3D100
Dec 19 11:56:35 morticia kernel: drbd0: Split-Brain detected, manually
solved. Sync from this node
Dec 19 11:56:35 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:56:35 morticia kernel: drbd2: conn( WFConnection ->
WFReportParams )

************************************************************************
**

Dec 19 11:56:35 gomez kernel: drbd0: conn( WFConnection ->
WFReportParams )
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
Dec 19 11:56:35 gomez kernel: drbd2: conn( WFConnection ->
WFReportParams )

##############State machines messages on both
nodes########################
[root@gomez ~]# grep WFBitMapS /var/log/messages|grep drbd0
Dec 19 11:03:25 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:03:25 gomez kernel: drbd0: conn( WFBitMapS -> SyncSource )
pdsk( UpToDate -> Inconsistent )
Dec 19 11:06:49 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:06:49 gomez kernel: drbd0: conn( WFBitMapS -> SyncSource )
pdsk( UpToDate -> Inconsistent )
Dec 19 11:09:56 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:09:57 gomez kernel: drbd0: conn( WFBitMapS -> SyncSource )
pdsk( UpToDate -> Inconsistent )
Dec 19 05:36:50 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 05:37:02 gomez kernel: drbd0: peer( Secondary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:39:53 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:40:04 gomez kernel: drbd0: peer( Secondary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:42:53 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:43:24 gomez kernel: drbd0: peer( Secondary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:47:06 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:47:16 gomez kernel: drbd0: peer( Secondary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:50:38 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:51:45 gomez kernel: drbd0: peer( Secondary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:56:35 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )


[root@morticia parameters]# grep WFBitMapS /var/log/messages|grep drbd0
Dec 19 04:25:29 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> Inconsistent )
Dec 19 04:25:29 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:30:30 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:30:30 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:32:41 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:32:41 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:36:57 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:36:58 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:47:01 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:47:01 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:52:10 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:52:10 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:56:09 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:56:09 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 10:58:32 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS )
Dec 19 10:58:33 morticia kernel: drbd0: conn( WFBitMapS -> SyncSource )
Dec 19 05:36:51 morticia kernel: drbd0: peer( Unknown -> Secondary )
conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 05:37:01 morticia kernel: drbd0: peer( Secondary -> Unknown )
conn( WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:39:53 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:40:04 morticia kernel: drbd0: peer( Primary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:42:53 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:43:24 morticia kernel: drbd0: peer( Primary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:47:06 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:47:16 morticia kernel: drbd0: peer( Primary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:50:38 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 11:51:45 morticia kernel: drbd0: peer( Primary -> Unknown ) conn(
WFBitMapS -> NetworkFailure ) pdsk( UpToDate -> DUnknown )
Dec 19 11:56:35 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Dec 19 15:16:44 morticia kernel: drbd0:  state =3D { cs:WFBitMapS
st:Secondary/Primary ds:UpToDate/UpToDate r--- }
Dec 19 15:16:44 morticia kernel: drbd0:  wanted =3D { cs:WFBitMapS
st:Secondary/Primary ds:Diskless/UpToDate r--- }

###########Other info (/proc/drbd etc...##############################
[root@morticia ~]# tail -f /var/log/messages
Dec 19 14:12:00 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965943
Dec 19 14:12:06 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965942
Dec 19 14:12:12 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965941
Dec 19 14:12:18 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965940
Dec 19 14:12:24 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965939
Dec 19 14:12:30 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965938
Dec 19 14:12:36 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965937
Dec 19 14:12:42 morticia kernel: drbd0: [drbd0_receiver/5841]
sock_sendmsg time expired, ko =3D 4294965936


[root@morticia ~]# cat /proc/drbd
version: 8.0pre6 (api:85/proto:85)
SVN Revision: 7932 build by sntriage@anna.sn.stratus.com, 2006-12-18
02:14:57
 0: cs:WFBitMapS st:Secondary/Primary ds:UpToDate/UpToDate C r---
    ns:0 nr:0 dw:0 dr:0 al:0 bm:257 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:0 misses:0 starving:0 dirty:0 changed:0
        act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0
 1: cs:Connected st:Secondary/Secondary ds:UpToDate/UpToDate C r---
    ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:0 misses:0 starving:0 dirty:0 changed:0
        act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0
 2: cs:Connected st:Secondary/Secondary ds:UpToDate/UpToDate C r---
    ns:11158536 nr:0 dw:0 dr:11198756 al:0 bm:679 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:696906 misses:689 starving:0 dirty:0
changed:689
        act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0

15: cs:WFConnection st:Primary/Unknown ds:UpToDate/DUnknown C r---
    ns:0 nr:0 dw:8856 dr:2449 al:5 bm:0 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:0 misses:0 starving:0 dirty:0 changed:0
        act_log: used:0/257 hits:2209 misses:5 starving:0 dirty:0
changed:5
[root@morticia ~]#


[root@gomez ~]# tail -f /var/log/messages
Dec 19 14:11:48 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965946
Dec 19 14:11:54 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965945
Dec 19 14:12:00 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965944
Dec 19 14:12:06 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965943
Dec 19 14:12:12 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965942
Dec 19 14:12:18 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965941
Dec 19 14:12:24 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965940
Dec 19 14:12:30 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965939
Dec 19 14:12:36 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965938
Dec 19 14:12:42 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965937
Dec 19 14:12:48 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965936
Dec 19 14:12:54 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965935
Dec 19 14:13:00 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965934
Dec 19 14:13:06 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965933
Dec 19 14:13:12 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965932
Dec 19 14:13:18 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965931
Dec 19 14:13:24 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965930
Dec 19 14:13:30 gomez kernel: drbd0: [drbd0_receiver/5857] sock_sendmsg
time expired, ko =3D 4294965929

[root@gomez ~]# cat /proc/drbd
version: 8.0pre6 (api:85/proto:85)
SVN Revision: 7932 build by sntriage@anna.sn.stratus.com, 2006-12-18
02:14:57
 0: cs:WFBitMapS st:Primary/Secondary ds:UpToDate/UpToDate C r---
    ns:0 nr:0 dw:952 dr:47985 al:0 bm:78 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:0 misses:0 starving:0 dirty:0 changed:0
        act_log: used:0/257 hits:226 misses:0 starving:0 dirty:0
changed:0
 1: cs:Connected st:Secondary/Secondary ds:UpToDate/UpToDate C r---
    ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:0 misses:0 starving:0 dirty:0 changed:0
        act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0
 2: cs:Connected st:Secondary/Secondary ds:UpToDate/UpToDate C r---
    ns:0 nr:11158084 dw:11158084 dr:0 al:0 bm:683 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:715858 misses:724 starving:0 dirty:0
changed:724
        act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0

15: cs:StandAlone st:Secondary/Unknown ds:UpToDate/DUnknown  r---
    ns:0 nr:0 dw:0 dr:0 al:0 bm:28 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:0 misses:0 starving:0 dirty:0 changed:0
        act_log: used:0/257 hits:0 misses:0 starving:0 dirty:0 changed:0


-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Thursday, December 21, 2006 3:39 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 -
trunk/drbd- The fix forthe "both nodes in WFBitMaps" issue, Ernest

Am Mittwoch, 20. Dezember 2006 18:46 schrieb Montrose, Ernest:
> Hi Phil,
> I am still seeing this issue that I reported a while back and for
which
> you submitted a fix (see original message below).  But essentially
after
> the drbd heartbeat link is disconnected and Split brain occurred, both
> nodes thinks they should be the sync source.  They send their
peers(each
> other) to the following states:
> peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) pdsk(
> DUnknown -> UpToDate ) At the same time..
> This state persists across a reboot and the drbd_receiver thread loops
> on both nodes with:
>


Hi Ernest,

Could you please post the kernel messages from both nodes including
the disconnect time, as well the reconnect time ?

And a "drbdadm show-gi" on both nodes from the resource in question
would be helpfull as well.

Thanks!

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
