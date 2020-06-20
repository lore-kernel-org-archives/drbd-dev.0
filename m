Return-Path: <keescook@chromium.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 560EB42038C
	for <drbd-dev@lists.linbit.com>; Sat, 20 Jun 2020 05:30:20 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id 35so4824581ple.0
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jun 2020 20:29:52 -0700
Message-Id: <20200620033007.1444705-2-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Whitcroft <apw@canonical.com>, Kees Cook <keescook@chromium.org>,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	clang-built-linux@googlegroups.com, linux-mm@kvack.org,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, linux-ide@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 01/16] docs: deprecated.rst: Add
	uninitialized_var()
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

Nothing should be using this macro, and the entire idea of tricking the
compiler into silencing such warnings is a mistake.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 652e2aa02a66..943a926ecbbb 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -51,6 +51,24 @@ to make sure their systems do not continue running in the face of
 "unreachable" conditions. (For example, see commits like `this one
 <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
 
+uninitialized_var()
+-------------------
+For any compiler warnings about uninitialized variables, just add
+an initializer. Using the uninitialized_var() macro (or similar
+warning-silencing tricks) is dangerous as it papers over `real bugs
+<https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/>`_
+(or can in the future), and suppresses unrelated compiler warnings
+(e.g. "unused variable"). If the compiler thinks it is uninitialized,
+either simply initialize the variable or make compiler changes. Keep in
+mind that in most cases, if an initialization is obviously redundant,
+the compiler's dead-store elimination pass will make sure there are no
+needless variable writes.
+
+As Linus has said, this macro
+`must <https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/>`_
+`be <https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/>`_
+`removed <https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/>`_.
+
 open-coded arithmetic in allocator arguments
 --------------------------------------------
 Dynamic size calculations (especially multiplication) should not be
-- 
2.25.1

