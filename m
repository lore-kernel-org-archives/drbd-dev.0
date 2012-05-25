Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 48433100008C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 441681B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:42 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FfzozpatPLiJ for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:40:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 25CB91B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:42 +0200 (CEST)
Resent-Message-ID: <20120530084042.GF4141@soda.linbit>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DEED1100008C
	for <drbd-dev@lists.linbit.com>; Sat, 26 May 2012 01:04:16 +0200 (CEST)
From: Andi Kleen <andi@firstfloor.org>
To: Kent Overstreet <koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-13-git-send-email-koverstreet@google.com>
Date: Fri, 25 May 2012 15:54:14 -0700
In-Reply-To: <1337817771-25038-13-git-send-email-koverstreet@google.com> (Kent
	Overstreet's message of "Wed, 23 May 2012 17:02:49 -0700")
Message-ID: <m2k3zzlvmx.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 12/14] Closures
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Kent Overstreet <koverstreet@google.com> writes:

> Asynchronous refcounty thingies; they embed a refcount and a work
> struct. Extensive documentation follows in include/linux/closure.h

Sounds like you reinvented WTDs? 

Anyways I don't think this is something that should be in a kernel.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
