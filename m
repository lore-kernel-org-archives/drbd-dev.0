Received: from ciphermail-gateway.data-experts.de (mail.data-experts.de [82.194.113.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FD41B8C2
	for <drbd-dev@lists.linux.dev>; Thu, 16 Jul 2026 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.194.113.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201808; cv=none; b=rkz/Pr5a+lFL3N2MAh6APcFCe6qpNgxWImPRSwk1jsTlyLiAmrOPvd37/I3KESXbBAwLulxgRbfU0yr/sg+xEbP5l4E/VEaEVNLmCiq/u0FhPVZsDxEGzcaJjpR+BBtiFKykxQtJAFA7Ktxe4o4RGETuVRduQINHVQb1dak1dJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201808; c=relaxed/simple;
	bh=up81Bd6kAlI9Zne2YiN9mdchhHy/LDIS36uo2xAk0D8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=bvJqjinlSemypYjfAgKNPnDxiXcaISXWRxxCNu4dtCI8lsihct7/FM5qObaiSf3RkKDfDT2kv9XJfqrqm7ToLXoyFcPd+ApoK7RrPEY1SMgDwLAJVI39o2YIvkyYZWCWpwgzcPtosYLWLKRoB0azCW2ThF5rki133O84pOW5fHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=data-experts.de; spf=pass smtp.mailfrom=data-experts.de; arc=none smtp.client-ip=82.194.113.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=data-experts.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=data-experts.de
Received: from ciphermail (localhost [127.0.0.1])
	by ciphermail-gateway.data-experts.de (CipherMail) with ESMTP id 4h19x564c9z5xGh
	for <drbd-dev@lists.linux.dev>; Thu, 16 Jul 2026 13:36:41 +0200 (CEST)
Received: from mail.data-experts.de (unknown [192.168.254.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ciphermail-gateway.data-experts.de (CipherMail) with ESMTPS id 4h19x53d3lz5xGh
	for <drbd-dev@lists.linux.dev>; Thu, 16 Jul 2026 13:36:41 +0200 (CEST)
X-AuditID: c0a8fe2a-e80c070000002109-d3-6a58c2494209
Message-ID: <02903afc-cda1-4d97-8155-4e03c3cc0e51@data-experts.de>
Date: Thu, 16 Jul 2026 13:36:40 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Bj=C3=B6rn_Stabel?= <bjoern.stabel@data-experts.de>
To: drbd-dev@lists.linux.dev
Subject: [PATCH] drbd: fix ldev refcount imbalance when resync request
 allocation fails
X-TNEFEvaluated: 1
X-Disclaimed: 24167
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: de-DE
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42JZI8Iur+t5KCLLYHmTlMW2vvnMDoweLzbP
	ZAxgjOKySUnNySxLLdK3S+DKaD5lXNAoVTFvxWTmBsaNYl2MnBwSAiYSO/Y/Ye1i5ODgFXCS
	2P7fHCTMIqAqcbPzHjuIzSsgKHFy5hMWEFtUQF7i/q0ZYHE2AWeJGcfXM4PYIgIyEr+mvwGr
	ERaIlLi7dj07xHghidOLzzJD2MIS1zfvZwKxmQW0JZYtfM0MYZtJdG3tYoSwxSU2PfvOOoGR
	dxaS1bOQtMxC0jILScsCRpZVjCJJuYYGeimJJYm6qRUFqUUlxXopqZsYgaF0YMU/rR2MJxrT
	DjEycTAeYpTgYFYS4X3PH54lxJuSWFmVWpQfX1Sak1p8iFGag0VJnFe6JyJLSCA9sSQ1OzUV
	aBRMlomDU6qBkdP+BdeEntKfj5XSgz5Vv5gc0Fc770B5quEc1w8GJz8mXHypyHtDfW7dm7Iz
	0RNdv30WUQ2Y49jX3rY6rrXHNWP756pUE+M+qSPi+teE22b3rBdYe+cl5wc3u5PHCiPP7E43
	XnH5r6uM/YnUo0rSZ5MvTZT5OyNEWjDkvEag8w1hruL/9ZY6SizFGYmGWsxFxYkAmPmIJRMC
	AAA=

make=5Fone=5Fresync=5Frequest() does not take its own ldev reference; it
relies on the reference held by its only caller, make=5Fresync=5Frequest().
Nevertheless, when drbd=5Falloc=5Fpeer=5Freq() fails, the error path called
put=5Fldev() before returning -EAGAIN. The caller then handles -EAGAIN by
jumping to request=5Fdone and eventually releases its reference again at
out=5Fput=5Fldev. The result is two put=5Fldev() calls for a single
get=5Fldev(), so device->local=5Fcnt underflows.

Once local=5Fcnt is negative, every subsequent get=5Fldev()/put=5Fldev() pa=
ir
trips D=5FASSERT(device, i >=3D 0) in put=5Fldev(), flooding the kernel log
with "ASSERTION i >=3D 0 FAILED in put=5Fldev" for every I/O completion on
the device. Worse, the "last reference dropped" detection (i =3D=3D 0) is
permanently skewed: a later detach either never sees the counter reach
zero (hanging the transition to diskless) or sees it reach zero while
references are still in flight, with use-after-free potential in the
ldev destroy path.

The allocation failure itself is expected transient behavior: resync
requests are allocated with GFP=5FTRY & ~=5F=5FGFP=5FRECLAIM on purpose, so=
 the
mempool can run dry under a burst of parallel resyncs and the request is
simply retried later. Observed in production on a Proxmox/LINSTOR
cluster after ten "linstor resource toggle-disk" migrations resynced
concurrently: five volumes hit the allocation failure and spammed the
assertion at the full I/O rate afterwards.

The sister path read=5Ffor=5Fcsum() takes and releases its own reference
and is balanced. Fix make=5Fone=5Fresync=5Frequest() by dropping the stray
put=5Fldev() so the reference is released exactly once, by the caller.

Fixes: 223009b6369f ("drbd: synchronize resync with interval tree and=20
dagtags")
Signed-off-by: Christian Taeumel <christian.taeumel@data-experts.de>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
---
 =C2=A0drbd/drbd=5Fsender.c | 1 -
 =C2=A01 file changed, 1 deletion(-)

diff --git a/drbd/drbd=5Fsender.c b/drbd/drbd=5Fsender.c
index 907f042b4..f90d3a9f6 100644
--- a/drbd/drbd=5Fsender.c
+++ b/drbd/drbd=5Fsender.c
@@ -680,7 +680,6 @@ static int make=5Fone=5Fresync=5Frequest(struct=20
drbd=5Fpeer=5Fdevice *peer=5Fdevice, int dis
 =C2=A0=E2=80=83=E2=80=83=E2=80=83=E2=80=83=E2=80=83=E2=80=83=E2=80=83=E2=
=80=83=C2=A0 =C2=A0 =C2=A0 =C2=A0size, REQ=5FOP=5FWRITE);
 =C2=A0=E2=80=83=E2=80=83if (!peer=5Freq) {
 =C2=A0=E2=80=83=E2=80=83=E2=80=83=E2=80=83drbd=5Ferr(device, "Could not al=
locate resync request\n");
-=E2=80=83=E2=80=83=E2=80=83=E2=80=83put=5Fldev(device);
 =C2=A0=E2=80=83=E2=80=83=E2=80=83=E2=80=83return -EAGAIN;
 =C2=A0=E2=80=83=E2=80=83}

--=20
2.43.0

Diese E-Mail sowie etwaige Anh=C3=A4nge enthalten vertrauliche und/oder rec=
htlich gesch=C3=BCtzte Informationen und sind ausschlie=C3=9Flich f=C3=BCr =
die im Adressfeld genannte(n) Person(en) bestimmt. Sollten Sie nicht zum vo=
rgesehenen Empf=C3=A4ngerkreis geh=C3=B6ren oder diese Nachricht irrt=C3=BC=
mlich erhalten haben, bitten wir Sie, die absendende Person zu informieren =
und die E-Mail sowie alle Anh=C3=A4nge zu l=C3=B6schen. In diesem Fall ist =
jede Kenntnisnahme, Verwendung, Weitergabe oder Vervielf=C3=A4ltigung der I=
nhalte nicht gestattet.
