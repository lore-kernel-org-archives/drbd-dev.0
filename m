Return-Path: <axboe@kernel.dk>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
	[209.85.214.52])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3576B101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 16:28:35 +0200 (CEST)
Received: by mail-it0-f52.google.com with SMTP id 70-v6so21325039ity.2
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 07:28:35 -0700 (PDT)
To: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dd30e115-f1c7-aa13-bb82-bffece8d07d7@kernel.dk>
Date: Mon, 21 May 2018 08:20:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 5/20/18 4:25 PM, Kent Overstreet wrote:
> Jens - this series does the rest of the conversions that Christoph wanted, and
> drops bioset_create().
> 
> Only lightly tested, but the changes are pretty mechanical. Based on your
> for-next tree.

Looks good to me. I'll let it simmer for a bit to give folks a chance
to comment on it.

-- 
Jens Axboe

