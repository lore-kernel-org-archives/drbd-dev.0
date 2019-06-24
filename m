Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 23D321011BFF
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 17:49:49 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id x4so14449317wrt.6
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 08:49:49 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	l8sm25567770wrg.40.2019.06.24.08.49.48
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 24 Jun 2019 08:49:48 -0700 (PDT)
Date: Mon, 24 Jun 2019 17:49:46 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190624154946.GU30528@soda.linbit>
References: <alpine.LRH.2.11.1906210638010.3326@mx.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.11.1906210638010.3326@mx.ewheeler.net>
Subject: Re: [Drbd-dev] Checksum based resync block size
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

On Sat, Jun 22, 2019 at 12:03:55AM +0000, Eric Wheeler wrote:
> Hello all,
> 
> Can someone help explain how checksum-based sync and verify are 
> implemented in the sender and receive side?  It looks like the hashes are 
> per-sector (looking at read_for_csum?) and I am interested in making the 
> csum chunk size configurable, or at least hack in some test code to see if 
> it would provide a performance benefit to csum multiple sectors.
> 
> I'm also trying to understand what iterates over the lldev and understand 
> where the csum takes place foreach chunk of data.
> 
> Any direction would be helpful.  Thank you.

As our in-sync/out-of-sync bitmap tracks 4k blocks,
we want to compare 4k checkesums.

Yes, that generates "a lot" of requests, and if these are not merged by
some IO scheduler on the lower layers, that may seriously suck.

make_ov_request() is what generates the online-verify requests.

What we potentially could do is issue the requests in larger chunks,
like (1 MiB) to the backends, then calculate and communicate the
checksum per each 4k, as well as the result.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
