Return-Path: <brice+drbd@daysofwonder.com>
Received: from mail.daysofwonder.com (mail.daysofwonder.com [87.98.213.69])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 501042DEAC66
	for <drbd-dev@lists.linbit.com>; Wed, 27 Feb 2008 17:18:40 +0100 (CET)
From: Brice Figureau <brice+drbd@daysofwonder.com>
To: drbd-dev@lists.linbit.com
In-Reply-To: <1204044621.1040.62.camel@localhost.localdomain>
References: <1204044621.1040.62.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-xwvtyxG1lUQkyx+R7CHO"
Date: Wed, 27 Feb 2008 17:00:48 +0100
Message-Id: <1204128048.10864.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH] dopd should notify when peer is dead (was
	"Refusing to be
	Primary while peer is not outdated" when peer is dead?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--=-xwvtyxG1lUQkyx+R7CHO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi again,

I now have a better understanding of the issue I posted in drbd-user
yesterday, which seems to be a bug in dopd/drbd-peer-updater, hence I'm
posted this mail in the dev list.

Note that dopd works fine in the other failover scenario (the other node
is still alive and can be contacted by other means).

On Tue, 2008-02-26 at 17:50 +0100, Brice Figureau wrote:
> I'm doing some failover tests of a passive/active mysql over drbd
> configuration.
> The current setup uses drbd 8.0.8 with heartbeat 2.1.3 (V2 crm style,
> drbddisk RA).
> 
> One of my failover scenario involves AC unpluging the current active
> node and see if the passive node is promoted. 
> Unfortunately for me it fails when the soon to become active node starts
> tries to promote drbd in primary mode.

Here is the failing scenario:

* I unplug the master

the slave gets:
drbd0: PingAck did not arrive in time.
drbd0: peer( Primary -> Unknown ) conn( Connected -> NetworkFailure )
pdsk( UpToDate -> DUnknown )
drbd0: asender terminated
drbd0: Terminating asender thread
drbd0: short read expecting header on sock: r=-512
drbd0: Writing meta data super block now.
drbd0: tl_clear()
drbd0: Connection closed
drbd0: conn( NetworkFailure -> Unconnected )
drbd0: receiver terminated
drbd0: receiver (re)started
drbd0: conn( Unconnected -> WFConnection )

* The slave's drbd notices it immediatly and launch the outdate-peer
helper:
 drbd0: helper command: /sbin/drbdadm outdate-peer

* Which launches "/usr/lib/heartbeat/drbd-peer-updater", which in turns
contact dopd with the peer's name and resource.

* Dopd connects to the crm only to see that the node is completely dead
(since it has been abruptly shutdowned). Dopd then returns 20 to the
client (see line 311 of dopd.c)

* drbd-peer-updater gets the 20, and aborts

* the drbd module gets the 20 return code and thinks drbd-peer-updater
is broken. Thus it doesn't mark the peer as outdated.

* Meanwhile, heartbeat notices it has to start the resources on the
slave soon to be primary node.

* Unfortunately that operation fails, because: "drbdsetup /dev/drbd0
primary" failed with the "Refusing to be Primary while peer is not
outdated" error message.

So what's the point to have an high-available cluster that can't survive
the death of one node?

I think that there should be a special handling of dead peers in dopd.c
that should return 5 (so that drbd knows the other node is dead).

Also in dopd.c the check_drbd_peer() function seems to be highly
suspect. It won't loop until it finds a matching node if there are some
dead nodes in-between...

So here is a dopd patch fixing this issue. I only slightly tested it
with the above scenario (with good results), so use at your own risks,
etc...
I'm not sure if I should send the patch on drbd-dev or on the linux-ha
lists, so I'm trying first here (the problem is drbd related). If I'm
wrong, please let me know and I'll send this mail on the linux-ha dev
list.

Many thanks,
-- 
Brice Figureau <brice+drbd@daysofwonder.com>

--=-xwvtyxG1lUQkyx+R7CHO
Content-Disposition: attachment; filename=dopd.patch
Content-Type: text/x-patch; name=dopd.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- a/contrib/drbd-outdate-peer/dopd.c	2007-12-21 16:32:27.000000000 +0100
+++ b/contrib/drbd-outdate-peer/dopd.c	2008-02-27 15:47:49.000000000 +0100
@@ -203,12 +203,13 @@
 
 /* check_drbd_peer()
  * walk the nodes and return TRUE if peer is not this node and it exists.
+ * returns 0 -> notfound, 1 -> found , 5 -> found but dead
  */
-gboolean
+int
 check_drbd_peer(const char *drbd_peer)
 {
 	const char *node;
-	gboolean found = FALSE;
+	int found = FALSE;
 	if (!strcmp(drbd_peer, node_name)) {
 		cl_log(LOG_WARNING, "drbd peer node %s is me!\n", drbd_peer);
 		return FALSE;
@@ -219,21 +220,27 @@
 		cl_log(LOG_WARNING, "Cannot start node walk");
 		cl_log(LOG_WARNING, "REASON: %s",
 		       dopd_cluster_conn->llc_ops->errmsg(dopd_cluster_conn));
-		return FALSE;
+		return 0;
 	}
 	while((node = dopd_cluster_conn->llc_ops->nextnode(dopd_cluster_conn)) != NULL) {
 		const char *status = dopd_cluster_conn->llc_ops->node_status(dopd_cluster_conn, node);
-		if (!strcmp(status, "dead")) {
+		if (!strcmp(status, "dead") && strcmp(node, drbd_peer)) {
 			cl_log(LOG_WARNING, "Cluster node: %s: status: %s",
 			       node, status);
-			return FALSE;
+		}
+	
+		if (!strcmp(status, "dead") && !strcmp(node, drbd_peer)) {
+			cl_log(LOG_WARNING, "Cluster node: %s: status: %s",
+			       node, status);
+			found = 5;
+			break;
 		}
 
 		/* Look for the peer */
 		if (!strcmp("normal", dopd_cluster_conn->llc_ops->node_type(dopd_cluster_conn, node))
 			&& !strcmp(node, drbd_peer)) {
 			cl_log(LOG_DEBUG, "node %s found\n", node);
-			found = TRUE;
+			found = 1;
 			break;
 		}
 	}
@@ -242,8 +249,10 @@
 		cl_log(LOG_INFO, "REASON: %s", dopd_cluster_conn->llc_ops->errmsg(dopd_cluster_conn));
 	}
 
-	if (found == FALSE)
+	if (found == 0)
 		cl_log(LOG_WARNING, "drbd peer %s was not found\n", drbd_peer);
+	if (found == 5)
+		cl_log(LOG_WARNING, "drbd peer %s is dead\n", drbd_peer);
 	return found;
 }
 
@@ -254,7 +263,7 @@
 static gboolean
 outdater_callback(IPC_Channel *client, gpointer user_data)
 {
-	int lpc = 0;
+	int lpc = 0, rc = 0;
 	HA_Message *msg = NULL;
 	const char *drbd_peer = NULL;
 	const char *drbd_resource = NULL;
@@ -285,7 +294,8 @@
 
 		drbd_resource = ha_msg_value(msg, F_OUTDATER_RES);
 		drbd_peer = ha_msg_value(msg, F_OUTDATER_PEER);
-		if (check_drbd_peer(drbd_peer)) {
+		rc = check_drbd_peer(drbd_peer);
+		if (rc == 1) {
 			dopd_client_t *entry;
 			pthread_mutex_lock(&conn_mutex);
 			entry = g_hash_table_lookup(connections,
@@ -307,8 +317,9 @@
 				pthread_mutex_unlock(&conn_mutex);
 		} else {
 			/* wrong peer was specified,
-			   send return code 20 to the client */
-			send_to_client(curr_client, "20");
+			   send return code 20 to the client,
+				 or dead peer was specified, then returns 5 */
+			send_to_client(curr_client, rc == 0 ? "20" : "5" );
 		}
 
 		ha_msg_del(msg);

--=-xwvtyxG1lUQkyx+R7CHO--

