Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 13:52:17 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd uses wrong API for struct bio
Message-ID: <20050124125217.GJ5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124091006.GA2716@suse.de>
	<20050124095854.GB5638@marowsky-bree.de>
	<20050124102310.GB2716@suse.de>
	<20050124102852.GC5638@marowsky-bree.de>
	<20050124122446.GF5638@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124122446.GF5638@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-24T13:24:46, Lars Marowsky-Bree <lmb@suse.de> wrote:

> So I converted that to use bio_alloc() and bio_put() etc correctly, but
> this wonderful beautiful code in drbd_worker.c assumes that every bio it
> gets is embedded in a epoch_entry struct and uses the container_of()
> macro to convert from the bio to the enclosing struct.
> 
> Which of course no longer works if the private_bio is indeed a pointer.
> Wonderful.

We could point bi_private at the epoch entry and have the epoch entry
reference the mdev in the Tl_epoch_entry and make this work again.

Would that be ok?

Except of course of not being useful for drbd_req_prepare_write/read(),
where there is no Tl_epoch_entry available. Sigh.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

