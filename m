Return-Path: <i.galic@brainsware.org>
Received: from mail.brainsware.org (mail.brainsware.org [188.40.115.121])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BC4741013809
	for <drbd-dev@lists.linbit.com>; Tue,  4 Sep 2012 00:38:09 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.brainsware.org (Postfix) with ESMTP id 084A028829A
	for <drbd-dev@lists.linbit.com>; Mon,  3 Sep 2012 22:30:08 +0000 (UTC)
Received: from mail.brainsware.org ([127.0.0.1])
	by localhost (mail.brainsware.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XeWLIsmbgBM7 for <drbd-dev@lists.linbit.com>;
	Mon,  3 Sep 2012 22:30:05 +0000 (UTC)
Received: from mail.brainsware.org (mail.brainsware.org [188.40.115.121])
	by mail.brainsware.org (Postfix) with ESMTP id EADA0288286
	for <drbd-dev@lists.linbit.com>; Mon,  3 Sep 2012 22:30:05 +0000 (UTC)
Date: Mon, 03 Sep 2012 22:30:05 -0000 (UTC)
From: Igor =?utf-8?Q?Gali=C4=87?= <i.galic@brainsware.org>
To: drbd-dev@lists.linbit.com
Message-ID: <0bfc9d31-6d7e-4cf2-9319-d463d4b927e2@iris>
In-Reply-To: <70652293-fdab-49a4-add0-a2890e30f216@iris>
Content-Type: multipart/mixed;
	boundary="=_7324fb1e-4920-4de7-ae0e-d8955c0726f7"
MIME-Version: 1.0
Subject: [Drbd-dev] [PATCH]: Creating a three-node setup
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--=_7324fb1e-4920-4de7-ae0e-d8955c0726f7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Here's a small patch to the users guide:

Consistently refer to the nodes as +alice+, +bob+ and
+charlie+ when telling users where to execute commands.


So long,

i

--
Igor Gali=C4=87

Tel: +43 (0) 664 886 22 883
Mail: i.galic@brainsware.org
URL: http://brainsware.org/
GPG: 6880 4155 74BD FD7C B515  2EA5 4B1D 9E08 A097 C9AE


--=_7324fb1e-4920-4de7-ae0e-d8955c0726f7
Content-Type: text/x-patch; name=s-three-nodes.patch
Content-Disposition: attachment; filename=s-three-nodes.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCB1c2Vycy1ndWlkZS9hZG1pbmlzdHJhdGlvbi50eHQgdXNlcnMtZ3VpZGUvYWRt
aW5pc3RyYXRpb24udHh0CmluZGV4IGNkM2QyMWYuLjg2YWMzYzkgMTAwNjQ0Ci0tLSB1c2Vycy1n
dWlkZS9hZG1pbmlzdHJhdGlvbi50eHQKKysrIHVzZXJzLWd1aWRlL2FkbWluaXN0cmF0aW9uLnR4
dApAQCAtMTYyMiw3ICsxNjIyLDcgQEAgZGVwZW5kaW5nIG9uIHlvdXIgYXBwbGljYXRpb24uCiA9
PT09IEVuYWJsaW5nIHN0YWNrZWQgcmVzb3VyY2VzCiAKIFRvIGVuYWJsZSBhIHN0YWNrZWQgcmVz
b3VyY2UsIHlvdSBmaXJzdCBlbmFibGUgaXRzIGxvd2VyLWxldmVsCi1yZXNvdXJjZSBhbmQgcHJv
bW90ZSBpdDoKK3Jlc291cmNlIGFuZCBwcm9tb3RlIGl0IG9uICthbGljZSsgYW5kICtib2IrOgog
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZHJiZGFkbSB1cCByMAogZHJiZGFkbSBwcmlt
YXJ5IHIwCkBAIC0xNjM1LDE1ICsxNjM1LDE1IEBAIHN0YWNrZWQgcmVzb3VyY2VzLiBUaGlzIGlz
IGRvbmUgdXNpbmcgdGhlIGZvbGxvd2luZyBjb21tYW5kOgogIyBkcmJkYWRtIGNyZWF0ZS1tZCAt
LXN0YWNrZWQgcjAtVQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1UaGVuLCB5b3Ug
bWF5IGVuYWJsZSB0aGUgc3RhY2tlZCByZXNvdXJjZToKK1RoZW4sIHlvdSBtYXkgZW5hYmxlIHRo
ZSBzdGFja2VkIHJlc291cmNlIG9uICthbGljZSsgYW5kICtib2IrOgogCiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KICMgZHJiZGFkbSB1cCAtLXN0YWNrZWQgcjAtVQogIyBkcmJkYWRtIHBy
aW1hcnkgLS1zdGFja2VkIHIwLVUKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotQWZ0
ZXIgdGhpcywgeW91IG1heSBicmluZyB1cCB0aGUgcmVzb3VyY2Ugb24gdGhlIGJhY2t1cCBub2Rl
LCBlbmFibGluZwotdGhyZWUtbm9kZSByZXBsaWNhdGlvbjoKK0FmdGVyIHRoaXMsIHlvdSBtYXkg
YnJpbmcgdXAgdGhlIHJlc291cmNlIG9uIHRoZSBiYWNrdXAgbm9kZSwgK2NoYXJsaWUrLAorZW5h
YmxpbmcgdGhyZWUtbm9kZSByZXBsaWNhdGlvbjoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQogIyBkcmJkYWRtIGNyZWF0ZS1tZCByMC1VCg==

--=_7324fb1e-4920-4de7-ae0e-d8955c0726f7--
