Return-Path: <jakobkoschel@gmail.com>
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
	[209.85.218.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 871E2420365
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 12:09:01 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id p9so23985089ejd.6
	for <drbd-dev@lists.linbit.com>; Mon, 28 Feb 2022 03:09:01 -0800 (PST)
From: Jakob Koschel <jakobkoschel@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Feb 2022 12:08:21 +0100
Message-Id: <20220228110822.491923-6-jakobkoschel@gmail.com>
In-Reply-To: <20220228110822.491923-1-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	amd-gfx@lists.freedesktop.org, samba-technical@lists.samba.org,
	linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
	linux-arch <linux-arch@vger.kernel.org>,
	linux-cifs@vger.kernel.org, kvm@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
	Jason Gunthorpe <jgg@ziepe.ca>, intel-wired-lan@lists.osuosl.org,
	kgdb-bugreport@lists.sourceforge.net,
	bcm-kernel-feedback-list@broadcom.com,
	Dan Carpenter <dan.carpenter@oracle.com>,
	linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Arnd Bergman <arnd@arndb.de>, linux-pm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jakob Koschel <jakobkoschel@gmail.com>,
	v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
	linux-block@vger.kernel.org, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	tipc-discussion@lists.sourceforge.net,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Subject: [Drbd-dev] [PATCH 5/6] treewide: remove dereference of list
	iterator after loop body
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The list iterator variable will be a bogus pointer if no break was hit.
Dereferencing it could load *any* out-of-bounds/undefined value
making it unsafe to use that in the comparision to determine if the
specific element was found.

This is fixed by using a separate list iterator variable for the loop
and only setting the original variable if a suitable element was found.
Then determing if the element was found is simply checking if the
variable is set.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 11 +++++++----
 drivers/scsi/wd719x.c                          | 12 ++++++++----
 fs/f2fs/segment.c                              |  9 ++++++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 57199be082fd..c56cd9e59a66 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -471,20 +471,23 @@ nvkm_pstate_new(struct nvkm_clk *clk, int idx)
 static int
 nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
 {
-	struct nvkm_pstate *pstate;
+	struct nvkm_pstate *pstate = NULL;
+	struct nvkm_pstate *tmp;
 	int i = 0;

 	if (!clk->allow_reclock)
 		return -ENOSYS;

 	if (req != -1 && req != -2) {
-		list_for_each_entry(pstate, &clk->states, head) {
-			if (pstate->pstate == req)
+		list_for_each_entry(tmp, &clk->states, head) {
+			if (tmp->pstate == req) {
+				pstate = tmp;
 				break;
+			}
 			i++;
 		}

-		if (pstate->pstate != req)
+		if (!pstate)
 			return -EINVAL;
 		req = i;
 	}
diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 1a7947554581..be270ed8e00d 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -684,11 +684,15 @@ static irqreturn_t wd719x_interrupt(int irq, void *dev_id)
 	case WD719X_INT_SPIDERFAILED:
 		/* was the cmd completed a direct or SCB command? */
 		if (regs.bytes.OPC == WD719X_CMD_PROCESS_SCB) {
-			struct wd719x_scb *scb;
-			list_for_each_entry(scb, &wd->active_scbs, list)
-				if (SCB_out == scb->phys)
+			struct wd719x_scb *scb = NULL;
+			struct wd719x_scb *tmp;
+
+			list_for_each_entry(tmp, &wd->active_scbs, list)
+				if (SCB_out == tmp->phys) {
+					scb = tmp;
 					break;
-			if (SCB_out == scb->phys)
+				}
+			if (scb)
 				wd719x_interrupt_SCB(wd, regs, scb);
 			else
 				dev_err(&wd->pdev->dev, "card returned invalid SCB pointer\n");
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1dabc8244083..a3684385e04a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -356,16 +356,19 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct list_head *head = &fi->inmem_pages;
 	struct inmem_pages *cur = NULL;
+	struct inmem_pages *tmp;

 	f2fs_bug_on(sbi, !page_private_atomic(page));

 	mutex_lock(&fi->inmem_lock);
-	list_for_each_entry(cur, head, list) {
-		if (cur->page == page)
+	list_for_each_entry(tmp, head, list) {
+		if (tmp->page == page) {
+			cur = tmp;
 			break;
+		}
 	}

-	f2fs_bug_on(sbi, list_empty(head) || cur->page != page);
+	f2fs_bug_on(sbi, !cur);
 	list_del(&cur->list);
 	mutex_unlock(&fi->inmem_lock);

--
2.25.1

