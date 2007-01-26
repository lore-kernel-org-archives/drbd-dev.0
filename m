Return-Path: <lmb@suse.de>
Date: Fri, 26 Jan 2007 16:24:08 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20070126152408.GT4268@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] Minor drbd 0.7 bugs
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I played around with drbd0.7 and heartbeat on a lonely train ride
yesterday ;-)

- drbdadm disconnect seems to also demote a primary; I'd expect it to
  just disconnect it from the secondary?

- freeze_io doesn't seem to work. It freezes the Xen guest completely,
  not just the IO. My expectation would have been for it to freeze io,
  until either reconnected or explicitly told to disconnect and go to
  standalone mode?

- drbdadm primary does not bubble up errors from drbdsetup.

  ioctl(,SET_STATE,) failed: Permission denied
  Partner is already primary 
  Command '/sbin/drbd setup /dev/drbd0 primary' terminated with exit code 20
  drbdadm aborting

  Still, drbdadm returned with exit code 0.


Sincerely,
    Lars

-- 
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge."

