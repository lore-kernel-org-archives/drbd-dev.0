Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 10AFA1058010
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:43 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:34:00 +1100
Message-Id: <1506897256-14072-2-git-send-email-me@tobin.cc>
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/17] lru_cache: remove FSF address from licence
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

checkpatch emits warning 'Do not include the paragraph about writing to the Free Software
Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past,
and may do so again. Linux already includes a copy of the GPL.'

Remove paragraph containing FSF address from licence.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/lru_cache.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 28ba40b..44d7ab0 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -16,11 +16,6 @@
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with drbd; see the file COPYING.  If not, write to
-   the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
-
  */
 
 #include <linux/module.h>
-- 
2.7.4

