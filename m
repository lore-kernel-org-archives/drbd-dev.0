Return-Path: <lmb@suse.de>
Date: Sat, 4 Sep 2004 12:51:35 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040904105135.GH11820@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<20040819113205.GP9601@marowsky-bree.de>
	<R+ahoCHARbsLOMKIahWH0/Q=lge@web.de>
	<200408201452.52512.philipp.reisner@linbit.com>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
	<20040904094814.GE11820@marowsky-bree.de>
	<20040904100008.GA14645@nudl>
	<20040904101813.GF11820@marowsky-bree.de>
	<20040904104338.GA16617@nudl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040904104338.GA16617@nudl>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-04T12:43:38,
   Lars Ellenberg <lars.ellenberg@linbit.com> said:

> I did not say we need either/or, I say I want an _additional_ timeout,

Ah, misread that. Ok, then we agree. Seems ok.

> won't need to, but it won't lose any writes anymore). Of course we can
> optimize, and I'd like to; but we need to be correct first.
> so don't argue if you don't disagree.

I wasn't realizing I wasn't disagreeing ;-) I thought you meant the
additional timeout relative to the current situation and instead of the
resume.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

