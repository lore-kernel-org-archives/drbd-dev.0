Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6FE5710518BC
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5AE52449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:37 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Aptmr_2-5bCp for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3A5D744A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:37 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xdRXmfGEkRD1 for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:37 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 12251449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:37 +0200 (CEST)
Resent-Message-ID: <20150507093536.GQ18767@soda.linbit>
Date: Tue, 28 Apr 2015 13:43:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150428114320.GA9790@lst.de>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-2-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430203717-13307-2-git-send-email-mlin@kernel.org>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	Christoph Hellwig <hch@lst.de>, drbd-user@lists.linbit.com
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

This seems to lack support for QUEUE_FLAG_SG_GAPS to work around
the retarded PPR format in the NVMe driver.  I'm actually not
sure we have a way to reproduce them for BLOCK_PC requests, but I think
we should make sure to properly handle them.

Maybe Keith or Jens have a good reproducer for these.
