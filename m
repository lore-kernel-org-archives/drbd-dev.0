Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 11:28:52 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jens Axboe <axboe@suse.de>
Message-ID: <20050124102852.GC5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124091006.GA2716@suse.de>
	<20050124095854.GB5638@marowsky-bree.de>
	<20050124102310.GB2716@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124102310.GB2716@suse.de>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: drbd uses wrong API for struct bio
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-24T11:23:10, Jens Axboe <axboe@suse.de> wrote:

> Yes, that is what would be nice to fix :-)
> 
> Make drbd_ee_init() just init the bastard, and add the page in
> prepare().

In theory you're right, but drbd seems to use this as a cache and
allocate the page just once, but fills it with different data of
different sizes over time, or at least that's what it looks like.

I'm not sure that's easily fixed.

I wish lge wasn't hiding in New Zealand ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

