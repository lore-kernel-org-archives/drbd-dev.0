Return-Path: <lmb@suse.de>
Date: Tue, 7 Sep 2004 14:03:30 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Message-ID: <20040907120330.GH10035@marowsky-bree.de>
References: <20040906135609.GT11820@marowsky-bree.de>
	<200409070957.57371.philipp.reisner@linbit.com>
	<20040907091507.GA3257@nudl>
	<200409071143.01189.philipp.reisner@linbit.com>
	<20040907104926.GA7387@nudl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907104926.GA7387@nudl>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T12:49:26,
   Lars Ellenberg <lars.ellenberg@linbit.com> said:

> it is more clean to have one ioctl, get the full info, and output that.
> I feel uneasy about introducing additional races by using several ioctls
> in a row (even if they all finish within one second). of course, once we
> have that info it could be stale already, but at least we have the
> guarantee that at some point in time it was correct.

Well, even if not correct, so at least it was consistent ;-)

It's also much easier to maintain in the external script, and less
likely to be gotten wrong in the script.

> as soon as we have a sane interface, I don't expect the internals to
> change so often, so the "maintenance trouble" is very low, either way.

Well, even if eventually change and export more data, that's more
maintainable.

I don't need writes to the generation counters, but getting at all that
information to know where to move things would be quite helpful.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

