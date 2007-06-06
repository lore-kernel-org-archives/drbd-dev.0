Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7A888.03D6959F"
Subject: RE: [Drbd-dev] Resync Stalls at 100% patch problem
Date: Wed, 6 Jun 2007 18:14:13 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47923@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47921@EXNA.corp.stratus.com>
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

------_=_NextPart_001_01C7A888.03D6959F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Phil,
I looked into the patch issue a bit more.=20
This problem happens if we acquire the req_lock early.  What I think is
going on is this:

Primary host ---->attach---> send_state()
Peer -----> receive_state()-->after_state_ch()-->send_bitmap()
Primary Host ---->receive_bitmap()***Unexpected cstate "Connected"
Peer ----> send_state()
Primary Host --->receive_state() and we are deadlock.

The primary host is receiving the bitmap too early.  Essentially the
peer should call send_state() before calling after_state_ch()

I noticed the patch had moved that logic after calling after_state_ch()
so moving it back before after_state_ch() should be OK.  Any reason why
it was moved down?

I tested the included patch that moved just before we call
after_state_ch().
Let me know.

Thanks.

EM--


-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Montrose, Ernest
Sent: Tuesday, June 05, 2007 6:50 PM
To: Philipp Reisner; drbd-dev@linbit.com
Subject: [Drbd-dev] Resync Stalls at 100% patch problem

Phil,
Unfortunately it seems like the patch for receive_state() in
drbd_receive.c has a problem.  Acquiring the req_lock at the top of this
routine causes the cstate machine to get confused.  To reproduce this
just do:
Drbdadm detach d0;sleep 3;drbdadm attach d0 for instance. One side ends
up WBTmpT and the other WbitmapS and deadlock.  I am researching more
but wanted to let you.  If I just remove the early lock then things are
OK..:(

EM--
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev


------_=_NextPart_001_01C7A888.03D6959F
Content-Type: application/octet-stream;
	name="sync_100.patch"
Content-Transfer-Encoding: base64
Content-Description: sync_100.patch
Content-Disposition: attachment;
	filename="sync_100.patch"

SW5kZXg6IGRyYmRfcmVjZWl2ZXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkX3JlY2VpdmVyLmMJKHJl
dmlzaW9uIDE0OTIzKQorKysgZHJiZF9yZWNlaXZlci5jCSh3b3JraW5nIGNvcHkpCkBAIC0yNDMx
LDcgKzI0MzEsMTggQEAKIAlydiA9IF9kcmJkX3NldF9zdGF0ZShtZGV2LG5zLENoZ1N0YXRlVmVy
Ym9zZSB8IENoZ1N0YXRlSGFyZCk7CiAJc3Bpbl91bmxvY2tfaXJxKCZtZGV2LT5yZXFfbG9jayk7
CiAJaWYgKHJ2PT1TU19TdWNjZXNzKSB7Ci0JCWFmdGVyX3N0YXRlX2NoKG1kZXYsb3MsbnMsQ2hn
U3RhdGVWZXJib3NlIHwgQ2hnU3RhdGVIYXJkKTsKKyAgICAgICAgICBpZiAob2Nvbm4gPiBXRlJl
cG9ydFBhcmFtcyApIHsKKyAgICAgICAgICAgICBpZiggbmNvbm4gPiBDb25uZWN0ZWQgJiYgcGVl
cl9zdGF0ZS5jb25uIDw9IENvbm5lY3RlZCkgeworICAgICAgICAgICAgICAgIC8vIHdlIHdhbnQg
cmVzeW5jLCBwZWVyIGhhcyBub3QgeWV0IGRlY2lkZWQgdG8gc3luYy4uLgorICAgICAgICAgICAg
ICAgIGRyYmRfc2VuZF91dWlkcyhtZGV2KTsKKyAgICAgICAgICAgICAgICBkcmJkX3NlbmRfc3Rh
dGUobWRldik7CisgICAgICAgICAgICAgfQorICAgICAgICAgICAgIGVsc2UgaWYgKG5jb25uID09
IENvbm5lY3RlZCAmJiBwZWVyX3N0YXRlLmRpc2sgPT0gTmVnb3RpYXRpbmcpIHsKKyAgICAgICAg
ICAgICAgICAvLyBwZWVyIGlzIHdhaXRpbmcgZm9yIHVzIHRvIHJlc3BvbmQuLi4KKyAgICAgICAg
ICAgICAgICBkcmJkX3NlbmRfc3RhdGUobWRldik7CisgICAgICAgICAgICAgfQorICAgICAgICAg
IH0KKyAgICAgICAgICBhZnRlcl9zdGF0ZV9jaChtZGV2LG9zLG5zLENoZ1N0YXRlVmVyYm9zZSB8
IENoZ1N0YXRlSGFyZCk7CiAJfQogCiAJaWYocnYgPCBTU19TdWNjZXNzKSB7CkBAIC0yNDM5LDE4
ICsyNDUwLDYgQEAKIAkJcmV0dXJuIEZBTFNFOwogCX0KIAotCWlmIChvY29ubiA+IFdGUmVwb3J0
UGFyYW1zICkgewotCQlpZiggbmNvbm4gPiBDb25uZWN0ZWQgJiYgcGVlcl9zdGF0ZS5jb25uIDw9
IENvbm5lY3RlZCkgewotCQkJLy8gd2Ugd2FudCByZXN5bmMsIHBlZXIgaGFzIG5vdCB5ZXQgZGVj
aWRlZCB0byBzeW5jLi4uCi0JCQlkcmJkX3NlbmRfdXVpZHMobWRldik7Ci0JCQlkcmJkX3NlbmRf
c3RhdGUobWRldik7Ci0JCX0KLQkJZWxzZSBpZiAobmNvbm4gPT0gQ29ubmVjdGVkICYmIHBlZXJf
c3RhdGUuZGlzayA9PSBOZWdvdGlhdGluZykgewotCQkJLy8gcGVlciBpcyB3YWl0aW5nIGZvciB1
cyB0byByZXNwb25kLi4uCi0JCQlkcmJkX3NlbmRfc3RhdGUobWRldik7Ci0JCX0KLQl9Ci0KIAlt
ZGV2LT5uZXRfY29uZi0+d2FudF9sb3NlID0gMDsKIAogCS8qIEZJWE1FIGFzc2VydGlvbiBmb3Ig
KGdlbmNvdW50cyBkbyBub3QgZGl2ZXJnZSkgKi8K

------_=_NextPart_001_01C7A888.03D6959F--
