Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3FD4E1005435
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:40:53 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so9174505wmt.0
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:40:53 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	f11-v6sm10471744edf.68.2018.05.23.06.40.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:40:51 -0700 (PDT)
Resent-Message-ID: <20180523134050.GW499@soda.linbit>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
	[209.85.216.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D4299101AC56
	for <drbd-dev@lists.linbit.com>; Tue, 22 May 2018 01:39:00 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id c2-v6so21169062qtn.9
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 16:39:00 -0700 (PDT)
Date: Mon, 21 May 2018 19:38:55 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20180521233855.GI11495@kmo-pixel>
References: <2bbeeb1a-8b99-b06a-eb9b-eb8523c16460@kernel.dk>
	<20180521144703.GA19303@redhat.com>
	<4b343aef-e11c-73ba-1d88-7e73ca838cad@kernel.dk>
	<20180521150439.GA19379@redhat.com>
	<61e30dcf-a01c-f47d-087a-12930caf9aef@kernel.dk>
	<20180521151817.GA19454@redhat.com>
	<d01a150a-7752-f6ce-78f2-17a65c1e6fa5@kernel.dk>
	<20180521160907.GA19553@redhat.com>
	<20180521173724.GG11495@kmo-pixel>
	<20180521182427.GA20013@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521182427.GA20013@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, hch@infradead.org, linux-raid@vger.kernel.org,
	darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
	colyli@suse.de, linux-block@vger.kernel.org, clm@fb.com,
	neilb@suse.com, bacik@fb.com, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
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

On Mon, May 21, 2018 at 02:24:32PM -0400, Mike Snitzer wrote:
> Every single data structure change in this series should be reviewed for
> unforeseen alignment consequences.  Jens seemed to say that is
> worthwhile.  Not sure if he'll do it or we divide it up.  If we divide
> it up a temp topic branch should be published for others to inspect.
> 
> Could be alignment hasn't been a historic concern for a bunch of the
> data structures changed in this series.. if so then all we can do is fix
> up any obvious potential for false sharing.

Honestly, I almost never worry about alignment... the very few times I do care,
I use __cacheline_aligned_in_smp.

If alignment is a concern in any of those structs, there really ought to be a
comment indicating it. I very much doubt anything I touched was performance
sensitive enough for it to be an issue, though. And if there is a performance
impact, it should be oughtweighed by the reduced pointer chasing.

If you disagree, I don't mind leaving the device mapper patch out, it really
makes no difference to me. I could glance over for alignment issues but I feel
like my analysis would not be terribly valuable to you considering I've already
said my position on alignment is "meh, don't care" :)
