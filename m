Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Deadlock in PausedSyncS
Date: Thu, 2 Aug 2007 11:44:49 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F4799A@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F4799A@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708021144.49764.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 31 July 2007 00:31:19 Montrose, Ernest wrote:
> Hi all,
> We are seeing a problem where we deadlock if a pause sync request
> happens while attaching.  Below is an explaination of what I think is
> occurring:
>
> Consider two nodes X primary and Y Secondary.
> 1. X becomes Secondary/Diskless
> 2. Y becomes Primary
> 3. X tries to Attach and sends its states/uuids to Y
> 4. While Y is in receive_state() doing a drbd_sync_handshake(), it
> receives a Paused Sync request.
>   This is where the trouble starts.
> 5. aftr_isp is changed from 0->1 on Y and after_state_ch() called.  This
> triggers
>   a drbd_send_state() from Y.
> 6.  X receives States from Y but no uuids and runs a
> drbd_sync_handshake() with the old uuids and
>     we deadlocked with PausedSyncS on both sides.
>
> I am not sure how to best fix this.  Perhaps we should not call
> drbd_send_state()
> in after_state_ch() for a sync request from the peer if the peer's disk
> is diskless.
> Or we do send states, sends the uuids as well.  The attached patch will
> at least serve as an illustration of the issue if not the correct fix.
>


Hi Ernest,

Your patch was correct I think. But in reality we have not only this
one case of the problem it is a whole class of such problems. 

While the node that gets the new disk is in disk=Negotiating, it 
will run drbd_sync_handshake() on each state packet that comes in.

We need to avoid this. Calling pause-sync is just one possible way
to cause the transmittion of a state packets, this is a whole class
of such problems.

Instead of fixing every place where we send a state packet, to not
send it if the peer has no disk, I decided to fix the receiving
side.

http://lists.linbit.com/pipermail/drbd-cvs/2007-August/001613.html

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
