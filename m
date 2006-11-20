Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
Date: Mon, 20 Nov 2006 08:38:44 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C83C@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks!  I will retest our scenario with this new configuration.
Hopefully this will yield the desired results for our specific
configuration.  Thanks a lot.

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Saturday, November 18, 2006 6:01 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest; Graham, Simon
Subject: Re: [Drbd-dev] DRBD8: Split-brain false positive on
Primary/primary potential patch

Am Dienstag, 7. November 2006 00:47 schrieb Montrose, Ernest:
> When running Primary/Primary if the Heartbeat connection goes down
when
> we recover we always split brain.  Simon had an idea which I have
> implemented. He is on vacation  so this may not reflect his exact
idea.
>
> Essentially with this change, we do not create a new current UUID on
the
> node unless I/O is seen. This prevent Split-Brain mitigation when both
> nodes are primary but only one node is originating I/O and never the
> other.  He is only stand-by in that case.
>
> Take a look and let me know.
>

Hi Ernset and Simon,

I found an good examply why I do not like this approach:

  N1/P   ---    N2/P/M both primary, FS mounted on N2 and is completely
idle.
  N1/P   - -    N2/P/M network breaks (still unchanged UUIDs on both
sides)
  N1/P/M - -    N2/P/M users mounts FS on N1 (and modifies data, new
UUID N1)
  N1/P   - -    N2/P/M users umounts FS on N1.
  N1/P   ->-    N2/P/M Network gets repaired. Sync from N1 to N2.

  With the patch you sent, we would get a resync from N1 to N2,
instantly=20
  corrupting all the cached information that the FS on N2 might have
from=20
  the data!


I understand you test scenario therefore I introduced this solution to
your
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
                      algorithm. Even if that causes case an erratic
change
                      of the primarie's view of the data.
                      This is only usefull if you use an 1node FS (i.e.
                      not OCFS2 or GFS) with the allow-two-primaries
                      flag, _AND_ you really know what you are doing.
                      This is DANGEROUS and MAY CRASH YOUR MACHINE if
you
                      have a FS mounted on the primary node.


Now you need to configure it like this:

after-sb-0pri discard-zero-changes;
after-sb-1pri violently-as0p;
after-sb-2pri violently-as0p;

And you can do the tests with the behaviour you expect, but other
users are free to select an other behaviour.

-Phil
