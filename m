Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: incorrect state transition Connected->WFBitMapS
	and UpToDate->Inconsistent
Date: Thu, 15 Nov 2007 11:34:14 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A36@EXNA.corp.stratus.com>
In-Reply-To: 200711151727.05736.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com><BD7042533C2F8943A6A4257A9E31C454F47A31@EXNA.corp.str
	atus.com> 200711151727.05736.philipp.reisner@linbit.com
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
I will test and advise later.

Thanks.

EM--

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Thursday, November 15, 2007 11:27 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: incorrect state transition
Connected->WFBitMapS and UpToDate->Inconsistent

On Monday 12 November 2007 14:41:10 Montrose, Ernest wrote:
> Hi,
> We have been struggling with a problem where one side gets stuck in
> WFBitMapS and Inconsistent State. Consider two nodes (Node0 and
node1).
>
>
> * Device r5 on node0 starts syncing as the synctarget.
> * Device r5 is done syncing and on node0 we call
drbd_resync_finished()
> this gets delayed for a bit in drbd_rs_del_all()
> * During this delay, device R0   wants to resync.  So the lower
priority
> devices like R5 gets paused.  This is were the trouble starts.

Right. But Something else happens...

[...]
> Oct  4 14:56:01 node0 kernel: drbd60: Syncer continues.
> Oct  4 14:56:01 node0 kernel: drbd60: ASSERT(
> !test_bit(STOP_SYNC_TIMER,&mdev->flags) ) in
> /sandbox/sgraham/sn/trunk/platform/drbd/src/drbd/drbd_main.c:786

That assert caught my attention, and this is my understanding what
went wrong...

r5 was already finished with its resync timer and calling=20
w_make_resync_request(), but due to the continue event after the
pause the timer got restarted...

Unfortunately the drbd_bm_find_next() searched through all the
bitmap and found those bits near the end that where not yet=20
cleared, and so resync requests where resent...

Therefore...

[...]
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused
0
> sec; 384 K/sec)
[...]
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused
0
> sec; 0 K/sec)
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused
0
> sec; 0 K/sec)
> Oct  4 14:56:09 node0 kernel: drbd60: Connected in
w_make_resync_request
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused
0
> sec; 0 K/sec)

... we got multiple calls to drbd_resync_finished().

Here is my suggestion to fix that.

1) Do not restart the timer after a syncpause, when the timer is no=20
   longer needed.

2) To make the whole thing more robust against such bugs,=20
   drbd_bm_find_next() should not reset the find_offset back to 0
   after it hit the end of the bitmap once.

I have not tested it.... but I think this should do...

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
