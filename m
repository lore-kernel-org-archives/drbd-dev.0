Return-Path: <lars@linbit.com>
Date: Mon, 25 Feb 2008 22:06:58 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] I/O can hang on primary synctarget after an io error.
Message-ID: <20080225210658.GB14695@mail.linbit.com>
References: <342BAC0A5467384983B586A6B0B3767108591DEC@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47ACB@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47ACB@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Feb 25, 2008 at 03:31:01PM -0500, Montrose, Ernest wrote:
> 
>    Hi all,
> 
>    We are seeing an issue where I/O to a volume that received an I/O
>    error during re-sync as the sync target hangs. Looking at the logs it
>    seems that what's going on is that we are skipping a dec_local().  My
>    theory is that after_state_ch() is blocked forever waiting for
>    local_cnt to be 0 as we are becoming Diskless.  So the worker will not
>    do any work, hence the hang I/O.  Here is the relevant logs:
> 
> 
>    Feb 13 03:48:55 node0 kernel: drbd5: Began resync as SyncTarget (will
>    sync 1048508 KB [262127 bits set]).
>    Feb 13 03:48:55 node0 kernel: drbd5: Writing meta data super block
>    now.
>    Feb 13 03:48:55 node0 kernel: drbd5: Creating new epoch in
>    drbd_try_rs_begin_io
>    Feb 13 03:48:55 node0 kernel: drbd5: ***Simulating Resync write
>    failure
>    Feb 13 03:48:56 node0 kernel: drbd5: Resync aborted.
>    Feb 13 03:48:56 node0 kernel: drbd5: conn( SyncTarget -> Connected )
>    disk( Inconsistent -> Failed )
>    Feb 13 03:48:56 node0 kernel: drbd5: Local IO failed. Detaching...
>    Feb 13 03:48:56 node0 kernel: drbd5: disk( Failed -> Diskless )
>    Feb 13 03:48:56 node0 kernel: drbd5: Notified peer that my disk is
>    broken.
>    Feb 13 03:48:56 node0 kernel: drbd5: Can not write resync data to
>    local disk.
>    Feb 13 03:54:57 node0 kernel: drbd5: drbd_nl_disk_conf: mdev->bc not
>    NULL.
> 
> 
>    Notice the last line of the log.  Our test environment must have tried
>    to do an "attach" so since local_cnt is not 0 we never freed the "bc".
> 
> 
>    But from the "Can not write resync data to local disk." we can go to
>    drbd_endio_write_sec() and there we see a suspicious :
> 
>    If(bio->bi_size) return 1;

it's not suspicious. it's "standard procedure".
it even got removed from the internal kernel API recently.

>    We are supposed to do the dec_local at the end of drbd_endio_write
>    sec(). I am guessing that's where the problem is.  But I do not know
>    why bi_size would be greater then 0.  Is the fix simply to dec_local
>    while returning?

IF there is imbalance in the local refcounting, then elsewhere.
drbd_endio_write_sec is correct, afaics.

do you have this a009fc907a14f69026b32fbb48a4db6f1cdd5ecd
commit included in your code base?

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
