Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 21:46:19 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd uses wrong API for struct bio
Message-ID: <20050124204619.GO5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<200501241538.33555.philipp.reisner@linbit.com>
	<20050124144157.GM5638@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124144157.GM5638@marowsky-bree.de>
Cc: axboe@suse.de
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-24T15:41:57, Lars Marowsky-Bree <lmb@suse.de> wrote:

> The proper way for fixing it would be to have drbd use bio_alloc() and
> friends instead of messing with the bio directly, but that changes quite
> a bit of the code...

I've decided to go for the cheaper (in terms of "lines of code changed")
now for the time being. I can however confirm LKCD is working very
reliably in SLES9 SP1 ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

