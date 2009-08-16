Return-Path: <gui@moolfreet.com>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 77D291012848
	for <drbd-dev@lists.linbit.com>; Sun, 16 Aug 2009 18:08:05 +0200 (CEST)
Received: by ywh17 with SMTP id 17so3378991ywh.3
	for <drbd-dev@lists.linbit.com>; Sun, 16 Aug 2009 09:08:05 -0700 (PDT)
MIME-Version: 1.0
From: Guillaume Plessis <gui@moolfreet.com>
Date: Sun, 16 Aug 2009 18:00:21 +0200
Message-ID: <479b87b70908160900ue855e71l8212d7f6936064c4@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary=0016e644ce6e190ff10471446371
Subject: [Drbd-dev] Patch for an up-to-date script/patch-kernel
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--0016e644ce6e190ff10471446371
Content-Type: multipart/alternative; boundary=0016e644ce6e190fe6047144636f

--0016e644ce6e190fe6047144636f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello DRBD-devs,
I encountered problems building a DRBD 8.3.2 patch with a 2.6.30.4 kernel
(missing lru_cache.h, drbd_vli.h, drbd_tracing.c and drbd_tracing.h).

You'll find as attachement a patch that fixes the patch-building process by
filling "include_linux" and "drbd_source" with the good values.

I hope it will be useful.

Keep up the good work.

--
Guillaume Plessis

--0016e644ce6e190fe6047144636f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello DRBD-devs,<div><br></div><div>I encountered problems building a DRBD =
8.3.2 patch with a 2.6.30.4 kernel (missing=C2=A0lru_cache.h,=C2=A0drbd_vli=
.h, drbd_tracing.c and drbd_tracing.h).</div><div><br></div><div>You&#39;ll=
 find as attachement a patch that fixes the patch-building process by filli=
ng &quot;include_linux&quot; and &quot;drbd_source&quot; with the good valu=
es.</div>

<div><br></div><div>I hope it will be useful.</div><div><br></div><div>Keep=
 up the good work.</div><div><br clear=3D"all">--<br>Guillaume Plessis<br><=
br>
</div>

--0016e644ce6e190fe6047144636f--

--0016e644ce6e190ff10471446371
Content-Type: application/octet-stream; name="83-patch-kernel_fix.patch"
Content-Disposition: attachment; filename="83-patch-kernel_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyfyqeqh0

ZGlmZiAtdXJOIGRyYmQtOC4zLjIub3JpZy9zY3JpcHRzL3BhdGNoLWtlcm5lbCBkcmJkLTguMy4y
L3NjcmlwdHMvcGF0Y2gta2VybmVsCi0tLSBkcmJkLTguMy4yLm9yaWcvc2NyaXB0cy9wYXRjaC1r
ZXJuZWwJMjAwOS0wNi0wOSAxMTozMzowMy4wMDAwMDAwMDAgKzAwMDAKKysrIGRyYmQtOC4zLjIv
c2NyaXB0cy9wYXRjaC1rZXJuZWwJMjAwOS0wOC0xNiAxNDoyMjoyNS4wMDAwMDAwMDAgKzAwMDAK
QEAgLTkwLDExICs5MCwxMSBAQAogIwogIyBQdWxsIGluIHRoZSBiYXNlIGRyYmQgc291cmNlCiAj
Ci1pbmNsdWRlX2xpbnV4PSJkcmJkLmggZHJiZF9saW1pdHMuaCBkcmJkX25sLmggZHJiZF90YWdf
bWFnaWMuaCIKK2luY2x1ZGVfbGludXg9ImRyYmQuaCBkcmJkX2xpbWl0cy5oIGRyYmRfbmwuaCBk
cmJkX3RhZ19tYWdpYy5oIGxydV9jYWNoZS5oIgogZHJiZF9zb3VyY2U9ImRyYmRfYWN0bG9nLmMg
ZHJiZF9iaXRtYXAuYyBkcmJkX2J1aWxkdGFnLmMKIAlkcmJkX3dyYXBwZXJzLmggZHJiZF9pbnQu
aCBkcmJkX21haW4uYyBkcmJkX25sLmMgZHJiZF9wcm9jLmMKIAlkcmJkX3JlY2VpdmVyLmMgZHJi
ZF9yZXEuYyBkcmJkX3JlcS5oIGRyYmRfc3RyaW5ncy5jIGRyYmRfd29ya2VyLmMKLQlscnVfY2Fj
aGUuYyBscnVfY2FjaGUuaCIKKwlscnVfY2FjaGUuYyBkcmJkX3ZsaS5oIGRyYmRfdHJhY2luZy5j
IGRyYmRfdHJhY2luZy5oIgogCiAjIGNsZWFuIGl0IGZpcnN0CiBtYWtlIC1zIC1DICREUkJEL2Ry
YmQgY2xlYW4K
--0016e644ce6e190ff10471446371--
