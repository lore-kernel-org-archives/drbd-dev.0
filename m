Return-Path: <lars.ellenberg@linbit.com>
Date: Sun, 14 Jun 2009 05:58:28 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090614035828.GA20436@soda.linbit>
References: <200906121138.55945.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200906121138.55945.philipp.reisner@linbit.com>
Cc: Tom Brown <wc-linbit.com@vmail.baremetal.com>,
	Valentin Vidic <Valentin.Vidic@CARNet.hr>,
	Ivars =?utf-8?B?U3RyYXpkacWGxaE=?= <ivars.strazdins@gmail.com>
Subject: Re: [Drbd-dev] possible FIX [Xen - DRBD issue / panic
	in	skb_copy_bits]
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jun 12, 2009 at 11:38:55AM +0200, Philipp Reisner wrote:
> Hi Simon,
> 
> As we are currently preparing the next DRBD release, we try to
> fix known issues...
> 
> I tried to reproduce, trigger the issue you described in that post:
> http://lists.linbit.com/pipermail/drbd-user/2009-March/011645.html
> I failed to reproduce it, probably because I tried with 
> instrumented DRBD code on a recent vanilla kernel.
> 
> Howerver, attached is the patch that is intended to fix the issue.
> Can you verify that it really fixes the issue?


It won't. It walks the wrong lists of pages.

But this might fix it.
Though I'm not able to reproduce the problem, the Linbit Xen test setup
apparently does not break.  So I cannot confirm it fixed, either.

Please, someone who can reproduce the problem without this patch,
verify and give feedback whether this fixes it.

Thanks,

	Lars

commit 9b16e21cba73d93bbe77fa8fcc8d3226a6c8b502
Author: Lars Ellenberg <lars.ellenberg@linbit.com>
Date:   Sun Jun 14 05:34:33 2009 +0200

    possible fix for XEN crashes on disconnect
    
    Add missing explicit shutdown.
    If we just sock_release(), there may still be some socket references
    open, and some sendpage pages may be referenced still.
    
    After IO completion from tl_clear(), xen virtio unmaps these pages,
    somewhen the last interrupt or deferred network job releases the last
    socket reference, at which point the network stack tries to release
    the sendpage pages. Since they are already unmapped, it crashes.
    
    Explicit shutdown() is not only correct behaviour, supposedly it also
    synchronously gets rid of those sendpage pages first - while they are
    still mapped, tl_clear() runs later.
    
    TODO:
    add compat wrapper for < 2.6.24 kernel

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 719a5fe..11af592 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -3412,10 +3412,12 @@ void drbd_free_bc(struct drbd_backing_dev *ldev)
 void drbd_free_sock(struct drbd_conf *mdev)
 {
 	if (mdev->data.socket) {
+		kernel_sock_shutdown(mdev->data.socket, SHUT_RDWR);
 		sock_release(mdev->data.socket);
 		mdev->data.socket = NULL;
 	}
 	if (mdev->meta.socket) {
+		kernel_sock_shutdown(mdev->meta.socket, SHUT_RDWR);
 		sock_release(mdev->meta.socket);
 		mdev->meta.socket = NULL;
 	}


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
