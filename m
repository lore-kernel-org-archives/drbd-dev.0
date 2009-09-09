Return-Path: <csdr@lthd.com>
Received: from lthd.com (lthd.com [193.231.233.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CFFFA1019AC6
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2009 16:28:59 +0200 (CEST)
Received: from stdom.domain.lthd.com (csdr@lthd.com@[172.16.0.105])
	(envelope-sender <csdr@lthd.com>)
	by lthd.com (qmail-ldap-1.03) with CAMELLIA256-SHA encrypted SMTP
	for <drbd-dev@lists.linbit.com>; 9 Sep 2009 17:22:10 +0300
Message-ID: <4AA7BA11.7040909@lthd.com>
Date: Wed, 09 Sep 2009 17:22:09 +0300
From: Dinu-Razvan Chis-Serban <csdr@lthd.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] I have found a bug in version 8.3.3rc1
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The symptoms: the second server goes into diskless mode after a while if 
on-io-error is set to detach, but if it is set to pass_on, nothing 
happens. The underlying device is a md-raid in RAID10 and it works OK.

Sincerely
Chis-Serban Dinu-Razvan
