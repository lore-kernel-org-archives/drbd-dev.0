Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 262EC1028A59
	for <drbd-dev@lists.linbit.com>; Fri, 31 Jul 2015 14:49:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Nick Wang <nwang@suse.com>
Date: Fri, 31 Jul 2015 14:48:53 +0200
Message-ID: <1950665.2mvfrclfR5@fat-tyre>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [Patch v2 00/10] Zero out devices instead of initial
	full sync
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

Hi Nick,

finally I have time to really review it:

* it uses blkdev_issue_zeroout() with the discard parameter
  set to false. I.e. it will completely allocate a thinly
  provided backing device. Please make this more generic.
  Maybe two one option --zeroout-device and --discard-device
  instread of --zap-device

* The patch-set is not very complex, I am fine with having
  this in a single patch

* It introduces a new packet into the protocol without 
  bumping the protocol version or introducing a protocol
  reature flag. Do that, and make sure to send the new 
  packets only when you know that the peer is recent enough
  to process them.
  See here for an example:
  http://git.drbd.org/gitweb.cgi?p=drbd-8.4.git;a=commitdiff;h=476039f699948155d71d6f86323a3b16e6d05f0c;hp=4c7521e19c6c2c046be6547490334294b6f190e4

Best regards,
phil

> Patch set is based on drbd-8.4 859e34a9, have
> already compiled/tested against SLES12.
> 
> If this feature can be merged into upstream, please
> ignore v1, since v1 may caused pingACK timeout when
> zeroing out large device.
> 
> Compare to v1, changes are as follow:
>  1. Using drbd_device_post_work to zero out device as background
>     task, so that it won't block pingACK when zeroing out
>     large device.
> 
>  2. Fix bug of won't update peer node status if it finished
>     zeroing out earier.
> 
>  3. Change some functions from file drbd_receive.c to
>     drbd_worker.c and reorder the patch set.
> 
> 
> Full sync for drbd initial usually take a long time, especically
> when network become the bottleneck of the syncing. Simply skip
> the full sync with "--clear-bitmap" may not the perfect solution
> for all the cases, like using the bare device(no filesystem) to
> work,etc database,vm... This patche set can be used to zero out
> devices locally instead of a full sync to make the consistent
> block device. This approach can be useful when lack of network
> bandwidth to sync.
> 
> The patches add one new option "--zap-devices" to "new-current-uuid"
> to zero out devices. It will start zeroing out devices of both
> side.
> 
> Nick Wang (10):
>   drbd: Fix the wrong logic of move history.
>   drbd: Add options zap_devices to new-current-uuid
>   drbd: Add a function to zero out drbd backing device.
>   drbd: New packet P_ZERO_OUT.
>   drbd: Functions to notify peer node to start
>         zeroing out and zero out finished.
>   drbd: Wapper for zeroing out device by worker.
>   drbd: Add flag for drbd device work.
>   drbd: Function to work with packet P_ZERO_OUT.
>   drbd: Receive zero out command from peer node.
>   drbd: Handle new-current-uuid --zap-devices.
> 
> Signed-off-by: Nick Wang <nwang@suse.com>
> CC: Philipp Reisner <philipp.reisner@linbit.com>
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: drbd-dev@lists.linbit.com
> CC: linux-kernel@vger.kernel.org
> 
>  drbd/drbd_int.h        | 13 ++++++++
>  drbd/drbd_main.c       | 51 ++++++++++++++++++++++++++--
>  drbd/drbd_nl.c         | 21 +++++++++++-
>  drbd/drbd_protocol.h   |  1 +
>  drbd/drbd_receiver.c   | 69 ++++++++++++++++++++++++++++++++++++++
>  drbd/drbd_worker.c     | 90
> ++++++++++++++++++++++++++++++++++++++++++++++++++ drbd/linux/drbd_genl.h |
>  1 +
>  7 files changed, 243 insertions(+), 3 deletions(-)

