Return-Path: <lmb@suse.de>
Date: Tue, 7 Sep 2004 14:12:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040907121218.GJ10035@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071139.29609.philipp.reisner@linbit.com>
	<20040907101343.GA5638@nudl>
	<200409071332.02477.philipp.reisner@linbit.com>
	<20040907120502.GA12518@nudl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907120502.GA12518@nudl>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T14:05:02,
   Lars Ellenberg <lars.ellenberg@linbit.com> said:

> maybe we still need to have this a two-stage process:
> after reboot, and we remain in Secondary/Unknown,
> we need to be told "peer dead", but we also need to get the confirmation
> "up-to-date" (just to cover our ass).

> when it was just a connection loss, we *are* up-to-date, and just need the
> confirmation "peer dead"; or we get the confirmation "link dead, peer
> alive", which basically is "you are outdated!".
> 
> just so we cannot be blamed for "automatically losing transactions",
> even in a multiple failure scenario.

I think peer-dead is sufficient. I don't see the additional problem
solved here?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

