Return-Path: <lmb@suse.de>
Date: Mon, 4 Oct 2004 15:49:12 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <20041004134912.GY1542@marowsky-bree.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
	<20041004130158.GP1542@marowsky-bree.de>
	<200410041526.15189.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200410041526.15189.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-10-04T15:26:15, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> If everything works (esp. the locking of the shared disk fs) no.
> 
> But just consider that the locking of the shared disk FS on 
> top of us is broken, and that it issues a write request to
> the same block number on both nodes.
> 
> Then each node would write its copy first and the peers
> version of the data at second to that block number.
> 
> => We would have different data in this block on our
>    two copies. - And we would event know about it!

You would know the moment the replicated write from the remote end came
in, no?

"Oh my, this is dirty locally too and unacked. We better arbitate now;
ie one side wins and the other one is silently discarded."

(This arbitation doesn't even require an additional communication step
as long as it's consistent; you can simply always let the one with the
lower node id or whatever else win.)

In protocol C mode that's enough if in that case one side becomes the
winner, as the write hasn't returned to the application yet and what is
read() returns until then is undefined anyway.

You don't need to implement global ordering with heavy weaponry; if you
really wanted that (and I don't think you do) the only sane choice would
be to make drbd use the total or causal ordering mechanisms in the
generic cluster infrastructure. Those are not algorithms you want to
implement internally.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

