Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Yeary, Mark A." <MYeary@utnet.utoledo.edu>
Date: Fri, 1 Apr 2005 08:51:06 +0200
References: <7A74B5DE6E54D849BAF89B9E2945F11B13E42F@MSG00CV01.utad.utoledo.edu>
In-Reply-To: <7A74B5DE6E54D849BAF89B9E2945F11B13E42F@MSG00CV01.utad.utoledo.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200504010851.06410.philipp.reisner@linbit.com>
Cc: drbd-dev@linbit.com
Subject: [Drbd-dev] Re: On the edge...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 1. April 2005 00:09 schrieben Sie:
> Dear Philipp,
>
>      This weekend my IBM X445's go online with DRBD 0.7.10.  When it has
> been online for a week or so and all runs great I will write a page for
> your site.  I am very nervous as I have almost 39,000 distance learning
> course enrollments running on these boxes.  I would like to ask you one
> more question.  Every night I do a dump of all of my course data to a
> scsi tape drive.  I would like to perform this function on what is
> normally my drbd secondary.  Is there any reason I cannot shut down
> heartbeat on the secondary, shut down all of the secondary ethernet
> interfaces, change the secondary drbd drive to primary temporarily,
> mount it and dump it to tape?  Afterwards I would unmount the drive on
> the secondary, return it to secondary status, turn my interfaces back
> on, do a "drbdadm up all" and then restart heartbeat?  Is this ok as
> long as I do not write data to the secondary when I have it mounted?
> Thanks for this one last piece of advice before I go live.  I'm trying
> to use the secondary to capture a snapshot to tape.  My primary will
> still be running and collecting data but when I put my secondary back
> online it should replicate to the primary, right?  I have tested this
> and it seems to work but I want your advice.  If you say, "No ! Don't do
> that !"  then I won't.
>

Hmmm.... Well, right it works with drbd-07 ...
The former primary increases its connected-count on disconnect, while
the other one increases its unconnected-count.=20
On reconnect the all-the-time primary becomes sync-source because the
connected-count has a higher priority than the unconnected-count.

So for your production system you will go online with, it is ok
to do so. It will also work with subsequent drbd-07 releases...

One hint:
  You might use "drbdadm disconnect all" and "drbdadm connect all"
  on the seondary, instead of shutting down the ethernet interfaces.

=2D

But let's look at the picture from a more formal point of view:

Actually you created a split brain situation, and crate a own
version of the data by making it primary temporarily. At reconenct
time DRBD should say "We had a split brain situation..." and offer
the recovery policies as discussed in item 5 of=20
http://svn.drbd.org/drbd/trunk/ROADMAP .

But on the other hand it is a usefull ussage pattern.... But should
probabely be a special command for that. Something like

"drbdadm snapshot resource"

This would be a new state besides primary and secondary. A resource
in snapshot state would allow read-only access, on the transition
from secondary -> snapshot it would disconnect itself.=20
primary -> snapshot is not allowed.
snapshot -> secondary would reconnect the resource, but is only=20
possible if we can claim the device again =3D=3D it is no longer mounted.

=2Dphilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
