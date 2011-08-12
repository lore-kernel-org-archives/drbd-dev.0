Return-Path: <shenqiyu@hotmail.com>
Received: from bay0-omc4-s13.bay0.hotmail.com (bay0-omc4-s13.bay0.hotmail.com
	[65.54.190.215])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3EF1B105627F
	for <drbd-dev@lists.linbit.com>; Fri, 12 Aug 2011 08:12:33 +0200 (CEST)
Message-ID: <BAY165-W48FA9D87FF3A44D0B3D391CB250@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_f68c6270-267d-4c00-96ff-1862fbe7cf38_"
From: ShenQiyu <shenqiyu@hotmail.com>
To: <drbd-dev@lists.linbit.com>
Date: Fri, 12 Aug 2011 14:12:32 +0800
MIME-Version: 1.0
Subject: [Drbd-dev] How DRBD uses active log to recovery from a crash in
	8.4.0
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--_f68c6270-267d-4c00-96ff-1862fbe7cf38_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear sir,
 
When learning and testing DRBD 8.4.0, I could not find where it applies active log to bitmap when up a resource after a crash.
 
While DRBD 8.3.9 do it in drbd_nl_disk_conf()  calls drbd_al_read_log(), then drbd_al_apply_to_bm().
 
So, is there anything I have not caught up? The code is download from http://oss.linbit.com/drbd/8.4/drbd-8.4.0.tar.gz
 
Any hints are very appreciated!
 
Regards!
 
Paul 		 	   		  
--_f68c6270-267d-4c00-96ff-1862fbe7cf38_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Dear sir,<BR>
&nbsp;<BR>
When&nbsp;learning and testing DRBD 8.4.0, I could not find where it&nbsp;applies active log to bitmap when up a resource&nbsp;after a crash.<BR>
&nbsp;<BR>
While DRBD 8.3.9 do it in drbd_nl_disk_conf()&nbsp; calls&nbsp;drbd_al_read_log(), then drbd_al_apply_to_bm().<BR>
&nbsp;<BR>
So, is there anything I have not caught up? The code is download from <A href="http://oss.linbit.com/drbd/8.4/drbd-8.4.0.tar.gz">http://oss.linbit.com/drbd/8.4/drbd-8.4.0.tar.gz</A><BR>
&nbsp;<BR>
Any hints are very appreciated!<BR>
&nbsp;<BR>
Regards!<BR>
&nbsp;<BR>
Paul<BR> 		 	   		  </div></body>
</html>
--_f68c6270-267d-4c00-96ff-1862fbe7cf38_--
