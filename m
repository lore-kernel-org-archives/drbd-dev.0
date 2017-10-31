Return-Path: <me@tobin.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
	[66.111.4.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 917981058015
	for <drbd-dev@lists.linbit.com>; Tue, 31 Oct 2017 04:58:23 +0100 (CET)
Date: Tue, 31 Oct 2017 14:58:18 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: drbd-dev@lists.linbit.com
Message-ID: <20171031035818.GA6109@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] verbose log output from drbd kernel module
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

Currently the drdb kernel module is a little bit verbose. While there
are numerous repeated log lines, a number of them are repeated in
different sequences. It is not immediately clear which lines
are _really_ necessary to understand what is going on. A good
understanding of drdb is probably required to reduce the duplicates
without loss of information. There are however a number of duplicate log
entries that appear consecutively, these could be reduced to a
single instance without loss of information (assuming the number of
times the error message appears consecutively is not useful
information).

So far I have found the following duplicate consecutive log entries

#

[ 1274.952627] F2FS-fs (drbd0): Magic Mismatch, valid(0xf2f52010) - read(0x29363930)
[ 1274.952646] F2FS-fs (drbd0): Can't find valid F2FS filesystem in 1th superblock
[ 1274.953695] F2FS-fs (drbd0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
[ 1274.953710] F2FS-fs (drbd0): Can't find valid F2FS filesystem in 2th superblock
[ 1274.953760] F2FS-fs (drbd0): Magic Mismatch, valid(0xf2f52010) - read(0x29363930)
[ 1274.953770] F2FS-fs (drbd0): Can't find valid F2FS filesystem in 1th superblock
[ 1274.953779] F2FS-fs (drbd0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
[ 1274.953786] F2FS-fs (drbd0): Can't find valid F2FS filesystem in 2th superblock

# After adding/deploying a resource 

[1368149.470125] drbd backups: Preparing cluster-wide state change 3280213538 (1->-1 3/1)
[1368149.470127] drbd backups: Committing cluster-wide state change 3280213538 (0ms)
[1368149.470136] drbd backups: role( Secondary -> Primary )
[1368149.474569] drbd backups: role( Primary -> Secondary )
[1368149.479674] drbd backups: Preparing cluster-wide state change 1520483517 (1->-1 3/1)
[1368149.479676] drbd backups: Committing cluster-wide state change 1520483517 (0ms)
[1368149.479685] drbd backups: role( Secondary -> Primary )
[1368149.484642] drbd backups: role( Primary -> Secondary )
[1368164.080148] drbd backups: Preparing cluster-wide state change 3014496965 (1->-1 3/1)
[1368164.080150] drbd backups: Committing cluster-wide state change 3014496965 (0ms)
[1368164.080161] drbd backups: role( Secondary -> Primary )
... [repeats many times]

# If block device is busy

[1369106.294749] drbd backups: Failed: role( Primary -> Secondary )
[1369106.297290] drbd backups: State change failed: Device is held open by someone
... [repeats 6 times]


Would it be useful to reduce these log lines to a single instance?

thanks,
Tobin.
