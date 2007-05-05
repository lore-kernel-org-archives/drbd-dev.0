Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C78EAC.AC302028"
Subject: RE: [Drbd-dev] Panic in _drbd_send_page() again.
Date: Fri, 4 May 2007 20:31:07 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105636A25@EXNA.corp.stratus.com>
In-Reply-To: 20070505001416.GA11793@nudl
References: <342BAC0A5467384983B586A6B0B376710563693E@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B37671056369DA@EXNA.corp.s
	tratus.com> 20070505001416.GA11793@nudl
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C78EAC.AC302028
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> but I don't think we can get rid of RQ_NET_SENT _that_ easy.

OK - you obviously know this stuff better than me!

I do still think that with this change we can remove the checks for
RQ_NET_SENT before calling req_may_be_done which I like because it moves
all the 'may be done' processing inside that function...

So - how about the attached...
/simgr


------_=_NextPart_001_01C78EAC.AC302028
Content-Type: application/octet-stream;
	name="net-queued.patch"
Content-Transfer-Encoding: base64
Content-Description: net-queued.patch
Content-Disposition: attachment;
	filename="net-queued.patch"

SW5kZXg6IGRyYmRfcmVxLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZF9yZXEuYwkocmV2aXNpb24gMTM1
NjMpCisrKyBkcmJkX3JlcS5jCSh3b3JraW5nIGNvcHkpCkBAIC0yNTUsNiArMjU1LDcgQEAKIAlw
cmludF9ycV9zdGF0ZShyZXEsICJfcmVxX21heV9iZV9kb25lIik7CiAJTVVTVF9IT0xEKCZtZGV2
LT5yZXFfbG9jaykKIAorCWlmIChzICYgUlFfTkVUX1FVRVVFRCkgcmV0dXJuOwogCWlmIChzICYg
UlFfTkVUX1BFTkRJTkcpIHJldHVybjsKIAlpZiAocyAmIFJRX0xPQ0FMX1BFTkRJTkcpIHJldHVy
bjsKIApAQCAtNjM4LDExICs2MzksNyBAQAogCQlpZiAocmVxLT5ycV9zdGF0ZSAmIFJRX05FVF9Q
RU5ESU5HKSBkZWNfYXBfcGVuZGluZyhtZGV2KTsKIAkJcmVxLT5ycV9zdGF0ZSAmPSB+KFJRX05F
VF9PS3xSUV9ORVRfUEVORElORyk7CiAJCXJlcS0+cnFfc3RhdGUgfD0gUlFfTkVUX0RPTkU7Ci0J
CS8qIGlmIGl0IGlzIHN0aWxsIHF1ZXVlZCwgd2UgbWF5IG5vdCBjb21wbGV0ZSBpdCBoZXJlLgot
CQkgKiBpdCB3aWxsIGJlIGNhbmNlbGVkIHNvb24uCi0JCSAqIEZJWE1FIHdlIHNob3VsZCBjaGFu
Z2UgdGhlIGNvZGUgc28gdGhpcyBjYW4gbm90IGhhcHBlbi4gKi8KLQkJaWYgKCEocmVxLT5ycV9z
dGF0ZSAmIFJRX05FVF9RVUVVRUQpKQotCQkJX3JlcV9tYXlfYmVfZG9uZShyZXEsZXJyb3IpOwor
CQlfcmVxX21heV9iZV9kb25lKHJlcSxlcnJvcik7CiAJCWJyZWFrOwogCiAJY2FzZSB3cml0ZV9h
Y2tlZF9ieV9wZWVyX2FuZF9zaXM6CkBAIC02NjIsOSArNjU5LDcgQEAKIAkJRF9BU1NFUlQocmVx
LT5ycV9zdGF0ZSAmIFJRX05FVF9QRU5ESU5HKTsKIAkJZGVjX2FwX3BlbmRpbmcobWRldik7CiAJ
CXJlcS0+cnFfc3RhdGUgJj0gflJRX05FVF9QRU5ESU5HOwotCQlpZiAocmVxLT5ycV9zdGF0ZSAm
IFJRX05FVF9TRU5UKQotCQkJX3JlcV9tYXlfYmVfZG9uZShyZXEsZXJyb3IpOwotCQkvKiBlbHNl
OiBkb25lIGJ5IGhhbmRlZF9vdmVyX3RvX25ldHdvcmsgKi8KKwkJX3JlcV9tYXlfYmVfZG9uZShy
ZXEsZXJyb3IpOwogCQlicmVhazsKIAogCWNhc2UgbmVnX2Fja2VkOgpAQCAtNjczLDkgKzY2OCw3
IEBACiAJCXJlcS0+cnFfc3RhdGUgJj0gfihSUV9ORVRfT0t8UlFfTkVUX1BFTkRJTkcpOwogCQkv
KiBGSVhNRSBUSElOSyEgaXMgaXQgRE9ORSBub3csIG9yIGlzIGl0IG5vdD8gKi8KIAkJcmVxLT5y
cV9zdGF0ZSB8PSBSUV9ORVRfRE9ORTsKLQkJaWYgKHJlcS0+cnFfc3RhdGUgJiBSUV9ORVRfU0VO
VCkKLQkJCV9yZXFfbWF5X2JlX2RvbmUocmVxLGVycm9yKTsKLQkJLyogZWxzZTogZG9uZSBieSBo
YW5kZWRfb3Zlcl90b19uZXR3b3JrICovCisJCV9yZXFfbWF5X2JlX2RvbmUocmVxLGVycm9yKTsK
IAkJYnJlYWs7CiAKIAljYXNlIGJhcnJpZXJfYWNrZWQ6CkBAIC03MTQsMTEgKzcwNyw3IEBACiAJ
CWRlY19hcF9wZW5kaW5nKG1kZXYpOwogCQlyZXEtPnJxX3N0YXRlICY9IH5SUV9ORVRfUEVORElO
RzsKIAkJcmVxLT5ycV9zdGF0ZSB8PSAoUlFfTkVUX09LfFJRX05FVF9ET05FKTsKLQkJLyogY2Fu
IGl0IGhhcHBlbiB0aGF0IHdlIHJlY2VpdmUgdGhlIERhdGFSZXBseQotCQkgKiBiZWZvcmUgdGhl
IHNlbmQgRGF0YVJlcXVlc3QgZnVuY3Rpb24gcmV0dXJucz8gKi8KLQkJaWYgKHJlcS0+cnFfc3Rh
dGUgJiBSUV9ORVRfU0VOVCkKLQkJCV9yZXFfbWF5X2JlX2RvbmUocmVxLGVycm9yKTsKLQkJLyog
ZWxzZTogZG9uZSBieSBoYW5kZWRfb3Zlcl90b19uZXR3b3JrICovCisJCV9yZXFfbWF5X2JlX2Rv
bmUocmVxLGVycm9yKTsKIAkJYnJlYWs7CiAJfTsKIH0K

------_=_NextPart_001_01C78EAC.AC302028--
