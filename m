Return-Path: <duan.zhang@easystack.cn>
Received: from m97134.mail.qiye.163.com (m97134.mail.qiye.163.com
	[220.181.97.134])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4460D420177
	for <drbd-dev@lists.linbit.com>; Mon,  2 Mar 2020 13:32:54 +0100 (CET)
From: Zhang Duan <duan.zhang@easystack.cn>
To: drbd-dev@lists.linbit.com
Message-ID: <76806ec7-77fd-56b9-96f5-954cfcb24eee@easystack.cn>
Date: Mon, 2 Mar 2020 20:31:59 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------A2B9B3EB9981DF692CBF92DA"
Cc: "dongsheng.yang" <dongsheng.yang@easystack.cn>
Subject: [Drbd-dev] [PATCH] drbd: Ignore negotiation result with the peer
 who is also negotiating
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
--------------A2B9B3EB9981DF692CBF92DA
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit


We have a test on 3 nodes cluster in which the primary is uptodate and 
the other two secondary
is diskless by doing drbdadm detach. Then after doing drbdadm attach on 
the two secondary at
the same time, one status hangs at NEGOTIATING while another hangs at 
ATTACHING.

That is because if a negotiating peer receives another's 
wide-cluster-change from DISKLESS to
NEGOTIATING, it will reject it due to more than one negotiation 
throughout the cluster, but the
new disk state of that node remains NEGOTIATING after a failed state 
change. Then neither of
two peers can get a negotiating result what they want.

Signed-off-by: ZhangDuan
---
drbd/drbd_state.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index c919d759..85910f1e 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -1835,8 +1835,10 @@ static void sanitize_state(struct drbd_resource 
*resource)
for_each_peer_device_rcu(peer_device, device) {
enum drbd_repl_state nr = peer_device->negotiation_result;
enum drbd_disk_state pdsk = peer_device->disk_state[NEW];
+ enum drbd_disk_state pdsk_old = peer_device->disk_state[OLD];

- if (pdsk == D_UNKNOWN || pdsk < D_NEGOTIATING)
+ if ((pdsk == D_UNKNOWN || pdsk < D_NEGOTIATING) ||
+ (pdsk_old < D_NEGOTIATING && pdsk == D_NEGOTIATING))
continue;

if (pdsk == D_UP_TO_DATE)
-- 
2.24.0.windows.2

-- 
Sincerely Yours,
Zhang Duan


--------------A2B9B3EB9981DF692CBF92DA
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=GBK">
  </head>
  <body>
    <p><br>
    </p>
    We have a test on 3 nodes cluster in which the primary is uptodate
    and the other two secondary<br>
    is diskless by doing drbdadm detach. Then after doing drbdadm attach
    on the two secondary at<br>
    the same time, one status hangs at NEGOTIATING while another hangs
    at ATTACHING.<br>
    <br>
    That is because if a negotiating peer receives another's
    wide-cluster-change from DISKLESS to<br>
    NEGOTIATING, it will reject it due to more than one negotiation
    throughout the cluster, but the<br>
    new disk state of that node remains NEGOTIATING after a failed state
    change. Then neither of<br>
    two peers can get a negotiating result what they want.<br>
    <br>
    Signed-off-by: ZhangDuan <duan.zhang@easystack.cn><br>
      ---<br>
      drbd/drbd_state.c | 4 +++-<br>
      1 file changed, 3 insertions(+), 1 deletion(-)<br>
      <br>
      diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c<br>
      index c919d759..85910f1e 100644<br>
      --- a/drbd/drbd_state.c<br>
      +++ b/drbd/drbd_state.c<br>
      @@ -1835,8 +1835,10 @@ static void sanitize_state(struct
      drbd_resource *resource)<br>
      for_each_peer_device_rcu(peer_device, device) {<br>
      enum drbd_repl_state nr = peer_device-&gt;negotiation_result;<br>
      enum drbd_disk_state pdsk = peer_device-&gt;disk_state[NEW];<br>
      + enum drbd_disk_state pdsk_old = peer_device-&gt;disk_state[OLD];<br>
      <br>
      - if (pdsk == D_UNKNOWN || pdsk &lt; D_NEGOTIATING)<br>
      + if ((pdsk == D_UNKNOWN || pdsk &lt; D_NEGOTIATING) ||<br>
      + (pdsk_old &lt; D_NEGOTIATING &amp;&amp; pdsk == D_NEGOTIATING))<br>
      continue;<br>
      <br>
      if (pdsk == D_UP_TO_DATE)<br>
      -- <br>
      2.24.0.windows.2<br>
      <br>
    </duan.zhang@easystack.cn>
    <pre class="moz-signature" cols="72">-- 
Sincerely Yours,
Zhang Duan</pre>
  </body>
</html>

--------------A2B9B3EB9981DF692CBF92DA--

