Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 10 Mar 2011 12:00:23 +0100
References: <201103091523.51815.philipp.reisner@linbit.com>
	<4D789ED1.6060905@kernel.dk>
In-Reply-To: <4D789ED1.6060905@kernel.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103101200.24005.philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD bits for 2.6.39
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> Philip, sorry for the extra work, but can I please ask you to rebase
> this on the new for-2.6.39/core? Two things happened:
> 
> - I pulled in the stack-plug changes, it's causing a few conflicts. All
>   of them are trivial, so that's not a real worry.
> 
> - I had to rebase for-2.6.39/core to get rid of an OOPS in the
>   ->check_events() changes from Tejun.

Hi Jens,

Done, it is rebased:

The following changes since commit 4c63f5646e405b5010cc9499419060bf2e838f5b:

  Merge branch 'for-2.6.39/stack-plug' into for-2.6.39/core (2011-03-10 
08:58:35 +0100)

are available in the git repository at:

  git://git.drbd.org/linux-2.6-drbd.git for-jens

Andreas Gruenbacher (22):
      drbd: Removed an unnecessary #undef
      drbd: Make sure that drbd_send() has sent the right number of bytes
      drbd: Remove left-over prototype
[...]

BTW, since we got a request for a "summary change-log":

8.3.10 (api:88/proto:86-96)
--------
 * Fixed a subtle performance degradation that might affected synchronous
   work loads (databases) (introduced in 8.3.9)
 * Fixed a locking regression (introduced in 8.3.9)
 * Fixed on-no-data-accessible for Primary, SyncTarget nodes (Bugz 332)
 * Progress bar for online verify
 * Optionally use the resync speed control loop code for the online verify
   process as well
 * Added code to detect false positives when using data-integrity-alg
 * New config option on-congestion and new connection states ahead and behind
 * Reduced IO latencies during resync, bitmap exchange and temporal states
 * On 64bit architectures allow device sizes up to one petabyte

Best,
 Phil
