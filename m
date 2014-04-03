Return-Path: <raulhp@ugr.es>
Received: from mail1.ugr.es (mail4.ugr.es [150.214.35.27])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 70603101AC77
	for <drbd-dev@lists.linbit.com>; Thu,  3 Apr 2014 12:41:21 +0200 (CEST)
Received: from rc.ugr.es (rc1.ugr.es [150.214.220.81])
	by mail1.ugr.es (Postfix) with ESMTP id D3ADA535
	for <drbd-dev@lists.linbit.com>; Thu,  3 Apr 2014 12:32:13 +0200 (CEST)
Received: from webmail.ugr.es (localhost [127.0.0.1])
	by rc.ugr.es (Postfix) with ESMTP id 9A5A522502
	for <drbd-dev@lists.linbit.com>; Thu,  3 Apr 2014 12:32:14 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Apr 2014 12:32:14 +0200
From: raulhp <raulhp@ugr.es>
To: <drbd-dev@lists.linbit.com>
Message-ID: <bd4dca3f93ea0361c978541eb47ff5c1@ugr.es>
Subject: [Drbd-dev] obtain addr
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

Where is the seccion in source code that

This code in drbd_int.h -> struct drbd_connection

struct sockaddr_storage my_addr;
	int my_addr_len;
	struct sockaddr_storage peer_addr;
	int peer_addr_len;
