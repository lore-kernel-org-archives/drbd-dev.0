Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4EF0A2D9DC71
	for <drbd-dev@lists.linbit.com>; Thu,  7 Dec 2006 16:56:47 +0100 (CET)
Date: Thu, 7 Dec 2006 16:56:48 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] lock for reading device state
Message-ID: <20061207155648.GF7521@soda.linbit>
References: <4576FC63.704@dcs.gla.ac.uk> <20061207130920.GD7521@soda.linbit>
	<45781C8F.1080400@dcs.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45781C8F.1080400@dcs.gla.ac.uk>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-07 13:52:15 +0000
\ Cristian Zamfir:
> 
> 
> Lars Ellenberg wrote:
> >/ 2006-12-06 17:22:43 +0000
> >\ Cristian Zamfir:
> >>
> >>Hi,
> >>
> >>I am using drbd to implement xen block device migration.  Right now I
> >>am parsing /proc/drbd to find out if the drives are synchronized and I
> >>can migrate them.
> >you talk about drbd state "Connected, Consistent",
> >or what exactly are you parsing?
> 
> Yes, indeed, I am parsing these values: "cs:Connected st:Secondary/Primary ld:Consistent"
> 
> 
> >>Is there a way to obtain a lock while reading and processing this
> >>information and prevent other writes to the primary device?
> >no. why?
> 
> I wrote a script that parses /proc/drbd on the primary node. While I am running this script, writes to the primary 
> device are still allowed. If I find that the ld state is "Consistent" then I will make this node secondary and the 
> peer will become primary.
> The problem is when writes happen while my script is making the peer node primary.
> 
> A race situation would be the following:
> At moment X, I read /proc/drbd and see the ld state is consistent.
> At moment X+1 a write arrives at /dev/drbd1 and the devices are not
> consistent any more. They start syncing but this may last longer, for
> instance until moment X+5.
> Now, at moment X+2, I wrongly believe that the state is still
> consistentand I decide to make the peer node primary and thus loose
> the write at moment X+1.
> 
> Are my assumptions correct so far?

no. you don't "become Inconsistent" because "some write".

"Consistent" in drbd speak is "not Inconsistent".
oh well.
so what is Inconsistent.
drbd starts as beeing "inconsistent" when the meta data is first
initialized. then you force one side to think it is Consistent,
to be able to make it Primary, and the initial full sync starts.

Once the sync is finished, the sync target becomes Connected Consistent.
If the nodes now disconnect, they still are "Consistent" in the sense of
"whatever data is on that disk, it is transactional consistent, though
maybe it is not 'clean', i.e. you may have to replay some journal to get
into 'clean' state."

You get into "Inconsistent" only by becoming SyncTarget after
(re)establishing the connection to the Peer and the handshake determins
that your data is different from the Peers, and the Peers is "better"
(which typically means "newer").

Because the Resync copies changed blocks linearly over the device,
while new writes get mirrored already, the data on the SyncTarget is
"not Consistent" anymore during sync. Even if we had data journalling
during degraded mode, and would replay that during Sync, the SyncTarget
would stay Consistent but "outdated" until the Resync was completely
done.

> I'm thinking that there are two solutions: One would be to prevent any writes from Xen's domUs by modifying Xen.
> The other would be to be able to hold a lock that prevents writes from reaching /dev/drbdX and release it after the 
> processing within the script finishes (that is while I switch the peer device from secondary to primary).
> 
> I haven't looked at drbd's source yet ( I am using 0.7.22 now) but I am considering implementing this lock within 
> drbd if there is no other solution available.

That "lock" does not make sense to me,
and even if you could do it, it won't solve that "race",
it would only move it to some other point in time.

Note that a device in Secondary state denies access.
Also note that you cannot make a device Primary if it sees its Peer as
being Primary (unless you use drbd8, and explicitly allow
"two-primaries").
And a device that knows it is "Inconsistent" cannot be made Primary,
unless it is Connected, in which case it would be SyncTarget and get the
good data from the SyncSource Peer.

So what you need to do for xen migration with drbd 0.7 is:
Start the migration, once you think you want to switch over, i.e.
 ** once you are done writing on nodeA **
 ** you switch nodeA to Secondary.     **
now, both nodes are Secondary, and neither can write.
now you can check wether the target nodeB is still Connected, Consistent.
if so, you make it Primary.
if not, you abort the migration.

"locking" the state of drbd or freezing io while it is Primary on
migration source nodeA won't help you in any way.

> As a future project, I am also interested if there is anyone working
> on implementing multiple secondary devices. I am interested in having
> multiple replicas of the primary node.

here at LINBIT we have some very nice concepts about how we'd implement
multiple (> 2) nodes and other nice features. But don't ask about timelines.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
