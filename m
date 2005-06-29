Return-Path: <lmb@suse.de>
Date: Wed, 29 Jun 2005 12:19:06 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd crashes the SyncSource if a read error is
	encountered during sync
Message-ID: <20050629101906.GB8522@marowsky-bree.de>
References: <20050623193709.GK29587@marowsky-bree.de>
	<200506241338.09028.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506241338.09028.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-06-24T13:38:08, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> > But the secondary here might be hosting other services in a cross-over
> > configuration and shouldn't do that.
> >
> > Comments?
> >
> I guess it that the syncSource fails during resync case needs to be 
> tested. -> Will do that as time permits.

OK. I was just checking whether you knew of any issues here off-hand.
I'll prepare to look into it "as time permits" too, but given that the
backup tapes need to be dug out anyway, it's not that critical, and in
the mean time we'll recommend local RAID beneath drbd ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

