Return-Path: <wguo@avaya.com>
Received: from p-us1-iereast-outbound-tmp.us1.avaya.com
	(nj300815-nj-outbound.net.avaya.com [135.11.29.16])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 06E9310003AF
	for <drbd-dev@lists.linbit.com>; Tue, 15 Dec 2009 01:40:04 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Dec 2009 19:29:11 -0500
Message-ID: <EAF41105EEA8E14BA54927856CEDEB3D01788A1C@300813ANEX2.global.avaya.com>
From: "Guo, Weiping (Jim)" <wguo@avaya.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Why sending and receiving dblock is so slow
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi DRBD experts,

I did some very basic profiling on drbd. I am really surprised that
sending/receiving could take long time.=20

1. sending: I measured the time from a dblock was inserted to the work
queue to when it is actually processed by the worker. Usually it only
takes less than 1ms, but I saw some instances of over 100ms.=20

2. receiving: I measured the time to execute read_in_block. I saw some
instances of 80ms and 40ms. Tracking down, it appears that
sock_recvmsg()could take long.=20

I just could not understand where those calls are blocked. Is there a
way to speed up the sending/receiving? Any comments and suggestions are
appreciated!

Thank you very much.

Jim=20

