Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD 8.0 PATCH] Update state processing so that
	after-state-change is always done in worker thread
Date: Tue, 15 Jan 2008 10:14:07 +0100
References: <342BAC0A5467384983B586A6B0B3767107C5AF5E@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AF5E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801151014.07561.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 11. Januar 2008 16:22:15 schrieb Graham, Simon:
> This patch updates the state processing so that the after state change
> processing is always done on the worker thread - my main motivation for
> this was to ensure that state change notifications are never re-ordered.
>
>
> This also involves the following:
> 1. starting the worker thread is done inline in drbd_set_state
> 2. the worker will be started whenever it is needed rather than
>    only when certain states are reached.
> 3. Marking the meta data dirty is done inline in drbd_set_state
>
> Simon

Hi Simon,

I definitely want to pick up that one, here are my notes from my
first review:

> @@ -818,19 +830,18 @@ int _drbd_set_state(drbd_dev* mdev, drbd_state_t
> ns,enum chg_state_flags flags) os.peer == Secondary && ns.peer == Primary)
>  		set_bit(CONSIDER_RESYNC, &mdev->flags);
>
> -	if( flags & ScheduleAfter ) {
> -		struct after_state_chg_work* ascw;
> -
> -		ascw = kmalloc(sizeof(*ascw), GFP_ATOMIC);
> -		if(ascw) {
> -			ascw->os = os;
> -			ascw->ns = ns;
> -			ascw->flags = flags;
> -			ascw->w.cb = w_after_state_ch;
> -			drbd_queue_work(&mdev->data.work,&ascw->w);
> -		} else {
> -			WARN("Could not kmalloc an ascw\n");
> -		}
> +	/* Make sure worker thread is running -- this is a NOP if it is already running */ 
> +	drbd_thread_start(&mdev->worker); 
> +

It is not allowed to call drbd_thread_start() while we are in _drbd_set_state(),
because drbd_thread_start() uses a sleeping function (wait_for_completion()).
And _drbd_set_state() is running with the req_lock hold.

But I think that can be easily took out of _drbd_set_state(), and done in the
context of the netlink connector callbacks.

I will prepare that...

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
