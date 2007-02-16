Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io
	errorduring resync.
Date: Fri, 16 Feb 2007 12:43:52 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C8FC@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C8FC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702161243.52905.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 15. Februar 2007 16:44 schrieb Montrose, Ernest:
> Phil,
> I will try all these but I think I have some clues for you that may lead
> you to a fix.
> I instrumented the driver and caused the crash. Essentially what I
> understand to be happening
> Is that after_state_ch() is setting mdev->bc to NULL and then
> drbd_io_error() is using it
> after in: drbd_io_error(){.......
>   If(inc_local_if_state(mdev,Failed )){
> 	eh = mdev->bc->dc.on_io_error; <-----we die here I
> think.mdev->bc is NULL
> ...
> }
> Mdev->bc was set to Null earlier in after_state_ch(){.....
> If(os.disk >Diskless && ns.disk == Diskless){
> ....mdev->bc = NULL;
> ..
> }
>
> This is some sort of a race condition as this does not happen all the
> times.  

Ernest,

At first look I would say this is not possible. Because in 
after_state_ch() it only gets freed when we already reached the 
Diskless state.

In drbd_io_error() the access to mdev->bc is protected by the
inc_local() - dec_local() clasp. 

In case we are Diskless that inc_local_if...() fails.
And on the other side, before freeing it in after_state_ch() 
we wait until the local_count really reached 0. 

PS: Was my explanation how to create that .s files too brief ?

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
