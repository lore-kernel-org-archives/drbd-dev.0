Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EA947101AC71
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:58:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E07903014F8
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:58:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VSfJfINxTG8S for <drbd-dev@lists.linbit.com>;
	Thu, 29 May 2014 23:58:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C4AD9302EAE
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:58:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gPAd2-F_M78Y for <drbd-dev@lists.linbit.com>;
	Thu, 29 May 2014 23:58:20 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id ABE483014F8
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:58:20 +0200 (CEST)
Resent-Message-ID: <20140529215820.GE6434@soda.linbit>
Received: from mailer.skroutz.gr (mailer.skroutz.gr [185.6.78.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 25ADA101AC79
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 09:48:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailer.skroutz.gr (Postfix) with ESMTP id 8BFC12A42A4
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 10:48:03 +0300 (EEST)
Received: from mailer.skroutz.gr ([127.0.0.1])
	by localhost (mailer.skroutz.gr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oEQkgDoUNEnN for <drbd-dev@lists.linbit.com>;
	Wed, 28 May 2014 10:48:03 +0300 (EEST)
Received: from marvin.skroutz.gr. (marvin.ws.skroutz.gr [185.6.78.147])
	by mailer.skroutz.gr (Postfix) with ESMTPSA id 39E962A4281
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2014 10:48:02 +0300 (EEST)
From: Apollon Oikonomopoulos <apoikos@debian.org>
To: drbd-dev@lists.linbit.com
Date: Wed, 28 May 2014 10:47:53 +0300
Message-Id: <1401263273-11610-1-git-send-email-apoikos@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] [PATCH drbd-utils] Fix drbdsetup-8.4 build with
	-Werror=format-security
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

Building drbdsetup-8.4 with -Werror=3Dformat-security (enabled by default
for Debian builds) currently fails with the following errors:

  drbdsetup.c: In function =E2=80=98print_command_usage=E2=80=99:
  drbdsetup.c:2311:6: error: format not a string literal and no format ar=
guments [-Werror=3Dformat-security]
        wrap_printf(4, "|resource" + first);
        ^
  drbdsetup.c:2315:6: error: format not a string literal and no format ar=
guments [-Werror=3Dformat-security]
        wrap_printf(4, "|minor" + first);
        ^
  drbdsetup.c:2319:6: error: format not a string literal and no format ar=
guments [-Werror=3Dformat-security]
        wrap_printf(4, "|all" + first);
        ^
  cc1: some warnings being treated as errors
  <builtin>: recipe for target 'drbdsetup.o' failed

Note that the way wrap_printf is called in this case is indeed safe, howe=
ver we
comply with gcc by adding a "%s" format string to these calls.

Signed-off-by: Apollon Oikonomopoulos <apoikos@debian.org>
---
 user/legacy-84/drbdsetup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/user/legacy-84/drbdsetup.c b/user/legacy-84/drbdsetup.c
index 99d23b4..c8a5ee0 100644
--- a/user/legacy-84/drbdsetup.c
+++ b/user/legacy-84/drbdsetup.c
@@ -2308,15 +2308,15 @@ static void print_command_usage(struct drbd_cmd *=
cm, enum usage_type ut)
=20
 				wrap_printf(4, " {");
 				if (ctx & CTX_RESOURCE) {
-					wrap_printf(4, "|resource" + first);
+					wrap_printf(4, "%s", "|resource" + first);
 					first =3D false;
 				}
 				if (ctx & CTX_MINOR) {
-					wrap_printf(4, "|minor" + first);
+					wrap_printf(4, "%s", "|minor" + first);
 					first =3D false;
 				}
 				if (ctx & CTX_ALL) {
-					wrap_printf(4, "|all" + first);
+					wrap_printf(4, "%s", "|all" + first);
 					first =3D false;
 				}
 				wrap_printf(4, "}");
--=20
2.0.0.rc2

