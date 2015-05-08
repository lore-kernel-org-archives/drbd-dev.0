Return-Path: <pryzby@telsasoft.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1A6381045C28
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 06:55:23 +0200 (CEST)
Received: by igbyr2 with SMTP id yr2so12027657igb.0
	for <drbd-dev@lists.linbit.com>; Thu, 07 May 2015 21:55:21 -0700 (PDT)
Received: from pryzbyj (charmander.telsasoft.com. [50.244.222.1])
	by mx.google.com with ESMTPSA id
	h128sm2785342ioh.38.2015.05.07.21.55.19
	for <drbd-dev@lists.linbit.com>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 May 2015 21:55:19 -0700 (PDT)
Date: Thu, 7 May 2015 23:55:17 -0500
From: Justin Pryzby <pryzby@telsasoft.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150508045517.GA6131@telsasoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] crm-fence-peer.sh missing shell expansion
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

There are several instances of unexpanded variables in here:

                sleep $(( net_hickup_time - SECONDS ))
        reboot_timeout=$(( reboot_timeout + SECONDS ))
                echo WARNING "${extra_msg}going to reboot -f in $(( reboot_timeout - SECONDS )) seconds! To cancel: kill $$"
                        if out=$( crmadmin -t $(( cibtimeout * 200 )) -S $DRBD_PEER ) \
