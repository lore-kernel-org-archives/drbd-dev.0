Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 -trunk/drbd-
	The fix forthe "both nodes in WFBitMaps" issue, Ernest
Date: Fri, 22 Dec 2006 14:44:40 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C8A2@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C8A2@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JF+iFWwXEhDkRZV"
Message-Id: <200612221444.41292.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_JF+iFWwXEhDkRZV
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 21. Dezember 2006 19:19 schrieben Sie:
> Phil,
> Thanks for looking at this.  I was just trying to remove all the cluter
> To help you out.  I include a tar ball here with the full messages file
> for both nodes. Search for "Split" as a starting point since the issue
> seems
> to occur after a split brian. There are two files in the tar ball:
> addams/Gomez/var/log/messages
> addams/morticia/var/log/messages
>
> Thanks!!
>

Hi Ernest,

With the full log, I got pointed to the bug rather quickly.

Dec 19 11:56:35 morticia kernel: drbd0: Handshake successful: DRBD Network Protocol version 85
Dec 19 11:56:35 morticia kernel: drbd0: drbd_sync_handshake:
Dec 19 11:56:35 morticia kernel: drbd0: self B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
Dec 19 11:56:35 morticia kernel: drbd0: peer EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
Dec 19 11:56:35 morticia kernel: drbd0: uuid_compare()=100
Dec 19 11:56:35 morticia kernel: drbd0: Split-Brain detected, manually solved. Sync from this node
Dec 19 11:56:35 morticia kernel: drbd0: peer( Unknown -> Primary ) conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )


Dec 19 11:56:35 gomez kernel: drbd0: Handshake successful: DRBD Network Protocol version 85
Dec 19 11:56:35 gomez kernel: drbd0: drbd_sync_handshake:
Dec 19 11:56:35 gomez kernel: drbd0: self EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
Dec 19 11:56:35 gomez kernel: drbd0: peer B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
Dec 19 11:56:35 gomez kernel: drbd0: uuid_compare()=100
Dec 19 11:56:35 gomez kernel: drbd0: Split-Brain detected, manually solved. Sync from this node
Dec 19 11:56:35 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )

Here are the lines that gave the hint.
It looks like you passed on both sides the option "--discard-my-data".

Now I fixed this. In the future it should disconnect if you pass
the "--discard-my-data" on both sides to the the net command.

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_JF+iFWwXEhDkRZV
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: drbd-cvs@lists.linbit.com: [DRBD-cvs] svn commit by phil
	- r2641 - trunk/drbd - Fixed an other bug That Ernest of
	Stratus pointed out.
Content-Disposition: inline

Return-Path: <drbd-cvs-bounces@lists.linbit.com>
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on nudl
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=AWL,BAYES_00 autolearn=no
	version=3.1.3
X-Original-To: philipp.reisner@linbit.com
Delivered-To: philipp.reisner@linbit.com
Received: from [212.69.162.21] (localhost [127.0.0.1])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 710782CFF4AE;
	Fri, 22 Dec 2006 14:39:20 +0100 (CET)
X-Original-To: drbd-cvs@linbit.com
Delivered-To: drbd-cvs@lists.linbit.com
Received: from garcon2 (unknown [212.69.162.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D34E2CFF492
	for <drbd-cvs@linbit.com>; Fri, 22 Dec 2006 14:39:19 +0100 (CET)
Received: by garcon2 (sSMTP sendmail emulation);
	Fri, 22 Dec 2006 14:39:18 +0100
Date: Fri, 22 Dec 2006 14:39:18 +0100
To: drbd-cvs@lists.linbit.com
Content-Type: text/plain;
  charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20061222133919.1D34E2CFF492@mail.linbit.com>
From: drbd-cvs@lists.linbit.com
Subject: [DRBD-cvs] svn commit by phil - r2641 - trunk/drbd - Fixed an other
	bug That Ernest of Stratus pointed out.
X-BeenThere: drbd-cvs@lists.linbit.com
X-Mailman-Version: 2.1.5
Precedence: list
Reply-To: drbd-dev@lists.linbit.com,
 drbd-cvs@lists.linbit.com
List-Id: "SVN Commits \[used to be CVS Commits\]" <drbd-cvs.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-cvs>,
	<mailto:drbd-cvs-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-cvs>
List-Post: <mailto:drbd-cvs@lists.linbit.com>
List-Help: <mailto:drbd-cvs-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-cvs>,
	<mailto:drbd-cvs-request@lists.linbit.com?subject=subscribe>
Sender: drbd-cvs-bounces@lists.linbit.com
Errors-To: drbd-cvs-bounces@lists.linbit.com
X-Length: 2995
X-UID: 38941

Author: phil
Date: 2006-12-22 14:39:17 +0100 (Fri, 22 Dec 2006)
New Revision: 2641

Modified:
   trunk/drbd/drbd_receiver.c
Log:
Fixed an other bug That Ernest of Stratus pointed out.


Modified: trunk/drbd/drbd_receiver.c
===================================================================
--- trunk/drbd/drbd_receiver.c	2006-12-21 15:49:27 UTC (rev 2640)
+++ trunk/drbd/drbd_receiver.c	2006-12-22 13:39:17 UTC (rev 2641)
@@ -1927,10 +1927,10 @@
 	}
 
 	if ( hg == -100 ) {
-		if(mdev->net_conf->want_lose && !mdev->p_uuid[UUID_FLAGS]) {
+		if(mdev->net_conf->want_lose && !(mdev->p_uuid[UUID_FLAGS]&1)){
 			hg = -1;
 		}
-		if(!mdev->net_conf->want_lose && mdev->p_uuid[UUID_FLAGS]) {
+		if(!mdev->net_conf->want_lose && (mdev->p_uuid[UUID_FLAGS]&1)){
 			hg = 1;
 		}
 

_______________________________________________
drbd-cvs mailing list
drbd-cvs@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-cvs


--Boundary-00=_JF+iFWwXEhDkRZV--
