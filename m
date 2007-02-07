Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8:Panics in lc_find due to null
	lcafterScsiMEDIUM_ERROR I.O error.
Date: Wed, 7 Feb 2007 13:59:53 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C8E1@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C8E1@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702071359.53872.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Samstag, 3. Februar 2007 00:27 schrieb Montrose, Ernest:
>  Phil,
> The one spot that was missed is in this patch.  I looked around for
> other places but I am
> Still not that everything is covered.

Hi Ernest,

I decided for a different patch:
http://lists.linbit.com/pipermail/drbd-cvs/2007-February/001460.html

Clearing the bit in the bitmap is valid in this case, we only
must not call drbd_try_clear_on_disk_bm(), since that function
in turn uses mdev->resync. 

The second reason is that there are more calls to the drbd_set_in_sync()
function than to the drbd_try_clear_on_disk_bm(). We would need
to protect each and every call to drbd_set_in_sync()...

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
