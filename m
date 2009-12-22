Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: akpm@linux-foundation.org
Date: Tue, 22 Dec 2009 10:07:50 +0100
References: <200912220027.nBM0Rrsj005415@imap1.linux-foundation.org>
In-Reply-To: <200912220027.nBM0Rrsj005415@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912221007.50695.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com, roel.kluin@gmail.com, jens.axboe@oracle.com
Subject: Re: [Drbd-dev] [patch 5/5] drbd: fix test of unsigned in
	_drbd_fault_random()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 22. Dezember 2009 01:27:52 schrieb akpm@linux-foundation.org:
> From: Roel Kluin <roel.kluin@gmail.com>
> 
> rsp->count is unsigned so the test does not work.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
[...]

This patch is on its way upstream
See http://git.kernel.dk/?p=linux-2.6-block.git;a=commit;h=49829ea74f790d3be2e803a617e714f5b9a5ed50

and in the DRBD tree for old kernels...
http://git.drbd.org/?p=drbd-8.3.git;a=commit;h=f1cb8ce303a26e4763bbfb32660643322f4e228d

-Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
