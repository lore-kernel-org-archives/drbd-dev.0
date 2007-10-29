Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
Subject: Re: [Drbd-dev] drbdsetup  events patch to announce Split-brain
Date: Mon, 29 Oct 2007 11:19:57 +0100
References: <BD7042533C2F8943A6A4257A9E31C454F479FA@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A1B@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A1B@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OPbJH/QYgUqDPPU"
Message-Id: <200710291119.58122.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_OPbJH/QYgUqDPPU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 25 October 2007 14:24:55 Montrose, Ernest wrote:
> Phil,
> Currently we do not use the payload for anything.  I was just being
> paranoid thinking that we might need it in the future.  But you can drop
> it if you wish.  If we have a pressing need for it in the future, we'll
> deal with it then.
>

Ernest,

Over the weekend I realized that the split brain event is quite
similar to a number of events we already signal back to userspace.

The invocation of handlers is also visible through the "drbdsetup events"
interface.

The attached patch creates an handler called "split-brain". If you
can live with that interface as well, I will commit that...

In the future I want to go this way:

  * Allow one to set the usermode_helper to the empty string. Then it 
    is still possible to get all events through the "drbdsetup events"
    interface.
  * The "outdate-peer" usermode_helper sends an exit code back
    to kernel space. This is not yet possible when one only uses
    the "drbdsetup events" interface. This should get fixed.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_OPbJH/QYgUqDPPU
Content-Type: text/x-diff; charset="iso-8859-1"; name="sb_as_handler.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sb_as_handler.diff"

diff --git a/documentation/drbd.conf.sgml b/documentation/drbd.conf.sgml
index b8c1282..c4b59af 100644
--- a/documentation/drbd.conf.sgml
+++ b/documentation/drbd.conf.sgml
@@ -247,7 +247,7 @@ resource r0 {
     Optional parameters:
     <option>pri-on-incon-degr</option>, <option>pri-lost-after-sb</option>,
     <option>pri-lost</option>, <option>outdate-peer</option>,
-    <option>local-io-error</option>.
+    <option>local-io-error</option>, <option>split-brain</option>.
   </para>
   </listitem>
 </varlistentry>
@@ -934,6 +934,13 @@ the unit is 1 second.
   <indexterm><primary>drbd.conf</primary><secondary>local-io-error </secondary></indexterm>
   </para></listitem> </varlistentry>
 
+<varlistentry>
+  <term><option>split-brain <replaceable>cmd</replaceable></option></term>
+  <listitem><para> DRBD detected a split brain situation. Manual recovery is necessary. 
+      This handler should alert someone on duty.
+  <indexterm><primary>drbd.conf</primary><secondary>split-brain </secondary></indexterm>
+  </para></listitem> </varlistentry>
+
 </variablelist>
 </refsect2>
 </refsect1>
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 6b5d180..e8aab71 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -2015,6 +2015,7 @@ STATIC drbd_conns_t drbd_sync_handshake(drbd_dev *mdev, drbd_role_t peer_role,
 		drbd_uuid_dump(mdev,"self",mdev->bc->md.uuid);
 		drbd_uuid_dump(mdev,"peer",mdev->p_uuid);
 		drbd_force_state(mdev,NS(conn,Disconnecting));
+		drbd_khelper(mdev,"split-brain");
 		return conn_mask;
 	}
 
diff --git a/scripts/drbd.conf b/scripts/drbd.conf
index a0f9d59..c5ecc54 100644
--- a/scripts/drbd.conf
+++ b/scripts/drbd.conf
@@ -148,6 +148,9 @@ resource r0 {
     # The node is currently primary, but should become sync target
     # after the negotiating phase. Alert someone about this incident.
     #pri-lost "echo pri-lost. Have a look at the log files. | mail -s 'DRBD Alert' root";
+
+    # Notify someone in case DRBD split brained. 
+    #split-brain "echo split-brain. drbdadm -- --discard-my-data connect $DRBD_RESOURCE ? | mail -s 'DRBD Alert' root";
   }
 
   startup {
diff --git a/user/drbdadm_main.c b/user/drbdadm_main.c
index 174ef5e..02cc8bf 100644
--- a/user/drbdadm_main.c
+++ b/user/drbdadm_main.c
@@ -239,6 +239,7 @@ struct adm_cmd cmds[] = {
   { "outdate-peer",      adm_khelper,   3,1,0 },
   { "local-io-error",    adm_khelper,   3,1,0 },
   { "pri-lost",          adm_khelper,   3,1,0 },
+  { "split-brain",       adm_khelper,   3,1,0 },
   { "set-gi",            admm_generic,  4,1,0 },
   { "suspend-io",        adm_generic_s, 4,1,0 },
   { "resume-io",         adm_generic_s, 4,1,0 },
diff --git a/user/drbdadm_scanner.fl b/user/drbdadm_scanner.fl
index d023446..7bec521 100644
--- a/user/drbdadm_scanner.fl
+++ b/user/drbdadm_scanner.fl
@@ -92,7 +92,8 @@ become-primary-on	{ DP; CP; return TK_STARTUP_OPTION;     }
 wait-after-sb		{ DP; CP; return TK_STARTUP_SWITCH;     }
 pri-on-incon-degr	{ DP; CP; return TK_HANDLER_OPTION;	}
 pri-lost-after-sb	{ DP; CP; return TK_HANDLER_OPTION;	}
-pri-lost	        { DP; CP; return TK_HANDLER_OPTION;     }
+pri-lost		{ DP; CP; return TK_HANDLER_OPTION;     }
+split-brain		{ DP; CP; return TK_HANDLER_OPTION;     }
 outdate-peer		{ DP; CP; return TK_HANDLER_OPTION;	}
 local-io-error		{ DP; CP; return TK_HANDLER_OPTION;     }
 {IPV4ADDR}		{ DP; CP; return TK_IPADDR;		}

--Boundary-00=_OPbJH/QYgUqDPPU--
