Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 294C210518BD
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 231C044A1C0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rpPjIhytufzD for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 058A844A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rCThfUfBO8Gg for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:37 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D0261449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:37 +0200 (CEST)
Resent-Message-ID: <20150507093537.GR18767@soda.linbit>
Date: Tue, 28 Apr 2015 16:01:26 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20150428114320.GA9790@lst.de>
Message-ID: <alpine.LNX.2.00.1504281546340.19844@localhost.lm.intel.com>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-2-git-send-email-mlin@kernel.org>
	<20150428114320.GA9790@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] block: make generic_make_request
 handle	arbitrarily sized bios
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

On Tue, 28 Apr 2015, Christoph Hellwig wrote:
> This seems to lack support for QUEUE_FLAG_SG_GAPS to work around
> the retarded PPR format in the NVMe driver.

Might strong words, sir! I'm missing the context here, but I'll say PRP
is much more efficient for h/w to process over SGL, and the requirement
comes from that h/w rather than the driver.
