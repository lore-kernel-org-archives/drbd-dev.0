Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3C04A1028A43
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 10:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2F9402A27CF
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 10:03:27 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cVNWlIi_SeOq for <drbd-dev@lists.linbit.com>;
	Fri,  8 May 2015 10:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F0C8431E489
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 10:03:26 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BOg0xZKCkZyI for <drbd-dev@lists.linbit.com>;
	Fri,  8 May 2015 10:03:26 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id C679A2A27CF
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 10:03:26 +0200 (CEST)
Date: Fri, 8 May 2015 10:03:26 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150508080325.GS1968@rck.sh>
References: <20150508045517.GA6131@telsasoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150508045517.GA6131@telsasoft.com>
Subject: Re: [Drbd-dev] crm-fence-peer.sh missing shell expansion
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

On Thu, May 07, 2015 at 11:55:17PM -0500, Justin Pryzby wrote:
> There are several instances of unexpanded variables in here:
> 
>                 sleep $(( net_hickup_time - SECONDS ))
>         reboot_timeout=$(( reboot_timeout + SECONDS ))
>                 echo WARNING "${extra_msg}going to reboot -f in $(( reboot_timeout - SECONDS )) seconds! To cancel: kill $$"
>                         if out=$( crmadmin -t $(( cibtimeout * 200 )) -S $DRBD_PEER ) \

Could you be a bit more precise where you _exactly_ see the problem,
please? "Several" does not help a bash n00b like me. Do you mean the '$'
is missing for example for 'SECONDS'?

If so, that isn't a problem:
----------8<----------8<----------
#!/bin/bash

FOO=42
BAR=23

echo $(( FOO - BAR ))
----------8<----------8<----------

Which will echo 19...

Regards, rck
