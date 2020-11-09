Return-Path: <duan.zhang@easystack.cn>
Received: from m9784.mail.qiye.163.com (m9784.mail.qiye.163.com
	[220.181.97.84])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8AD5A4207A7
	for <drbd-dev@lists.linbit.com>; Mon,  9 Nov 2020 07:58:03 +0100 (CET)
Received: from [192.168.9.105] (unknown [101.207.233.66])
	by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1F4D041872
	for <drbd-dev@lists.linbit.com>; Mon,  9 Nov 2020 14:52:08 +0800 (CST)
From: Zhang Duan <duan.zhang@easystack.cn>
To: drbd-dev@lists.linbit.com
Message-ID: <68d1f053-e293-c7c0-b974-cb47d95bdac5@easystack.cn>
Date: Mon, 9 Nov 2020 14:52:07 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------DF3B984C51EA3A2A1BB945D5"
Subject: [Drbd-dev] [PATCH] drbd: reply cancel to source when target of
 verify becomes inconsistent
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

This is a multi-part message in MIME format.
--------------DF3B984C51EA3A2A1BB945D5
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit

Consider one situation below:
1. primary A disconnects with secondary B & C both of which are Uptodate
2. start a verify from B to C
3. during the verify above, A reconnects and starts a resync to C because of
primary-lost-quorum
4. C becomes resync target and Inconsistent, then ignore the verify requests
from B which are already in its receive buffer
5. verify from B to C stalls here

To resolve it, at step 4, C should reply a message of P_RS_CANCEL to B
Here is the result if do that:
Nov 6 16:25:46 node-2 kernel: drbd drbd1/0 drbd1 node-3: Skipped verify, 
too busy: start=170208, size=48 (sectors)
Nov 6 16:25:46 node-2 kernel: drbd drbd1/0 drbd1 node-3: Online verify 
done but 6 4k blocks skipped (total 314 sec; paused 0 sec; 3336 K/sec)
Nov 6 16:25:46 node-2 kernel: drbd drbd1/0 drbd1 node-3: repl( VerifyS 
-> Established )

Signed-off-by: ZhangDuan
---
drbd/drbd_receiver.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 268dbf4d..c6d4b7c9 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -3273,6 +3273,8 @@ static int receive_DataRequest(struct 
drbd_connection *connection, struct packet
break;
case P_OV_REQUEST:
verify_skipped_block(peer_device, sector, size);
+ drbd_send_ack_rp(peer_device, P_RS_CANCEL, p);
+ break;
/* Fall through */
case P_RS_THIN_REQ:
case P_RS_DATA_REQUEST:
-- 
2.24.0.windows.2

-- 
Sincerely Yours,
Zhang Duan


--------------DF3B984C51EA3A2A1BB945D5
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=GBK">
  </head>
  <body>
    Consider one situation below:<br>
    1. primary A disconnects with secondary B &amp; C both of which are
    Uptodate<br>
    2. start a verify from B to C<br>
    3. during the verify above, A reconnects and starts a resync to C
    because of<br>
    primary-lost-quorum<br>
    4. C becomes resync target and Inconsistent, then ignore the verify
    requests<br>
    from B which are already in its receive buffer<br>
    5. verify from B to C stalls here<br>
    <br>
    To resolve it, at step 4, C should reply a message of P_RS_CANCEL to
    B<br>
    Here is the result if do that:<br>
    Nov 6 16:25:46 node-2 kernel: drbd drbd1/0 drbd1 node-3: Skipped
    verify, too busy: start=170208, size=48 (sectors)<br>
    Nov 6 16:25:46 node-2 kernel: drbd drbd1/0 drbd1 node-3: Online
    verify done but 6 4k blocks skipped (total 314 sec; paused 0 sec;
    3336 K/sec)<br>
    Nov 6 16:25:46 node-2 kernel: drbd drbd1/0 drbd1 node-3: repl(
    VerifyS -&gt; Established )<br>
    <br>
    Signed-off-by: ZhangDuan <duan.zhang@easystack.cn><br>
      ---<br>
      drbd/drbd_receiver.c | 2 ++<br>
      1 file changed, 2 insertions(+)<br>
      <br>
      diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c<br>
      index 268dbf4d..c6d4b7c9 100644<br>
      --- a/drbd/drbd_receiver.c<br>
      +++ b/drbd/drbd_receiver.c<br>
      @@ -3273,6 +3273,8 @@ static int receive_DataRequest(struct
      drbd_connection *connection, struct packet<br>
      break;<br>
      case P_OV_REQUEST:<br>
      verify_skipped_block(peer_device, sector, size);<br>
      + drbd_send_ack_rp(peer_device, P_RS_CANCEL, p);<br>
      + break;<br>
      /* Fall through */<br>
      case P_RS_THIN_REQ:<br>
      case P_RS_DATA_REQUEST:<br>
      -- <br>
      2.24.0.windows.2<br>
      <br>
    </duan.zhang@easystack.cn>
    <pre class="moz-signature" cols="72">-- 
Sincerely Yours,
Zhang Duan</pre>
  </body>
</html>

--------------DF3B984C51EA3A2A1BB945D5--
