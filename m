Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 15:37:34 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd uses wrong API for struct bio
Message-ID: <20050124143733.GL5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<200501241527.03616.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501241527.03616.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-24T15:27:03, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> Hi Lars,
> 
> Did you tested this patch ?
> 
> If yes -> I will commit it to SVN right now...

The one part is correct, but the other cases of drbd using struct bio
need fixing too. If you look at the last diff (mostly converting
everything to struct bio * and the API which goes with it) you'll see
that mostly the container_of() macros are stumbling still, and that's
fairly deep within the drbd code.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

