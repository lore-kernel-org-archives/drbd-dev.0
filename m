Return-Path: <keescook@chromium.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DFD124203EB
	for <drbd-dev@lists.linbit.com>; Sat, 20 Jun 2020 05:30:22 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id e18so5396647pgn.7
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2020 20:30:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jun 2020 20:29:56 -0700
Message-Id: <20200620033007.1444705-6-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Whitcroft <apw@canonical.com>, linux-wireless@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	clang-built-linux@googlegroups.com, linux-mm@kvack.org,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, linux-ide@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 05/16] rtlwifi: rtl8192cu: Remove
	uninitialized_var() usage
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
and avoid sending garbage by returning.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Fixes: dc0313f46664 ("rtlwifi: rtl8192cu: Add routine hw")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index f070f25bb735..5b071b70bc08 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -592,7 +592,7 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 						    bool wmm_enable,
 						    u8 queue_sel)
 {
-	u16 uninitialized_var(value);
+	u16 value;
 
 	switch (queue_sel) {
 	case TX_SELE_HQ:
@@ -606,7 +606,7 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 		break;
 	default:
 		WARN_ON(1); /* Shall not reach here! */
-		break;
+		return;
 	}
 	_rtl92c_init_chipn_reg_priority(hw, value, value, value, value,
 					value, value);
-- 
2.25.1

