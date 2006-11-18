Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
Date: Sat, 18 Nov 2006 12:00:40 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C826@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C826@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181200.41393.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 7. November 2006 00:47 schrieb Montrose, Ernest:
> When running Primary/Primary if the Heartbeat connection goes down when
> we recover we always split brain.  Simon had an idea which I have
> implemented. He is on vacation  so this may not reflect his exact idea.
>
> Essentially with this change, we do not create a new current UUID on the
> node unless I/O is seen. This prevent Split-Brain mitigation when both
> nodes are primary but only one node is originating I/O and never the
> other.  He is only stand-by in that case.
>
> Take a look and let me know.
>

Hi Ernset and Simon,

I found an good examply why I do not like this approach:

  N1/P   ---    N2/P/M both primary, FS mounted on N2 and is completely idle.
  N1/P   - -    N2/P/M network breaks (still unchanged UUIDs on both sides)
  N1/P/M - -    N2/P/M users mounts FS on N1 (and modifies data, new UUID N1)
  N1/P   - -    N2/P/M users umounts FS on N1.
  N1/P   ->-    N2/P/M Network gets repaired. Sync from N1 to N2.

  With the patch you sent, we would get a resync from N1 to N2, instantly 
  corrupting all the cached information that the FS on N2 might have from 
  the data!


I understand you test scenario therefore I introduced this solution to your
problem:

Implemented a new after-slit-brain-0pri policy:
       "discard-zero-changes"
                      Auto sync from the node that modified
                      blocks during the split brain situation, but only
                      if the target not did not touched a single block.
                      If both nodes touched their data, this policy
                      falls back to disconnect.

And a new after-sb-1pri & 2pri policy
     "violently-as0p" Alsways take the decission of the "after-sb-0pri"
                      algorithm. Even if that causes case an erratic change
                      of the primarie's view of the data.
                      This is only usefull if you use an 1node FS (i.e.
                      not OCFS2 or GFS) with the allow-two-primaries
                      flag, _AND_ you really know what you are doing.
                      This is DANGEROUS and MAY CRASH YOUR MACHINE if you
                      have a FS mounted on the primary node.


Now you need to configure it like this:

after-sb-0pri discard-zero-changes;
after-sb-1pri violently-as0p;
after-sb-2pri violently-as0p;

And you can do the tests with the behaviour you expect, but other
users are free to select an other behaviour.

-Phil
