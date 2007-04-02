Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C77570.24C657D2"
Subject: RE: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT
Date: Mon, 2 Apr 2007 17:44:51 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C948@EXNA.corp.stratus.com>
In-reply-to: <200704022159.32913.philipp.reisner@linbit.com>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77570.24C657D2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Phil,
OK...I have learned a tad more since that last email.  So before I even
try the proposed patch here is a way I was able to duplicate the
problem.
Perhaps that will help a bit.  Here it is with two nodes 'a' and 'b' .
Suppose
They are in steady states with UUIDS:
Xa:0:Ha:HH:1:1:0:1:0:0
Xb:0:Hb:HH:1:1:0:1:0:0
Role Secondary/Secondary

1) Disconnect/detach /dev/drbdX on nodea
2) Move Current UUID of nodea to history-UUID of nodea and set
current_UUID of nodea to 00000000000 with drbdmeta..
0:0:Xa:HH:1:1:0:1:0:0
3) Now attach and connect /dev/drbdX and the problem will occur

I have attached the logs for my "manufactured" version of the problem
:).  I have some extra instrumentation that I had placed in there so you
can ignore
Them...

I am not sure how we got that way under normal operation..:( One thing
is that
the test we are running calls for "pulling the plug" on one of the node.
So=20
the reboot was not the result of a graceful shutdown and right before
the reboot, the messed up volume had just written its meta data "to
super block" coming fresh from a resync.

Hope this helps

Thanks a lot...

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Monday, April 02, 2007 4:00 PM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT

Hi Ernest,

I removed all the linebreaks:

Drbd2: Writing metadata to superblock now.
......
....... This nodes is powered of and came back with:

13:16:53 je rct =3D 0 in
13:16:54 je drbd_sync_handshake:
13:16:54 je self
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:54 je peer
F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:55 je uuid_compare()=3D0 by rule 4
<<<<<<<<=3D=3D=3D=3D=3D=3D=3D=3D=3D---------------
13:16:55 je No resync, but bits in bitmap!

......

13:17:00 je drbd_sync_handshake:
13:17:00 je self
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:17:00 je peer
0000000000000000:0000000000000000:F71E503A8179BC5C:3F430D4E1D59C3EA
13:17:00 je uuid_compare()=3D-2 by rule 6
13:17:00 je Writing meta data super block now.
13:17:01 je writing of bitmap took 11 jiffies
13:17:01 je 12 GB marked out-of-sync by on disk bit-map.
13:17:02 je 13336132 KB now marked out-of-sync by on disk bit-map.
13:17:02 je Writing meta data super block now.
13:17:02 je  uuid[History_start] now F71E503A8179BC5D
13:17:02 je  uuid[Current] now 0000000000000000
13:17:03 je conn( Connected -> WFBitMapT )
13:17:03 je Writing meta data super block now.

On theh other =
node=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

13:16:48 be aftr_isp( 0 -> 1 )
13:16:48 be Handshake successful: DRBD Network Protocol version 86
13:16:48 be peer( Unknown -> Secondary ) conn( WFReportParams ->
Connected ) pdsk( DUnknown -> UpToDate ) peer_isp( 0 -> 1 )
13:16:48 be Writing meta data super block now.

....

13:16:49 be rct =3D 2 in
13:16:49 be drbd_sync_handshake:
13:16:49 be self
F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:49 be peer
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:49 be uuid_compare()=3D-1 by rule 4
<<<<<<<<=3D=3D=3D=3D=3D=3D=3D=3D=3D---------------
13:16:49 be  uuid[History_start] now F71E503A8179BC5C
13:16:49 be  uuid[Current] now 0000000000000000
13:16:49 be conn( Connected -> WFBitMapT )
13:16:49 be Writing meta data super block now.


Unfortunately the clocks of the nodes seems to be not in sync (please
use NTP, this would make reading such logs much easiert!)

I assume that the line marked with the arrow ( <<=3D=3D-- ) is=20
where the troubles begin. Because the 'self' and 'peer' line
is matches here inverse. Then the suspicious decision is
the outcome of uuid_compare() with rule 4.=20

While je (jerry) comes to the conclusion 0, gets ben -1.=20

The rtc (a few lines before) suggests us that jerry thought
that neither node was a CRASHED_PRIMARY, while ben thought
that jerry was a CRASHED_PRIMARY. Out of you comment
that jerry was powered off, I guess that jerry was really
a CRASHED_PRIMARY, and therefore it sent this information
over to ben. But somehow that CRASHED_PRIMARY bit got
cleared before jerry came to its drbd_uuid_compare()
function.=20

The question is: how did that happen ?

In the rest of the log entries on jerry we can see how he
tried to do a second sync handshake ...=20

Back to the question of the lost CRASHED_PRIMARY bit.=20

That bits can get cleared when:
1) We attach a disk.
2) Connection state goes to connected.
3) In the receive_bitmap.

I think that the clear_bit in receive_bitmap() is wrong, but
I currently can not think of a situation where this clear_bit
can get executed before the drbd_sync_handshake() function.

Ernest, could you provide a bit more context with a few more
lines of jerry's log before 13:16:53.

So far this my proposed patch. But there is still a missing
link in the reasoning:

--- drbd_receiver.c	(revision 2821)
+++ drbd_receiver.c	(working copy)
@@ -2509,7 +2509,6 @@
 		D_ASSERT(h->command =3D=3D ReportBitMap);
 	}
=20
-	clear_bit(CRASHED_PRIMARY, &mdev->flags); // md_write() is in
drbd_start_resync.
 	if (mdev->state.conn =3D=3D WFBitMapS) {
 		drbd_start_resync(mdev,SyncSource);
 	} else if (mdev->state.conn =3D=3D WFBitMapT) {

------_=_NextPart_001_01C77570.24C657D2
Content-Type: text/plain;
	name="nodeA.txt"
Content-Transfer-Encoding: base64
Content-Description: nodeA.txt
Content-Disposition: attachment;
	filename="nodeA.txt"

ZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogQ2hhbmdpbmcgc3RhdGUuCmRyYmQyOiBfZHJiZF9zZXRf
c3RhdGU6IHNldHRpbmcgY29ubiB0byBTeW5jU291cmNlIG9yIFN5bmNUYXJnZXQgc2VlIG1lc3Nh
Z2UgYmVsb3cKZHJiZDI6IHBlZXIoIFNlY29uZGFyeSAtPiBVbmtub3duICkgY29ubiggQ29ubmVj
dGVkIC0+IERpc2Nvbm5lY3RpbmcgKSBwZHNrKCBVcFRvRGF0ZSAtPiBEVW5rbm93biApIApkcmJk
MjogX2RyYmRfc2V0X3N0YXRlOiBDaGFuZ2luZyBzdGF0ZS4KZHJiZDI6IF9kcmJkX3NldF9zdGF0
ZTogc2V0dGluZyBjb25uIHRvIFN5bmNTb3VyY2Ugb3IgU3luY1RhcmdldCBzZWUgbWVzc2FnZSBi
ZWxvdwpkcmJkMjogX2RyYmRfc2V0X3N0YXRlOiBObyBzdGF0ZSBuZXcgc3RhdGUgdG8gY2hhbmdl
IHRvLgpkcmJkMjogc2hvcnQgcmVhZCBleHBlY3RpbmcgaGVhZGVyIG9uIHNvY2s6IHI9LTUxMgpk
cmJkMjogYXNlbmRlciB0ZXJtaW5hdGVkCmRyYmQyOiB0bF9jbGVhcigpCmRyYmQyOiBDb25uZWN0
aW9uIGNsb3NlZApkcmJkMjogV3JpdGluZyBtZXRhIGRhdGEgc3VwZXIgYmxvY2sgbm93LgpkcmJk
MjogX2RyYmRfc2V0X3N0YXRlOiBDaGFuZ2luZyBzdGF0ZS4KZHJiZDI6IF9kcmJkX3NldF9zdGF0
ZTogc2V0dGluZyBjb25uIHRvIFN5bmNTb3VyY2Ugb3IgU3luY1RhcmdldCBzZWUgbWVzc2FnZSBi
ZWxvdwpkcmJkMjogY29ubiggRGlzY29ubmVjdGluZyAtPiBTdGFuZEFsb25lICkgCmRyYmQyOiBy
ZWNlaXZlciB0ZXJtaW5hdGVkCmRyYmQyOiBfZHJiZF9zZXRfc3RhdGU6IENoYW5naW5nIHN0YXRl
LgpkcmJkMjogX2RyYmRfc2V0X3N0YXRlOiBzZXR0aW5nIGNvbm4gdG8gU3luY1NvdXJjZSBvciBT
eW5jVGFyZ2V0IHNlZSBtZXNzYWdlIGJlbG93CmRyYmQyOiBkaXNrKCBVcFRvRGF0ZSAtPiBEaXNr
bGVzcyApIApkcmJkMjogZHJiZF9ibV9yZXNpemUgY2FsbGVkIHdpdGggY2FwYWNpdHkgPT0gMApk
cmJkMjogd29ya2VyIHRlcm1pbmF0ZWQKZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogQ2hhbmdpbmcg
c3RhdGUuCmRyYmQyOiBfZHJiZF9zZXRfc3RhdGU6IHNldHRpbmcgY29ubiB0byBTeW5jU291cmNl
IG9yIFN5bmNUYXJnZXQgc2VlIG1lc3NhZ2UgYmVsb3cKZHJiZDI6IGRpc2soIERpc2tsZXNzIC0+
IEF0dGFjaGluZyApIApkcmJkMjogTm8gdXNhYmxlIGFjdGl2aXR5IGxvZyBmb3VuZC4KZHJiZDI6
IG1heF9zZWdtZW50X3NpemUgKCA9IEJJTyBzaXplICkgPSAzMjc2OApkcmJkMjogZHJiZF9ibV9y
ZXNpemUgY2FsbGVkIHdpdGggY2FwYWNpdHkgPT0gMjY2NzIyNjQKZHJiZDI6IHJlc3luYyBiaXRt
YXA6IGJpdHM9MzMzNDAzMyB3b3Jkcz0xMDQxOTAKZHJiZDI6IHNpemUgPSAxMiBHQiAoMTMzMzYx
MzIgS0IpCmRyYmQyOiByZWFkaW5nIG9mIGJpdG1hcCB0b29rIDIgamlmZmllcwpkcmJkMjogcmVj
b3VudGluZyBvZiBzZXQgYml0cyB0b29rIGFkZGl0aW9uYWwgMCBqaWZmaWVzCmRyYmQyOiAwIEtC
IG1hcmtlZCBvdXQtb2Ytc3luYyBieSBvbiBkaXNrIGJpdC1tYXAuCmRyYmQyOiBfZHJiZF9zZXRf
c3RhdGU6IENoYW5naW5nIHN0YXRlLgpkcmJkMjogX2RyYmRfc2V0X3N0YXRlOiBzZXR0aW5nIGNv
bm4gdG8gU3luY1NvdXJjZSBvciBTeW5jVGFyZ2V0IHNlZSBtZXNzYWdlIGJlbG93CmRyYmQyOiBk
aXNrKCBBdHRhY2hpbmcgLT4gVXBUb0RhdGUgKSAKZHJiZDI6IFdyaXRpbmcgbWV0YSBkYXRhIHN1
cGVyIGJsb2NrIG5vdy4KZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogQ2hhbmdpbmcgc3RhdGUuCmRy
YmQyOiBfZHJiZF9zZXRfc3RhdGU6IHNldHRpbmcgY29ubiB0byBTeW5jU291cmNlIG9yIFN5bmNU
YXJnZXQgc2VlIG1lc3NhZ2UgYmVsb3cKZHJiZDI6IGNvbm4oIFN0YW5kQWxvbmUgLT4gVW5jb25u
ZWN0ZWQgKSAKZHJiZDI6IHJlY2VpdmVyIChyZSlzdGFydGVkCmRyYmQyOiBkcmJkX2Nvbm5lY3Q6
ICoqKioqKioqKioqKioqKipDb25uZWN0aW5nKioqKioqKioKZHJiZDI6IF9kcmJkX3NldF9zdGF0
ZTogQ2hhbmdpbmcgc3RhdGUuCmRyYmQyOiBfZHJiZF9zZXRfc3RhdGU6IHNldHRpbmcgY29ubiB0
byBTeW5jU291cmNlIG9yIFN5bmNUYXJnZXQgc2VlIG1lc3NhZ2UgYmVsb3cKZHJiZDI6IGNvbm4o
IFVuY29ubmVjdGVkIC0+IFdGQ29ubmVjdGlvbiApIApkcmJkMjogX2RyYmRfc2V0X3N0YXRlOiBD
aGFuZ2luZyBzdGF0ZS4KZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogc2V0dGluZyBjb25uIHRvIFN5
bmNTb3VyY2Ugb3IgU3luY1RhcmdldCBzZWUgbWVzc2FnZSBiZWxvdwpkcmJkMjogY29ubiggV0ZD
b25uZWN0aW9uIC0+IFdGUmVwb3J0UGFyYW1zICkgCmRyYmQyOiBIYW5kc2hha2Ugc3VjY2Vzc2Z1
bDogRFJCRCBOZXR3b3JrIFByb3RvY29sIHZlcnNpb24gODYKZHJiZDI6IGRyYmRfY29ubmVjdDog
KioqKioqKioqKioqKioqKnNlbmRpbmcgcHJvY29sIHdoaWxlIENvbm5lY3RpbmcqKioqKioqKgpk
cmJkMjogZHJiZF9jb25uZWN0OiAqKioqKioqKioqKioqKioqU2VuZGluZyBwYXJhbiB3aGlsZSBD
b25uZWN0aW5nKioqKioqKioKZHJiZDI6IGRyYmRfY29ubmVjdDogKioqKioqKioqKioqKioqKiBT
ZW5kaW5nIHNpemVzIHdoaWxlIENvbm5lY3RpbmcqKioqKioqKgpkcmJkMjogZHJiZF9jb25uZWN0
OiAqKioqKioqKioqKioqKioqc2VuZGluIHV1aWRzIHdoaWxlIENvbm5lY3RpbmcqKioqKioqKgpk
cmJkMjogZHJiZF9jb25uZWN0OiAqKioqKioqKioqKioqKioqU2VuZGluZyBzdGF0ZXMgd2hpbGUg
Q29ubmVjdGluZyoqKioqKioqCmRyYmQyOiBkcmJkX2Nvbm5lY3Q6ICoqKioqKioqKioqKioqKipE
T05FISEhISBDb25uZWN0aW5nKioqKioqKioKZHJiZDI6IGRyYmRfc3luY19oYW5kc2hha2U6CmRy
YmQyOiBzZWxmIDAwMDAwMDAwMDAwMDAwMDA6MDAwMDAwMDAwMDAwMDAwMDpCMkUzNDBGRDBGQjRG
MjM2OkIyRTM0MEZEMEZCNEYyMTkKZHJiZDI6IHBlZXIgQjJFMzQwRkQwRkI0RjIzNjowMDAwMDAw
MDAwMDAwMDAwOkU1MTVEN0M3MDY0NEFGOTI6QjJFMzQwRkQwRkI0RjIxOQpkcmJkMjogdXVpZF9j
b21wYXJlKCk9LTEgYnkgcnVsZSA1CmRyYmQyOiAgdXVpZFtDdXJyZW50XSBub3cgMDAwMDAwMDAw
MDAwMDAwMApkcmJkMjogX2RyYmRfc2V0X3N0YXRlOiBDaGFuZ2luZyBzdGF0ZS4KZHJiZDI6IF9k
cmJkX3NldF9zdGF0ZTogc2V0dGluZyBjb25uIHRvIFN5bmNTb3VyY2Ugb3IgU3luY1RhcmdldCBz
ZWUgbWVzc2FnZSBiZWxvdwpkcmJkMjogcGVlciggVW5rbm93biAtPiBTZWNvbmRhcnkgKSBjb25u
KCBXRlJlcG9ydFBhcmFtcyAtPiBXRkJpdE1hcFQgKSBwZHNrKCBEVW5rbm93biAtPiBVcFRvRGF0
ZSApIApkcmJkMjogV3JpdGluZyBtZXRhIGRhdGEgc3VwZXIgYmxvY2sgbm93Lgo=

------_=_NextPart_001_01C77570.24C657D2
Content-Type: text/plain;
	name="nodeB.txt"
Content-Transfer-Encoding: base64
Content-Description: nodeB.txt
Content-Disposition: attachment;
	filename="nodeB.txt"

ZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogQ2hhbmdpbmcgc3RhdGUuCmRyYmQyOiBfZHJiZF9zZXRf
c3RhdGU6IHNldHRpbmcgY29ubiB0byBTeW5jU291cmNlIG9yIFN5bmNUYXJnZXQgc2VlIG1lc3Nh
Z2UgYmVsb3cKZHJiZDI6IHBlZXIoIFNlY29uZGFyeSAtPiBVbmtub3duICkgY29ubiggQ29ubmVj
dGVkIC0+IFRlYXJEb3duICkgcGRzayggVXBUb0RhdGUgLT4gRFVua25vd24gKSAKZHJiZDI6IFdy
aXRpbmcgbWV0YSBkYXRhIHN1cGVyIGJsb2NrIG5vdy4KZHJiZDI6IG1ldGEgY29ubmVjdGlvbiBz
aHV0IGRvd24gYnkgcGVlci4KZHJiZDI6IGFzZW5kZXIgdGVybWluYXRlZApkcmJkMjogdGxfY2xl
YXIoKQpkcmJkMjogQ29ubmVjdGlvbiBjbG9zZWQKZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogQ2hh
bmdpbmcgc3RhdGUuCmRyYmQyOiBfZHJiZF9zZXRfc3RhdGU6IHNldHRpbmcgY29ubiB0byBTeW5j
U291cmNlIG9yIFN5bmNUYXJnZXQgc2VlIG1lc3NhZ2UgYmVsb3cKZHJiZDI6IGNvbm4oIFRlYXJE
b3duIC0+IFVuY29ubmVjdGVkICkgCmRyYmQyOiByZWNlaXZlciB0ZXJtaW5hdGVkCmRyYmQyOiBy
ZWNlaXZlciAocmUpc3RhcnRlZApkcmJkMjogZHJiZF9jb25uZWN0OiAqKioqKioqKioqKioqKioq
Q29ubmVjdGluZyoqKioqKioqCmRyYmQyOiBfZHJiZF9zZXRfc3RhdGU6IENoYW5naW5nIHN0YXRl
LgpkcmJkMjogX2RyYmRfc2V0X3N0YXRlOiBzZXR0aW5nIGNvbm4gdG8gU3luY1NvdXJjZSBvciBT
eW5jVGFyZ2V0IHNlZSBtZXNzYWdlIGJlbG93CmRyYmQyOiBjb25uKCBVbmNvbm5lY3RlZCAtPiBX
RkNvbm5lY3Rpb24gKSAKZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTogQ2hhbmdpbmcgc3RhdGUuCmRy
YmQyOiBfZHJiZF9zZXRfc3RhdGU6IHNldHRpbmcgY29ubiB0byBTeW5jU291cmNlIG9yIFN5bmNU
YXJnZXQgc2VlIG1lc3NhZ2UgYmVsb3cKZHJiZDI6IGNvbm4oIFdGQ29ubmVjdGlvbiAtPiBXRlJl
cG9ydFBhcmFtcyApIApkcmJkMjogSGFuZHNoYWtlIHN1Y2Nlc3NmdWw6IERSQkQgTmV0d29yayBQ
cm90b2NvbCB2ZXJzaW9uIDg2CmRyYmQyOiBkcmJkX2Nvbm5lY3Q6ICoqKioqKioqKioqKioqKipz
ZW5kaW5nIHByb2NvbCB3aGlsZSBDb25uZWN0aW5nKioqKioqKioKZHJiZDI6IGRyYmRfY29ubmVj
dDogKioqKioqKioqKioqKioqKlNlbmRpbmcgcGFyYW4gd2hpbGUgQ29ubmVjdGluZyoqKioqKioq
CmRyYmQyOiBkcmJkX2Nvbm5lY3Q6ICoqKioqKioqKioqKioqKiogU2VuZGluZyBzaXplcyB3aGls
ZSBDb25uZWN0aW5nKioqKioqKioKZHJiZDI6IGRyYmRfY29ubmVjdDogKioqKioqKioqKioqKioq
KnNlbmRpbiB1dWlkcyB3aGlsZSBDb25uZWN0aW5nKioqKioqKioKZHJiZDI6IGRyYmRfY29ubmVj
dDogKioqKioqKioqKioqKioqKlNlbmRpbmcgc3RhdGVzIHdoaWxlIENvbm5lY3RpbmcqKioqKioq
KgpkcmJkMjogZHJiZF9jb25uZWN0OiAqKioqKioqKioqKioqKioqRE9ORSEhISEgQ29ubmVjdGlu
ZyoqKioqKioqCmRyYmQyOiBkcmJkX3N5bmNfaGFuZHNoYWtlOgpkcmJkMjogc2VsZiBCMkUzNDBG
RDBGQjRGMjM2OjAwMDAwMDAwMDAwMDAwMDA6RTUxNUQ3QzcwNjQ0QUY5MjpCMkUzNDBGRDBGQjRG
MjE5CmRyYmQyOiBwZWVyIDAwMDAwMDAwMDAwMDAwMDA6MDAwMDAwMDAwMDAwMDAwMDpCMkUzNDBG
RDBGQjRGMjM2OkIyRTM0MEZEMEZCNEYyMTkKZHJiZDI6IHV1aWRfY29tcGFyZSgpPS0yIGJ5IHJ1
bGUgNgpkcmJkMjogV3JpdGluZyBtZXRhIGRhdGEgc3VwZXIgYmxvY2sgbm93LgpkcmJkMjogd3Jp
dGluZyBvZiBiaXRtYXAgdG9vayA0IGppZmZpZXMKZHJiZDI6IDEyIEdCIG1hcmtlZCBvdXQtb2Yt
c3luYyBieSBvbiBkaXNrIGJpdC1tYXAuCmRyYmQyOiAxMzMzNjEzMiBLQiBub3cgbWFya2VkIG91
dC1vZi1zeW5jIGJ5IG9uIGRpc2sgYml0LW1hcC4KZHJiZDI6IFdyaXRpbmcgbWV0YSBkYXRhIHN1
cGVyIGJsb2NrIG5vdy4KZHJiZDI6ICB1dWlkW0hpc3Rvcnlfc3RhcnRdIG5vdyBCMkUzNDBGRDBG
QjRGMjM2CmRyYmQyOiAgdXVpZFtDdXJyZW50XSBub3cgMDAwMDAwMDAwMDAwMDAwMApkcmJkMjog
X2RyYmRfc2V0X3N0YXRlOiBDaGFuZ2luZyBzdGF0ZS4KZHJiZDI6IF9kcmJkX3NldF9zdGF0ZTog
c2V0dGluZyBjb25uIHRvIFN5bmNTb3VyY2Ugb3IgU3luY1RhcmdldCBzZWUgbWVzc2FnZSBiZWxv
dwpkcmJkMjogcGVlciggVW5rbm93biAtPiBTZWNvbmRhcnkgKSBjb25uKCBXRlJlcG9ydFBhcmFt
cyAtPiBXRkJpdE1hcFQgKSBwZHNrKCBEVW5rbm93biAtPiBVcFRvRGF0ZSApIApkcmJkMjogV3Jp
dGluZyBtZXRhIGRhdGEgc3VwZXIgYmxvY2sgbm93Lgo=

------_=_NextPart_001_01C77570.24C657D2--
