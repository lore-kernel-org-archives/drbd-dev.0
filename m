Return-Path: <udo1@udo.hu>
Received: from mail.udo.hu (pumukli.udo.hu [87.229.14.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5C7E610003C4
	for <drbd-dev@lists.linbit.com>; Thu,  4 Mar 2010 12:39:43 +0100 (CET)
Received: from localhost ([127.0.0.1] helo=[192.168.0.196])
	by mail.udo.hu with esmtpa (Exim 4.63) (envelope-from <udo1@udo.hu>)
	id 1Nn98l-0002W5-L5
	for drbd-dev@lists.linbit.com; Thu, 04 Mar 2010 12:22:52 +0100
Message-ID: <4B8F980C.7050303@udo.hu>
Date: Thu, 04 Mar 2010 12:22:52 +0100
From: udo1 <udo1@udo.hu>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative;
	boundary="------------090504090806070804060900"
Subject: [Drbd-dev] OpenSuse 11.2 8.7 Kernel packages not compile
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------090504090806070804060900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear developers,

I want to use 8.7 on OpenSuSE 11.2, but the kernel modules rpm fails to 
compile.
On the users list there was a question
[DRBD-user] In drbd-8.3.7 'make km-rpm' failed unter openSUSE-11.2 
x86_64 
<http://lists.linbit.com/pipermail/drbd-user/2010-January/013434.html> 
/Henrik Kuhn
http://lists.linbit.com/pipermail/drbd-user/2010-January/013434.html
/regarding this issue, but no answers.
I have updated the other node to 8.7 (running CentOS 5.4) , but I need 
the same for the OpenSuSE side.
I have problems with the 8.4 it freeze the server without any log if it 
connects to the other node when in
  cs:WFConnection ro:Secondary/Unknown ds:UpToDate/DUnknown
state and the connection and doing restart drbd while the other node has.
  cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown
Drbd running on the Primary node and drbd started on the Secondary -> 
result :freeze.
If I have stopped the service on the Primary node and have started on 
the Secondary node, and than start on the primary node, it starts to 
sync and no freeze occurs...
I renamed the halt command in case a handler doing this, but the same 
result.

Can it caused by the different drbd version?
I am using Infiniband connection(sdp) on xen kernel.

Can somebody modify the drbd 8.7 tarball that it compiles on OpenSuSE 
11.2? Or OpenSuSE 11.2 will not be supported?
Is the solution suggested by Henrik Kuhn ok?

Best Regards,
Udo Attila Fischer


--------------090504090806070804060900
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff" text="#000000">
Dear developers,<br>
<br>
I want to use 8.7 on OpenSuSE 11.2, but the kernel modules rpm fails to
compile.<br>
On the users list there was a question <br>
<a
 href="http://lists.linbit.com/pipermail/drbd-user/2010-January/013434.html">[DRBD-user]
In
drbd-8.3.7 'make km-rpm' failed unter openSUSE-11.2 x86_64
</a><a name="13434"> </a>
<i>Henrik Kuhn
<br>
<a class="moz-txt-link-freetext"
 href="http://lists.linbit.com/pipermail/drbd-user/2010-January/013434.html">http://lists.linbit.com/pipermail/drbd-user/2010-January/013434.html</a><br>
</i>regarding this issue, but no answers.<br>
I have updated the other node to 8.7 (running CentOS 5.4) , but I need
the same for the OpenSuSE side.<br>
I have problems with the 8.4 it freeze the server without any log if it
connects to the other node when in<br>
 cs:WFConnection ro:Secondary/Unknown ds:UpToDate/DUnknown<br>
state and the connection and doing restart drbd while the other node
has.<br>
 cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown<br>
Drbd running on the Primary node and drbd started on the Secondary
-&gt; result :freeze. <br>
If I have stopped the service on the Primary node and have started on
the Secondary node, and than start on the primary node, it starts to
sync and no freeze occurs...<br>
I renamed the halt command in case a handler doing this, but the same
result. <br>
<br>
Can it caused by the different drbd version?<br>
I am using Infiniband connection(sdp) on xen kernel.<br>
<br>
Can somebody modify the drbd 8.7 tarball that it compiles on OpenSuSE
11.2? Or OpenSuSE 11.2 will not be supported? <br>
Is the solution suggested by Henrik Kuhn ok?<br>
<br>
Best Regards,<br>
Udo Attila Fischer<br>
<br>
</body>
</html>

--------------090504090806070804060900--
