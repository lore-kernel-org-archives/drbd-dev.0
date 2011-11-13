Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 17B7810556AF
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 17:54:41 +0100 (CET)
Received: by bkbzs8 with SMTP id zs8so9472332bkb.27
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 08:54:40 -0800 (PST)
Message-ID: <4EBFF64D.50607@hastexo.com>
Date: Sun, 13 Nov 2011 17:54:37 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: "Robinson, Eric" <eric.robinson@psmnv.com>
References: <4EBF8022.6020202@hastexo.com>
	<768FEA3F936926468F594E3CA7741FE80368307C@ipa-vault.nvipa.com>
	<4EBFE9CD.1020302@hastexo.com>
	<768FEA3F936926468F594E3CA7741FE80368307D@ipa-vault.nvipa.com>
In-Reply-To: <768FEA3F936926468F594E3CA7741FE80368307D@ipa-vault.nvipa.com>
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

On 2011-11-13 17:27, Robinson, Eric wrote:
>> ... was committed during the 8.3.3 development cycle. So the 
>> fact that you are getting this message (which is benign, 
>> though admittedly
>> annoying) is expected in your version.
>>
> 
> Fair enough. I was only concerned because of that --reboot switch in
> there.

No, that only means that the node attribute being set has a lifetime of
"until the next cluster reboot", meaning it's only stored in the
volatile "status" section of the CIB.

Cheers,
Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
