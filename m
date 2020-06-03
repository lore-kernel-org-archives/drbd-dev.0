Return-Path: <keescook@chromium.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D10C4203E7
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 01:32:17 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id o8so2656010pgm.7
	for <drbd-dev@lists.linbit.com>; Wed, 03 Jun 2020 16:32:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Wed,  3 Jun 2020 16:31:56 -0700
Message-Id: <20200603233203.1695403-4-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Whitcroft <apw@canonical.com>, Kees Cook <keescook@chromium.org>,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, clang-built-linux@googlegroups.com,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/10] b43: Remove uninitialized_var() usage
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

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just initialize this variable to NULL,
and make the (unreachable!) code do a conditional test.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/broadcom/b43/phy_n.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index d3c001fa8eb4..88cdcea10d61 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
 	u32 rfpwr_offset;
 	u8 pga_gain, pad_gain;
 	int i;
-	const s16 *uninitialized_var(rf_pwr_offset_table);
+	const s16 *rf_pwr_offset_table = NULL;
 
 	table = b43_nphy_get_tx_gain_table(dev);
 	if (!table)
@@ -4256,9 +4256,13 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
 			pga_gain = (table[i] >> 24) & 0xf;
 			pad_gain = (table[i] >> 19) & 0x1f;
 			if (b43_current_band(dev->wl) == NL80211_BAND_2GHZ)
-				rfpwr_offset = rf_pwr_offset_table[pad_gain];
+				rfpwr_offset = rf_pwr_offset_table
+						? rf_pwr_offset_table[pad_gain]
+						: 0;
 			else
-				rfpwr_offset = rf_pwr_offset_table[pga_gain];
+				rfpwr_offset = rf_pwr_offset_table
+						? rf_pwr_offset_table[pga_gain]
+						: 0;
 		} else {
 			pga_gain = (table[i] >> 24) & 0xF;
 			if (b43_current_band(dev->wl) == NL80211_BAND_2GHZ)
-- 
2.25.1

