Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2007 11:03:07 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105FCED4F@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Skipping initial sync of DRBD devices...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I've been following the advice documented at
http://drbd-plus.linbit.com/examples:skip-initial-sync to skip the
initial sync of devices when you know that the first thing you will do
is create a filesystem on the device and have run into a problem;
although the initial sync is indeed skipped, I see this warning in the
messages file:

	No resync, but XXX bits in bitmap!

where XXX is the size of the volume. If you then reboot one of the nodes
(or suffer a connection failure), when the connection comes back, you
end up syncing the entire volume unnecessarily - because the
reboot/connectionloss causes the remaining node to update it's meta-data
so when the node comes back, it looks like a sync is needed and since
all it's on-disk bitmap bits are set, we have to sync the whole disk.

Now, I notices this output from drbdmeta when creating the meta-data:

	NOT initialized bitmap (%u KB)

And I also see that drbdmeta.c has a define called
"DON'T_INITIALIZE_BITMAP" which indeed stops it from initializing the
bitmap area, so presumably we end up with whatever was on the disk area
as the bitmap for the new volume (and in my case, I'm recreating volumes
on a disk that previously had DRBD volumes on it, so I get whatever
bitmap was there previously).

I also note that even if you clear this define, the code actually SETS
all the bits in the bitmap, which would have the same (or even worse)
effect...

So - I think that to reliably skip the initial sync, we need to ensure
the bitmap is clear, I'm just not sure what the right way to do this is
- I see three alternatives:

1. Modify drbdmeta create-md to clear the bitmap -- presumably there was
a reason for setting the bitmap though?
2. Add a new drbdmeta command to clear the bitmap explicitely
3. Modify the driver to clear the bitmap when it sees bits unexpectedly
set -- I don't like this because it might
   result in data corruption if we hit some other bug...

Suggestions?
Simon
