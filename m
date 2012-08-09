Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B95D7103B4A4
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B22001B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqVRp4jJlO5S for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 90CF81B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Resent-Message-ID: <20120810203334.GI31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 399A01055F43
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:06:40 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so435117pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:06:39 -0700 (PDT)
Date: Thu, 9 Aug 2012 02:06:40 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809060640.GA9088@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-4-git-send-email-koverstreet@google.com>
	<20120808221129.GB6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809000711.GB7262@moria.home.lan>
	<20120809060019.GA2845@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809060019.GA2845@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 03/12] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 11:00:19PM -0700, Tejun Heo wrote:
> Anyways, understood.  Can you *please* put some comment what bits are
> being preserved across reset then?  Things like this aren't obvious at
> all and need ample explanation.

I did, in the header:

#define BIO_RESET_BITS	12	/* Flags starting here get preserved by
bio_reset() */

Where the rest of the flags are defined, and near where BIO_RESET_BYTES
are defined.
