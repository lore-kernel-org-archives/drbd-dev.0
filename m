Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9794C1050584
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 10:54:08 +0200 (CEST)
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id 64925AD09BB
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 10:54:08 +0200 (CEST)
Date: Mon, 11 May 2015 10:54:03 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: drbd-dev <drbd-dev@lists.linbit.com>
Message-ID: <1945028087.159.1431334443252.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] drbdmanage lintian warnings
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
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

I compile my own debian package on jessie, but get many lintian warnings about
man pages:

# lintian drbdmanage_0.34-1_amd64.deb
warning: the authors of lintian do not recommend running it with root
privileges!
W: drbdmanage: manpage-has-bad-whatis-entry
usr/share/man/man8/dm-add-resource.8.gz
W: drbdmanage: manpage-section-mismatch
usr/share/man/man8/dm-add-resource.8.gz:2 8 != ADD-RESOURCE
W: drbdmanage: manpage-has-bad-whatis-entry
usr/share/man/man8/dm-add-volume.8.gz
W: drbdmanage: manpage-section-mismatch usr/share/man/man8/dm-add-volume.8.gz:2
8 != ADD-VOLUME
W: drbdmanage: manpage-has-bad-whatis-entry usr/share/man/man8/dm-assign.8.gz
W: drbdmanage: manpage-has-bad-whatis-entry
usr/share/man/man8/dm-assignments.8.gz
W: drbdmanage: manpage-has-bad-whatis-entry usr/share/man/man8/dm-attach.8.gz
...

Can someone reproduce that?

