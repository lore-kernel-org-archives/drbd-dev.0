Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A4CB62E0917E
	for <drbd-dev@lists.linbit.com>; Mon, 26 Nov 2007 14:55:22 +0100 (CET)
Received: from [192.168.1.132] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 082BD8817
	for <drbd-dev@lists.linbit.com>; Mon, 26 Nov 2007 18:26:51 +0400 (SAMT)
Message-ID: <474AF52C.6090409@ru.mvista.com>
Date: Mon, 26 Nov 2007 16:32:44 +0000
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------060105060402050705090800"
Subject: [Drbd-dev] [DRBD][PATCH] drbd_bitfild_endian.patch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------060105060402050705090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

We have found that drbd  state is passed incorrectly between machines  
with different endianness.
Attached patch fixes this problem by converting bitfild to int.

Replacing all bitfileds (both in kernel and userland) isn't safe way 
(there are
about hundred lines to replace). Maybe adding converter from bitfield to 
int32
is appropriate solution ? Then sending state we do 
"drbd_state_to_int(state)"
and then receive we restore state by "int_to_drbd_state(i)". only 9 lines of
kernel code was changed (No need to change userspace). Additional 
overhead is
neglible.


Best regards,
Maxim.

--------------060105060402050705090800
Content-Type: text/plain;
 name="drbd_bitfild_endian.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drbd_bitfild_endian.patch"

Source: MontaVista Software, Inc.
MR: 26056
Type: Defect Fix
Disposition: needs submitting to DRBD maintainer 
Signed-off-by: Maxim Uvarov <muvarov@ru.mvista.com>
Signed-off-by: Maxim Syrchin <msyrchin@ru.mvista.com>
Description:
  DRBD uses bitfield to store its state. Since bitfields are not 
  cross-architecture safe - it causes error then archs of peers are
  different. The simplest way to solve this is to convert biitfild
  to cross-arch safe int32. This change makes new protocol incompatile
  with old one - so PRO_VERSION is increased from 86 up to 88.

Index: linux-2.6.21_mvlcge500/drivers/block/drbd/drbd_int.h
===================================================================
--- linux-2.6.21_mvlcge500.orig/drivers/block/drbd/drbd_int.h
+++ linux-2.6.21_mvlcge500/drivers/block/drbd/drbd_int.h
@@ -1446,6 +1446,64 @@ void drbd_bcast_state(drbd_dev *mdev);
                 D,({drbd_state_t ns; ns.i = D->state.i; ns.T1 = (S1); \
                 ns.T2 = (S2); ns.T3 = (S3); ns;})
 
+/*
+ * Using bitfields is no cross-architecture safe.
+ * Use shifts to convert bitfield to cross-safe int
+ */
+
+#define	ROLE_OFF	0
+#define	PEER_OFF	2
+#define	CONN_OFF	4
+#define	DISK_OFF	9
+#define	PDSK_OFF	13
+#define	SUSP_OFF	17
+#define	AISP_OFF	18
+#define	PISP_OFF	19
+#define	UISP_OFF	20
+
+#define	ROLE_MASK	(unsigned int)0x03
+#define	PEER_MASK	(unsigned int)0x03
+#define	CONN_MASK	(unsigned int)0x1f
+#define	DISK_MASK	(unsigned int)0x0f
+#define	PDSK_MASK	(unsigned int)0x0f
+#define	SUSP_MASK	(unsigned int)0x01
+#define	AISP_MASK	(unsigned int)0x01
+#define	PISP_MASK	(unsigned int)0x01
+#define	UISP_MASK	(unsigned int)0x01
+
+static inline unsigned int drbd_state_to_int (unsigned int state_i)
+{
+	unsigned int i = 0;
+	drbd_state_t state;
+	state.i = state_i;
+	i = ((unsigned int)state.role)<<ROLE_OFF;
+	i |= ((unsigned int)state.peer)<<PEER_OFF;
+	i |= ((unsigned int)state.conn)<<CONN_OFF;
+	i |= ((unsigned int)state.disk)<<DISK_OFF;
+	i |= ((unsigned int)state.pdsk)<<PDSK_OFF;
+	i |= ((unsigned int)state.susp)<<SUSP_OFF;
+	i |= ((unsigned int)state.aftr_isp)<<AISP_OFF;
+	i |= ((unsigned int)state.peer_isp)<<PISP_OFF;
+	i |= ((unsigned int)state.user_isp)<<UISP_OFF;
+	return i;
+}
+
+static inline unsigned int int_to_drbd_state (unsigned int i)
+{
+	drbd_state_t state;
+	state.i = 0;
+	state.role = (i>>ROLE_OFF)&ROLE_MASK;
+	state.peer = (i>>PEER_OFF)&PEER_MASK;
+	state.conn = (i>>CONN_OFF)&CONN_MASK;
+	state.disk = (i>>DISK_OFF)&DISK_MASK;
+	state.pdsk = (i>>PDSK_OFF)&PDSK_MASK;
+	state.susp = (i>>SUSP_OFF)&SUSP_MASK;
+	state.aftr_isp = (i>>AISP_OFF)&AISP_MASK;
+	state.peer_isp = (i>>PISP_OFF)&PISP_MASK;
+	state.user_isp = (i>>UISP_OFF)&UISP_MASK;
+	return state.i;
+}
+
 static inline void drbd_state_lock(drbd_dev *mdev)
 {
 	wait_event(mdev->misc_wait,
Index: linux-2.6.21_mvlcge500/drivers/block/drbd/drbd_main.c
===================================================================
--- linux-2.6.21_mvlcge500.orig/drivers/block/drbd/drbd_main.c
+++ linux-2.6.21_mvlcge500/drivers/block/drbd/drbd_main.c
@@ -1366,7 +1366,7 @@ int drbd_send_state(drbd_dev *mdev)
 {
 	Drbd_State_Packet p;
 
-	p.state    = cpu_to_be32(mdev->state.i);
+	p.state    = cpu_to_be32(drbd_state_to_int(mdev->state.i));
 
 	return drbd_send_cmd(mdev,USE_DATA_SOCKET,ReportState,
 			     (Drbd_Header*)&p,sizeof(p));
@@ -1376,8 +1376,8 @@ STATIC int drbd_send_state_req(drbd_dev 
 {
 	Drbd_Req_State_Packet p;
 
-	p.mask    = cpu_to_be32(mask.i);
-	p.val     = cpu_to_be32(val.i);
+	p.mask    = cpu_to_be32(drbd_state_to_int(mask.i));
+	p.val     = cpu_to_be32(drbd_state_to_int(val.i));
 
 	return drbd_send_cmd(mdev,USE_DATA_SOCKET,StateChgRequest,
 			     (Drbd_Header*)&p,sizeof(p));
@@ -3179,15 +3179,15 @@ _dump_packet(drbd_dev *mdev, struct sock
 		break;
 
 	case ReportState:
-		v.i = be32_to_cpu(p->State.state);
+		v.i = int_to_drbd_state(be32_to_cpu(p->State.state));
 		m.i = 0xffffffff;
 		dump_st(tmp,sizeof(tmp),m,v);
 		INFOP("%s (s %x {%s})\n", cmdname(cmd), v.i, tmp);
 		break;
 
 	case StateChgRequest:
-		m.i = be32_to_cpu(p->ReqState.mask);
-		v.i = be32_to_cpu(p->ReqState.val);
+		m.i = int_to_drbd_state(be32_to_cpu(p->ReqState.mask));
+		v.i = int_to_drbd_state(be32_to_cpu(p->ReqState.val));
 		dump_st(tmp,sizeof(tmp),m,v);
 		INFOP("%s (m %x v %x {%s})\n", cmdname(cmd), m.i, v.i, tmp);
 		break;
Index: linux-2.6.21_mvlcge500/drivers/block/drbd/drbd_receiver.c
===================================================================
--- linux-2.6.21_mvlcge500.orig/drivers/block/drbd/drbd_receiver.c
+++ linux-2.6.21_mvlcge500/drivers/block/drbd/drbd_receiver.c
@@ -2369,8 +2369,8 @@ STATIC int receive_req_state(drbd_dev *m
 	if (drbd_recv(mdev, h->payload, h->length) != h->length)
 		return FALSE;
 
-	mask.i = be32_to_cpu(p->mask);
-	val.i = be32_to_cpu(p->val);
+	mask.i = int_to_drbd_state(be32_to_cpu(p->mask));
+	val.i =  int_to_drbd_state(be32_to_cpu(p->val));
 
 	if (test_bit(DISCARD_CONCURRENT,&mdev->flags)) drbd_state_lock(mdev);
 
@@ -2401,7 +2401,7 @@ STATIC int receive_state(drbd_dev *mdev,
 	nconn = mdev->state.conn;
 	if (nconn == WFReportParams ) nconn = Connected;
 
-	peer_state.i = be32_to_cpu(p->state);
+	peer_state.i =  int_to_drbd_state(be32_to_cpu(p->state));
 
 	if (mdev->p_uuid && mdev->state.conn <= Connected &&
 	    inc_local_if_state(mdev,Negotiating) &&
Index: linux-2.6.21_mvlcge500/include/linux/drbd_config.h
===================================================================
--- linux-2.6.21_mvlcge500.orig/include/linux/drbd_config.h
+++ linux-2.6.21_mvlcge500/include/linux/drbd_config.h
@@ -24,7 +24,7 @@ extern const char * drbd_buildtag(void);
 
 #define REL_VERSION "8.0.3"
 #define API_VERSION 86
-#define PRO_VERSION 86
+#define PRO_VERSION 88
 
 // undef if you need the workaround in drbd_receiver
 #define HAVE_UML_TO_VIRT 1

--------------060105060402050705090800--
