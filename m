Return-Path: <lmb@suse.de>
Date: Wed, 2 Feb 2005 11:13:22 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1743 - in branches/drbd-0.7: . drbd
Message-ID: <20050202101322.GQ7628@marowsky-bree.de>
References: <20050131111921.EE6F83BE6D@garcon.linbit.com>
	<20050201164820.GL7628@marowsky-bree.de>
	<200502011836.43449.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502011836.43449.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-02-01T18:36:43, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> I did not look at the comments, I read the code. And what I read there was:
> a BIO has after bio_init() a refcount (bi_cnt) of 1. It is freed when the 
> refcount drops to zero. 
> 
> bio_alloc();
> do something with it

"submit_bio()" is slightly different from just "something".

> bio_put();
> 
> is right.
> 
> What you did is:
> 
> bio_alloc();
> bio_get();   // increase to 2
> bio_put();   // decreat to 1
> 
> and let it live forever...

The cleanup at the end of the bio processing however should drop the bio
reference count too. Which is why the comment in bio.h says what it is.
Either the comment is wrong (and Jens's very same fix for the md code,
too), or you have introduced a race condition into the actlog.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

