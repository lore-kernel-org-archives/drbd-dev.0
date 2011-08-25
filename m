Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:06:56 +0200
Message-Id: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
	support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This the first request for review of drbd-8.4. The complete set has 
500 patches. In this first series there are only 118 of these.

The most noticeable change is the support for multiple replicated volumes in
a single DRBD connection.  Write-ordering is obeyed among all writes in all
volumes in a single connection.  This feature is really important for users
who use DRBD for mirroring over longer distances. (Protocol A).

0001 - 0012  cleanups
0013 - 0026  replace the hash tables of drbd_requests with two interval trees
0027         have a look at the idr_for_each_entry(). Outside of drbd's directory.
0028 - 0035  introduced a new object which represents a DRBD connection;
             move a view members from the device object to the new conenction
             object
0036 - 0041  Introduce volume numbers into the protocol
0042 - 0052  cleanups; renames; 
0053         Improvements to handling of conflicting writes
0054 - 0060  cleanups; renames; 
0061 - 0064  code reorganisation
0065         IO latency bugfix
0066 - 0099  moving members from the device object to the connection object;
             converting function from the device object to the connection obj
0100 - 0118  work on the state engine to match the new object model
