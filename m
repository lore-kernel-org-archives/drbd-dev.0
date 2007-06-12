Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Panic in drbd_uuid_compare due to mdev->bc
	being null
Date: Tue, 12 Jun 2007 16:39:54 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F4792B@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F4792B@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706121639.54538.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 11 June 2007 22:17:25 Montrose, Ernest wrote:
> Hi all,
>
> We are seeing a panic that occurs while syncing.  Essentially if you are
> primary and you are syncing and get an io error then on the next attach
> you can panic.  Especially if that attach happens quickly after the
> detach.
>
> I think what's happening is this:
> * The local disk dies and we transiton to "Diskless"
> * After_state_ch() suppose to call drbd_free_bc() to free mdev->bc.
> * But before we can free mdev->bc, mdev->local_cnt would have to be 0,
> in this case it was not.  Not too sure why. So we wait for
> mdev->local_cnt to become 0.
> * While waiting an "Attach" request comes in. We ASSERT that mdev->bc is
> not NULL but we brush it off, set a new bc and leak the old.
> * The wait in after_state_ch is now over. we free the new mdev->bc that
> the "attach" had set.
> * we call drbd_sync_handshake(), access a NULL mdev->bc and we die.
>
> A quick thing to do is to just fail the attach request if mdev->bc is
> not null. Patch included
>
> EM--

Hi Ernest,

Thanks! I just changed it to Linux coding style, and shortened it a 
bit. It is commited.

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
