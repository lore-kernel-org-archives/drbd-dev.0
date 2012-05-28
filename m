Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 159DB1012A92
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 03:30:29 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so5022530pbb.27
	for <drbd-dev@lists.linbit.com>; Sun, 27 May 2012 18:30:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 May 2012 10:30:12 +0900
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120528013012.GD9891@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-5-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-5-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 04/16] pktcdvd: Switch to bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25, 2012 at 01:25:27PM -0700, Kent Overstreet wrote:
> This is prep work for killing bi_destructor - previously, pktcdvd had
> its own pkt_bio_alloc which was basically duplication bio_kmalloc(),
> necessitating its own bi_destructor implementation.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> Change-Id: I5604293e07f695c8f0106ae819e306f1def89a67
> ---
>  drivers/block/pktcdvd.c |  115 ++++++++++++++++-------------------------------
>  1 file changed, 39 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index ba66e44..6fe693a 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -522,36 +522,38 @@ static void pkt_bio_finished(struct pktcdvd_device *pd)
>  	}
>  }
>  
> -static void pkt_bio_destructor(struct bio *bio)
> +static void pkt_end_io_read(struct bio *bio, int err)

* Why isn't pktcdvd maintainer cc'd?

* How is it tested or why do you think this change is correct?

* Didn't Boaz point out that mixing function relocations and
  functional changes makes the patch difficult to review and verify
  already?  Why doesn't the patch description mention function
  relocations?  And why are they mixed with functional changes?

-- 
tejun
