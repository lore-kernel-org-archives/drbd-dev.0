Return-Path: <Craig.Magina@stratus.com>
Received: from mailhub4.stratus.com (mailhub4.stratus.com [134.111.1.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ABA2D105E5B0
	for <drbd-dev@lists.linbit.com>; Wed,  3 Mar 2010 21:49:32 +0100 (CET)
Received: from EXHQ.corp.stratus.com (exhq.corp.stratus.com [134.111.201.100])
	by mailhub4.stratus.com (8.12.11/8.12.11) with ESMTP id
	o23KnVXD001046
	for <drbd-dev@lists.linbit.com>; Wed, 3 Mar 2010 15:49:31 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 3 Mar 2010 15:50:01 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C9809384@EXHQ.corp.stratus.com>
From: "Magina, Craig" <Craig.Magina@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] .filelist build target broken by commit
	d6bcfd29e249d40ebe01a573ab8573e74593422a
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Changes were made to drbd/linux/drbd_config.h adding REL_VERSION =
preprocessor code.  However, the base Makefile uses a sed on that file =
looking for REL_VERSION to populate DIST_VERSION with, which the =
.filelist build target uses.  This sed was not updated to match these =
changes, so it gets populated with "#ifdef REL_VERSION" instead of =
"8.3.7".  I hit this while trying to build the tarball target in order =
to build an rpm from a freshly cloned drbd-8.3 repository.

Craig Magina
