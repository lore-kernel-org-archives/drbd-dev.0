Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9C4DD101AC77
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 11:58:58 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com, Joe Perches <joe@perches.com>
Date: Wed, 02 Jul 2014 11:58:57 +0200
Message-ID: <1635548.f802ec2nnc@fat-tyre>
In-Reply-To: <1404232237.14624.2.camel@joe-AO725>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
	<1404231410-29852-16-git-send-email-philipp.reisner@linbit.com>
	<1404232237.14624.2.camel@joe-AO725>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 15/20] drbd: cosmetic: change all
	printk(level, ...) to pr_<level>(...)
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 1. Juli 2014, 09:30:37 schrieb Joe Perches:
> On Tue, 2014-07-01 at 18:16 +0200, Philipp Reisner wrote:
> > From: Lars Ellenberg <lars.ellenberg@linbit.com>
> > 
> > Cosmetic change only.
> 
> []
> 
> > diff --git a/drivers/block/drbd/drbd_bitmap.c
> > b/drivers/block/drbd/drbd_bitmap.c
> []
> 
> > @@ -353,9 +353,8 @@ static void bm_free_pages(struct page **pages,
> > unsigned long number)> 
> >  	for (i = 0; i < number; i++) {
> >  	
> >  		if (!pages[i]) {
> > 
> > -			printk(KERN_ALERT "drbd: bm_free_pages tried to free "
> > -					  "a NULL pointer; i=%lu n=%lu\n",
> > -					  i, number);
> > +			pr_alert("bm_free_pages tried to free a NULL pointer; i=%lu n=%lu\n",
> > +				 i, number);
> 
> Cosmetic yes, but these won't be prefixed with "drbd: "
> unless there's a #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> somewhere above this and before any other #include.
> 

Right. Thanks for pointing that out!
I ammend it with this:

Subject: [PATCH] fixup! drbd: cosmetic: change all printk(level, ...) to
 pr_<level>(...)

---
 drivers/block/drbd/drbd_bitmap.c | 2 ++
 drivers/block/drbd/drbd_main.c   | 2 +-
 drivers/block/drbd/drbd_nl.c     | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 72370e2..f435e7e 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -22,6 +22,8 @@
    the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
+
 #include <linux/bitops.h>
 #include <linux/vmalloc.h>
 #include <linux/string.h>
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 3788ac1..9b465bb 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -26,7 +26,7 @@
 
  */
 
-#define pr_fmt(fmt)    "drbd: " fmt
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
 #include <linux/jiffies.h>
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bb9b8e5..7fcdc54 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -23,7 +23,7 @@
 
  */
 
-#define pr_fmt(fmt)    "drbd: " fmt
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
 #include <linux/drbd.h>
-- 
1.9.1

