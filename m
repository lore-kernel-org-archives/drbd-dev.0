Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8654A.C60D5684"
Date: Fri, 1 Feb 2008 22:21:59 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671080C9554@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] ordering problem between StateChangeRequest and
	send_state
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8654A.C60D5684
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have seen a problem where if resync is paused and resumed and then =
completed quickly, the sync target node correctly transitions to =
UptoDate but the other ends up Inconsistent. I believe this is a =
reordering issue caused by an interaction between drbd_send_state_req =
and drbd_send_state as follows (with the resync starting off in the =
paused state):

1. We resumed syncing and set aftr_isp->0 -- this schedules a work item =
to report the change
=A0  to the peer.

2. Syncing completes on an other thread, drbd_send_state_req is called =
inline to send the
 =A0 new state to the peer with a StateChgRequest, BUT the mdev state is =
not updated yet.=20
=A0  This code then waits for a response from the peer... when the peer =
gets this, it updates
   it's state immediately (to Consistent) and sends the response.

3. Now the after state change starts running and does a send-state call =
which grabs
 =A0 the current state from the device (which is still inconsistent) and =
sends this. When
=A0  the peer gets this, it will change from UpToDate->Inconsistent.

4. Finally, we get the response to the StateChgRequest and change the =
state to UpToDate on
 =A0 the sync target - no further state change is sent because =
transition to UpToDate doesn't
=A0  generate one.

My suggested fix is to use the existing drbd_state_lock - this is =
already used in drbd_send_state_req, my suggestion is to also grab it in =
drbd_send_state so that we don't attempt to send ReportState if a state =
change rq is already in progress.

I've attached a proposed patch that implements this suggestion BUT this =
is based on an earlier patch of ours that splits drbd_send_state into =
two routines and acquires the send mutex - the one titled "Ensure that =
state updated cannot be done out of order whilst running receive_state =
(914435c)".

Simon

------_=_NextPart_001_01C8654A.C60D5684
Content-Type: application/octet-stream;
	name="0001-Make-sure-we-dont-send-state-if-a-cluster-wide-state.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Make-sure-we-dont-send-state-if-a-cluster-wide-state.patch
Content-Disposition: attachment;
	filename="0001-Make-sure-we-dont-send-state-if-a-cluster-wide-state.patch"

RnJvbSBmMzgwYmM0MzVkMjQwZDAxZmYzNjBjOWJlNjZjMzdhODZmNTRiN2QwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBQLiBHcmFoYW0gPFNpbW9uLkdyYWhhbUBzdHJhdHVz
LmNvbT4KRGF0ZTogV2VkLCAzMCBKYW4gMjAwOCAyMzozNjo0MyAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIE1ha2Ugc3VyZSB3ZSBkb250IHNlbmQgc3RhdGUgaWYgYSBjbHVzdGVyIHdpZGUgc3RhdGUg
Y2hhbmdlIGlzIGluIHByb2dyZXNzCgotLS0KIGRyYmQvZHJiZF9tYWluLmMgfCAgICA1ICsrKysr
CiAxIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcmJkL2RyYmRfbWFpbi5jIGIvZHJiZC9kcmJkX21haW4uYwppbmRleCBkNTg5YmZm
Li41NTQxYjA1IDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfbWFpbi5jCisrKyBiL2RyYmQvZHJiZF9t
YWluLmMKQEAgLTE0NDAsMTAgKzE0NDAsMTUgQEAgaW50IGRyYmRfc2VuZF9zdGF0ZShkcmJkX2Rl
diAqbWRldikKIHsKIAlpbnQgb2s7CiAKKwkvKiBHcmFiIHN0YXRlIGxvY2sgc28gd2Ugd29udCBz
ZW5kIHN0YXRlIGlmIHdlJ3JlIGluIHRoZSBtaWRkbGUKKwkgKiBvZiBhIGNsdXN0ZXIgd2lkZSBz
dGF0ZSBjaGFuZ2Ugb24gYW5vdGhlciB0aHJlYWQgKi8KKwlkcmJkX3N0YXRlX2xvY2sobWRldik7
CisKIAlkb3duKCZtZGV2LT5kYXRhLm11dGV4KTsKIAlvayA9IF9kcmJkX3NlbmRfc3RhdGUobWRl
dik7CiAJdXAoJm1kZXYtPmRhdGEubXV0ZXgpOwogCisJZHJiZF9zdGF0ZV91bmxvY2sobWRldik7
CiAJcmV0dXJuIG9rOwogfQogCi0tIAoxLjUuNC5yYzEKCg==

------_=_NextPart_001_01C8654A.C60D5684--
