Return-Path: <fan.chen@easystack.cn>
Received: from mail-m2835.qiye.163.com (mail-m2835.qiye.163.com [103.74.28.35])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 779AE4205C4
	for <drbd-dev@lists.linbit.com>; Fri, 28 May 2021 03:32:37 +0200 (CEST)
From: Chen Fan <fan.chen@easystack.cn>
To: drbd-dev@lists.linbit.com
Date: Fri, 28 May 2021 09:22:44 +0800
Message-Id: <20210528012244.46041-1-fan.chen@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "lingang . zeng" <linggang.zeng@easystack.cn>
Subject: [Drbd-dev] [PATCH 1/1] Fix the wrong maxinum of ping timeout in
	documentation
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

Signed-off-by: Chen Fan <fan.chen@easystack.cn>
Reported-by: lingang.zeng <linggang.zeng@easystack.cn>
---
 documentation/ja/v9/drbdsetup-options.xml.po | 4 ++--
 documentation/v9/drbdsetup-options.xml       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/documentation/ja/v9/drbdsetup-options.xml.po b/documentation/ja/v9/drbdsetup-options.xml.po
index 6010913e..c4aacfff 100644
--- a/documentation/ja/v9/drbdsetup-options.xml.po
+++ b/documentation/ja/v9/drbdsetup-options.xml.po
@@ -1632,13 +1632,13 @@ msgid ""
 "<placeholder type=\"indexterm\" id=\"0\"/> Define the timeout for replies to "
 "keep-alive packets.  If the peer does not reply within <option>ping-timeout</"
 "option>, DRBD will close and try to reestablish the connection.  The default "
-"value is 0.5 seconds, with a minimum of 0.1 seconds and a maximum of 3 "
+"value is 0.5 seconds, with a minimum of 0.1 seconds and a maximum of 30 "
 "seconds.  The unit is tenths of a second."
 msgstr ""
 "<placeholder type=\"indexterm\" id=\"0\"/>キープアライブパケットへの応答のタ"
 "イムアウトを定義する。対向ノードが <option>ping-timeout</option> 間で応答しな"
 "い場合、 DRBD は接続を終了し、再接続しようとする。デフォルト値は 0.5 秒で、最"
-"小値は 0.1 秒、最大値は 3 秒である。単位は 10 分の 1 秒である。"
+"小値は 0.1 秒、最大値は 30 秒である。単位は 10 分の 1 秒である。"
 
 #. type: Content of: <drbdsetup_options><drbdsetup_option><term>
 msgid ""
diff --git a/documentation/v9/drbdsetup-options.xml b/documentation/v9/drbdsetup-options.xml
index 5b5e58d7..a8990707 100644
--- a/documentation/v9/drbdsetup-options.xml
+++ b/documentation/v9/drbdsetup-options.xml
@@ -1161,7 +1161,7 @@ SYMLINK_BY_DISK=drbd/by-disk/<backing-disk-name>
 	</indexterm> Define the timeout for replies to keep-alive packets.  If
 	the peer does not reply within <option>ping-timeout</option>, DRBD will
 	close and try to reestablish the connection.  The default value is 0.5
-	seconds, with a minimum of 0.1 seconds and a maximum of 3 seconds.  The
+	seconds, with a minimum of 0.1 seconds and a maximum of 30 seconds.  The
 	unit is tenths of a second.</para>
     </definition>
   </drbdsetup_option>
-- 
2.25.1

