Return-Path: <lmb@suse.de>
Date: Wed, 8 Sep 2004 13:21:25 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Message-ID: <20040908112125.GE20844@marowsky-bree.de>
References: <20040906135609.GT11820@marowsky-bree.de>
	<20040907104926.GA7387@nudl>
	<20040907120330.GH10035@marowsky-bree.de>
	<200409071456.19233.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409071456.19233.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T14:56:19,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> My initial understanding was that this read-generation counters
> operation would read it off the disk (== run while the DRBD 
> module is not loaded). Do you mean that ? Or do you want to have
> an ioctl to ask the module for the current value of the countes ?

I need it in both scenarios and give me the proper information about the
state drbd is in - "Unconfigured" being one of them...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

