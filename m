Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (unknown [60.234.198.231])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 21133142FF
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2004 01:57:12 +0100 (CET)
Date: Thu, 25 Nov 2004 13:57:08 +1300
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
Message-ID: <rIe9JTBXuI5VKlizdCtH1u8=lge@web.de>
References: <200411152259.28960.philipp.reisner@linbit.com>
	<41A48BB0.4080707@wollmersdorfer.at> <41A4909F.4070806@hug.cx>
	<200411241518.55023.philipp.reisner@linbit.com>
	<41A4A309.9030705@hug.cx> <Z+CHtpDcVPhqXMZ3GOO8Jts=lge@web.de>
	<41A51BF0.10109@hug.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A51BF0.10109@hug.cx>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-11-25 00:40:32 +0100
\ Philipp Hug:
> 
> >what about renaming it to debian.upstream or so.
> >then, if you are the official debian, then you can put your debian in
> >there, if not, you can symlink it.
> >
> >does that make sense?
> > 
> >
> lars,
> I don't think there's a need for a debian directory in the release 
> tarball because debian versions will be released soon after drbd 
> releases anyway and you could still get it from svn.

ok, just checked in 
--- Makefile	(revision 1655)
+++ Makefile	(working copy)
@@ -120,7 +120,7 @@
 .PHONY: .filelist
 .filelist:
 	@ svn info >/dev/null || { echo "you need a svn checkout to do this." ; false ; }
-	@find $$(svn st -v | sed '/^?/d;s/^.\{8\} \+[0-9]\+ \+[0-9]\+ [a-z]\+ *//;') \
+	@find $$(svn st -v | sed '/^?/d;s/^.\{8\} \+[0-9]\+ \+[0-9]\+ [a-z]\+ *//;/^debian/d' ) \
 	\! -type d -maxdepth 0 |\
 	sed 's:^:drbd-$(DIST_VERSION)/:' > .filelist
 	@[ -s .filelist ] # assert there is something in .filelist now
