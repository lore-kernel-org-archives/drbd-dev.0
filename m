Return-Path: <rui.xu@easystack.cn>
Received: from mail-m24100.qiye.163.com (mail-m24100.qiye.163.com
	[220.194.24.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 17CB44201F1
	for <drbd-dev@lists.linbit.com>; Fri, 10 Sep 2021 07:57:02 +0200 (CEST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APgATADQH09q-D*PRYzV4qoq.3.1631252960808.Hmail.rui.xu@easystack.cn>
To: Joel Colledge <joel.colledge@linbit.com>
In-Reply-To: <CAGNP_+U3-BZ+9uykZuttOp6+irG15yesyFfDs27kj3M6BJN+1A@mail.gmail.com>
MIME-Version: 1.0
From: =?UTF-8?B?5b6Q6ZSQ?= <rui.xu@easystack.cn>
Date: Fri, 10 Sep 2021 13:49:20 +0800 (GMT+08:00)
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev]
	=?utf-8?q?=5BPATCH=5D_drbd=3A_do_not_finish_the_stable?=
	=?utf-8?q?_resync_when_repl_state_is_L=5FPAUSED=5FSYNC=5FT?=
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

SGkgSm9lbCw8YnIvPiAgICBUaGFua3MgZm9yIHRoZSByZXBseSBhbmQgc29ycnkgZm9yIHRoZSBk
ZWxheS4gQWZ0ZXIgc29tZSBtb3JlIDxici8+aW52ZXN0aWdhdGlvbiwgSSBmb3VuZCB0aGUgcm9v
dCBjYXVzZSBvZiB0aGlzIHByb2JsZW0gd2UgbWV0IGlzIHRoYXQgPGJyLz50aGVyZSBpcyBhIHJh
Y2UgY29uZGl0aW9uIGluIHVwZGF0ZV9zeW5jX2JpdHMoKSBhbmQgcmVjZWl2ZV9iaXRtYXAoKS48
YnIvPlRoaXMgcmFjZSBjb25kaXRpb24gd2lsbCBsZWFkIHRoZSBwcm9ibGVtIEkgd2FzIHRyeWlu
ZyB0byBzb2x2ZSBpbiB0aGlzIDxici8+cGF0Y2ggYWJvdmUuPGJyLz48YnIvPldlIGNvbmZpcm1l
ZCB0aGUgcmFjZSBjb25kaXRpb24gZXhpc3RpbmcgaW4gdXBzdHJlYW0gYW5kIEkgaGF2ZSBzZW50
IGEgPGJyLz5wYXRjaCBmb3IgaXQ6PGJyLz5odHRwczovL2xpc3RzLmxpbmJpdC5jb20vcGlwZXJt
YWlsL2RyYmQtZGV2LzIwMjEtU2VwdGVtYmVyLzAwNTg0MC5odG1sPGJyLz48YnIvPlNvIHlvdSBj
YW4gZ28gdG8gcmV2aWV3IG15IG5ldyBwYXRjaCBkaXJlY3RseS48YnIvPjxici8+VGhhbmtzLDxi
ci8+WHUKRnJvbTogSm9lbCBDb2xsZWRnZSA8am9lbC5jb2xsZWRnZUBsaW5iaXQuY29tPgpEYXRl
OiAyMDIxLTA5LTAxIDE2OjQwOjMyClRvOiAgUnVpIFh1IDxydWkueHVAZWFzeXN0YWNrLmNuPgpD
YzogIFBoaWxpcHAgUmVpc25lciA8cGhpbGlwcC5yZWlzbmVyQGxpbmJpdC5jb20+LGRyYmQtZGV2
QGxpc3RzLmxpbmJpdC5jb20KU3ViamVjdDogUmU6IFtEcmJkLWRldl0gW1BBVENIXSBkcmJkOiBk
byBub3QgZmluaXNoIHRoZSBzdGFibGUgcmVzeW5jIHdoZW4gcmVwbCBzdGF0ZSBpcyBMX1BBVVNF
RF9TWU5DX1QNCg0K
