Return-Path: <lmb@suse.de>
Date: Thu, 3 Feb 2005 10:15:56 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1743 - in branches/drbd-0.7: . drbd
Message-ID: <20050203091556.GO7628@marowsky-bree.de>
References: <20050131111921.EE6F83BE6D@garcon.linbit.com>
	<200502011836.43449.philipp.reisner@linbit.com>
	<20050202101322.GQ7628@marowsky-bree.de>
	<200502021859.10633.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502021859.10633.philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@suse.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-02-02T18:59:10, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> Why do you not simply read the code ? 

I did, but because the comments in the code and those I got from Jens were
contradictionary with what you said, and I wanted to figure out who was
right, and I'm known to misunderstand code.

But Jens confirmed in a private discussion that you're right ;-)
Normally, the end_io functions would drop their reference count. Alas,
because drbd and md were converted from on stack bios, those didn't.

So yes, the additional bio_get seems to be wrong indeed, or a bio_put()
should be added to the end_io.

Thanks for catching this, this means we'll have another bugfix queued
soon...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

