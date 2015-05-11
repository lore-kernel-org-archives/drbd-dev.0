Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8AC721045C28
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 12:07:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7ED0E305694
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 12:07:36 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qbkEPuO5tAzJ for <drbd-dev@lists.linbit.com>;
	Mon, 11 May 2015 12:07:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 621ED30DAC1
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 12:07:36 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tdJYF9RRoVge for <drbd-dev@lists.linbit.com>;
	Mon, 11 May 2015 12:07:36 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id ED68B305694
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 12:07:35 +0200 (CEST)
Date: Mon, 11 May 2015 12:07:35 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150511100735.GY1968@rck.sh>
References: <1945028087.159.1431334443252.JavaMail.open-xchange@ronja.mits.lan>
	<20150511092206.GX1968@rck.sh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20150511092206.GX1968@rck.sh>
Subject: Re: [Drbd-dev] drbdmanage lintian warnings
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


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 11:22:06AM +0200, Roland Kammerer wrote:
>  Patches welcome. ;-)

See attached patch. It fixes the bulk of the lintian warnings. There are
still some other unrelated manpage errors left that would need a closer
look (e.g. command string too long).

Regards, rck

--J/dobhs11T7y2rNN
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-man-pages-Fixed-some-lintian-warnings.patch"

From 88ef35ee774bf66184937c68de5a373a352d7e6e Mon Sep 17 00:00:00 2001
From: Roland Kammerer <roland.kammerer@linbit.com>
Date: Mon, 11 May 2015 11:53:16 +0200
Subject: [PATCH] man-pages: Fixed some lintian warnings

This fixes the "manpage-has-bad-wahtis-entry" warnings.
---
 setup.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/setup.py b/setup.py
index 900f9c9..d8faa99 100755
--- a/setup.py
+++ b/setup.py
@@ -98,7 +98,7 @@ class BuildManCommand(Command):
             if os.path.isfile(outfile):
                 continue
             print "Generating %s ..." % (outfile)
-            mangen = ["help2man", "-n", toplevel, '-s', '8',
+            mangen = ["help2man", "-n", toplevel, '-s', mansection,
                       '--version-string=%s' % (get_version()), "-N",
                       '"./drbdmanage_client.py %s"' % (toplevel)]
 
@@ -106,6 +106,9 @@ class BuildManCommand(Command):
             manpage = subprocess.check_output(toexec, shell=True)
             manpage = manpage.replace(replace[0], replace[1])
             manpage = manpage.replace(replace[0].upper(), replace[1].upper())
+            manpage = manpage.replace(toplevel.upper(), mansection)
+            manpage = manpage.replace("%s %s" % (replace[1], toplevel),
+                                      "%s_%s" % (replace[1], toplevel))
             with gzip.open(outfile, 'wb') as f:
                 f.write(manpage)
 
-- 
2.1.4


--J/dobhs11T7y2rNN--
