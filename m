Return-Path: <dkrovich@csee.wvu.edu>
Received: from localhost (krovich.dsl2.d-mgtn.labyrinth.net [65.242.77.190])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 053A614301
	for <drbd-dev@lists.linbit.com>; Mon,  4 Oct 2004 16:30:58 +0200 (CEST)
Message-ID: <41615E9A.5070203@csee.wvu.edu>
Date: Mon, 04 Oct 2004 10:30:50 -0400
From: David Krovich <dkrovich@csee.wvu.edu>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 244291@bugs.debian.org
Subject: [Drbd-dev] 0.7.5 debian stuff
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I started looking at the debian directory released with the 0.7.5 
tarball.  Since we're changing some things around, how about the following?

Have the drbd source package create 2 binary packages, one named 
drbd-utils and one named drbd-modules-source.  I think those would be 
much cleaner names for the binary packages.

I like the fact that drbd0.7 conflicts drbd << 0.7, but do we think 
0.6.x is no longer being used?  If we upload this package into debian, 
how would we ever be able to upload a newer version of the 0.6.x series?
