Return-Path: <raulhp@ugr.es>
Received: from mail1.ugr.es (mail2.ugr.es [150.214.35.29])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8226C101AC7D
	for <drbd-dev@lists.linbit.com>; Thu,  3 Apr 2014 12:41:23 +0200 (CEST)
Received: from rc.ugr.es (rc1.ugr.es [150.214.220.81])
	by mail1.ugr.es (Postfix) with ESMTP id 8B8AB437
	for <drbd-dev@lists.linbit.com>; Thu,  3 Apr 2014 12:35:35 +0200 (CEST)
Received: from webmail.ugr.es (localhost [127.0.0.1])
	by rc.ugr.es (Postfix) with ESMTP id 52C9722502
	for <drbd-dev@lists.linbit.com>; Thu,  3 Apr 2014 12:35:36 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Apr 2014 12:35:36 +0200
From: raulhp <raulhp@ugr.es>
To: <drbd-dev@lists.linbit.com>
In-Reply-To: <bd4dca3f93ea0361c978541eb47ff5c1@ugr.es>
References: <bd4dca3f93ea0361c978541eb47ff5c1@ugr.es>
Message-ID: <5302c0939964d7f19bec260413f4c90c@ugr.es>
Subject: Re: [Drbd-dev] obtain addr
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

Sorry, I accidentally sent email, then...


  Where is the seccion in source code that obtain the IP address from 
drbd.conf file?

  The follow code in drbd_int.h -> struct drbd_connection

  struct sockaddr_storage my_addr;
  int my_addr_len;
  struct sockaddr_storage peer_addr;
  int peer_addr_len;


Best Regards,
Ra
