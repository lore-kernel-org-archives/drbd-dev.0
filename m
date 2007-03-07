Return-Path: <komal@linsyssoft.com>
Received: from svr68.ehostpros.com (svr68.ehostpros.com [67.15.48.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8DA892E233B0
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2007 11:10:16 +0100 (CET)
Received: from [59.95.8.85] (helo=titan.linsyssoft.com)
	by svr68.ehostpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <komal@linsyssoft.com>)
	id 1HOt61-0003j2-QA
	for drbd-dev@lists.linbit.com; Wed, 07 Mar 2007 02:10:11 -0800
Received: from [192.168.1.22] (xenon [192.168.1.22] (may be forged))
	by titan.linsyssoft.com (8.13.1/8.13.1) with ESMTP id l279kqxD001546
	for <drbd-dev@lists.linbit.com>; Wed, 7 Mar 2007 15:16:52 +0530
From: komal <komal@linsyssoft.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain
Date: Wed, 07 Mar 2007 15:46:39 +0530
Message-Id: <1173262599.2536.25.camel@xenon>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Compression in DRBD
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,
          Bandwidth is an important issue in DRBD during replication of
data. If bandwidth is properly utilized then replication will be faster
and speed is what everyone needs.
        When bandwidth utilization comes into picture, compressing data
is what
is needed. Earlier discussions were going on to use vtun with a tcp
tunnel with zlib compression factor 9 or so to achieve compression.
        What about implementing compression in DRBD itself. Like using
zlib to
compress each packet and decompress it on receiver side in DRBD code
itself rather than using vtun and all. Wont it solve the purpose? 

Thanks and Regards,
Komal Nawandar.

