Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9EC112CFF5DC
	for <drbd-dev@lists.linbit.com>; Thu, 21 Dec 2006 19:01:54 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 -
	trunk/drbd- The fix forthe "both nodes in WFBitMaps" issue, Ernest
Date: Thu, 21 Dec 2006 19:01:54 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C89C@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C89C@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612211901.55110.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 21. Dezember 2006 16:05 schrieb Montrose, Ernest:
> Phil,
> Thanks, I have to wait for another occurrence for the drbdadm show-gi
> output. But I have the kernel messages below for both nodes in the
> cluster:
>
> *****Split brain messages*******
> I think this case May be another Split-Brain manifestation...But the
> states are not right for manual sync. In both cases eth1 was previously
> down:
> Here are some data:
> Dec 19 11:56:35 morticia kernel: drbd0: self
> B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
> Dec 19 11:56:35 morticia kernel: drbd0: peer
> EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
> Dec 19 11:56:35 morticia kernel: drbd0: uuid_compare()=100
> Dec 19 11:56:35 morticia kernel: drbd0: Split-Brain detected, manually
> solved. Sync from this node
> Dec 19 11:56:35 morticia kernel: drbd0: peer( Unknown -> Primary ) conn(
> WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
> Dec 19 11:56:35 morticia kernel: drbd2: conn( WFConnection ->
> WFReportParams )
>
> ************************************************************************
> **
>
> Dec 19 11:56:35 gomez kernel: drbd0: conn( WFConnection ->
> WFReportParams )
> Dec 19 11:56:35 gomez kernel: drbd0: Handshake successful: DRBD Network
> Protocol version 85
> Dec 19 11:56:35 gomez kernel: drbd0: drbd_sync_handshake:
> Dec 19 11:56:35 gomez kernel: drbd0: self
> EA51CF76B39C65CF:7CF87E16765B2991:A6CE234412D1AEF1:32225FC919BDC7B9
> Dec 19 11:56:35 gomez kernel: drbd0: peer
> B53E750F0FDF5CD5:7CF87E16765B2990:A6CE234412D1AEF0:32225FC919BDC7B8
> Dec 19 11:56:35 gomez kernel: drbd0: uuid_compare()=100
> Dec 19 11:56:35 gomez kernel: drbd0: Split-Brain detected, manually
> solved. Sync from this node
> Dec 19 11:56:35 gomez kernel: drbd0: peer( Unknown -> Secondary ) conn(
> WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
> Dec 19 11:56:35 gomez kernel: drbd2: conn( WFConnection ->
> WFReportParams )
>
> ##############State machines messages on both
> nodes########################
> [root@gomez ~]# grep WFBitMapS /var/log/messages|grep drbd0

Hi Ernest,

This is too less. I hoped to find out what is going on there by
reading all the other messages as well.... only grep for "drbd0".

> Phil,
> In the earlier data I sent to you, UUID tracing was enabled.  So I think
> you may not need the "drbdadm show-gi" output anymore.  Let me know if
> you still do.

You are right, since you have the UUID tracing turned on, the output
of show-gi is not necessary.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
