Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1D2D1028A59
	for <drbd-dev@lists.linbit.com>; Fri, 31 Jul 2015 14:51:05 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Nick Wang <nwang@suse.com>
Date: Fri, 31 Jul 2015 14:50:53 +0200
Message-ID: <1574351.c1nomEfrHy@fat-tyre>
In-Reply-To: <1436776744-3135-3-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
	<1436776744-3135-3-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [Patch v2 02/10] drbd: Add option zap_devices to
	new-current-uuid
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

Hi Nick,

When introducing new fields alsways mark them as optional. Otherwise
a new kernel/module code would refuse netlink messages from older
drbd-utils:

> +	__flg_field(2, DRBD_GENLA_F_MANDATORY, zap_devices)

__flg_field(2, /* OPTIONAL */ 0, zap_devices)

best regards,
 Phil
