Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6D905.AE405783"
Date: Fri, 15 Sep 2006 16:29:42 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D3D5E@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6D905.AE405783
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I took the latest update today and found that when I did detach/attach,
the side attaching would never exit the Negotiating state - the other
side updated it's view of the peer correctly, but it never sent anything
back to the originating side to make it go from Negotiating to UpToDate
- I _think_ the expected thing here is to send back a ReportState
message when we are Connected _and_ the peer says its Negotiating --
patch attached that seems to work...

Simon



------_=_NextPart_001_01C6D905.AE405783
Content-Type: application/octet-stream;
	name="connpatch.patch"
Content-Transfer-Encoding: base64
Content-Description: connpatch.patch
Content-Disposition: attachment;
	filename="connpatch.patch"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9yZWNl
aXZlci5jCShyZXZpc2lvbiA0MDYzKQorKysgZHJiZC9kcmJkX3JlY2VpdmVyLmMJKHdvcmtpbmcg
Y29weSkKQEAgLTIxNjcsNiArMjE3MSwxMCBAQAogCQkJZHJiZF9zZW5kX3N0YXRlKG1kZXYpOwog
CQl9CiAJfQorCWVsc2UgaWYgKG5jb25uID09IENvbm5lY3RlZCAmJiBucy5kaXNrID09IE5lZ290
aWF0aW5nKSB7CisJCS8vIHBlZXIgaXMgd2FpdGluZyBmb3IgdXMgdG8gcmVzcG9uZC4uLgorCQlk
cmJkX3NlbmRfc3RhdGUobWRldik7CisJfQogCiAJc3Bpbl9sb2NrX2lycSgmbWRldi0+cmVxX2xv
Y2spOwogCW9zID0gbWRldi0+c3RhdGU7Cg==

------_=_NextPart_001_01C6D905.AE405783--
