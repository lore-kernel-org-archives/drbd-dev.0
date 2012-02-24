Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9EEDF106E0E3
	for <drbd-dev@lists.linbit.com>; Sat, 25 Feb 2012 23:21:25 +0100 (CET)
Resent-Message-ID: <20120225222123.GI28351@barkeeper1-xen.linbit>
Received: from smtp.digdes.com (smtp.digdes.com [85.114.5.10])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EE85F106E0E3
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2012 14:32:51 +0100 (CET)
From: Apollonskiy Evgeniy <apollonskiy.e@digdes.com>
To: <drbd-dev@lists.linbit.com>
Date: Fri, 24 Feb 2012 17:28:29 +0400
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-01=_9B5RP2jWoDf24cg"
Content-Transfer-Encoding: 7bit
Message-ID: <201202241728.29238.apollonskiy.e@digdes.com>
Subject: [Drbd-dev] ko-count overflow
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-01=_9B5RP2jWoDf24cg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

There is a strange code fragment in drbd_main.c:

	drop_it = !--mdev->ko_count;
	if (!drop_it) {
		dev_err(DEV, "[%s/%d] sock_sendmsg time expired, ko = %u\n",
		       current->comm, current->pid, mdev->ko_count);
		request_ping(mdev);
	}

Default value of ko_count is 0, so --mdev->ko_count will be equal to 
4294967295 (ko_count is unsigned int).

--Boundary-01=_9B5RP2jWoDf24cg
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Liberation Sans'; font-size:9pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hello,</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">There is a strange code fragment in drbd_main.c:</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	drop_it = !--mdev-&gt;ko_count;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	if (!drop_it) {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">		dev_err(DEV, &quot;[%s/%d] sock_sendmsg time expired, ko = %u\n&quot;,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">		       current-&gt;comm, current-&gt;pid, mdev-&gt;ko_count);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">		request_ping(mdev);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	}</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Default value of ko_count is 0, so --mdev-&gt;ko_count will be equal to 4294967295 (ko_count is unsigned int).</p></body></html>
--Boundary-01=_9B5RP2jWoDf24cg--
