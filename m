Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B5D51103B4AE
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 15:02:40 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so17239204wrt.3
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 06:02:40 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	h8-v6sm14559697wre.15.2018.09.17.06.02.38
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 17 Sep 2018 06:02:38 -0700 (PDT)
Resent-Message-ID: <20180917130236.GC5481@soda.linbit>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F2331103B4AE
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 14:54:39 +0200 (CEST)
From: Philipp Klocke <Phil_K97@gmx.de>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, arnd@arndb.de
Message-ID: <4ffc2255-2ae2-60d4-703e-151979efe7ab@gmx.de>
Date: Mon, 17 Sep 2018 14:54:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-HK
Cc: lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
	nicolas.dichtel@6wind.com, davem@davemloft.net, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [RESEND] drbd: avoid clang warning about pointless
	switch statement
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

VGhlIGRyYmQgY29kZSBjYXVzZXMgd2FybmluZ3MgdGhhdCB3ZSBjYW5ub3QgZWFzaWx5IGRp
c2FibGUgd2hlbgpidWlsZGluZyB3aXRoIGNsYW5nOgoKSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX2RlYnVnZnMuYzoxMDoKSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX2ludC5oOjQ4OgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gaW5jbHVkZS9saW51eC9kcmJkX2dlbmxfYXBpLmg6NTM6CkluIGZpbGUgaW5j
bHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L2dlbmxfbWFnaWNfc3RydWN0Lmg6MjM3OgppbmNs
dWRlL2xpbnV4L2RyYmRfZ2VubC5oOjMwMDoxOiB3YXJuaW5nOiBubyBjYXNlIG1hdGNoaW5n
IGNvbnN0YW50CnN3aXRjaCBjb25kaXRpb24gJzAnCgpUaGVyZSBpcyBub3RoaW5nIHdyb25n
IHdpdGggdGhlIGNvZGUsIGFuZCBhZGRpbmcgJ2RlZmF1bHQ6JyBsYWJlbHMKaW4gdGhlIHJp
Z2h0IHBsYWNlIGlzIGVub3VnaCB0byBsZXQgY2xhbmcgc2h1dCB1cCBhYm91dCB0aGUgd2Fy
bmluZy4KCkZpeGVzOiBlYzJjMzVhYzFlYTIgKCJkcmJkOiBwcmVwYXJlIHRoZSB0cmFuc2l0
aW9uIGZyb20gY29ubmVjdG9yIHRvCmdlbmV0bGluayIpClNpZ25lZC1vZmYtYnk6IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Ci0tCndhcyBzZW50IG9uIEZlYi4gMSwgMjAxNywg
NDo1NSBwLm0uIFVUQyBieSBBcm5kIEJlcmdtYW5uCndhcyBhY2tlZCBidXQgbm90IG1lcmdl
ZApyZXNlbmQKLS0tCsKgaW5jbHVkZS9saW51eC9nZW5sX21hZ2ljX3N0cnVjdC5oIHwgMyAr
KysKwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9nZW5sX21hZ2ljX3N0cnVjdC5oCmIvaW5jbHVkZS9saW51eC9nZW5sX21h
Z2ljX3N0cnVjdC5oCmluZGV4IDYyNzBhNTZlNWVkYy4uYzZmYmFmYjgzNGYxIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2dlbmxfbWFnaWNfc3RydWN0LmgKKysrIGIvaW5jbHVkZS9s
aW51eC9nZW5sX21hZ2ljX3N0cnVjdC5oCkBAIC0xOTAsNiArMTkwLDcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGN0X2Fzc2VydF91bmlxdWVfb3BlcmF0aW9ucyh2b2lkKQrCoHsKwqDCoMKg
wqAgc3dpdGNoICgwKSB7CsKgI2luY2x1ZGUgR0VOTF9NQUdJQ19JTkNMVURFX0ZJTEUKK8Kg
wqDCoCBkZWZhdWx0OgrCoMKgwqDCoCDCoMKgwqAgOwrCoMKgwqDCoCB9CsKgfQpAQCAtMjA4
LDYgKzIwOSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZApjdF9hc3NlcnRfdW5pcXVlX3RvcF9s
ZXZlbF9hdHRyaWJ1dGVzKHZvaWQpCsKgewrCoMKgwqDCoCBzd2l0Y2ggKDApIHsKwqAjaW5j
bHVkZSBHRU5MX01BR0lDX0lOQ0xVREVfRklMRQorwqDCoMKgIGRlZmF1bHQ6CsKgwqDCoMKg
IMKgwqDCoCA7CsKgwqDCoMKgIH0KwqB9CkBAIC0yMTgsNiArMjIwLDcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGN0X2Fzc2VydF91bmlxdWVfICMjIHNfbmFtZSAjIwpfYXR0cmlidXRlcyh2
b2lkKcKgwqDCoCBcCsKge8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFwKwqDCoMKgwqAgc3dpdGNoICgwKSB7wqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFwKwqDCoMKgwqAg
wqDCoMKgIHNfZmllbGRzwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgXAorwqDCoMKgIMKgwqDCoCBkZWZhdWx0OsKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIFwKwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCA7wqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgXArCoMKgwqDCoCB9wqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBcCsKgfQoK
