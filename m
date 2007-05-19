Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C799B0.D59D0782"
Content-class: urn:content-classes:message
Date: Fri, 18 May 2007 20:58:27 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671057E5593@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD connection fails with unexpected packet
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C799B0.D59D0782
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We are seeing an occasional problem where DRBD connection fails with
this error:

May 13 04:25:12 ben kernel: drbd2: expected HandShake packet, received:
ReportState (0x000e)

I believe this is a timing issue between the thread setting up the
connection and the thread for a different drbd device pausing the resync
for the device being connected.

Here's the full trace on the side that sends the ReportState (I've left
out a lot of stuff here, but it shows drbd0 starting to resync and
causing drbd1 and drbd2 to set aftr_isp:

May 13 04:22:31 jerry kernel: drbd2: receiver (re)started
May 13 04:22:31 jerry kernel: drbd2: conn( Unconnected -> WFConnection )

...
May 13 04:25:07 jerry kernel: drbd2: conn( WFConnection ->
WFReportParams )=20
...
May 13 04:25:08 jerry kernel: drbd0: Writing meta data super block now.
May 13 04:25:08 jerry kernel: drbd0:  uuid[History_start] now
9349CA8853B42403
May 13 04:25:08 jerry kernel: drbd0:  uuid[Bitmap] now BD4768B8E7A944E2
May 13 04:25:09 jerry kernel: drbd0: conn( WFBitMapS -> SyncSource )
pdsk( UpToDate -> Inconsistent )=20
May 13 04:25:09 jerry kernel: drbd1: aftr_isp( 0 -> 1 )
May 13 04:25:09 jerry kernel: drbd2: aftr_isp( 0 -> 1 )=20
May 13 04:25:12 jerry kernel: drbd2: sock_sendmsg returned -104
May 13 04:25:12 jerry kernel: drbd2: conn( WFReportParams -> BrokenPipe
)=20

and on the other side:

May 13 04:25:09 ben kernel: drbd2: receiver (re)started
May 13 04:25:09 ben kernel: drbd2: conn( Unconnected -> WFConnection )=20
May 13 04:25:11 ben kernel: drbd2: conn( WFConnection -> WFReportParams
)=20
May 13 04:25:12 ben kernel: drbd2: aftr_isp( 0 -> 1 )=20
May 13 04:25:12 ben kernel: drbd2: expected HandShake packet, received:
ReportState (0x000e)
May 13 04:25:12 ben kernel: drbd2: Discarding network configuration.
May 13 04:25:12 ben kernel: drbd2: conn( WFReportParams -> Disconnecting
)=20
May 13 04:25:12 ben kernel: drbd2: tl_clear()
May 13 04:25:12 ben kernel: drbd2: Connection closed

Here's what I think the sequence is:

1. We start connecting drbd2 - we get to the point of having the data
connection
   up but have not done the handshake yet - state is now WFReportParams.
2. DRBD0 thread decides it needs to pause the sync of drbd2 - calls=20
   _drbd_pause_after - this sets the aftr_isp flag amd THIS causes the
ReportState
   to be sent
3. Now we come back to the original thread and start the handshake which
fails=20
   because of the ReportState message that was sent that is sitting in
the pipe.

I think the fix is to check that (ns.conn is >=3D Connected) in
after_state_ch before sending the current state. I haven't tested this
yet, but I've attached a proposed patch that does this for the two cases
I can see where this might be an issue...

Simon


------_=_NextPart_001_01C799B0.D59D0782
Content-Type: application/octet-stream;
	name="drbd-2311.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-2311.patch
Content-Disposition: attachment;
	filename="drbd-2311.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNyYy9kcmJkL2RyYmRf
bWFpbi5jCShyZXZpc2lvbiAxNDI3MSkKKysrIHNyYy9kcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5n
IGNvcHkpCkBAIC05MzUsMTUgKzkzNSwxNiBAQAogCX0KIAogCS8qIExhc3QgcGFydCBvZiB0aGUg
YXR0YWNoaW5nIHByb2Nlc3MgLi4uICovCi0JaWYgKCBvcy5kaXNrID09IEF0dGFjaGluZyAmJiBu
cy5kaXNrID09IE5lZ290aWF0aW5nICkgeworCWlmICggbnMuY29ubiA+PSBDb25uZWN0ZWQgJiYg
b3MuZGlzayA9PSBBdHRhY2hpbmcgJiYgbnMuZGlzayA9PSBOZWdvdGlhdGluZyApIHsKIAkJZHJi
ZF9zZW5kX3NpemVzKG1kZXYpOyAgLy8gdG8gc3RhcnQgc3luYy4uLgogCQlkcmJkX3NlbmRfdXVp
ZHMobWRldik7CiAJCWRyYmRfc2VuZF9zdGF0ZShtZGV2KTsKIAl9CiAKIAkvKiBXZSB3YW50IHRv
IHBhdXNlL2NvbnRpbnVlIHJlc3luYywgdGVsbCBwZWVyLiAqLwotCWlmICggICggb3MuYWZ0cl9p
c3AgIT0gbnMuYWZ0cl9pc3AgKSB8fAotCSAgICAgICggb3MudXNlcl9pc3AgIT0gbnMudXNlcl9p
c3AgKSApIHsKKwlpZiAoICBvcy5jb25uID49IENvbm5lY3RlZCAmJgorCSAgICAgICgoIG9zLmFm
dHJfaXNwICE9IG5zLmFmdHJfaXNwICkgfHwKKwkgICAgICAgKCBvcy51c2VyX2lzcCAhPSBucy51
c2VyX2lzcCApICAgKSkgewogCQlkcmJkX3NlbmRfc3RhdGUobWRldik7CiAJfQogCg==

------_=_NextPart_001_01C799B0.D59D0782--
