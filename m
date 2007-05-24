Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C79E00.E8296FEE"
Date: Thu, 24 May 2007 08:41:53 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47908@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47906@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Resync stalled at 100% due to race condition
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79E00.E8296FEE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing a problem where a resync hangs on the SyncSource at the
end.  The SyncTarget finished OK and shows Connected. The signature on
the SyncSource is:
=20
 ns:364900 nr:13389364 dw:13754324 dr:800327 al:165 bm:959 lo:0 pe:0
ua:0 ap:0
    [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>] =
sync'ed:100.0% (0/0)K
    stalled

What I think is happening is that there is a race condition where
drbd_resync_finished() races receive_state() in this manner:
1)  The resync finished on drbd0 and we enter drbd_resync_finished().
But before it can set the stated to Connected, drbd15 which is a higher
priority device starts syncing. This puts drbd0 in PausedSyncS from
SyncSource.
=20
2) Drbd_resync_finished() for drbd0 now tries to go to Connected from
PausedSyncS.  The logs below prints this transition but the transition
was not actually commited since we print before we actually assign the
new values.=20
=20
3) At this precise moment, another thread calls receive_state().
Receive_state() is entered with a state of "PausedSyncS".  It skips the
drbd_sync_handshake() because of that.  However, before reaching the end
of receive_state() the drbd0 state change from drbd_request_finished()
is commited for real. So the state is Connected for drbd0.
=20
4) By the time receive_state calls _drbd_set_state()  we have
os=3DConnected and ns=3DPausedSyncS because receive_state() had cached =
the
state in nconn early without the req_lock held.  The mdev value had
changed while the cached value is being used.=20
=20
5) drbd0 now transitions from Connected to PausedSyncS.
=20
6) Because of 5 above we transition from PausedSyncS to SyncSource but
the other side is connected and Uptodate ...So we're stuck.
=20
I think this is the result of receive_state() being a bit racy.  I
include a patch that may at least help illustrate the issue if not fix
it as I am not sure the req_lock can be held this early without causing
a deadlock or other perfomance issues.
=20
Here are the logs for completeness:
=20
So on syncsource:
May  8 03:50:12 bruce kernel: drbd0: Began resync as SyncSource (will
sync 840 KB [210 bits set]).
May  8 03:50:12 bruce kernel: drbd0: Writing meta data super block now.
May  8 03:50:13 bruce kernel: drbd0: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
May  8 03:50:13 bruce kernel: drbd0: Resync suspended
May  8 03:50:13 bruce kernel: drbd0: Resync done (total 1 sec; paused 0
sec; 840 K/sec)
May  8 03:50:13 bruce kernel: drbd0:  uuid[History_start] now
1DCA5DA245F96038
May  8 03:50:13 bruce kernel: drbd0:  uuid[Bitmap] now 0000000000000000
May  8 03:50:13 bruce kernel: drbd0: conn( PausedSyncS -> Connected )
pdsk( Inconsistent -> UpToDate )
May  8 03:50:13 bruce kernel: drbd0: conn( Connected -> PausedSyncS )
peer_isp( 0 -> 1 )
May  8 03:50:13 bruce kernel: drbd0: Writing meta data super block now.
May  8 03:50:13 bruce kernel: drbd0: peer_isp( 1 -> 0 )
May  8 03:50:13 bruce kernel: drbd0: conn( PausedSyncS -> SyncSource )
aftr_isp( 1 -> 0 )
May  8 03:50:13 bruce kernel: drbd0: Syncer continues.


On the syncTarget:
May  8 03:50:13 dick kernel: drbd0: conn( WFSyncUUID -> SyncTarget )
disk( UpToDate -> Inconsistent )
May  8 03:50:13 dick kernel: drbd0: Began resync as SyncTarget (will
sync 840 KB [210 bits set]).
May  8 03:50:13 dick kernel: drbd0: Writing meta data super block now.
May  8 03:50:14 dick kernel: drbd0: Resync done (total 1 sec; paused 0
sec; 840 K/sec)
May  8 03:50:14 dick kernel: drbd0:  uuid[Bitmap] now A10989D4FAD4C4BB
May  8 03:50:14 dick kernel: drbd0:  uuid[History_start] now
B2E9873EF8AC35CB
May  8 03:50:14 dick kernel: drbd0:  uuid[History_end] now
161E8961AB2B5473
May  8 03:50:14 dick kernel: drbd0:  uuid[History_start] now
A10989D4FAD4C4BB
May  8 03:50:14 dick kernel: drbd0:  uuid[Bitmap] now 1DCA5DA245F96038
May  8 03:50:14 dick kernel: drbd0:  uuid[Current] now 8B19AE5BFEDF83D4
May  8 03:50:14 dick kernel: drbd0:  uuid[History_start] now
1DCA5DA245F96038
May  8 03:50:14 dick kernel: drbd0:  uuid[Bitmap] now 0000000000000000
May  8 03:50:14 dick kernel: drbd0: conn( SyncTarget -> Connected )
disk( Inconsistent -> UpToDate )
May  8 03:50:14 dick kernel: drbd0: Writing meta data super block now.

EM--

------_=_NextPart_001_01C79E00.E8296FEE
Content-Type: application/octet-stream;
	name="resync_hangs_2290.patch"
Content-Transfer-Encoding: base64
Content-Description: resync_hangs_2290.patch
Content-Disposition: attachment;
	filename="resync_hangs_2290.patch"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9yZWNl
aXZlci5jCShyZXZpc2lvbiAxNDM4NykKKysrIGRyYmQvZHJiZF9yZWNlaXZlci5jCSh3b3JraW5n
IGNvcHkpCkBAIC0yMzk4LDYgKzIzOTgsOCBAQAogCWlmIChkcmJkX3JlY3YobWRldiwgaC0+cGF5
bG9hZCwgaC0+bGVuZ3RoKSAhPSBoLT5sZW5ndGgpCiAJCXJldHVybiBGQUxTRTsKIAorICAgICAg
IHNwaW5fbG9ja19pcnEoJm1kZXYtPnJlcV9sb2NrKTsKKyAgIAogCW5jb25uID0gbWRldi0+c3Rh
dGUuY29ubjsKIAlpZiAobmNvbm4gPT0gV0ZSZXBvcnRQYXJhbXMgKSBuY29ubiA9IENvbm5lY3Rl
ZDsKIApAQCAtMjQwOSw3ICsyNDExLDExIEBACiAJCW5jb25uPWRyYmRfc3luY19oYW5kc2hha2Uo
bWRldixwZWVyX3N0YXRlLnJvbGUscGVlcl9zdGF0ZS5kaXNrKTsKIAkJZGVjX2xvY2FsKG1kZXYp
OwogCi0JCWlmKG5jb25uID09IGNvbm5fbWFzaykgcmV0dXJuIEZBTFNFOworCQlpZihuY29ubiA9
PSBjb25uX21hc2spIHsKKyAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxKCZtZGV2LT5y
ZXFfbG9jayk7CisgICAgICAgICAgICAgICAgIHJldHVybiBGQUxTRTsKKyAgICAgICAgICAgICAg
fQorICAgICAgICAgICAgICAKIAl9CiAKIAlpZiAobWRldi0+c3RhdGUuY29ubiA+IFdGUmVwb3J0
UGFyYW1zICkgewpAQCAtMjQyNCw3ICsyNDMwLDYgQEAKIAkJfQogCX0KIAotCXNwaW5fbG9ja19p
cnEoJm1kZXYtPnJlcV9sb2NrKTsKIAlvcyA9IG1kZXYtPnN0YXRlOwogCW5zLmkgPSBtZGV2LT5z
dGF0ZS5pOwogCW5zLmNvbm4gPSBuY29ubjsK

------_=_NextPart_001_01C79E00.E8296FEE--
