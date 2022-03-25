Return-Path: <rui.xu@easystack.cn>
Received: from mail-m24100.qiye.163.com (mail-m24100.qiye.163.com
	[220.194.24.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E47E94201F2
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2022 04:12:47 +0100 (CET)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ANUANAAVIdwn*FrX7b*E8aoA.3.1648177379860.Hmail.rui.xu@easystack.cn>
To: Rui Xu <rui.xu@easystack.cn>
In-Reply-To: <20220302123523.471277-1-rui.xu@easystack.cn>
MIME-Version: 1.0
From: Xu Rui <rui.xu@easystack.cn>
Date: Fri, 25 Mar 2022 11:02:59 +0800 (GMT+08:00)
Cc: philipp.reisner@linbit.com, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev]
	=?utf-8?q?=5BPATCH=5D_drbd=3Ado_not_wait_for_negotiati?=
	=?utf-8?q?on_result_with_unconnected_peer?=
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

UElORwpGcm9tOiBSdWkgWHUgPHJ1aS54dUBlYXN5c3RhY2suY24+CkRhdGU6IDIwMjItMDMtMDIg
MjA6MzU6MjMKVG86ICBqb2VsLmNvbGxlZGdlQGxpbmJpdC5jb20scGhpbGlwcC5yZWlzbmVyQGxp
bmJpdC5jb20sZHJiZC1kZXZAbGlzdHMubGluYml0LmNvbQpDYzogIGRvbmdzaGVuZy55YW5nQGVh
c3lzdGFjay5jbixSdWkgWHUgPHJ1aS54dUBlYXN5c3RhY2suY24+ClN1YmplY3Q6IFtQQVRDSF0g
ZHJiZDpkbyBub3Qgd2FpdCBmb3IgbmVnb3RpYXRpb24gcmVzdWx0IHdpdGggdW5jb25uZWN0ZWQg
cGVlcj5UaGUgY29tbWl0IDhhOTYyYTZhIGZyb20gRGVjIDIwMTQKPiJkcmJkOiBmaXggbGVhdmlu
ZyBvZiBEX05FR09USUFUSU5HIGlmIHNvbWUgcGVlciBkbyBub3QgaGF2ZSB0aGUgbWlub3IgeWV0
Igo+aW50cm9kdWNlZCBhIGJ1ZyB0aGF0IGRpc2sgc3RhdGUgd2lsbCBhbHdheXMgc3RheSBpbiBu
ZWdvdGlhdGluZyBzaW5jZSB0aGVyZQo+d2lsbCBuZXZlciBiZSBuZWdvdGlhdGlvbiByZXN1bHQg
d2l0aCB1bmNvbm5lY3RlZCBwZWVyLgo+Cj5TbyBkbyBub3Qgd2FpdCBmb3IgYW4gbmVnb3RpYXRp
b24gcmVzdWx0IHdpdGggdW5jb25uZWN0ZWQgcGVlciEKPgo+U2lnbmVkLW9mZi1ieTogUnVpIFh1
IDxydWkueHVAZWFzeXN0YWNrLmNuPgo+LS0tCj4gZHJiZC9kcmJkX3N0YXRlLmMgfCAzICsrLQo+
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAt
LWdpdCBhL2RyYmQvZHJiZF9zdGF0ZS5jIGIvZHJiZC9kcmJkX3N0YXRlLmMKPmluZGV4IGFlYWYz
NmEuLmY3OWY1YTQgMTAwNjQ0Cj4tLS0gYS9kcmJkL2RyYmRfc3RhdGUuYwo+KysrIGIvZHJiZC9k
cmJkX3N0YXRlLmMKPkBAIC0xOTEyLDcgKzE5MTIsOCBAQCBzdGF0aWMgdm9pZCBzYW5pdGl6ZV9z
dGF0ZShzdHJ1Y3QgZHJiZF9yZXNvdXJjZSAqcmVzb3VyY2UpCj4gCQkJCWVudW0gZHJiZF9yZXBs
X3N0YXRlIG5yID0gcGVlcl9kZXZpY2UtPm5lZ290aWF0aW9uX3Jlc3VsdDsKPiAJCQkJZW51bSBk
cmJkX2Rpc2tfc3RhdGUgcGRzayA9IHBlZXJfZGV2aWNlLT5kaXNrX3N0YXRlW05FV107Cj4gCj4t
CQkJCWlmIChwZHNrID09IERfVU5LTk9XTiB8fCBwZHNrIDwgRF9ORUdPVElBVElORykKPisJCQkJ
aWYgKHBkc2sgPT0gRF9VTktOT1dOIHx8IHBkc2sgPCBEX05FR09USUFUSU5HIHx8Cj4rCQkJCSAg
ICBwZWVyX2RldmljZS0+Y29ubmVjdGlvbi0+Y3N0YXRlW05FV10gPCBDX0NPTk5FQ1RFRCkKPiAJ
CQkJCWNvbnRpbnVlOwo+IAo+IAkJCQlpZiAocGRzayA9PSBEX1VQX1RPX0RBVEUpCj4tLSAKPjEu
OC4zLjEKPgoNCg0K
