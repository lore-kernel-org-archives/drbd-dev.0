Return-Path: <opitz@primacom.net>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.190])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AB27F1431F
	for <drbd-dev@lists.linbit.com>; Thu,  7 Oct 2004 00:25:48 +0200 (CEST)
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CFKEF-0000C3-00
	for drbd-dev@lists.linbit.com; Thu, 07 Oct 2004 00:25:47 +0200
Received: from [83.169.139.51] (helo=zimmer.altersheim.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1) id 1CFKEF-0000Q2-00
	for drbd-dev@lists.linbit.com; Thu, 07 Oct 2004 00:25:47 +0200
From: Alexander Opitz <opitz@primacom.net>
To: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] 0.7.5 debian stuff
Date: Thu, 7 Oct 2004 00:36:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410070036.06736.opitz@primacom.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

> I like the fact that drbd0.7 conflicts drbd << 0.7, but do we think 
> 0.6.x is no longer being used?  If we upload this package into debian, 
> how would we ever be able to upload a newer version of the 0.6.x series?

The conflict is correct.

If you update the drbd package to a newer 0.6.x version, the drbd package is 
updated and still conflicts with drbd0.7 ... but if you do not have drbd0.7 
installed, then you see the newer drbd package from the 0.6 series.

You also can update the drbd0.7 package to a newer version with this conflict 
to drbd, the conflict doesn't stop the debian upload process, it only helps 
the user to do not make stupid installations.

My first thought was: "And for note, a debian package can't named drbd0.7 
(with point) ... the normal way for such transitions is to add the next 
higher number to the end of package name ... so you have then drbd (old name) 
and drbd1 (new name)."

but as you can see for the libswig package a point in name is possible:

http://packages.debian.org/cgi-bin/search_packages.pl?version=all&subword=1&exact=&arch=any&releases=all&case=insensitive&keywords=libswig&searchon=names

It have likely same conflict/update setup.

Greetings Alex//
