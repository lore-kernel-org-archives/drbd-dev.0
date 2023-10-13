Return-Path: <chenguohua@jari.cn>
Received: from jari.cn (unknown [218.92.28.115])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 15C464201C5
	for <drbd-dev@lists.linbit.com>; Fri, 13 Oct 2023 05:45:24 +0200 (CEST)
Date: Fri, 13 Oct 2023 11:36:56 +0800 (GMT+08:00)
From: chenguohua@jari.cn
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <505ab7d2.949.18b271bd108.Coremail.chenguohua@jari.cn>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] kallsyms: Clean up errors in module.h
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L21vZHVs
ZS5oIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW9kdWxlLmggYi9pbmNsdWRlL2xpbnV4
L21vZHVsZS5oCmluZGV4IGE5OGUxODhjZjM3Yi4uNDhhZWJlYTcyZDNhIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L21vZHVsZS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW9kdWxlLmgKQEAgLTE1
Miw3ICsxNTIsNyBAQCBleHRlcm4gdm9pZCBjbGVhbnVwX21vZHVsZSh2b2lkKTsKICNkZWZpbmUg
X19pbml0Y29uc3Rfb3JfbW9kdWxlCiAjZGVmaW5lIF9fSU5JVF9PUl9NT0RVTEUJLnRleHQKICNk
ZWZpbmUgX19JTklUREFUQV9PUl9NT0RVTEUJLmRhdGEKLSNkZWZpbmUgX19JTklUUk9EQVRBX09S
X01PRFVMRQkuc2VjdGlvbiAiLnJvZGF0YSIsImEiLCVwcm9nYml0cworI2RlZmluZSBfX0lOSVRS
T0RBVEFfT1JfTU9EVUxFCS5zZWN0aW9uICIucm9kYXRhIiwgImEiLCAlcHJvZ2JpdHMKICNlbHNl
CiAjZGVmaW5lIF9faW5pdF9vcl9tb2R1bGUgX19pbml0CiAjZGVmaW5lIF9faW5pdGRhdGFfb3Jf
bW9kdWxlIF9faW5pdGRhdGEKQEAgLTgwMiw3ICs4MDIsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wg
d2l0aGluX21vZHVsZSh1bnNpZ25lZCBsb25nIGFkZHIsIGNvbnN0IHN0cnVjdCBtb2R1bGUgKm1v
ZCkKIH0KIAogLyogR2V0L3B1dCBhIGtlcm5lbCBzeW1ib2wgKGNhbGxzIHNob3VsZCBiZSBzeW1t
ZXRyaWMpICovCi0jZGVmaW5lIHN5bWJvbF9nZXQoeCkgKHsgZXh0ZXJuIHR5cGVvZih4KSB4IF9f
YXR0cmlidXRlX18oKHdlYWssdmlzaWJpbGl0eSgiaGlkZGVuIikpKTsgJih4KTsgfSkKKyNkZWZp
bmUgc3ltYm9sX2dldCh4KSAoeyBleHRlcm4gdHlwZW9mKHgpIHggX19hdHRyaWJ1dGVfXygod2Vh
aywgdmlzaWJpbGl0eSgiaGlkZGVuIikpKTsgJih4KTsgfSkKICNkZWZpbmUgc3ltYm9sX3B1dCh4
KSBkbyB7IH0gd2hpbGUgKDApCiAjZGVmaW5lIHN5bWJvbF9wdXRfYWRkcih4KSBkbyB7IH0gd2hp
bGUgKDApCiAKLS0gCjIuMTcuMQo=
