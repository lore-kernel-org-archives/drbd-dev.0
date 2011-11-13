Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6B03510556B9
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 17:01:37 +0100 (CET)
Received: by bkbzs8 with SMTP id zs8so9415631bkb.27
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 08:01:37 -0800 (PST)
Message-ID: <4EBFE9CD.1020302@hastexo.com>
Date: Sun, 13 Nov 2011 17:01:17 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: "Robinson, Eric" <eric.robinson@psmnv.com>
References: <4EBF8022.6020202@hastexo.com>
	<768FEA3F936926468F594E3CA7741FE80368307C@ipa-vault.nvipa.com>
In-Reply-To: <768FEA3F936926468F594E3CA7741FE80368307C@ipa-vault.nvipa.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: The Pacemaker cluster resource manager <pacemaker@oss.clusterlabs.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] crm_attribute --quiet (was Fwd: [Linux-HA] Should
 This Worry Me?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-11-13 12:34, Robinson, Eric wrote:
> FYI, this particular cluster is running DRBD 8.3.2.

Right, and this changeset:

commit e71e95975f2c4231a240ad856a5ac37d65685061
Author: Florian Haas <florian.haas@linbit.com>
Date:   Fri Sep 18 15:18:31 2009 +0200

    OCF RA: use crm_master in quiet mode in set_master_score()

... was committed during the 8.3.3 development cycle. So the fact that
you are getting this message (which is benign, though admittedly
annoying) is expected in your version.

What I'm wondering is merely whether the -Q flag is still correct.

Cheers,
Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
