Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Sat, 6 Jan 2007 00:15:36 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671046140CB@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: BUG when disk write errors occur during heavy I/O
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

We have encountered a BUG crash when inserting real disk errors during =
I/O as follows:

drbd0: drbd_md_sync_page_io(,8191929s,WRITE) failed!
drbd0: Notified peer that my disk is broken.
Jan=A0 5 06:24:09=A0 1:0:28:0: rejecting I/O to dead device
drbd0: got an _req_mod() errno of -5
drbd0: Local WRITE failed sec=3D675944s size=3D4096
tennille kernel: drbd0: got an _req_mod() errno of -5
------------[ cut here ]------------
kernel BUG at =
/test_logs/builds/SuperNova/trunk/070105/platform/drbd/src/drbd/lru_cache=
.c:120!

This is actually in this code:

struct lc_element* lc_find(struct lru_cache* lc, unsigned int enr)
{
    struct hlist_node *n;
    struct lc_element *e;

    BUG_ON(!lc);

called from=20

void drbd_al_complete_io(struct Drbd_Conf *mdev, sector_t sector)
{
...
    spin_lock_irqsave(&mdev->al_lock,flags);

    extent =3D lc_find(mdev->act_log,enr);

So the act_log field was NULL when the lc_find executed.

Now, I believe the following is what happened:

1. We had a write error in the meta-data region of the disk -- the code =
I added a while back forces
   the error to be processed and will change the state to Diskless. This =
code path blocks waiting
   for the mdev->local_cnt to reach zero (which it isn't because there's =
a bunch of I/O outstanding)

2. The last outstanding local write completes (either with or without an =
error) and we end up running
   req_mod with write_completed_with_error or completed_ok. This code =
does a dec_local() BEFORE calling
   req_may_be_done -- thus it's entirely possible for the stalled code =
from above that is waiting
   for local_cnt to reach zero will run and release the act_log and =
resync data.

3. Now the req_may_be_done() call for the last I/O is called which calls =
drbd_al_complete_io which
   calls lc_find which BUGs because act_log is now NULL.

Now, it seems to me there are a couple of ways to fix this:

1. We could delay calling dec_local() until all the code that might =
reference fields in the mdev is
   done -- i.e. after _req_may_be_done is called - I'm worried this =
might cause problems though.

2. Change drbd_al_complete_io to check act_log inside the spin lock. =
Also change after_state_change
   to acquire the spinlock before freeing act_log and resync AND any =
other places that use act_log and
   resync to check for NULL. I'd be worried about finding all the =
possible places with this fix.

So -- I'm looking for guidance on the best way to fix this =
sycnronization issue
Thanks,
Simon
   =20
