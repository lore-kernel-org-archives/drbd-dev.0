Return-Path: <schmiddy@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 29F911057140
	for <drbd-dev@lists.linbit.com>; Sun, 24 Apr 2011 02:16:44 +0200 (CEST)
Received: by wwk4 with SMTP id 4so615013wwk.3
	for <drbd-dev@lists.linbit.com>; Sat, 23 Apr 2011 17:16:43 -0700 (PDT)
MIME-Version: 1.0
From: Josh Kupershmidt <schmiddy@gmail.com>
Date: Sat, 23 Apr 2011 20:10:16 -0400
Message-ID: <BANLkTikPLSwDgUGqHrpxnNQMbXtKkHoNYQ@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary=00504502d3199401f504a19eeb7b
Subject: [Drbd-dev] Makefile: non-portable flags to mv
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--00504502d3199401f504a19eeb7b
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi all,

I noticed that ./drbd/Makefile tries to use the command
  mv --force =85

On some systems this will not work; only the -f flag is in the UNIX
spec <http://pubs.opengroup.org/onlinepubs/007908799/xcu/mv.html>.
Trivial patch attached.

Josh

--00504502d3199401f504a19eeb7b
Content-Type: text/x-patch; charset=US-ASCII; name="drbd_Makefile.patch"
Content-Disposition: attachment; filename="drbd_Makefile.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmv80avf0

ZGlmZiAtLWdpdCBhL2RyYmQvTWFrZWZpbGUgYi9kcmJkL01ha2VmaWxlCmluZGV4IDdlNWM4NDQu
LjUyMTA1ZDIgMTAwNjQ0Ci0tLSBhL2RyYmQvTWFrZWZpbGUKKysrIGIvZHJiZC9NYWtlZmlsZQpA
QCAtMTMzLDcgKzEzMyw3IEBAIGVsc2UKIAkJZ3JlcCByZXR1cm4gJEAgOwkJCQkJCVwKIAlmaSA7
CQkJCQkJCQkJXAogCWVjaG8gLWUgIlx0XHRcIiBidWlsZCBieSAkJFVTRVJAJCRIT1NUTkFNRSwg
YGRhdGUgIislRiAlVCJgXCI7XG59IjsJXAotCW12IC0tZm9yY2UgJEAubmV3ICRACisJbXYgLWYg
JEAubmV3ICRACiAKICAga2J1aWxkOiBkcmJkX2J1aWxkdGFnLmMKIAlAcm0gLWYgLmRyYmRfa2Vy
bmVscmVsZWFzZSoK
--00504502d3199401f504a19eeb7b--
