Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D6E551012A92
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id CDABA1B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:03 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOCTTSBzd6tl for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:30:03 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A55331B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:03 +0200 (CEST)
Resent-Message-ID: <20120525203003.GC1903@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 33E2C100008C
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:01:28 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so2872857pbb.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 13:01:26 -0700 (PDT)
Date: Fri, 25 May 2012 13:01:23 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20120525200123.GA14196@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-10-git-send-email-koverstreet@google.com>
	<4FBE687E.1030605@panasas.com> <20120524213158.GB22664@google.com>
	<20120525164914.GE3855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120525164914.GE3855@redhat.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	Boaz Harrosh <bharrosh@panasas.com>,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 09/14] block: Add an explicit bio flag for
 bios that own their bvec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25, 2012 at 12:49:14PM -0400, Vivek Goyal wrote:
> Even if you keep it as it is, I thought BIO_OWNS_BVEC probably communicates
> the idea better than BIO_HAS_BVEC.

Yeah, I'll make that change.
