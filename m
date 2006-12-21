Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 47C3C2D9D522
	for <drbd-dev@lists.linbit.com>; Thu, 21 Dec 2006 09:38:54 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RE: [DRBD-cvs] svn commit by phil - r2607 - trunk/drbd
	- The fix forthe "both nodes in WFBitMaps" issue, Ernest
Date: Thu, 21 Dec 2006 09:38:53 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C897@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C897@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612210938.53959.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 20. Dezember 2006 18:46 schrieb Montrose, Ernest:
> Hi Phil,
> I am still seeing this issue that I reported a while back and for which
> you submitted a fix (see original message below).  But essentially after
> the drbd heartbeat link is disconnected and Split brain occurred, both
> nodes thinks they should be the sync source.  They send their peers(each
> other) to the following states:
> peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) pdsk(
> DUnknown -> UpToDate ) At the same time..
> This state persists across a reboot and the drbd_receiver thread loops
> on both nodes with:
>


Hi Ernest,

Could you please post the kernel messages from both nodes including
the disconnect time, as well the reconnect time ?

And a "drbdadm show-gi" on both nodes from the resource in question
would be helpfull as well.

Thanks!

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
