Return-Path: <chenguohua@jari.cn>
Received: from jari.cn (unknown [218.92.28.115])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E420D4201C5
	for <drbd-dev@lists.linbit.com>; Fri, 13 Oct 2023 05:46:24 +0200 (CEST)
Date: Fri, 13 Oct 2023 11:37:49 +0800 (GMT+08:00)
From: chenguohua@jari.cn
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4b210be.94a.18b271ca056.Coremail.chenguohua@jari.cn>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Clean up errors in drbd.h
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
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VykKClNpZ25lZC1vZmYtYnk6
IEd1b0h1YSBDaGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvZHJi
ZC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kcmJkLmggYi9pbmNsdWRlL2xpbnV4L2RyYmQu
aAppbmRleCA1NDY4YTIzOTlkNDguLjNhOGM2MGVhZjNiZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9kcmJkLmgKKysrIGIvaW5jbHVkZS9saW51eC9kcmJkLmgKQEAgLTEzOSw3ICsxMzksNyBA
QCBlbnVtIGRyYmRfcmV0X2NvZGUgewogCUVSUl9DU1VNU19BTEdfTkQJPSAxNDUsIC8qIERSQkQg
OC4yIG9ubHkgKi8KIAlFUlJfVkVSSUZZX0FMRwkJPSAxNDYsIC8qIERSQkQgOC4yIG9ubHkgKi8K
IAlFUlJfVkVSSUZZX0FMR19ORAk9IDE0NywgLyogRFJCRCA4LjIgb25seSAqLwotCUVSUl9DU1VN
U19SRVNZTkNfUlVOTklORz0gMTQ4LCAvKiBEUkJEIDguMiBvbmx5ICovCisJRVJSX0NTVU1TX1JF
U1lOQ19SVU5OSU5HID0gMTQ4LCAvKiBEUkJEIDguMiBvbmx5ICovCiAJRVJSX1ZFUklGWV9SVU5O
SU5HCT0gMTQ5LCAvKiBEUkJEIDguMiBvbmx5ICovCiAJRVJSX0RBVEFfTk9UX0NVUlJFTlQJPSAx
NTAsCiAJRVJSX0NPTk5FQ1RFRAkJPSAxNTEsIC8qIERSQkQgOC4zIG9ubHkgKi8KLS0gCjIuMTcu
MQo=
